Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVL2Am3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVL2Am3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVL2AjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:21 -0500
Received: from mx.pathscale.com ([64.160.42.68]:51432 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932573AbVL2AjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:09 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 20] ipath - core driver, part 3 of 4
X-Mercurial-Node: c37b118ef80698acc4eb1cbec223e28dd8b5eeab
Message-Id: <c37b118ef80698acc4eb.1135816289@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:29 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r dad2e87e21f4 -r c37b118ef806 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
@@ -3878,3 +3878,1533 @@
 		/* process possible error packets in hdrq */
 		ipath_kreceive(t);
 }
+
+/* must only be called if ipath_pd[port] is known to be allocated */
+static inline void *ipath_get_egrbuf(const ipath_type t, uint32_t bufnum,
+					 int err)
+{
+	return devdata[t].ipath_port0_skbs ?
+	    (void *)devdata[t].ipath_port0_skbs[bufnum]->data : NULL;
+
+#ifdef _USE_FOR_DEBUGGING_ONLY
+	/*
+	 * want routine to be inlined and fast this is here so if we do ports
+	 * other than 0, I don't have to rewrite the code, since it's slightly
+	 * complicated
+	 */
+	if (port != 1) {
+		void *chunkbase;
+		/*
+		 * This calculation takes about 50 cycles.  Could do
+		 * what I did for protocol code, and have an array of
+		 * addresses, getting it down to just a few cycles per
+		 * lookup, at the cost of 16KB of memory.
+		 */
+		if (!devdata[t].ipath_pd[port]->port_rcvegrbuf_virt)
+			return NULL;
+		chunkbase = devdata[t].ipath_pd[port]->port_rcvegrbuf_virt
+		    [bufnum /
+		     devdata[t].ipath_pd[port]->port_rcvegrbufs_perchunk];
+		return (void *)(chunkbase +
+				(bufnum %
+				 devdata[t].ipath_pd[port]->
+				 port_rcvegrbufs_perchunk)
+				* devdata[t].ipath_rcvegrbufsize);
+	}
+#endif
+}
+
+/* receive an sma packet.  Separate for better overall optimization */
+static void ipath_rcv_sma(const ipath_type t, uint32_t tlen,
+			  uint64_t * rc, void *ebuf)
+{
+	int sindex, slen, elen;
+	void *smbuf;
+	uint8_t pad, *bthbytes;
+
+	ipath_stats.sps_sma_rpkts++;	/* another SMA packet received */
+
+	bthbytes = (uint8_t *)((struct ips_message_header_typ *) &rc[1])->bth;
+
+	pad = (bthbytes[1] >> 4) & 3;
+	elen = tlen - (IPATH_SMA_HDRSZ + pad + (uint32_t) sizeof(uint32_t));
+	if (elen > (SMA_MAX_PKTSZ - IPATH_SMA_HDRSZ))
+		elen = SMA_MAX_PKTSZ - IPATH_SMA_HDRSZ;
+
+	spin_lock_irq(&ipath_sma_lock);
+	sindex = ipath_sma_next;
+	smbuf = ipath_sma_data[sindex].buf;
+	ipath_sma_data[sindex].unit = t;
+	slen = ipath_sma_data[ipath_sma_next].len;
+	memcpy(smbuf, &rc[1], IPATH_SMA_HDRSZ);
+	memcpy(smbuf + IPATH_SMA_HDRSZ, ebuf, elen);
+	if (slen) {
+		/*
+		 * overwriting a yet unread old one (buffer wrap), have to
+		 * advance ipath_sma_first to next oldest
+		 */
+
+		/* count OK packets that we drop */
+		ipath_stats.sps_krdrops++;
+		if (++ipath_sma_first >= IPATH_NUM_SMAPKTS)
+			ipath_sma_first = 0;
+	}
+	slen = ipath_sma_data[sindex].len = elen + IPATH_SMA_HDRSZ;
+	if (++ipath_sma_next >= IPATH_NUM_SMAPKTS)
+		ipath_sma_next = 0;
+	spin_unlock_irq(&ipath_sma_lock);
+}
+
+/*
+ * receive a packet for the layered (ethernet) driver.
+ * Separate routine for better overall optimization
+ */
+static void ipath_rcv_layer(const ipath_type t, uint32_t etail,
+			    uint32_t tlen, struct ether_header_typ * hdr)
+{
+	uint32_t elen;
+	uint8_t pad, *bthbytes;
+	struct sk_buff *skb;
+	struct sk_buff *nskb;
+	struct ipath_devdata *dd = &devdata[t];
+	struct ipath_portdata *pd;
+	unsigned long pa, pent;
+	uint64_t __iomem *egrbase;
+	uint64_t lenvalid;	/* in words */
+
+	if (dd->ipath_port0_skbs && hdr->sub_opcode == OPCODE_ENCAP) {
+		/*
+		 * Allocate a new sk_buff to replace the one we give
+		 * to the network stack.
+		 */
+		if (!(nskb = dev_alloc_skb(dd->ipath_ibmaxlen + 4))) {
+			/* count OK packets that we drop */
+			ipath_stats.sps_krdrops++;
+			return;
+		}
+
+		bthbytes = (uint8_t *) hdr->bth;
+		pad = (bthbytes[1] >> 4) & 3;
+		/* +CRC32 */
+		elen = tlen - (sizeof(*hdr) + pad + sizeof(uint32_t));
+
+		skb_reserve(nskb, 4);
+
+		skb = dd->ipath_port0_skbs[etail];
+		dd->ipath_port0_skbs[etail] = nskb;
+		skb_put(skb, elen);
+
+		pd = dd->ipath_pd[0];
+		lenvalid = (dd->ipath_ibmaxlen - pd->port_egrskip) >> 2;
+		lenvalid <<= INFINIPATH_RT_BUFSIZE_SHIFT;
+		lenvalid |= INFINIPATH_RT_VALID;
+		pa = virt_to_phys(nskb->data);
+		pa += pd->port_egrskip;
+		pent = (pa & INFINIPATH_RT_ADDR_MASK) | lenvalid;
+		/* This is simplified for port 0 */
+		egrbase = (uint64_t __iomem *)
+			((char __iomem *)(dd->ipath_kregbase) +
+			 dd->ipath_rcvegrbase);
+		ipath_kput_memq(t, &egrbase[etail], pent);
+
+		dd->ipath_layer.l_rcv(t, hdr, skb);
+
+		/* another ether packet received */
+		ipath_stats.sps_ether_rpkts++;
+	} else if (hdr->sub_opcode == OPCODE_LID_ARP) {
+		if (dd->ipath_layer.l_rcv_lid)
+			dd->ipath_layer.l_rcv_lid(t, hdr);
+	}
+
+}
+
+/* called from interrupt handler for errors or receive interrupt */
+void ipath_kreceive(const ipath_type t)
+{
+	uint64_t *rc;
+	void *ebuf;
+	struct ipath_devdata *dd = &devdata[t];
+	const uint32_t rsize = dd->ipath_rcvhdrentsize;	/* words */
+	const uint32_t maxcnt = dd->ipath_rcvhdrcnt * rsize;	/* in words */
+	uint32_t etail = -1, l, hdrqtail, sma_this_time = 0;
+	struct ips_message_header_typ *hdr;
+	uint32_t eflags, i, etype, tlen, pkttot=0;
+	static uint64_t totcalls; /* stats, may eventually remove */
+	char emsg[128];
+
+	if (!dd->ipath_hdrqtailptr) {
+		_IPATH_UNIT_ERROR(t,
+				  "hdrqtailptr not set, can't do receives\n");
+		return;
+	}
+
+	if (test_and_set_bit(0, &dd->ipath_rcv_pending)) {
+		/* There is already a thread processing this queue. */
+		return;
+	}
+
+	if (dd->ipath_port0head == *dd->ipath_hdrqtailptr)
+		goto done;
+
+gotmore:
+	/*
+	 * read only once at start.  If in flood situation, this helps
+	 * performance slightly.  If more arrive while we are processing,
+	 * we'll come back here and do them
+	 */
+	hdrqtail = *dd->ipath_hdrqtailptr;
+
+	for (i = 0, l = dd->ipath_port0head; l != hdrqtail; i++) {
+		uint32_t qp;
+		uint8_t *bthbytes;
+
+
+		rc = (uint64_t *) (dd->ipath_pd[0]->port_rcvhdrq + (l << 2));
+		hdr = (struct ips_message_header_typ *) & rc[1];
+		/*
+		 * could make a network order version of IPATH_KD_QP, and
+		 * do the obvious shift before masking to speed this up.
+		 */
+		qp = ntohl(hdr->bth[1]) & 0xffffff;
+		bthbytes = (uint8_t *) hdr->bth;
+
+		eflags = ips_get_hdr_err_flags((uint32_t*)rc);
+		etype = ips_get_rcv_type((uint32_t*)rc);
+		tlen = ips_get_length_in_bytes((uint32_t*)rc);	/* total length */
+		ebuf = NULL;
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED) {
+			/*
+			 * it turns out that the chips uses an eager buffer for
+			 * all non-expected packets, whether it "needs"
+			 * one or not.	So always get the index, but
+			 * don't set ebuf (so we try to copy data)
+			 * unless the length requires it.
+			 */
+			etail = ips_get_index((uint32_t*)rc);
+			if (tlen > sizeof(*hdr)
+			    || etype == RCVHQ_RCV_TYPE_NON_KD) {
+				ebuf = ipath_get_egrbuf(t, etail, 0);
+			}
+		}
+
+		/*
+		 * both tiderr and ipathhdrerr are set for all plain IB
+		 * packets; only ipathhdrerr should be set.
+		 */
+
+		if (etype != RCVHQ_RCV_TYPE_NON_KD
+		    && etype != RCVHQ_RCV_TYPE_ERROR
+		    && ips_get_ipath_ver(hdr->iph.ver_port_tid_offset) !=
+		    IPS_PROTO_VERSION) {
+			_IPATH_PDBG("Bad InfiniPath protocol version %x\n",
+				    etype);
+		}
+
+		if (eflags &
+		    ~(INFINIPATH_RHF_H_TIDERR | INFINIPATH_RHF_H_IHDRERR)) {
+			get_rhf_errstring(eflags, emsg, sizeof emsg);
+			_IPATH_PDBG
+			    ("RHFerrs %x hdrqtail=%x typ=%u tlen=%x opcode=%x egridx=%x: %s\n",
+			     eflags, l, etype, tlen, bthbytes[0],
+			     ips_get_index((uint32_t*)rc), emsg);
+		} else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
+			/*
+			 * If there is a userland SMA and this is a MAD packet,
+			 * then pass it to the userland SMA.
+			 */
+			if (ipath_sma_alive && qp <= 1) {
+				/*
+				 * count OK packets that we drop because
+				 * SMA isn't yet running, or because we
+				 * are in an sma flood (no point in
+				 * constantly acquiring the spin lock, and
+				 * overwriting previous packets).
+				 * Eventually things will recover.
+				 * Similarly if the sma consumer is
+				 * so far behind that we would overwrite
+				 * (yes, it's outside the lock)
+				 */
+				if (!ipath_sma_data_spare ||
+				    ipath_sma_data[ipath_sma_next].len ||
+				    ++sma_this_time > IPATH_NUM_SMAPKTS) {
+					ipath_stats.sps_krdrops++;
+				} else if (ebuf) {
+					ipath_rcv_sma(t, tlen, rc, ebuf);
+				}
+			} else if (dd->verbs_layer.l_rcv) {
+				dd->verbs_layer.l_rcv(t, rc + 1, ebuf, tlen);
+			} else {
+				_IPATH_VDBG("received IB packet, not SMA (QP=%x)\n",
+					    qp);
+			}
+		} else if (etype == RCVHQ_RCV_TYPE_EAGER) {
+			if (qp == IPATH_KD_QP && bthbytes[0] ==
+			    dd->ipath_layer.l_rcv_opcode && ebuf)
+				ipath_rcv_layer(t, etail, tlen,
+						(struct ether_header_typ *)hdr);
+			else
+				_IPATH_PDBG
+				    ("typ %x, opcode %x (eager, qp=%x), len %x; ignored\n",
+				     etype, bthbytes[0], qp, tlen);
+		} else if (etype == RCVHQ_RCV_TYPE_EXPECTED) {
+			_IPATH_DBG("Bug: Expected TID, opcode %x; ignored\n",
+				   hdr->bth[0] & 0xff);
+		} else if (eflags &
+			   (INFINIPATH_RHF_H_TIDERR | INFINIPATH_RHF_H_IHDRERR))
+		{
+			/*
+			 * This is a type 3 packet, only the LRH is in
+			 * the rcvhdrq, the rest of the header is in
+			 * the eager buffer.
+			 */
+			uint8_t opcode;
+			if (ebuf) {
+				bthbytes = (uint8_t *) ebuf;
+				opcode = *bthbytes;
+			} else
+				opcode = 0;
+			get_rhf_errstring(eflags, emsg, sizeof emsg);
+			_IPATH_DBG
+			    ("Err %x (%s), opcode %x, egrbuf %x, len %x\n",
+			     eflags, emsg, opcode, etail, tlen);
+		} else {
+			/*
+			 * error packet, type of error	unknown.
+			 * Probably type 3, but we don't know, so don't
+			 * even try to print the opcode, etc.
+			 */
+			_IPATH_DBG
+			    ("Error Pkt, but no eflags! egrbuf %x, len %x\n"
+			     "hdrq@%lx;hdrq+%x rhf: %llx; hdr %llx %llx %llx %llx %llx\n",
+			     etail, tlen, (unsigned long)rc, l, rc[0], rc[1],
+			     rc[2], rc[3], rc[4], rc[5]);
+		}
+		l += rsize;
+		if (l >= maxcnt)
+			l = 0;
+		/*
+		 * update for each packet, to help prevent overflows if we have
+		 * lots of packets.
+		 */
+		(void)ipath_kput_ureg(t, ur_rcvhdrhead, l, 0);
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED)
+			(void)ipath_kput_ureg(t, ur_rcvegrindexhead, etail, 0);
+	}
+
+	pkttot += i;
+
+	dd->ipath_port0head = l;
+
+	if (hdrqtail != *dd->ipath_hdrqtailptr)
+		goto gotmore;	/* more arrived while we handled first batch */
+
+	if (pkttot > ipath_stats.sps_maxpkts_call)
+		ipath_stats.sps_maxpkts_call = pkttot;
+	ipath_stats.sps_port0pkts += pkttot;
+	ipath_stats.sps_avgpkts_call = ipath_stats.sps_port0pkts / ++totcalls;
+
+	if (sma_this_time)	/* only once at end, not each time */
+		wake_up_interruptible(&ipath_sma_wait);
+
+done:
+	clear_bit(0, &dd->ipath_rcv_pending);
+	smp_mb__after_clear_bit();
+}
+
+/*
+ * Update our shadow copy of the PIO availability register map, called
+ * whenever our local copy indicates we have run out of send buffers
+ * NOTE: This can be called from interrupt context by ipath_bufavail()
+ * and from non-interrupt context by ipath_getpiobuf().
+ */
+
+static void ipath_update_pio_bufs(const ipath_type t)
+{
+	unsigned long flags;
+	int i;
+	const unsigned piobregs = (unsigned)devdata[t].ipath_pioavregs;
+
+	/* If the generation (check) bits have changed, then we update the
+	 * busy bit for the corresponding PIO buffer.  This algorithm will
+	 * modify positions to the value they already have in some cases
+	 * (i.e., no change), but it's faster than changing only the bits
+	 * that have changed.
+	 *
+	 * We would like to do this atomicly, to avoid spinlocks in the
+	 * critical send path, but that's not really possible, given the
+	 * type of changes, and that this routine could be called on multiple
+	 * cpu's simultaneously, so we lock in this routine only, to avoid
+	 * conflicting updates; all we change is the shadow, and it's a
+	 * single 64 bit memory location, so by definition the update is
+	 * atomic in terms of what other cpu's can see in testing the
+	 * bits.  The spin_lock overhead isn't too bad, since it only
+	 * happens when all buffers are in use, so only cpu overhead,
+	 * not latency or bandwidth is affected.
+	 */
+#define _IPATH_ALL_CHECKBITS 0x5555555555555555ULL
+	if (!devdata[t].ipath_pioavailregs_dma) {
+		_IPATH_DBG("Update shadow pioavail, but regs_dma NULL!\n");
+		return;
+	}
+	if (infinipath_debug & __IPATH_VERBDBG) {
+		/* only if packet debug and verbose */
+		_IPATH_PDBG("Refill avail, dma0=%llx shad0=%llx, "
+			    "d1=%llx s1=%llx, d2=%llx s2=%llx, d3=%llx s3=%llx\n",
+			    devdata[t].ipath_pioavailregs_dma[0],
+			    devdata[t].ipath_pioavailshadow[0],
+			    devdata[t].ipath_pioavailregs_dma[1],
+			    devdata[t].ipath_pioavailshadow[1],
+			    devdata[t].ipath_pioavailregs_dma[2],
+			    devdata[t].ipath_pioavailshadow[2],
+			    devdata[t].ipath_pioavailregs_dma[3],
+			    devdata[t].ipath_pioavailshadow[3]);
+		if (piobregs > 4)
+			_IPATH_PDBG("2nd group, dma4=%llx shad4=%llx, "
+				    "d5=%llx s5=%llx, d6=%llx s6=%llx, d7=%llx s7=%llx\n",
+				    devdata[t].ipath_pioavailregs_dma[4],
+				    devdata[t].ipath_pioavailshadow[4],
+				    devdata[t].ipath_pioavailregs_dma[5],
+				    devdata[t].ipath_pioavailshadow[5],
+				    devdata[t].ipath_pioavailregs_dma[6],
+				    devdata[t].ipath_pioavailshadow[6],
+				    devdata[t].ipath_pioavailregs_dma[7],
+				    devdata[t].ipath_pioavailshadow[7]);
+	}
+	spin_lock_irqsave(&ipath_pioavail_lock, flags);
+	for (i = 0; i < piobregs; i++) {
+		uint64_t pchbusy, pchg, piov, pnew;
+		/* Chip Errata: bug 6641; even and odd qwords>3 are swapped */
+		piov = devdata[t].ipath_pioavailregs_dma[i > 3 ? i ^ 1 : i];
+		pchg =
+		    _IPATH_ALL_CHECKBITS & ~(devdata[t].
+					     ipath_pioavailshadow[i] ^ piov);
+		pchbusy = pchg << INFINIPATH_SENDPIOAVAIL_BUSY_SHIFT;
+		if (pchg && (pchbusy & devdata[t].ipath_pioavailshadow[i])) {
+			pnew = devdata[t].ipath_pioavailshadow[i] & ~pchbusy;
+			pnew |= piov & pchbusy;
+			devdata[t].ipath_pioavailshadow[i] = pnew;
+		}
+	}
+	spin_unlock_irqrestore(&ipath_pioavail_lock, flags);
+}
+
+static int ipath_do_user_init(struct ipath_portdata *pd,
+			      struct ipath_user_info __user *uinfo)
+{
+	int ret = 0;
+	ipath_type t = pd->port_unit;
+	struct ipath_devdata *dd = &devdata[t];
+	struct ipath_user_info kinfo;
+
+	if (copy_from_user(&kinfo, uinfo, sizeof kinfo))
+		ret = -EFAULT;
+	else {
+		/* for now, if major version is different, bail */
+		if ((kinfo.spu_userversion >> 16) != IPATH_USER_SWMAJOR) {
+			_IPATH_INFO
+			    ("User major version %d not same as driver major %d\n",
+			     kinfo.spu_userversion >> 16, IPATH_USER_SWMAJOR);
+			ret = -ENODEV;
+		} else {
+			if ((kinfo.spu_userversion & 0xffff) !=
+			    IPATH_USER_SWMINOR)
+				_IPATH_DBG
+				    ("User minor version %d not same as driver minor %d\n",
+				     kinfo.spu_userversion & 0xffff,
+				     IPATH_USER_SWMINOR);
+			if (kinfo.spu_rcvhdrsize) {
+				if ((ret =
+				     ipath_setrcvhdrsize(t,
+							 kinfo.spu_rcvhdrsize)))
+					goto done;
+			} else if (!dd->ipath_rcvhdrsize) {
+				/*
+				 * first user of field, kernel or user
+				 * code, and using default
+				 */
+				dd->ipath_rcvhdrsize = IPATH_DFLT_RCVHDRSIZE;
+				ipath_kput_kreg(pd->port_unit, kr_rcvhdrsize,
+						dd->ipath_rcvhdrsize);
+				_IPATH_VDBG
+				    ("Use default protocol header size %u\n",
+				     dd->ipath_rcvhdrsize);
+			}
+
+			pd->port_egrskip = kinfo.spu_egrskip;
+			if (pd->port_egrskip) {
+				if (pd->port_egrskip & 3) {
+					_IPATH_DBG
+					    ("eager skip 0x%x invalid, must be word multiple; using 0x%x\n",
+					     pd->port_egrskip,
+					     pd->port_egrskip & ~3);
+					pd->port_egrskip &= ~3;
+				}
+				_IPATH_DBG
+				    ("user reserves 0x%x bytes at start of eager TIDs\n",
+				     pd->port_egrskip);
+			}
+
+			/*
+			 * for now we do nothing with rcvhdrcnt:
+			 * kinfo.spu_rcvhdrcnt
+			 */
+
+			/*
+			 * set up for the rcvhdr Q tail register writeback
+			 * to user memory
+			 */
+			if (kinfo.spu_rcvhdraddr &&
+			    access_ok(VERIFY_WRITE,
+				      (uint64_t __user *) kinfo.spu_rcvhdraddr,
+				      sizeof(uint64_t))) {
+				uint64_t physaddr, uaddr, off, atmp;
+				struct page *pagep;
+				off = offset_in_page(kinfo.spu_rcvhdraddr);
+				uaddr =
+				    PAGE_MASK & (unsigned long)kinfo.
+				    spu_rcvhdraddr;
+				if ((ret = ipath_get_upages_nocopy(uaddr, &pagep))) {
+					_IPATH_INFO
+					    ("Failed to lookup and lock address %llx for rcvhdrtail: errno %d\n",
+					     kinfo.spu_rcvhdraddr, -ret);
+					goto done;
+				}
+				ipath_stats.sps_pagelocks++;
+				pd->port_rcvhdrtail_uaddr = uaddr;
+				pd->port_rcvhdrtail_pagep = pagep;
+				pd->port_rcvhdrtail_kvaddr =
+				    page_address(pagep);
+				pd->port_rcvhdrtail_kvaddr += off;
+				physaddr = page_to_phys(pagep) + off;
+				_IPATH_VDBG
+				    ("port %d user addr %llx hdrtailaddr, %llx physical (off=%llx)\n",
+				     pd->port_port, kinfo.spu_rcvhdraddr,
+				     physaddr, off);
+				ipath_kput_kreg_port(t, kr_rcvhdrtailaddr,
+						     pd->port_port, physaddr);
+				atmp =
+				    ipath_kget_kreg64_port(t, kr_rcvhdrtailaddr,
+							   pd->port_port);
+				if (physaddr != atmp) {
+					_IPATH_UNIT_ERROR(t,
+							  "Catastrophic software error, RcvHdrTailAddr%u written as %llx, read back as %llx\n",
+							  pd->port_port,
+							  physaddr, atmp);
+					ret = -EINVAL;
+					goto done;
+				}
+			} else {
+				_IPATH_DBG
+				    ("Port %d rcvhdrtail addr %llx not valid\n",
+				     pd->port_port, kinfo.spu_rcvhdraddr);
+				ret = -EINVAL;
+				goto done;
+			}
+
+			/*
+			 * for right now, kernel piobufs are at end,
+			 * so port 1 is at 0
+			 */
+			pd->port_piobufs = dd->ipath_piobufbase +
+			    dd->ipath_pbufsport * (pd->port_port -
+						   1) * dd->ipath_palign;
+			_IPATH_VDBG("Set base of piobufs for port %u to 0x%x\n",
+				    pd->port_port, pd->port_piobufs);
+
+			/*
+			 * Now allocate the rcvhdr Q and eager TIDs;
+			 * skip the TID array for time being.
+			 * If pd->port_port > chip-supported, we need
+			 * to do extra stuff here to handle by handling
+			 * overflow through port 0, someday
+			 */
+			if (!(ret = ipath_create_rcvhdrq(pd)))
+				ret = ipath_create_user_egr(pd);
+			if (!ret) {	/* enable receives now */
+				uint64_t head;
+				uint32_t head32;
+				/* atomically set enable bit for this port */
+				atomic_set_mask(1U <<
+						(INFINIPATH_R_PORTENABLE_SHIFT +
+						 pd->port_port),
+						&dd->ipath_rcvctrl);
+
+				/*
+				 * set the head registers for this port
+				 * to the current values of the tail
+				 * pointers, since we don't know if they
+				 * were updated on last use of the port.
+				 */
+				head32 =
+				    ipath_kget_ureg32(t, ur_rcvhdrtail,
+						      pd->port_port);
+				head = (uint64_t) head32;
+				ipath_kput_ureg(t, ur_rcvhdrhead, head,
+						pd->port_port);
+				head32 =
+				    ipath_kget_ureg32(t, ur_rcvegrindextail,
+						      pd->port_port);
+				ipath_kput_ureg(t, ur_rcvegrindexhead, head32,
+						pd->port_port);
+				dd->ipath_lastegrheads[pd->port_port] = -1;
+				dd->ipath_lastrcvhdrqtails[pd->port_port] = -1;
+				_IPATH_VDBG
+				    ("Wrote port%d head %llx, egrhead %x from tail regs\n",
+				     pd->port_port, head, head32);
+				/* start at beginning after open */
+				pd->port_tidcursor = 0;
+				{
+					/*
+					 * now enable the port; the tail
+					 * registers will be written to
+					 * memory by the chip as soon
+					 * as it sees the write to
+					 * kr_rcvctrl.  The update only
+					 * happens on transition from 0
+					 * to 1, so clear it first, then
+					 * set it as part of enabling
+					 * the port.  This will (very
+					 * briefly) affect any other open
+					 * ports, but it shouldn't be long
+					 * enough to be an issue.
+					 */
+					ipath_kput_kreg(t, kr_rcvctrl,
+							dd->
+							ipath_rcvctrl &
+							~INFINIPATH_R_TAILUPD);
+					ipath_kput_kreg(t, kr_rcvctrl,
+							dd->ipath_rcvctrl);
+				}
+			}
+		}
+	}
+
+done:
+	return ret;
+}
+
+static int ipath_get_baseinfo(struct ipath_portdata *pd,
+			      struct ipath_base_info __user *ubase)
+{
+	int ret = 0;
+	struct ipath_base_info kbase;
+	struct ipath_devdata *dd = &devdata[pd->port_unit];
+
+	/* be sure anything we don't set is 0ed */
+	memset(&kbase, 0, sizeof kbase);
+	kbase.spi_rcvhdr_cnt = dd->ipath_rcvhdrcnt;
+	kbase.spi_rcvhdrent_size = dd->ipath_rcvhdrentsize;
+	kbase.spi_tidegrcnt = dd->ipath_rcvegrcnt;
+	kbase.spi_rcv_egrbufsize = dd->ipath_rcvegrbufsize;
+	kbase.spi_rcv_egrbuftotlen = pd->port_rcvegrbuf_chunks * PAGE_SIZE * (1 << pd->port_rcvegrbuf_order);	/* have to mmap whole thing */
+	kbase.spi_rcv_egrperchunk = pd->port_rcvegrbufs_perchunk;
+	kbase.spi_rcv_egrchunksize = kbase.spi_rcv_egrbuftotlen /
+	    pd->port_rcvegrbuf_chunks;
+	kbase.spi_tidcnt = dd->ipath_rcvtidcnt;
+	/*
+	 * for this use, may be ipath_cfgports summed over all chips that
+	 * are are configured and present
+	 */
+	kbase.spi_nports = dd->ipath_cfgports;
+	kbase.spi_unit = pd->port_unit;	/* unit (chip/board) our port is on */
+	/* for now, only a single page */
+	kbase.spi_tid_maxsize = PAGE_SIZE;
+
+	/*
+	 * doing this per port, and based on the skip value, etc.
+	 * This has to be the actual buffer size, since the protocol
+	 * code treats it as an array.
+	 *
+	 * These have to be set to user addresses in the user code via mmap
+	 * These values are used on return to user code for the mmap target
+	 * addresses only.  For 32 bit, same 44 bit address problem, so use
+	 * the physical address, not virtual.  Before 2.6.11, using the
+	 * page_address() macro worked, but in 2.6.11, even that returns
+	 * the full 64 bit address (upper bits all 1's).
+	 * So far, using the physical addresses (or chip offsets, for
+	 * chip mapping) works, but no doubt some future kernel release
+	 * will chang that, and we'll be on to yet another method of
+	 * dealing with this
+	 */
+	kbase.spi_rcvhdr_base = (uint64_t) pd->port_rcvhdrq_phys;
+	kbase.spi_rcv_egrbufs = (uint64_t) pd->port_rcvegr_phys;
+	kbase.spi_pioavailaddr = (uint64_t) dd->ipath_pioavailregs_phys;
+	kbase.spi_status = (uint64_t) kbase.spi_pioavailaddr +
+	    (void *)dd->ipath_statusp - (void *)dd->ipath_pioavailregs_dma;
+	kbase.spi_piobufbase = (uint64_t) pd->port_piobufs;
+	kbase.__spi_uregbase =
+	    dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
+
+	kbase.spi_pioindex = dd->ipath_pbufsport * (pd->port_port - 1);
+	kbase.spi_piocnt = dd->ipath_pbufsport;
+	kbase.spi_pioalign = dd->ipath_palign;
+
+	kbase.spi_qpair = IPATH_KD_QP;
+	kbase.spi_piosize = dd->ipath_ibmaxlen;
+	kbase.spi_mtu = dd->ipath_ibmaxlen;	/* maxlen, not ibmtu */
+	kbase.spi_port = pd->port_port;
+	kbase.spi_sw_version = IPATH_KERN_SWVERSION;
+	kbase.spi_hw_version = dd->ipath_revision;
+
+	if (copy_to_user(ubase, &kbase, sizeof kbase))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+/*
+ * return number of units supported by driver.  This is infinipath_max,
+ * unless there are no initted units.
+ */
+static int ipath_get_units(void)
+{
+	int i;
+
+	for (i = 0; i < infinipath_max; i++)
+		if (devdata[i].ipath_flags & IPATH_INITTED)
+			return infinipath_max;
+	return 0;
+}
+
+/* write data to the EEPROM on the board */
+static int ipath_wr_eeprom(struct ipath_portdata* pd,
+			   struct ipath_eeprom_req __user *req)
+{
+	int ret = 0;
+	struct ipath_eeprom_req kreq;
+	void *buf = NULL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;	/* not just any old user can write flash */
+	if (copy_from_user(&kreq, req, sizeof kreq))
+		return -EFAULT;
+	if (!kreq.addr || (kreq.offset + kreq.len) > 128) {
+		_IPATH_DBG
+		    ("called with NULL addr %llx, or bad cnt %u or offset %u\n",
+		     kreq.addr, kreq.len, kreq.offset);
+		return -EINVAL;
+	}
+
+	if (!(buf = vmalloc(kreq.len))) {
+		ret = -ENOMEM;
+		_IPATH_UNIT_ERROR(pd->port_unit,
+				  "Couldn't allocate memory to write %u bytes from eeprom\n",
+				  kreq.len);
+		goto done;
+	}
+	if (copy_from_user(buf, (void __user *) kreq.addr, kreq.len)) {
+		ret = -EFAULT;
+		goto done;
+	}
+	if (ipath_eeprom_write(pd->port_unit, kreq.offset, buf, kreq.len)) {
+		ret = -ENXIO;
+		_IPATH_UNIT_ERROR(pd->port_unit,
+				  "Failed write to eeprom %u bytes offset %u\n",
+				  kreq.len, kreq.offset);
+	}
+
+done:
+	if (buf)
+		vfree(buf);
+	return ret;
+}
+
+/* read data from the EEPROM on the board */
+int ipath_rd_eeprom(const ipath_type port_unit,
+		    struct ipath_eeprom_req __user *req)
+{
+	int ret = 0;
+	struct ipath_eeprom_req kreq;
+	void *buf = NULL;
+
+	if (copy_from_user(&kreq, req, sizeof kreq))
+		return -EFAULT;
+	if (!kreq.addr || (kreq.offset + kreq.len) > 128) {
+		_IPATH_DBG
+		    ("called with NULL addr %llx, or bad cnt %u or offset %u\n",
+		     kreq.addr, kreq.len, kreq.offset);
+		return -EINVAL;
+	}
+
+	if (!(buf = vmalloc(kreq.len))) {
+		ret = -ENOMEM;
+		_IPATH_UNIT_ERROR(port_unit,
+				  "Couldn't allocate memory to read %u bytes from eeprom\n",
+				  kreq.len);
+		goto done;
+	}
+	if (ipath_eeprom_read(port_unit, kreq.offset, buf, kreq.len)) {
+		ret = -ENXIO;
+		_IPATH_UNIT_ERROR(port_unit,
+				  "Failed reading %u bytes offset %u from eeprom\n",
+				  kreq.len, kreq.offset);
+	}
+	if (copy_to_user((void __user *) kreq.addr, buf, kreq.len))
+		ret = -EFAULT;
+
+done:
+	if (buf)
+		vfree(buf);
+	return ret;
+}
+
+/*
+ * wait for something to happen on a port.  Currently this is
+ * PIO buffer available, or a packet being received.  For now, at
+ * least, we wait no longer than 1/2 seconds on rcv, 1 tick on PIO, so
+ * we recover from any bugs (or, as we see in ips.c init and close, cases
+ * where other side isn't yet ready).
+ * NOTE: currently called only with PIO or RCV, never both, so path with both
+ * has not been tested
+ */
+static int ipath_wait_intr(struct ipath_portdata * pd, uint32_t flag)
+{
+	struct ipath_devdata *dd = &devdata[pd->port_unit];
+	/* stupid compiler can't tell it's initialized */
+	uint32_t im = 0;
+	uint32_t head, tail, timeo = 0, wflag = 0;
+
+	if (!(flag & (IPATH_WAIT_RCV | IPATH_WAIT_PIO)))
+		return -EINVAL;
+	if (flag & IPATH_WAIT_RCV) {
+		head = flag >> 16;
+		im = (1U << pd->port_port) << INFINIPATH_R_INTRAVAIL_SHIFT;
+		atomic_set_mask(im, &dd->ipath_rcvctrl);
+		/*
+		 * now, before blocking, make sure that head is still == tail,
+		 * reading from the chip, so we can be sure the interrupt enable
+		 * has made it to the chip.  If not equal, disable
+		 * interrupt again and return immediately.  This avoids
+		 * races, and the overhead of the chip read doesn't
+		 * matter much at this point, since we are waiting for
+		 * something anyway.
+		 */
+		ipath_kput_kreg(pd->port_unit, kr_rcvctrl, dd->ipath_rcvctrl);
+		tail =
+		    ipath_kget_ureg32(pd->port_unit, ur_rcvhdrtail,
+				      pd->port_port);
+		if (tail == head) {
+			timeo = HZ / 2;
+			wflag = IPATH_PORT_WAITING_RCV;
+		} else {
+			atomic_clear_mask(im, &dd->ipath_rcvctrl);
+			ipath_kput_kreg(pd->port_unit, kr_rcvctrl,
+					dd->ipath_rcvctrl);
+		}
+	}
+	if (flag & IPATH_WAIT_PIO) {
+		/*
+		 * this one's a bit worse than the receive case, in that we
+		 * can't really verify that at least one interrupt
+		 * will happen...
+		 * We do use a really short timeout, however
+		 */
+		timeo = 1;	/* if both, the short PIO timeout wins */
+		atomic_set_mask(1U << pd->port_port, &dd->ipath_portpiowait);
+		wflag |= IPATH_PORT_WAITING_PIO;
+		/*
+		 * this has a possible race with the ipath stuff, so do
+		 * it atomicly
+		 */
+		atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+				&dd->ipath_sendctrl);
+		ipath_kput_kreg(pd->port_unit, kr_sendctrl, dd->ipath_sendctrl);
+	}
+	if (wflag) {
+		pd->port_flag |= wflag;
+		wait_event_interruptible_timeout(pd->port_wait,
+						 (pd->port_flag & wflag) !=
+						 wflag, timeo);
+		if (wflag & pd->port_flag & IPATH_PORT_WAITING_PIO) {
+			/* timed out, no PIO interrupts */
+			atomic_clear_mask(IPATH_PORT_WAITING_PIO,
+					  &pd->port_flag);
+			pd->port_piowait_to++;
+			atomic_clear_mask(1U << pd->port_port,
+					  &dd->ipath_portpiowait);
+			/*
+			 * *don't* clear the pio interrupt enable;
+			 * let that happen in the interrupt handler;
+			 * else we have a race condition.
+			 */
+		}
+		if (wflag & pd->port_flag & IPATH_PORT_WAITING_RCV) {
+			/* timed out, no packets received */
+			atomic_clear_mask(IPATH_PORT_WAITING_RCV,
+					  &pd->port_flag);
+			pd->port_rcvwait_to++;
+			atomic_clear_mask(im, &dd->ipath_rcvctrl);
+			ipath_kput_kreg(pd->port_unit, kr_rcvctrl,
+					dd->ipath_rcvctrl);
+		}
+	} else {
+		/* else it's already happened, don't do wait_event overhead */
+		if (flag & IPATH_WAIT_RCV)
+			pd->port_rcvnowait++;
+		if (flag & IPATH_WAIT_PIO)
+			pd->port_pionowait++;
+	}
+	return 0;
+}
+
+/*
+ * The new implementation as of Oct 2004 is that the driver assigns
+ * the tid and returns it to the caller.   To make it easier to
+ * catch bugs, and to reduce search time, we keep a cursor for
+ * each port, walking the shadow tid array to find one that's not
+ * in use.
+ *
+ * For now, if we can't allocate the full list, we fail, although
+ * in the long run, we'll allocate as many as we can, and the
+ * caller will deal with that by trying the remaining pages later.
+ * That means that when we fail, we have to mark the tids as not in
+ * use again, in our shadow copy.
+ *
+ * It's up to the caller to free the tids when they are done.
+ * We'll unlock the pages as they free them.
+ *
+ * Also, right now we are locking one page at a time, but since
+ * the intended use of this routine is for a single group of
+ * virtually contiguous pages, that should change to improve
+ * performance.
+ */
+static int ipath_tid_update(struct ipath_portdata * pd,
+			    struct _tidupd __user *tidu)
+{
+	int ret = 0, ntids;
+	uint32_t tid, porttid, cnt, i, tidcnt;
+	struct _tidupd tu;
+	uint16_t *tidlist;
+	struct ipath_devdata *dd = &devdata[pd->port_unit];
+	uint64_t vaddr, physaddr, lenvalid;
+	uint64_t __iomem *tidbase;
+	uint64_t tidmap[8];
+	struct page **pagep = NULL;
+
+	tu.tidcnt = 0;		/* for early errors */
+	if (!dd->ipath_pageshadow) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	if (copy_from_user(&tu, tidu, sizeof tu)) {
+		ret = -EFAULT;
+		goto done;
+	}
+
+	if (!(cnt = tu.tidcnt)) {
+		_IPATH_DBG("After copyin, tidcnt 0, tidlist %llx\n",
+			   tu.tidlist);
+		/* or should we treat as success?  likely a bug */
+		ret = -EFAULT;
+		goto done;
+	}
+	tidcnt = dd->ipath_rcvtidcnt;
+	if (cnt >= tidcnt) {	/* make sure it all fits in port_tid_pg_list */
+		_IPATH_INFO
+		    ("Process tried to allocate %u TIDs, only trying max (%u)\n",
+		     cnt, tidcnt);
+		cnt = tidcnt;
+	}
+	pagep = (struct page **)pd->port_tid_pg_list;
+	tidlist = (uint16_t *) (&pagep[cnt]);
+
+	memset(tidmap, 0, sizeof(tidmap));
+	tid = pd->port_tidcursor;
+	/* before decrement; chip actual # */
+	porttid = pd->port_port * tidcnt;
+	ntids = tidcnt;
+	tidbase = (uint64_t __iomem *)
+		(((char __iomem *) devdata[pd->port_unit].ipath_kregbase) +
+		devdata[pd->port_unit].ipath_rcvtidbase +
+		porttid * sizeof(*tidbase));
+
+	_IPATH_VDBG("Port%u %u tids, cursor %u, tidbase %p\n", pd->port_port,
+		    cnt, tid, tidbase);
+
+	vaddr = tu.tidvaddr;	/* virtual address of first page in transfer */
+	if (!access_ok(VERIFY_WRITE, (void __user *) vaddr, cnt * PAGE_SIZE)) {
+		_IPATH_DBG("Fail vaddr %llx, %u pages, !access_ok\n",
+			   vaddr, cnt);
+		ret = -EFAULT;
+		goto done;
+	}
+	if ((ret = ipath_get_upages((unsigned long)vaddr, cnt, pagep))) {
+		if (ret == -EBUSY) {
+			_IPATH_DBG
+			    ("Failed to lock addr %p, %u pages (already locked)\n",
+			     (void *)vaddr, cnt);
+			/*
+			 * for now, continue, and see what happens
+			 * but with the new implementation, this should
+			 * never happen, unless perhaps the user has
+			 * mpin'ed the pages themselves (something we
+			 * need to test)
+			 */
+			ret = 0;
+		} else {
+			_IPATH_INFO
+			    ("Failed to lock addr %p, %u pages: errno %d\n",
+			     (void *)vaddr, cnt, -ret);
+			goto done;
+		}
+	}
+	for (i = 0; i < cnt; i++, vaddr += PAGE_SIZE) {
+		for (; ntids--; tid++) {
+			if (tid == tidcnt)
+				tid = 0;
+			if (!dd->ipath_pageshadow[porttid + tid])
+				break;
+		}
+		if (ntids < 0) {
+			/*
+			 * oops, wrapped all the way through their TIDs,
+			 * and didn't have enough free; see comments at
+			 * start of routine
+			 */
+			_IPATH_DBG
+			    ("Not enough free TIDs for %u pages (index %d), failing\n",
+			     cnt, i);
+			i--;	/* last tidlist[i] not filled in */
+			ret = -ENOMEM;
+			break;
+		}
+		tidlist[i] = tid;
+		_IPATH_VDBG("Updating idx %u to TID %u, vaddr %llx\n",
+			    i, tid, vaddr);
+		/* for now we "know" system pages and TID pages are same size */
+		/* for ipath_free_tid */
+		dd->ipath_pageshadow[porttid + tid] = pagep[i];
+		__set_bit(tid, tidmap);	/* don't need atomic or it's overhead */
+		physaddr = page_to_phys(pagep[i]);
+		ipath_stats.sps_pagelocks++;
+		_IPATH_VDBG("TID %u, vaddr %llx, physaddr %llx pgp %p\n",
+			    tid, vaddr, physaddr, pagep[i]);
+		/*
+		 * in words (fixed, full page).  could make less for very last
+		 * page in transfer, but for now we won't worry about it.
+		 */
+		lenvalid = PAGE_SIZE >> 2;
+		lenvalid <<= INFINIPATH_RT_BUFSIZE_SHIFT;
+		physaddr |= lenvalid | INFINIPATH_RT_VALID;
+		ipath_kput_memq(pd->port_unit, &tidbase[tid], physaddr);
+		/*
+		 * don't check this tid in ipath_portshadow, since we
+		 * just filled it in; start with the next one.
+		 */
+		tid++;
+	}
+
+	if (ret) {
+		uint32_t limit;
+		uint64_t tidval;
+		/*
+		 * chip errata bug 7358, try to work around it by
+		 * marking invalid tids as having max length
+		 */
+		tidval =
+		    (-1LL & INFINIPATH_RT_BUFSIZE_MASK) <<
+		    INFINIPATH_RT_BUFSIZE_SHIFT;
+	      cleanup:
+		/* jump here if copy out of updated info failed... */
+		_IPATH_DBG("After failure (ret=%d), undo %d of %d entries\n",
+			   -ret, i, cnt);
+		/* same code that's in ipath_free_tid() */
+		if ((limit = sizeof(tidmap) * BITS_PER_BYTE) > tidcnt)
+			/* just in case size changes in future */
+			limit = tidcnt;
+		tid = find_first_bit((const unsigned long *)tidmap, limit);
+		/*
+		 * chip errata bug 7358, try to work around it by
+		 * marking invalid tids as having max length
+		 */
+		tidval =
+		    (-1LL & INFINIPATH_RT_BUFSIZE_MASK) <<
+		    INFINIPATH_RT_BUFSIZE_SHIFT;
+		for (; tid < limit; tid++) {
+			if (!test_bit(tid, tidmap))
+				continue;
+			if (dd->ipath_pageshadow[porttid + tid]) {
+				_IPATH_VDBG("Freeing TID %u\n", tid);
+				ipath_kput_memq(pd->port_unit, &tidbase[tid],
+						tidval);
+				dd->ipath_pageshadow[porttid + tid] = NULL;
+				ipath_stats.sps_pageunlocks++;
+			}
+		}
+		ipath_putpages(cnt, pagep);
+	} else {
+		/*
+		 * copy the updated array, with ipath_tid's filled in,
+		 * back to user.  Since we did the copy in already, this
+		 * "should never fail"
+		 * If it does, we have to clean up...
+		 */
+		int r;
+		if ((r = copy_to_user((void __user *) tu.tidlist, tidlist,
+				      cnt * sizeof(*tidlist)))) {
+			_IPATH_DBG("Failed to copy out %d TIDs (%lx bytes) "
+				   "to %llx (ret %x)\n", cnt,
+				    cnt * sizeof(*tidlist), tu.tidlist, r);
+			ret = -EFAULT;
+			goto cleanup;
+		}
+		if (copy_to_user((void __user *) tu.tidmap, tidmap,
+				 sizeof tidmap)) {
+			_IPATH_DBG("Failed to copy out TID map to %llx\n",
+				   tu.tidmap);
+			ret = -EFAULT;
+			goto cleanup;
+		}
+		if (tid == tidcnt)
+			tid = 0;
+		pd->port_tidcursor = tid;
+	}
+
+done:
+	if (ret)
+		_IPATH_DBG("Failed to map %u TID pages, failing with %d, "
+			   "tidu %p\n", tu.tidcnt, -ret, tidu);
+	return ret;
+}
+
+/*
+ * right now we are unlocking one page at a time, but since
+ * the intended use of this routine is for a single group of
+ * virtually contiguous pages, that should change to improve
+ * performance.  We check that the TID is in range for this port
+ * but otherwise don't check validity; if user has an error and
+ * frees the wrong tid, it's only their own data that can thereby
+ * be corrupted.  We do check that the TID was in use, for sanity
+ * We always use our idea of the saved address, not the address that
+ * they pass in to us.
+ */
+
+static int ipath_tid_free(struct ipath_portdata * pd,
+			  struct _tidupd __user *tidu)
+{
+	int ret = 0;
+	uint32_t tid, porttid, cnt, limit, tidcnt;
+	struct _tidupd tu;
+	struct ipath_devdata *dd = &devdata[pd->port_unit];
+	uint64_t __iomem *tidbase;
+	uint64_t tidmap[8];
+	uint64_t tidval;
+
+	tu.tidcnt = 0;		/* for early errors */
+	if (!dd->ipath_pageshadow) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	if (copy_from_user(&tu, tidu, sizeof tu)) {
+		_IPATH_DBG("copy of tidupd structure failed\n");
+		ret = -EFAULT;
+		goto done;
+	}
+	if (copy_from_user(tidmap, (void __user *) tu.tidmap, sizeof tidmap)) {
+		_IPATH_DBG("copy of tidmap failed\n");
+		ret = -EFAULT;
+		goto done;
+	}
+
+	porttid = pd->port_port * dd->ipath_rcvtidcnt;
+	tidbase = (uint64_t __iomem *)
+		((char __iomem *) (devdata[pd->port_unit].ipath_kregbase) +
+		 devdata[pd->port_unit].ipath_rcvtidbase +
+		 porttid * sizeof(*tidbase));
+
+	tidcnt = dd->ipath_rcvtidcnt;
+	if ((limit = sizeof(tidmap) * BITS_PER_BYTE) > tidcnt)
+		limit = tidcnt;	/* just in case size changes in future */
+	tid = find_first_bit((const unsigned long *)tidmap, limit);
+	_IPATH_VDBG
+	    ("Port%u free %u tids; first bit (max=%d) set is %d, porttid %u\n",
+	     pd->port_port, tu.tidcnt, limit, tid, porttid);
+	/*
+	 * chip errata bug 7358, try to work around it by marking invalid
+	 * tids as having max length
+	 */
+	tidval =
+	    (-1LL & INFINIPATH_RT_BUFSIZE_MASK) << INFINIPATH_RT_BUFSIZE_SHIFT;
+	for (cnt = 0; tid < limit; tid++) {
+		/*
+		 * small optimization; if we detect a run of 3 or so without
+		 * any set, use find_first_bit again.  That's mainly to
+		 * accelerate the case where we wrapped, so we have some at
+		 * the beginning, and some at the end, and a big gap
+		 * in the middle.
+		 */
+		if (!test_bit(tid, tidmap))
+			continue;
+		cnt++;
+		if (dd->ipath_pageshadow[porttid + tid]) {
+			_IPATH_VDBG("Freeing TID %u\n", tid);
+			ipath_kput_memq(pd->port_unit, &tidbase[tid], tidval);
+			ipath_putpages(1, &dd->ipath_pageshadow[porttid + tid]);
+			dd->ipath_pageshadow[porttid + tid] = NULL;
+			ipath_stats.sps_pageunlocks++;
+		} else
+			_IPATH_DBG("Unused tid %u, ignoring\n", tid);
+	}
+	if (cnt != tu.tidcnt)
+		_IPATH_DBG("passed in tidcnt %d, only %d bits set in map\n",
+			   tu.tidcnt, cnt);
+done:
+	if (ret)
+		_IPATH_DBG("Failed to unmap %u TID pages, failing with %d\n",
+			   tu.tidcnt, -ret);
+	return ret;
+}
+
+/* called from user init code, and also layered driver init */
+int ipath_setrcvhdrsize(const ipath_type mdev, unsigned rhdrsize)
+{
+	int ret = 0;
+	if (devdata[mdev].ipath_flags & IPATH_RCVHDRSZ_SET) {
+		if (devdata[mdev].ipath_rcvhdrsize != rhdrsize) {
+			_IPATH_INFO
+			    ("Error: can't set protocol header size %u, already %u\n",
+			     rhdrsize, devdata[mdev].ipath_rcvhdrsize);
+			ret = -EAGAIN;
+		} else
+			/* OK if set already, with same value, nothing to do */
+			_IPATH_VDBG("Reuse same protocol header size %u\n",
+				    devdata[mdev].ipath_rcvhdrsize);
+	} else if (rhdrsize >
+		   (devdata[mdev].ipath_rcvhdrentsize -
+		    (sizeof(uint64_t) / sizeof(uint32_t)))) {
+		_IPATH_DBG
+		    ("Error: can't set protocol header size %u (> max %u)\n",
+		     rhdrsize,
+		     devdata[mdev].ipath_rcvhdrentsize -
+		     (uint32_t) (sizeof(uint64_t) / sizeof(uint32_t)));
+		ret = -EOVERFLOW;
+	} else {
+		devdata[mdev].ipath_flags |= IPATH_RCVHDRSZ_SET;
+		devdata[mdev].ipath_rcvhdrsize = rhdrsize;
+		ipath_kput_kreg(mdev, kr_rcvhdrsize,
+				devdata[mdev].ipath_rcvhdrsize);
+		_IPATH_VDBG("Set protocol header size to %u\n",
+			    devdata[mdev].ipath_rcvhdrsize);
+	}
+	return ret;
+}
+
+
+/*
+ * find an available pio buffer, and do appropriate marking as busy, etc.
+ * returns buffer number if one found (>=0), negative number is error.
+ * Used by ipath_send_smapkt and ipath_layer_send
+ */
+uint32_t __iomem *ipath_getpiobuf(int mdev, uint32_t *pbufnum)
+{
+	int i, j, starti, updated = 0;
+	unsigned piobcnt, iter;
+	unsigned long flags;
+	struct ipath_devdata *dd = &devdata[mdev];
+	uint64_t *shadow = dd->ipath_pioavailshadow;
+	uint32_t __iomem *buf;
+
+	piobcnt = (unsigned)devdata[mdev].ipath_piobcnt;
+	starti = devdata[mdev].ipath_lastport_piobuf;
+	iter = piobcnt - starti;
+	if (dd->ipath_upd_pio_shadow) {
+		/*
+		 * minor optimization.  If we had no buffers on last call, start out
+		 * by doing the update; continue and do scan even if no buffers
+		 * were updated, to be paranoid
+		 */
+		ipath_update_pio_bufs(mdev);
+		updated = 1;    /* we scanned here, don't do it at end of scan */
+		i = starti;
+	}
+	else
+		i = devdata[mdev].ipath_lastpioindex;
+
+rescan:
+	/*
+	 * while test_and_set_bit() is atomic,
+	 * we do that and then the change_bit(), and the pair is not.
+	 * See if this is the cause of the remaining armlaunch errors.
+	 */
+	spin_lock_irqsave(&ipath_pioavail_lock, flags);
+	for (j = 0; j < iter; j++, i++) {
+		if (i >= piobcnt)
+			i = starti;
+		/*
+		 * To avoid bus lock overhead, we first find a candidate
+		 * buffer, then do the test and set, and continue if that fails.
+		 */
+		if (test_bit((2 * i) + 1, shadow) ||
+		    test_and_set_bit((2 * i) + 1, shadow)) {
+			continue;
+		}
+		/* flip generation bit */
+		change_bit(2 * i, shadow);
+		break;
+	}
+	spin_unlock_irqrestore(&ipath_pioavail_lock, flags);
+
+	if (j == iter) {
+		/*
+		 * first time through; shadow exhausted, but may be
+		 * real buffers available, so go see; if any updated, rescan (once)
+		 */
+		if (!updated) {
+			ipath_update_pio_bufs(mdev);
+			updated = 1;
+			i = starti;
+			goto rescan;
+		}
+		dd->ipath_upd_pio_shadow = 1;
+		/* not atomic, but if we lose one once in a while, that's OK */
+		ipath_stats.sps_nopiobufs++;
+		if (!(++dd->ipath_consec_nopiobuf % 100000)) {
+			_IPATH_DBG
+			    ("%u pio sends with no bufavail; dmacopy: %llx %llx %llx %llx; shadow:  %llx %llx %llx %llx\n",
+			     dd->ipath_consec_nopiobuf,
+			     dd->ipath_pioavailregs_dma[0],
+			     dd->ipath_pioavailregs_dma[1],
+			     dd->ipath_pioavailregs_dma[2],
+			     dd->ipath_pioavailregs_dma[3],
+			     shadow[0], shadow[1], shadow[2], shadow[3]);
+			/*
+			 * 4 buffers per byte, 4 registers above, cover
+			 * rest below
+			 */
+			if (dd->ipath_piobcnt > (sizeof(shadow[0])
+					* 4 * 4))
+				_IPATH_DBG
+				    ("2nd group: dmacopy: %llx %llx %llx %llx; shadow: %llx %llx %llx %llx\n",
+				    devdata[mdev].ipath_pioavailregs_dma[4],
+				    devdata[mdev].ipath_pioavailregs_dma[5],
+				    devdata[mdev].ipath_pioavailregs_dma[6],
+				    devdata[mdev].ipath_pioavailregs_dma[7],
+				    shadow[4], shadow[5], shadow[6], shadow[7]);
+		}
+		return NULL;
+	}
+
+	if (updated && devdata[mdev].ipath_layer.l_intr) {
+		/*
+		 * ran out of bufs, now some (at least this one we just got)
+		 * are now available, so tell the layered driver.
+		 */
+		dd->ipath_layer.l_intr(mdev, IPATH_LAYER_INT_SEND_CONTINUE);
+	}
+
+	/*
+	 * set next starting place.  Since it's just an optimization,
+	 * it doesn't matter who wins on this, so no locking
+	 */
+	dd->ipath_lastpioindex = i + 1;
+	if (dd->ipath_upd_pio_shadow)
+		dd->ipath_upd_pio_shadow = 0;
+	if (dd->ipath_consec_nopiobuf)
+		dd->ipath_consec_nopiobuf = 0;
+	buf = (uint32_t __iomem *)(dd->ipath_piobase + i * dd->ipath_palign);
+	_IPATH_VDBG("Return piobuf %u @ %p\n", i,  buf);
+	if (pbufnum)
+		*pbufnum = i;
+	return buf;
+}
+
+/*
+ * this is like ipath_getpiobuf(), except it just probes to see if a buffer
+ * is available.  If it returns that there is one, it's not allocated,
+ * and so may not be available if caller tries to send.
+ * NOTE: This can be called from interrupt context by ipath_intr()
+ * and from non-interrupt context by layer_send_getpiobuf().
+ */
+int ipath_bufavail(int mdev)
+{
+	int i;
+	unsigned piobcnt;
+	uint64_t *shadow = devdata[mdev].ipath_pioavailshadow;
+
+	piobcnt = (unsigned)devdata[mdev].ipath_piobcnt;
+
+	for (i = devdata[mdev].ipath_lastport_piobuf; i < piobcnt; i++)
+		if (!test_bit((2 * i) + 1, shadow))
+			return 1;
+
+	/* if none, check for update and rescan if we updated */
+	ipath_update_pio_bufs(mdev);
+	for (i = devdata[mdev].ipath_lastport_piobuf; i < piobcnt; i++)
+		if (!test_bit((2 * i) + 1, shadow))
+			return 1;
+	_IPATH_PDBG("No bufs avail\n");
+	return 0;
+}
+
+/*
+ * This routine is no longer on any critical paths; it is used only
+ * for sending SMA packets, and some diagnostic usage.
+ * Because it's currently sma only, there are no checks to see if the
+ * link is up; sma must be able to send in the not fully initialized state
+ */
+int ipath_send_smapkt(struct ipath_sendpkt __user *upkt)
+{
+	int i, ret = 0;
+	uint32_t __iomem *piobuf;
+	uint32_t plen = 0, clen, pbufn;
+	struct ipath_sendpkt kpkt;
+	struct ipath_iovec *iov = kpkt.sps_iov;
+	ipath_type t;
+	uint32_t *tmpbuf = NULL;
+
+	if (unlikely((copy_from_user(&kpkt, upkt, sizeof kpkt))))
+		ret = -EFAULT;
+	if (ret) {
+		_IPATH_VDBG("Send failed: error %d\n", -ret);
+		goto done;
+	}
+	t = kpkt.sps_flags;
+	if (t >= infinipath_max || !(devdata[t].ipath_flags & IPATH_PRESENT) ||
+	    !devdata[t].ipath_kregbase) {
+		_IPATH_SMADBG("illegal unit %u for sma send\n", t);
+		return -ENODEV;
+	}
+	if (!(devdata[t].ipath_flags & IPATH_INITTED)) {
+		/* no hardware, freeze, etc. */
+		_IPATH_SMADBG("unit %u not usable\n", t);
+		return -ENODEV;
+	}
+
+	/* need total length before first word written */
+	plen = sizeof(uint32_t);	/* +1 word is for the qword padding */
+	for (i = 0; i < kpkt.sps_cnt; i++)
+		/* each must be dword multiple */
+		plen += kpkt.sps_iov[i].iov_len;
+
+	if ((plen + 4) > devdata[t].ipath_ibmaxlen) {
+		_IPATH_DBG("Pkt len 0x%x > ibmaxlen %x\n",
+			plen - 4, devdata[t].ipath_ibmaxlen);
+		ret = -EINVAL;
+		goto done;	/* before writing pbc */
+	}
+	if (!(tmpbuf = vmalloc(plen))) {
+		_IPATH_INFO("Unable to allocate tmp buffer, failing\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+	plen >>= 2;		/* in words */
+
+	piobuf = ipath_getpiobuf(t, &pbufn);
+	if (!piobuf) {
+		ret = -EBUSY;
+		devdata[t].ipath_nosma_bufs++;
+		_IPATH_SMADBG("No PIO buffers available unit %u %u times\n",
+			t, devdata[t].ipath_nosma_bufs);
+		goto done;
+	}
+	if (devdata[t].ipath_nosma_bufs) {
+		_IPATH_SMADBG(
+			"Unit %u got SMA send buffer after %u failures, %u seconds\n",
+			t, devdata[t].ipath_nosma_bufs, devdata[t].ipath_nosma_secs);
+		devdata[t].ipath_nosma_bufs = 0;
+		devdata[t].ipath_nosma_secs = 0;
+	}
+	if ((devdata[t].ipath_lastibcstat & 0x11) != 0x11 &&
+		(devdata[t].ipath_lastibcstat & 0x21) != 0x21) {
+	    /* we need to be at least at INIT for SMA packets to go out.  If we
+	     * aren't, something has gone wrong, and SMA hasn't noticed.
+	     * Therefore we'll try to go to INIT here, in hopes of fixing up the
+	     * problem.  First we verify that indeed the state is still "bad"
+	     * (that is, that lastibcstat * isn't "stale") */
+	    uint64_t val;
+	    val = ipath_kget_kreg64(t, kr_ibcstatus);
+	    if ((val & 0x11) != 0x11 && (val & 0x21) != 0x21) {
+		_IPATH_SMADBG("Invalid Link state 0x%llx unit %u for send, try INIT\n",
+			val, t);
+		ipath_set_ib_lstate(t, INFINIPATH_IBCC_LINKCMD_INIT);
+		val = ipath_kget_kreg64(t, kr_ibcstatus);
+		if ((val & 0x11) != 0x11 && (val & 0x21) != 0x21)
+		    _IPATH_SMADBG("Link state still not OK unit %u (0x%llx) after INIT\n",
+				t, val);
+		else
+		    _IPATH_SMADBG("Link state OK unit %u (0x%llx) after INIT\n",
+				t, val);
+	    }
+	    /* and continue, regardless */
+	}
+
+	if (infinipath_debug & __IPATH_PKTDBG) // SMA and PKT, both
+		_IPATH_SMADBG("unit %u 0x%x+1w pio%d, (scnt %d)\n",
+			t, plen - 1, pbufn, kpkt.sps_cnt);
+
+
+	/* we have to flush after the PBC for correctness on some cpus
+	 * or WC buffer can be written out of order */
+	writeq(plen, piobuf);
+	mb();
+	ret = 0;
+	for (clen=i=0; i < kpkt.sps_cnt; i++) {
+		if (unlikely(copy_from_user(tmpbuf + clen,
+					    (void __user *) iov->iov_base,
+					    iov->iov_len)))
+			ret = -EFAULT;	/* no break */
+		clen += iov->iov_len >> 2;
+		iov++;
+	}
+	/* copy all by the trigger word, then flush, so it's written
+	 * to chip before trigger word, then write trigger word, then
+	 * flush again, so packet is sent. */
+	memcpy_toio32(piobuf+2, tmpbuf, clen-1);
+	mb();
+	writel(tmpbuf[clen-1], piobuf+clen+1);
+	mb();
+
+	if (ret) {
+		/*
+		 * Packet is bad, so we need to use the PIO abort mechanism to
+		 * abort the packet
+		 */
+		uint32_t sendctrl;
+		sendctrl = devdata[t].ipath_sendctrl | INFINIPATH_S_DISARM |
+		    (pbufn << INFINIPATH_S_DISARMPIOBUF_SHIFT);
+		_IPATH_DBG("Doing PIO abort on buffer %u after error\n",
+			   pbufn);
+		ipath_kput_kreg(t, kr_sendctrl, sendctrl);
+	}
+
+done:
+	vfree(tmpbuf);
+	return ret;
+}
+
+/*
+ * implemention of the ioctl to get the counter values from the chip
+ * For the time being, we get all of them when asked, no shadowing.
+ * We need to shadow the byte counters at a minimum, because otherwise
+ * they will wrap in just a few seconds at full bandwidth
+ * The second argument is the user address to which we do the copy_to_user()
+ */
+static int ipath_get_counters(ipath_type t,
+			      struct infinipath_counters __user *ucounters)
+{
+	int ret = 0;
+	uint64_t val;
+	uint64_t __user *ucreg;
+	uint16_t vcreg;
+
+	ucreg = (uint64_t __user *) ucounters;
+	/*
+	 * for now, let's do this one at a time.  It's not the most
+	 * optimal method, but it is simple, and has no intermediate
+	 * memory requirements.
+	 */
+	for (vcreg = 0;
+	     vcreg < (sizeof(struct infinipath_counters) / sizeof(val));
+	     vcreg++, ucreg++) {
+		ipath_creg creg = vcreg;
+		val = ipath_snap_cntr(t, creg);
+		if ((ret = copy_to_user(ucreg, &val, sizeof(val)))) {
+			_IPATH_DBG("copy_to_user error on counter %d\n", creg);
+			ret = -EFAULT;
+			break;
+		}
+	}
+
+	return ret;
+}
