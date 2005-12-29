Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVL2Alr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVL2Alr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVL2Ajb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:31 -0500
Received: from mx.pathscale.com ([64.160.42.68]:51688 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932576AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 20] ipath - core driver, part 4 of 4
X-Mercurial-Node: e8af3873b0d910e0c6239df453c08cd89499fabc
Message-Id: <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:30 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c37b118ef806 -r e8af3873b0d9 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:43 2005 -0800
@@ -5408,3 +5408,1709 @@
 
 	return ret;
 }
+
+/*
+ * implemention of the ioctl to get the stats values from the driver
+ * The argument is the user address to which we do the copy_to_user()
+ */
+static int ipath_get_stats(struct infinipath_stats __user *ustats)
+{
+	int ret = 0;
+
+	if ((ret = copy_to_user(ustats, &ipath_stats, sizeof(ipath_stats)))) {
+		_IPATH_DBG("copy_to_user error on driver stats\n");
+		ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+/* set a partition key.  We can have up to 4 active at a time (other than
+ * the default, which is always allowed).  This is somewhat tricky, since
+ * multiple ports may set the same key, so we reference count them, and
+ * clean up at exit.  All 4 partition keys are packed into a single
+ * infinipath register.  It's an error for a process to set the same
+ * pkey multiple times.  We provide no mechanism to de-allocate a pkey
+ * at this time, we may eventually need to do that.
+ * I've used the atomic operations, and no locking, and only make a single
+ * pass through what's available.  This should be more than adequate for
+ * some time. I'll think about spinlocks or the like if and as it's necessary
+ */
+static int ipath_set_partkey(struct ipath_portdata *pd, uint16_t key)
+{
+	struct ipath_devdata *dd;
+	int i, any = 0, pidx = -1;
+	uint16_t lkey = key & 0x7FFF;
+
+	dd = &devdata[pd->port_unit];
+
+	if (lkey == (IPS_DEFAULT_P_KEY & 0x7FFF)) {
+		/* nothing to do; this key always valid */
+		return 0;
+	}
+
+	_IPATH_VDBG
+	    ("p%u try to set pkey %hx, current keys %hx:%x %hx:%x %hx:%x %hx:%x\n",
+	     pd->port_port, key, dd->ipath_pkeys[0],
+	     atomic_read(&dd->ipath_pkeyrefs[0]), dd->ipath_pkeys[1],
+	     atomic_read(&dd->ipath_pkeyrefs[1]), dd->ipath_pkeys[2],
+	     atomic_read(&dd->ipath_pkeyrefs[2]), dd->ipath_pkeys[3],
+	     atomic_read(&dd->ipath_pkeyrefs[3]));
+
+	if (!lkey) {
+		_IPATH_PRDBG("p%u tries to set key 0, not allowed\n",
+			     pd->port_port);
+		return -EINVAL;
+	}
+
+	/*
+	 * Set the full membership bit, because it has to be
+	 * set in the register or the packet, and it seems
+	 * cleaner to set in the register than to force all
+	 * callers to set it. (see bug 4331)
+	 */
+	key |= 0x8000;
+
+	for (i = 0; i < ARRAY_SIZE(pd->port_pkeys); i++) {
+		if (!pd->port_pkeys[i] && pidx == -1)
+			pidx = i;
+		if (pd->port_pkeys[i] == key) {
+			_IPATH_VDBG
+			    ("p%u tries to set same pkey (%x) more than once\n",
+			     pd->port_port, key);
+			return -EEXIST;
+		}
+	}
+	if (pidx == -1) {
+		_IPATH_DBG
+		    ("All pkeys for port %u already in use, can't set %x\n",
+		     pd->port_port, key);
+		return -EBUSY;
+	}
+	for (any = i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (!dd->ipath_pkeys[i]) {
+			any++;
+			continue;
+		}
+		if (dd->ipath_pkeys[i] == key) {
+			if (atomic_inc_return(&dd->ipath_pkeyrefs[i]) > 1) {
+				pd->port_pkeys[pidx] = key;
+				_IPATH_VDBG
+				    ("p%u set key %x matches #%d, count now %d\n",
+				     pd->port_port, key, i,
+				     atomic_read(&dd->ipath_pkeyrefs[i]));
+				return 0;
+			} else {
+				/* lost race, decrement count, catch below */
+				atomic_dec(&dd->ipath_pkeyrefs[i]);
+				_IPATH_VDBG
+				    ("Lost race, count was 0, after dec, it's %d\n",
+				     atomic_read(&dd->ipath_pkeyrefs[i]));
+				any++;
+			}
+		}
+		if ((dd->ipath_pkeys[i] & 0x7FFF) == lkey) {
+			/*
+			 * It makes no sense to have both the limited and full
+			 * membership PKEY set at the same time since the
+			 * unlimited one will disable the limited one.
+			 */
+			return -EEXIST;
+		}
+	}
+	if (!any) {
+		_IPATH_DBG
+		    ("port %u, all pkeys already in use, can't set %x\n",
+		     pd->port_port, key);
+		return -EBUSY;
+	}
+	for (any = i = 0; i < ARRAY_SIZE(dd->ipath_pkeys); i++) {
+		if (!dd->ipath_pkeys[i] &&
+		    atomic_inc_return(&dd->ipath_pkeyrefs[i]) == 1) {
+			uint64_t pkey;
+
+			/* for ipathstats, etc. */
+			ipath_stats.sps_pkeys[i] = lkey;
+			pd->port_pkeys[pidx] = dd->ipath_pkeys[i] = key;
+			pkey =
+			    (uint64_t) dd->ipath_pkeys[0] |
+			    ((uint64_t) dd->ipath_pkeys[1] << 16) |
+			    ((uint64_t) dd->ipath_pkeys[2] << 32) |
+			    ((uint64_t) dd->ipath_pkeys[3] << 48);
+			_IPATH_PRDBG
+			    ("p%u set key %x in #%d, portidx %d, new pkey reg %llx\n",
+			     pd->port_port, key, i, pidx, pkey);
+			ipath_kput_kreg(pd->port_unit, kr_partitionkey, pkey);
+
+			return 0;
+		}
+	}
+	_IPATH_DBG
+	    ("port %u, all pkeys already in use 2nd pass, can't set %x\n",
+	     pd->port_port, key);
+	return -EBUSY;
+}
+
+/*
+ * stop_start == 0 disables receive on the port, for use in queue overflow
+ * conditions.  stop_start==1 re-enables, and returns value of tail register,
+ * to be used to re-init the software copy of the head register
+ */
+
+static int ipath_manage_rcvq(struct ipath_portdata * pd, uint16_t start_stop)
+{
+	struct ipath_devdata *dd;
+	/*
+	 * This needs to be volatile, so that the compiler doesn't
+	 * optimize away the read to the device's mapped memory.
+	 */
+	volatile uint64_t tval;
+
+	dd = &devdata[pd->port_unit];
+	_IPATH_PRDBG("%sabling rcv for unit %u port %u\n",
+		     start_stop ? "en" : "dis", pd->port_unit, pd->port_port);
+	/* atomically clear receive enable port. */
+	if (start_stop) {
+		/*
+		 * on enable, force in-memory copy of the tail register
+		 * to 0, so that protocol code doesn't have to worry
+		 * about whether or not the chip has yet updated
+		 * the in-memory copy or not on return from the system
+		 * call. The chip always resets it's tail register back
+		 * to 0 on a transition from disabled to enabled.
+		 * This could cause a problem if software was broken,
+		 * and did the enable w/o the disable, but eventually
+		 * the in-memory copy will be updated and correct
+		 * itself, even in the face of software bugs.
+		 */
+		*pd->port_rcvhdrtail_kvaddr = 0;
+		atomic_set_mask(1U <<
+				(INFINIPATH_R_PORTENABLE_SHIFT + pd->port_port),
+				&dd->ipath_rcvctrl);
+	} else
+		atomic_clear_mask(1U <<
+				  (INFINIPATH_R_PORTENABLE_SHIFT +
+				   pd->port_port), &dd->ipath_rcvctrl);
+	ipath_kput_kreg(pd->port_unit, kr_rcvctrl, dd->ipath_rcvctrl);
+	/* now be sure chip saw it before we return */
+	tval = ipath_kget_kreg64(pd->port_unit, kr_scratch);
+	if (start_stop) {
+		/*
+		 * and try to be sure that tail reg update has happened
+		 * too.  This should in theory interlock with the RXE
+		 * changes to the tail register.  Don't assign it to
+		 * the tail register in memory copy, since we could
+		 * overwrite an update by the chip if we did.
+		 */
+		tval =
+		    ipath_kget_ureg32(pd->port_unit, ur_rcvhdrtail,
+				      pd->port_port);
+	}
+	/* always; new head should be equal to new tail; see above */
+	return 0;
+}
+
+/*
+ * This routine is now quite different for user and kernel, because
+ * the kernel uses skb's, for the accelerated network performance
+ * This is the user port version
+ *
+ * allocate the eager TID buffers and program them into infinipath
+ * They are no longer completely contiguous, we do multiple
+ * alloc_pages() calls.
+ */
+static int ipath_create_user_egr(struct ipath_portdata * pd)
+{
+	char *buf;
+	struct ipath_devdata *dd = &devdata[pd->port_unit];
+	uint64_t __iomem *egrbase;
+	uint64_t egroff, lenvalid;
+	unsigned e, egrcnt, alloced, order, egrperchunk, chunk;
+	unsigned long pa, pent;
+
+	egrcnt = dd->ipath_rcvegrcnt;
+	egroff =
+	    dd->ipath_rcvegrbase + pd->port_port * egrcnt * sizeof(*egrbase);
+	egrbase = (uint64_t __iomem *)
+		((char __iomem *)(dd->ipath_kregbase) + egroff);
+	_IPATH_VDBG("Allocating %d egr buffers, at chip offset %llx (%p)\n",
+		    egrcnt, egroff, egrbase);
+
+	/*
+	 * to avoid wasting a lot of memory, we allocate 32KB chunks of
+	 * physically contiguous memory, advance through it until used up
+	 * and then allocate more.  Of course, we need memory to store
+	 * those extra pointers, now.  Started out with 256KB, but under
+	 * heavy memory pressure (creating large files and then copying
+	 * them over NFS while doing lots of MPI jobs), we hit some
+	 * alloc_pages() failures, even though we can sleep...  (2.6.10)
+	 * Still get failures at 64K.  32K is the lowest we can go without
+	 * waiting more memory again.  It seems likely that the coalescing
+	 * in free_pages, etc. still has issues (as it has had previously
+	 * during 2.6.x development).
+	 */
+	order = get_order(0x8000);
+	alloced = ALIGN(dd->ipath_rcvegrbufsize * egrcnt,
+			(1 << order) * PAGE_SIZE);
+	egrperchunk = ((1 << order) * PAGE_SIZE) / dd->ipath_rcvegrbufsize;
+	chunk = (egrcnt + egrperchunk - 1) / egrperchunk;
+	pd->port_rcvegrbuf_chunks = chunk;
+	pd->port_rcvegrbufs_perchunk = egrperchunk;
+	pd->port_rcvegrbuf_order = order;
+	pd->port_rcvegrbuf_pages =
+	    vmalloc(chunk * sizeof(pd->port_rcvegrbuf_pages[0]));
+	pd->port_rcvegrbuf_virt =
+	    vmalloc(chunk * sizeof(pd->port_rcvegrbuf_virt[0]));
+	if (!pd->port_rcvegrbuf_pages || !pd->port_rcvegrbuf_pages) {
+		_IPATH_UNIT_ERROR(pd->port_unit,
+				  "Unable to allocate %u EGR buffer array pointers\n",
+				  chunk);
+		if (pd->port_rcvegrbuf_pages) {
+			vfree(pd->port_rcvegrbuf_pages);
+			pd->port_rcvegrbuf_pages = NULL;
+		}
+		return -ENOMEM;
+	}
+	for (e = 0; e < pd->port_rcvegrbuf_chunks; e++) {
+		/*
+		 * GFP_USER, but without GFP_FS, so buffer cache can
+		 * be coalesced (we hope); otherwise, even at order 4, heavy
+		 * filesystem activity makes these fail
+		 */
+		if (!
+		    (pd->port_rcvegrbuf_pages[e] =
+		     alloc_pages(__GFP_WAIT | __GFP_IO, order))) {
+			_IPATH_UNIT_ERROR(pd->port_unit,
+					  "Unable to allocate EGR buffer array %u/%u\n",
+					  e, pd->port_rcvegrbuf_chunks);
+			vfree(pd->port_rcvegrbuf_pages);
+			pd->port_rcvegrbuf_pages = NULL;
+			vfree(pd->port_rcvegrbuf_virt);
+			pd->port_rcvegrbuf_virt = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	/*
+	 * calculate physical, then phys_to_virt()
+	 * so that we get an address that fits in 64 bits, so we can use
+	 * mmap64 from 32 bit programs on the chip and kernel virtual
+	 * addresses (mmap64 for 32 bit programs on i386 and x86_64
+	 * only has 44 bits of address, because it uses mmap2())
+	 * We do this with the first chunk;  We don't need a kernel
+	 * virtually contiguous address to give the user virtually
+	 * contiguous mappings.  It just complicates the nopage routine
+	 * a little tiny bit ;)
+	 */
+	buf = page_address(pd->port_rcvegrbuf_pages[0]);
+	pa = virt_to_phys(buf);
+	pd->port_rcvegr_phys = pa;
+
+	/* in words */
+	lenvalid = (dd->ipath_rcvegrbufsize - pd->port_egrskip) >> 2;
+	_IPATH_VDBG
+	    ("port%u egrbuf vaddr %p, cpu %d, egrskip %u, len %llx words\n",
+	     pd->port_port, buf, smp_processor_id(), pd->port_egrskip,
+	     lenvalid);
+	lenvalid <<= INFINIPATH_RT_BUFSIZE_SHIFT;
+	lenvalid |= INFINIPATH_RT_VALID;
+
+	for (e = chunk = 0; chunk < pd->port_rcvegrbuf_chunks; chunk++) {
+		int i, n;
+		struct page *p;
+		p = pd->port_rcvegrbuf_pages[chunk];
+		pa = page_to_phys(p);
+		buf = page_address(p);
+		/*
+		 * stash away for later use, since page_address() lookup
+		 * is not cheap
+		 */
+		pd->port_rcvegrbuf_virt[chunk] = buf;
+		if (pa & ~INFINIPATH_RT_ADDR_MASK)
+			_IPATH_INFO
+			    ("physaddr %lx has more than 40 bits, using only 40!\n",
+			     pa);
+		n = 1 << pd->port_rcvegrbuf_order;
+		for (i = 0; i < n; i++)
+			SetPageReserved(virt_to_page(buf + (i * PAGE_SIZE)));
+
+		/* clear buffer for security, sanity, and, debugging */
+		memset(buf, 0, PAGE_SIZE * n);
+
+		for (i = 0; e < egrcnt && i < egrperchunk; e++, i++) {
+			pent = ((pa + pd->port_egrskip) &
+				INFINIPATH_RT_ADDR_MASK) | lenvalid;
+
+			ipath_kput_memq(pd->port_unit, &egrbase[e], pent);
+			_IPATH_VDBG("egr %u phys %lx val %lx\n", e, pa, pent);
+			pa += dd->ipath_rcvegrbufsize;
+		}
+		yield();	/* don't hog the cpu */
+	}
+
+	return 0;
+}
+
+/*
+ * This routine is now quite different for user and kernel, because
+ * the kernel uses skb's, for the accelerated network performance
+ * This is the kernel (port0) version
+ *
+ * Allocate the eager TID buffers and program them into infinipath.
+ * We use the network layer alloc_skb() allocator to allocate the memory, and
+ * either use the buffers as is for things like SMA packets, or pass
+ * the buffers up to the ipath layered driver and thence the network layer,
+ * replacing them as we do so (see ipath_kreceive())
+ */
+static int ipath_create_port0_egr(struct ipath_portdata * pd)
+{
+	int ret = 0;
+	uint64_t __iomem *egrbase;
+	uint64_t egroff;
+	unsigned e, egrcnt;
+	struct ipath_devdata *dd;
+	struct sk_buff **skbs;
+
+	dd = &devdata[pd->port_unit];
+	egrcnt = dd->ipath_rcvegrcnt;
+	egroff = dd->ipath_rcvegrbase +
+		pd->port_port * egrcnt * sizeof(*egrbase);
+	egrbase = (uint64_t __iomem *) ((char __iomem *)(dd->ipath_kregbase) +
+					egroff);
+	_IPATH_VDBG
+	    ("unit%u Allocating %d egr buffers, at chip offset %llx (%p)\n",
+	     pd->port_unit, egrcnt, egroff, egrbase);
+
+	skbs = vmalloc(sizeof(*dd->ipath_port0_skbs) * egrcnt);
+	if (skbs == NULL)
+		ret = -ENOMEM;
+	else {
+		for (e = 0; e < egrcnt; e++) {
+			/*
+			 * This is a bit tricky in that we allocate
+			 * extra space for 2 bytes of the 14 byte
+			 * ethernet header.  These two bytes are passed
+			 * in the ipath header so the rest of the data
+			 * is word aligned.  We allocate 4 bytes so that the
+			 * data buffer stays word aligned.
+			 * See ipath_kreceive() for more details.
+			 */
+			skbs[e] =
+			    __dev_alloc_skb(dd->ipath_ibmaxlen + 4, GFP_KERNEL);
+			if (skbs[e] == NULL) {
+				_IPATH_UNIT_ERROR(pd->port_unit,
+						  "SKB allocation error for eager TID %u\n",
+						  e);
+				while (e != 0)
+					dev_kfree_skb(skbs[--e]);
+				ret = -ENOMEM;
+				break;
+			}
+			skb_reserve(skbs[e], 4);
+		}
+	}
+	/*
+	 * after loop above, so we can test non-NULL
+	 * to see if ready to use at receive, etc.  Hope this fixes some
+	 * panics.
+	 */
+	dd->ipath_port0_skbs = skbs;
+
+	/*
+	 * have to tell chip each time we init it
+	 * even if we are re-using previous memory.
+	 */
+	if (!ret) {
+		uint64_t lenvalid;	/* in words */
+
+		lenvalid = (dd->ipath_ibmaxlen - pd->port_egrskip) >> 2;
+		lenvalid <<= INFINIPATH_RT_BUFSIZE_SHIFT;
+		lenvalid |= INFINIPATH_RT_VALID;
+		for (e = 0; e < egrcnt; e++) {
+			unsigned long pa, pent;
+
+			pa = virt_to_phys(dd->ipath_port0_skbs[e]->data);
+			pa += pd->port_egrskip;
+			if (!e && (pa & ~INFINIPATH_RT_ADDR_MASK))
+				_IPATH_INFO
+				    ("phys addr %lx has more than 40 bits, using only 40!!!\n",
+				     pa);
+			pent = (pa & INFINIPATH_RT_ADDR_MASK) | lenvalid;
+			/*
+			 * don't need this except extreme debugging,
+			 * but leaving to save future typing.
+			 * _IPATH_VDBG("egr[%d] %p <- %lx\n", e, &egrbase[e], pent);
+			 */
+			ipath_kput_memq(pd->port_unit, &egrbase[e], pent);
+		}
+		yield();	/* don't hog the cpu */
+	}
+
+	return ret;
+}
+
+/*
+ * this *must* be physically contiguous memory, and for now,
+ * that limits it to what kmalloc can do.
+ */
+static int ipath_create_rcvhdrq(struct ipath_portdata * pd)
+{
+	int i, ret = 0, amt, order, pgs;
+	char *qt;
+	struct page *p;
+	unsigned long pa, pa0;
+
+	amt = ALIGN(devdata[pd->port_unit].ipath_rcvhdrcnt * devdata[pd->port_unit].ipath_rcvhdrentsize * sizeof(uint32_t), PAGE_SIZE);
+	if (!pd->port_rcvhdrq) {
+		order = get_order(amt);
+		/*
+		 * not using REPEAT isn't viable; at 128KB, we can easily fail
+		 * this.  The problem with REPEAT is we can block here
+		 * "forever".  There isn't an inbetween, unfortunately.
+		 * We could reduce the risk by never freeing the rcvhdrq
+		 * except at unload, but even then, the first time a
+		 * port is used, we could delay for some time...
+		 */
+		p = alloc_pages(GFP_USER, order);
+		if (!p) {
+			_IPATH_UNIT_ERROR(pd->port_unit,
+					  "attempt to allocate order %u memory for port %u rcvhdrq failed\n",
+					  order, pd->port_port);
+			return -ENOMEM;
+		}
+
+		/*
+		 * should use kmap (and later kunmap), even though high mem will
+		 * always be mapped on x86_64, to play it safe, but for some
+		 * bizarre reason these aren't exported symbols...
+		 */
+		pd->port_rcvhdrq = page_address(p);
+		if (!virt_addr_valid(pd->port_rcvhdrq)) {
+			_IPATH_DBG
+			    ("weird, virt_addr_valid false right after alloc_pages\n");
+			_IPATH_DBG("__pa(%p) is %lx, num_physpages %lx\n",
+				   pd->port_rcvhdrq, __pa(pd->port_rcvhdrq),
+				   num_physpages);
+		}
+		pd->port_rcvhdrq_phys = virt_to_phys(pd->port_rcvhdrq);
+		pd->port_rcvhdrq_order = order;
+
+		pa0 = pd->port_rcvhdrq_phys;
+		pgs = amt >> PAGE_SHIFT;
+		_IPATH_VDBG
+		    ("%d pages at %p (phys %lx) order=%u for port %u rcvhdr Q\n",
+		     pgs, pd->port_rcvhdrq, pa0, pd->port_rcvhdrq_order,
+		     pd->port_port);
+
+		/*
+		 * verify it's really physically contiguous, to be paranoid
+		 * also mark pages as reserved, to avoid problems when
+		 * user process with them mapped then exits.
+		 */
+		qt = pd->port_rcvhdrq;
+		SetPageReserved(virt_to_page(qt));
+		qt += PAGE_SIZE;
+		for (pa = pa0, i = 1; i < pgs; i++, qt += PAGE_SIZE) {
+			SetPageReserved(virt_to_page(qt));
+			pa = virt_to_phys(qt);
+			if (pa != (pa0 + (i * PAGE_SIZE)))
+				_IPATH_INFO
+				    ("pg %d at %p phys %lx not contiguous\n", i,
+				     qt, pa);
+			else
+				_IPATH_VDBG("pg %d at %p phys %lx\n", i, qt,
+					    pa);
+		}
+	}
+
+	/*
+	 * clear for security, sanity, and/or debugging (each time we
+	 * use/reuse)
+	 */
+	memset(pd->port_rcvhdrq, 0, amt);
+
+	/*
+	 * tell chip each time we init it, even if we are re-using previous
+	 * memory (we zero it at process close)
+	 */
+	_IPATH_VDBG("writing port %d rcvhdraddr as %lx\n", pd->port_port,
+		    pd->port_rcvhdrq_phys);
+	ipath_kput_kreg_port(pd->port_unit, kr_rcvhdraddr, pd->port_port,
+			     pd->port_rcvhdrq_phys);
+
+	return ret;
+}
+
+#ifdef _IPATH_EXTRA_DEBUG
+/*
+ * occasionally useful to dump the full set of kernel registers for debugging.
+ */
+static void ipath_dump_allregs(char *what, ipath_type t)
+{
+	uint16_t reg;
+	_IPATH_DBG("%s\n", what);
+	for (reg = 0; reg <= 0x100; reg++) {
+		uint64_t v = ipath_kget_kreg64(t, reg);
+		if (!(reg % 4))
+			printk("\n%3x: ", reg);
+		printk("%16llx  ", v);
+	}
+	printk("\n");
+}
+#endif				/* _IPATH_EXTRA_DEBUG */
+
+/*
+ * Do the actual initialization sequence on the chip.  For the real
+ * hardware, this is done from the init routine called from the PCI
+ * infrastructure.
+ */
+int ipath_init_chip(const ipath_type t)
+{
+	int ret = 0, i;
+	uint32_t val32, kpiobufs;
+	uint64_t val, atmp;
+	uint32_t __iomem *piobuf;
+	uint32_t pioincr;
+	struct ipath_devdata *dd = &devdata[t];
+	struct ipath_portdata *pd;
+	struct page *vpage;
+	char boardn[32];
+
+	/* first time only, set after static version info */
+	if (!chip_driver_version) {
+		i = strlen(ipath_core_version);
+		chip_driver_version = ipath_core_version + i;
+		chip_driver_size = sizeof ipath_core_version - i;
+	}
+
+	/*
+	 * have to clear shadow copies of registers at init that are not
+	 * otherwise set here, or all kinds of bizarre things happen with
+	 * driver on chip reset
+	 */
+	dd->ipath_rcvhdrsize = 0;
+
+	/*
+	 * don't clear ipath_flags as 8bit mode was set before entering
+	 * this func.  However, we do set the linkstate to unknown
+	 */
+
+	/* so we can watch for a transition */
+	dd->ipath_flags |= IPATH_LINKUNK;
+	dd->ipath_flags &= ~(IPATH_LINKACTIVE | IPATH_LINKARMED | IPATH_LINKDOWN
+			     | IPATH_LINKINIT);
+
+	_IPATH_VDBG("Try to read spc chip revision\n");
+	dd->ipath_revision = ipath_kget_kreg64(t, kr_revision);
+
+	/*
+	 * set up fundamental info we need to use the chip;  we assume if
+	 * the revision reg and these regs are OK, we don't need to special
+	 * case the rest
+	 */
+	dd->ipath_sregbase = ipath_kget_kreg32(t, kr_sendregbase);
+	dd->ipath_cregbase = ipath_kget_kreg32(t, kr_counterregbase);
+	dd->ipath_uregbase = ipath_kget_kreg32(t, kr_userregbase);
+	_IPATH_VDBG("ipath_kregbase %p, sendbase %x usrbase %x, cntrbase %x\n",
+		    dd->ipath_kregbase, dd->ipath_sregbase, dd->ipath_uregbase,
+		    dd->ipath_cregbase);
+	if ((dd->ipath_revision & 0xffffffff) == 0xffffffff ||
+	    (dd->ipath_sregbase & 0xffffffff) == 0xffffffff ||
+	    (dd->ipath_cregbase & 0xffffffff) == 0xffffffff ||
+	    (dd->ipath_uregbase & 0xffffffff) == 0xffffffff) {
+		_IPATH_UNIT_ERROR(t,
+				  "Register read failures from chip, giving up initialization\n");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	/* clear the initial reset flag, in case first driver load */
+	ipath_kput_kreg(t, kr_errorclear, INFINIPATH_E_RESET);
+
+	dd->ipath_portcnt = ipath_kget_kreg32(t, kr_portcnt);
+	if (!infinipath_cfgports)
+		dd->ipath_cfgports = dd->ipath_portcnt;
+	else if (infinipath_cfgports <= dd->ipath_portcnt) {
+		dd->ipath_cfgports = infinipath_cfgports;
+		_IPATH_DBG("Configured to use %u ports out of %u in chip\n",
+			   dd->ipath_cfgports, dd->ipath_portcnt);
+	} else {
+		dd->ipath_cfgports = dd->ipath_portcnt;
+		_IPATH_DBG
+		    ("Tried to configured to use %u ports; chip only supports %u\n",
+		     infinipath_cfgports, dd->ipath_portcnt);
+	}
+	dd->ipath_pd = kmalloc(sizeof(*dd->ipath_pd) * dd->ipath_cfgports,
+			       GFP_KERNEL);
+	if (!dd->ipath_pd) {
+		_IPATH_UNIT_ERROR(t,
+				  "Unable to allocate portdata array, failing\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+	memset(dd->ipath_pd, 0, sizeof(*dd->ipath_pd) * dd->ipath_cfgports);
+
+	dd->ipath_lastegrheads = kmalloc(sizeof(*dd->ipath_lastegrheads)
+					 * dd->ipath_cfgports, GFP_KERNEL);
+	dd->ipath_lastrcvhdrqtails = kmalloc(sizeof(*dd->ipath_lastrcvhdrqtails)
+					     * dd->ipath_cfgports, GFP_KERNEL);
+	if (!dd->ipath_lastegrheads || !dd->ipath_lastrcvhdrqtails) {
+		_IPATH_UNIT_ERROR(t,
+				  "Unable to allocate head arrays, failing\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+	memset(dd->ipath_lastrcvhdrqtails, 0,
+	       sizeof(*dd->ipath_lastrcvhdrqtails)
+	       * dd->ipath_cfgports);
+	memset(dd->ipath_lastegrheads, 0, sizeof(*dd->ipath_lastegrheads)
+	       * dd->ipath_cfgports);
+
+	dd->ipath_pd[0] = kmalloc(sizeof(struct ipath_portdata), GFP_KERNEL);
+	if (!dd->ipath_pd[0]) {
+		_IPATH_UNIT_ERROR(t,
+				  "Unable to allocate portdata for port 0, failing\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+	memset(dd->ipath_pd[0], 0, sizeof(struct ipath_portdata));
+
+	pd = dd->ipath_pd[0];
+	pd->port_unit = t;
+	pd->port_port = 0;
+	pd->port_cnt = 1;
+	/* The port 0 pkey table is used by the layer interface. */
+	pd->port_pkeys[0] = IPS_DEFAULT_P_KEY;
+
+	dd->ipath_rcvtidcnt = ipath_kget_kreg32(t, kr_rcvtidcnt);
+	dd->ipath_rcvtidbase = ipath_kget_kreg32(t, kr_rcvtidbase);
+	dd->ipath_rcvegrcnt = ipath_kget_kreg32(t, kr_rcvegrcnt);
+	dd->ipath_rcvegrbase = ipath_kget_kreg32(t, kr_rcvegrbase);
+	dd->ipath_palign = ipath_kget_kreg32(t, kr_pagealign);
+	dd->ipath_piobufbase = ipath_kget_kreg32(t, kr_sendpiobufbase);
+	dd->ipath_piosize = ipath_kget_kreg32(t, kr_sendpiosize);
+	dd->ipath_ibmtu = 4096;	/* default to largest legal MTU */
+	dd->ipath_piobcnt = ipath_kget_kreg32(t, kr_sendpiobufcnt);
+	dd->ipath_piobase = (((char __iomem *) dd->ipath_kregbase) +
+			     (dd->ipath_piobufbase & 0xffffffff));
+
+	_IPATH_VDBG
+	    ("Revision %llx (PCI %x), %u ports, %u tids, %u egrtids, %u piobufs\n",
+	     dd->ipath_revision, dd->ipath_pcirev, dd->ipath_portcnt,
+	     dd->ipath_rcvtidcnt, dd->ipath_rcvegrcnt, dd->ipath_piobcnt);
+
+	if (((dd->ipath_revision >> INFINIPATH_R_SOFTWARE_SHIFT) & INFINIPATH_R_SOFTWARE_MASK) != IPATH_CHIP_SWVERSION) {	/* >= maybe, someday */
+		_IPATH_UNIT_ERROR(t,
+				  "Driver only handles version %d, chip swversion is %d (%llx), failng\n",
+				  IPATH_CHIP_SWVERSION,
+				  (int)(dd->
+					ipath_revision >>
+					INFINIPATH_R_SOFTWARE_SHIFT) &
+				  INFINIPATH_R_SOFTWARE_MASK,
+				  dd->ipath_revision);
+		ret = -ENOSYS;
+		goto done;
+	}
+	dd->ipath_majrev = (uint8_t) ((dd->ipath_revision >>
+				       INFINIPATH_R_CHIPREVMAJOR_SHIFT) &
+				      INFINIPATH_R_CHIPREVMAJOR_MASK);
+	dd->ipath_minrev =
+	    (uint8_t) ((dd->
+			ipath_revision >> INFINIPATH_R_CHIPREVMINOR_SHIFT) &
+		       INFINIPATH_R_CHIPREVMINOR_MASK);
+	dd->ipath_boardrev =
+	    (uint8_t) ((dd->
+			ipath_revision >> INFINIPATH_R_BOARDID_SHIFT) &
+		       INFINIPATH_R_BOARDID_MASK);
+
+	ipath_get_boardname(t, boardn, sizeof boardn);
+
+	{
+		snprintf(chip_driver_version, chip_driver_size,
+			 "Driver %u.%u, %s, InfiniPath%u %u.%u, PCI %u, SW Compat %u\n",
+			 IPATH_CHIP_VERS_MAJ, IPATH_CHIP_VERS_MIN, boardn,
+			 (unsigned)(dd->
+				    ipath_revision >> INFINIPATH_R_ARCH_SHIFT) &
+			 INFINIPATH_R_ARCH_MASK, dd->ipath_majrev,
+			 dd->ipath_minrev, dd->ipath_pcirev,
+			 (unsigned)(dd->
+				    ipath_revision >>
+				    INFINIPATH_R_SOFTWARE_SHIFT) &
+			 INFINIPATH_R_SOFTWARE_MASK);
+
+	}
+
+	_IPATH_DBG("%s", chip_driver_version);
+
+	/*
+	 * we ignore most issues after reporting them, but have to specially
+	 * handle hardware-disabled chips.
+	 */
+	if (ipath_validate_rev(dd) == 2) {
+		ret = -EPERM; /* unique error, known to infinipath_init_one() */
+		goto done;
+	}
+
+	/*
+	 * zero all the TID entries at startup.  We do this for sanity,
+	 * in case of a previous driver crash of some kind, and also
+	 * because the chip powers up with these memories in an unknown
+	 * state.  Use portcnt, not cfgports, since this is for the full chip,
+	 * not for current (possibly different) configuration value
+	 * Chip Errata bug 6447
+	 */
+	for (val32 = 0; val32 < dd->ipath_portcnt; val32++)
+		ipath_clear_tids(t, val32);
+
+	dd->ipath_rcvhdrentsize = IPATH_RCVHDRENTSIZE;
+	/* we could bump this
+	 * to allow for full rcvegrcnt + rcvtidcnt, but then it no
+	 * longer nicely fits power of two, and since we now use
+	 * alloc_pages, the rest would be wasted.
+	 */
+	dd->ipath_rcvhdrcnt = dd->ipath_rcvegrcnt;
+	/*
+	 * setup offset of last valid entry in rcvhdrq, for various tests, to
+	 * avoid calculating each time we need it
+	 */
+	dd->ipath_hdrqlast =
+	    dd->ipath_rcvhdrentsize * (dd->ipath_rcvhdrcnt - 1);
+	ipath_kput_kreg(t, kr_rcvhdrentsize, dd->ipath_rcvhdrentsize);
+	ipath_kput_kreg(t, kr_rcvhdrcnt, dd->ipath_rcvhdrcnt);
+	/*
+	 * not in ipath_rcvhdrsize, so user programs can set differently, but
+	 * so any early packets see the default size.
+	 */
+	ipath_kput_kreg(t, kr_rcvhdrsize, IPATH_DFLT_RCVHDRSIZE);
+
+	/*
+	 * we "know" that this works
+	 * out OK.  It's actually a bit more than we need, but 2048+64 isn't
+	 * quite enough for full size, and we want the +N to be a power of 2
+	 * to give us reasonable alignment and fit within page_alloc()'ed
+	 * memory
+	 */
+	dd->ipath_rcvegrbufsize = dd->ipath_piosize;
+
+	/*
+	 * the min() check here is currently a nop, but it may not always be,
+	 * depending on just how we do ipath_rcvegrbufsize
+	 */
+	dd->ipath_ibmaxlen = min(dd->ipath_piosize, dd->ipath_rcvegrbufsize);
+	dd->ipath_init_ibmaxlen = dd->ipath_ibmaxlen;
+
+	/*
+	 * set up the shadow copies of the piobufavail registers, which
+	 * we compare against the chip registers for now, and the in
+	 * memory DMA'ed copies of the registers.  This has to be done
+	 * early, before we calculate lastport, etc.
+	 */
+	val = dd->ipath_piobcnt;
+	/*
+	 * calc number of pioavail registers, and save it; we have 2 bits
+	 * per buffer
+	 */
+	dd->ipath_pioavregs = ALIGN(val, sizeof(uint64_t) * BITS_PER_BYTE / 2) / (sizeof(uint64_t) * BITS_PER_BYTE / 2);
+	if (dd->ipath_pioavregs >
+	    (sizeof(dd->ipath_pioavailshadow) /
+	     sizeof(dd->ipath_pioavailshadow[0]))) {
+		dd->ipath_pioavregs =
+		    sizeof(dd->ipath_pioavailshadow) /
+		    sizeof(dd->ipath_pioavailshadow[0]);
+		dd->ipath_piobcnt = dd->ipath_pioavregs * sizeof(uint64_t) * BITS_PER_BYTE >> 1;	/* 2 bits/reg */
+		_IPATH_INFO
+		    ("Warning: %lld piobufs is too many to fit in shadow, only using %d\n",
+		     val, dd->ipath_piobcnt);
+	}
+
+	if (!infinipath_kpiobufs) {
+		/* have to have at least one, for SMA */
+		kpiobufs = infinipath_kpiobufs = 1;
+	} else if (dd->ipath_piobcnt <
+		   (dd->ipath_cfgports * IPATH_MIN_USER_PORT_BUFCNT)) {
+		_IPATH_INFO
+		    ("Too few PIO buffers (%u) for %u ports to have %u each!\n",
+		     dd->ipath_piobcnt, dd->ipath_cfgports,
+		     IPATH_MIN_USER_PORT_BUFCNT);
+		kpiobufs = 1;	/* reserve just the minimum for SMA/ether */
+	} else
+		kpiobufs = infinipath_kpiobufs;
+
+	if (kpiobufs >
+	    (dd->ipath_piobcnt -
+	     (dd->ipath_cfgports * IPATH_MIN_USER_PORT_BUFCNT))) {
+		i = dd->ipath_piobcnt -
+		    (dd->ipath_cfgports * IPATH_MIN_USER_PORT_BUFCNT);
+		if (i < 0)
+			i = 0;
+		_IPATH_INFO
+		    ("Allocating %d PIO bufs for kernel leaves too few for %d user ports (%d each); using %u\n",
+		     kpiobufs, dd->ipath_cfgports - 1,
+		     IPATH_MIN_USER_PORT_BUFCNT, i);
+		/*
+		 * shouldn't change infinipath_kpiobufs, because could be
+		 * different for different devices...
+		 */
+		kpiobufs = i;
+	}
+	dd->ipath_lastport_piobuf = dd->ipath_piobcnt - kpiobufs;
+	dd->ipath_pbufsport = dd->ipath_cfgports > 1 ?
+	    dd->ipath_lastport_piobuf / (dd->ipath_cfgports - 1) : 0;
+	val32 = dd->ipath_lastport_piobuf -
+	    (dd->ipath_pbufsport * (dd->ipath_cfgports - 1));
+	if (val32 > 0) {
+		_IPATH_DBG
+		    ("allocating %u pbufs/port leaves %u unused, add to kernel\n",
+		     dd->ipath_pbufsport, val32);
+		dd->ipath_lastport_piobuf -= val32;
+		_IPATH_DBG("%u pbufs/port leaves %u unused, add to kernel\n",
+			   dd->ipath_pbufsport, val32);
+	}
+	dd->ipath_lastpioindex = dd->ipath_lastport_piobuf;
+	_IPATH_VDBG
+	    ("%d PIO bufs %u - %u, %u each for %u user ports\n",
+	     kpiobufs, dd->ipath_lastport_piobuf, dd->ipath_piobcnt, dd->ipath_pbufsport,
+	     dd->ipath_cfgports - 1);
+
+	/*
+	 * this has to be page aligned, and on a page of it's own, so we
+	 * can map it into user space.  We also use it to give processes
+	 * a copy of ipath_statusp, on a separate cacheline, followed by
+	 * a copy of the freeze error string, if it's happened.  Might also
+	 * use that space for other things.
+	 */
+	val = ALIGN(2 * L1_CACHE_BYTES + sizeof(*dd->ipath_statusp) +
+		    dd->ipath_pioavregs * sizeof(uint64_t), 2 * PAGE_SIZE);
+	if (!(dd->ipath_pioavailregs_dma = kmalloc(val * sizeof(uint64_t),
+						   GFP_KERNEL))) {
+		_IPATH_UNIT_ERROR(t,
+				  "failed to allocate PIOavail reg area in memory\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+	if ((PAGE_SIZE - 1) & (uint64_t) dd->ipath_pioavailregs_dma) {
+		dd->__ipath_pioavailregs_base = dd->ipath_pioavailregs_dma;
+		dd->ipath_pioavailregs_dma = (uint64_t *)
+		    ALIGN((uint64_t) dd->ipath_pioavailregs_dma, PAGE_SIZE);
+	} else
+		dd->__ipath_pioavailregs_base = dd->ipath_pioavailregs_dma;
+	/*
+	 * zero initial, since whole thing mapped
+	 * into user space, and don't want info leak, or confusing garbage
+	 */
+	memset((void *)dd->ipath_pioavailregs_dma, 0, PAGE_SIZE);
+
+	/*
+	 * we really want L2 cache aligned, but for current CPUs of interest,
+	 * they are the same.
+	 */
+	dd->ipath_statusp = (uint64_t *) ((char *)dd->ipath_pioavailregs_dma +
+					  ((2 * L1_CACHE_BYTES +
+					    dd->ipath_pioavregs *
+					    sizeof(uint64_t)) &
+					   ~L1_CACHE_BYTES));
+	/* copy the current value now that it's really allocated */
+	*dd->ipath_statusp = dd->_ipath_status;
+	/*
+	 * setup buffer to hold freeze msg, accessible to apps, following
+	 * statusp
+	 */
+	dd->ipath_freezemsg = (char *)&dd->ipath_statusp[1];
+	/* and it's length */
+	dd->ipath_freezelen = L1_CACHE_BYTES - sizeof(dd->ipath_statusp[0]);
+
+	atmp = virt_to_phys(dd->ipath_pioavailregs_dma);
+	/* stash physical address for user progs */
+	dd->ipath_pioavailregs_phys = atmp;
+	(void)ipath_kput_kreg(t, kr_sendpioavailaddr, atmp);
+	/*
+	 * this is to detect s/w errors, which the h/w works around by
+	 * ignoring the low 6 bits of address, if it wasn't aligned.
+	 */
+	val = ipath_kget_kreg64(t, kr_sendpioavailaddr);
+	if (val != atmp) {
+		_IPATH_UNIT_ERROR(t,
+				  "Catastrophic software error, SendPIOAvailAddr written as %llx, read back as %llx\n",
+				  atmp, val);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (t * 64 > (sizeof(ipath_port0_rcvhdrtail) - 64)) {
+		_IPATH_UNIT_ERROR(t,
+				  "unit %u too large for port 0 rcvhdrtail buffer size\n",
+				  t);
+		ret = -ENODEV;
+	}
+
+	/*
+	 * kernel modules loaded into vmalloc'ed memory,
+	 * verify that when we assume that, map to phys, and back to virt,
+	 * that we get the right contents, so we did the mapping right.
+	 */
+	vpage = vmalloc_to_page((void *)ipath_port0_rcvhdrtail);
+	if (vpage == NOPAGE_SIGBUS || vpage == NOPAGE_OOM) {
+		_IPATH_UNIT_ERROR(t, "vmalloc_to_page for rcvhdrtail fails!\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	/*
+	 * 64 is driven by cache line size, and also by chip requirement
+	 * that low 6 bits be 0
+	 */
+	val = page_to_phys(vpage) + t * 64;
+
+	/* verify that the alignment requirement was met */
+	ipath_kput_kreg_port(t, kr_rcvhdrtailaddr, 0, val);
+	atmp = ipath_kget_kreg64_port(t, kr_rcvhdrtailaddr, 0);
+	if (val != atmp) {
+		_IPATH_UNIT_ERROR(t,
+				  "Catastrophic software error, RcvHdrTailAddr0 written as %llx, read back as %llx from %x\n",
+				  val, atmp, kr_rcvhdrtailaddr);
+		ret = -EINVAL;
+		goto done;
+	}
+	/* so we can get current tail in ipath_kreceive(), per chip */
+	dd->ipath_hdrqtailptr =
+	    &ipath_port0_rcvhdrtail[t *
+				    (64 / sizeof(ipath_port0_rcvhdrtail[0]))];
+
+	ipath_kput_kreg(t, kr_rcvbthqp, IPATH_KD_QP);
+
+	/*
+	 * make sure we are not in freeze, and PIO send enabled, so
+	 * writes to pbc happen
+	 */
+	ipath_kput_kreg(t, kr_hwerrmask, 0ULL);
+	ipath_kput_kreg(t, kr_hwerrclear, -1LL);
+	ipath_kput_kreg(t, kr_control, 0ULL);
+	ipath_kput_kreg(t, kr_sendctrl, INFINIPATH_S_PIOENABLE);
+
+	/*
+	 * write the pbc of each buffer, to be sure it's initialized, then
+	 * cancel all the buffers, and also abort any packets that might
+	 * have been in flight for some reason (the latter is for driver
+	 * unload/reload, but isn't a bad idea at first init).
+	 * PIO send isn't enabled at this point, so there is no danger
+	 * of sending these out on the wire.
+	 * Chip Errata bug 6610
+	 */
+	piobuf = (uint32_t __iomem *) (((char __iomem *)(dd->ipath_kregbase)) +
+				       dd->ipath_piobufbase);
+	pioincr = devdata[t].ipath_palign / sizeof(*piobuf);
+	for (i = 0; i < dd->ipath_piobcnt; i++) {
+		writel(16, piobuf);	/* reasonable word count, just to init pbc */
+		piobuf += pioincr;
+	}
+	/* self-clearing */
+	ipath_kput_kreg(t, kr_sendctrl, INFINIPATH_S_ABORT);
+
+	/*
+	 * before error clears, since we expect serdes pll errors during
+	 * this, the first time after reset
+	 */
+	if (ipath_bringup_link(t)) {
+		_IPATH_INFO("Failed to bringup IB link\n");
+		ret = -ENETDOWN;
+		goto done;
+	}
+
+	/*
+	 * clear any "expected" hwerrs from reset and/or initialization
+	 * clear any that aren't enabled (at least this once), and then
+	 * set the enable mask
+	 */
+	ipath_clear_init_hwerrs(t);
+	ipath_kput_kreg(t, kr_hwerrclear, -1LL);
+	ipath_kput_kreg(t, kr_hwerrmask, dd->ipath_hwerrmask);
+
+	dd->ipath_maskederrs = dd->ipath_ignorederrs;
+	ipath_kput_kreg(t, kr_errorclear, -1LL);	/* clear all */
+	/* enable errors that are masked, at least this first time. */
+	ipath_kput_kreg(t, kr_errormask, ~dd->ipath_maskederrs);
+	/* clear any interrups up to this point (ints still not enabled) */
+	ipath_kput_kreg(t, kr_intclear, -1LL);
+
+	ipath_stats.sps_lid[t] = dd->ipath_lid;
+
+	/*
+	 * allocate the shadow TID array, so we can ipath_putpages
+	 * previous entries. It make make more sense to move the pageshadow
+	 * to the port data structure, so we only allocate memory for ports
+	 * actually in use, since we at 8k per port, now
+	 */
+	dd->ipath_pageshadow = (struct page **)
+	    vmalloc(dd->ipath_cfgports * dd->ipath_rcvtidcnt *
+		    sizeof(struct page *));
+	if (!dd->ipath_pageshadow)
+		_IPATH_UNIT_ERROR(t,
+				  "failed to allocate shadow page * array, no expected sends!\n");
+	else
+		memset(dd->ipath_pageshadow, 0,
+		       dd->ipath_cfgports * dd->ipath_rcvtidcnt *
+		       sizeof(struct page *));
+
+	/* set up the port 0 (kernel) rcvhdr q and egr TIDs */
+	if (!(ret = ipath_create_rcvhdrq(dd->ipath_pd[0])))
+		ret = ipath_create_port0_egr(dd->ipath_pd[0]);
+	if (ret)
+		_IPATH_UNIT_ERROR(t,
+				  "failed to allocate port 0 (kernel) rcvhdrq and/or egr bufs\n");
+	else {
+		init_waitqueue_head(&ipath_sma_wait);
+		init_waitqueue_head(&ipath_sma_state_wait);
+
+		ipath_kput_kreg(pd->port_unit, kr_rcvctrl, dd->ipath_rcvctrl);
+
+		ipath_kput_kreg(t, kr_rcvbthqp, IPATH_KD_QP);
+
+		/* Enable PIO send, and update of PIOavail regs to memory. */
+		dd->ipath_sendctrl = INFINIPATH_S_PIOENABLE
+		    | INFINIPATH_S_PIOBUFAVAILUPD;
+		ipath_kput_kreg(t, kr_sendctrl, dd->ipath_sendctrl);
+
+		/*
+		 * enable port 0 receive, and receive interrupt
+		 * other ports done as user opens and inits them
+		 */
+		dd->ipath_rcvctrl = INFINIPATH_R_TAILUPD |
+		    (1ULL << INFINIPATH_R_PORTENABLE_SHIFT) |
+		    (1ULL << INFINIPATH_R_INTRAVAIL_SHIFT);
+		ipath_kput_kreg(t, kr_rcvctrl, dd->ipath_rcvctrl);
+
+		/*
+		 * now ready for use
+		 * this should be cleared whenever we detect a reset, or
+		 * initiate one.
+		 */
+		dd->ipath_flags |= IPATH_INITTED;
+
+		/*
+		 * init our shadow copies of head from tail values, and write
+		 * head values to match
+		 */
+		val32 = ipath_kget_ureg32(t, ur_rcvegrindextail, 0);
+		(void)ipath_kput_ureg(t, ur_rcvegrindexhead, val32, 0);
+		dd->ipath_port0head = ipath_kget_ureg32(t, ur_rcvhdrtail, 0);
+		(void)ipath_kput_ureg(t, ur_rcvhdrhead, dd->ipath_port0head, 0);
+
+		/*
+		 * by now pioavail updates to memory should have occurred,
+		 * so copy them into our working/shadow registers; this is
+		 * in case something went wrong with abort, but mostly to
+		 * get the initial values of the generation bit correct
+		 */
+		for (i = 0; i < dd->ipath_pioavregs; i++) {
+			/*
+			 * Chip Errata bug 6641; even and odd qwords>3
+			 * are swapped
+			 */
+			if (i > 3) {
+				if (i & 1)
+					dd->ipath_pioavailshadow[i] =
+					    dd->ipath_pioavailregs_dma[i - 1];
+				else
+					dd->ipath_pioavailshadow[i] =
+					    dd->ipath_pioavailregs_dma[i + 1];
+			} else
+				dd->ipath_pioavailshadow[i] =
+				    dd->ipath_pioavailregs_dma[i];
+		}
+		/* can get counters, stats, etc. */
+		dd->ipath_flags |= IPATH_PRESENT;
+	}
+
+	/*
+	 * cause retrigger of pending interrupts ignored during init, even if
+	 * we had errors
+	 */
+	ipath_kput_kreg(t, kr_intclear, 0ULL);
+
+	/*
+	 * set up stats retrieval timer, even if we had errors in last
+	 * portion of setup
+	 */
+	init_timer(&dd->ipath_stats_timer);
+	dd->ipath_stats_timer.function = ipath_get_faststats;
+	dd->ipath_stats_timer.data = (unsigned long)t;
+	/* every 5 seconds; */
+	dd->ipath_stats_timer.expires = jiffies + 5 * HZ;
+	/* takes ~16 seconds to overflow at full IB 4x bandwdith */
+	add_timer(&dd->ipath_stats_timer);
+
+	dd->ipath_stats_timer_active = 1;
+
+done:
+	if (!ret) {
+		ipath_get_guid(t);
+		*dd->ipath_statusp |= IPATH_STATUS_CHIP_PRESENT;
+		if (!ipath_sma_data_spare) {
+			/* first init, setup SMA data structs */
+			ipath_sma_data_spare =
+			    ipath_sma_data_bufs[IPATH_NUM_SMAPKTS];
+			for (i = 0; i < IPATH_NUM_SMAPKTS; i++)
+				ipath_sma_data[i].buf = ipath_sma_data_bufs[i];
+		}
+		/*
+		 * sps_nports is a global, so, we set it to the highest
+		 * number of ports of any of the chips we find; we never
+		 * decrement it, at least for now.
+		 */
+		if (dd->ipath_cfgports > ipath_stats.sps_nports)
+			ipath_stats.sps_nports = dd->ipath_cfgports;
+	}
+	/* if ret is non-zero, we probably should do some cleanup here... */
+	return ret;
+}
+
+int ipath_waitfor_complete(const ipath_type t, ipath_kreg reg_id,
+			   uint64_t bits_to_wait_for, uint64_t * valp)
+{
+	uint64_t timeout, lastval, val;
+
+	lastval = ipath_kget_kreg64(t, reg_id);
+	timeout = get_cycles() + 0x10000000ULL;	/* <- ridiculously long time */
+	do {
+		val = ipath_kget_kreg64(t, reg_id);
+		*valp = val;	/* so they have something, even on failures. */
+		if ((val & bits_to_wait_for) == bits_to_wait_for)
+			return 0;
+		if (val != lastval)
+			_IPATH_VDBG
+			    ("Changed from %llx to %llx, waiting for %llx bits\n",
+			     lastval, val, bits_to_wait_for);
+		yield();
+		if (get_cycles() > timeout) {
+			_IPATH_DBG
+			    ("Didn't get bits %llx in register 0x%x, got %llx\n",
+			     bits_to_wait_for, reg_id, *valp);
+			return ENODEV;
+		}
+	} while (1);
+}
+
+/*
+ * like ipath_waitfor_complete(), but we wait for the CMDVALID bit to go away
+ * indicating the last command has completed.  It doesn't return data
+ */
+int ipath_waitfor_mdio_cmdready(const ipath_type t)
+{
+	uint64_t timeout;
+	uint64_t val;
+
+	timeout = get_cycles() + 0x10000000ULL;	/* <- ridiculously long time */
+	do {
+		val = ipath_kget_kreg64(t, kr_mdio);
+		if (!(val & IPATH_MDIO_CMDVALID))
+			return 0;
+		yield();
+		if (get_cycles() > timeout) {
+			_IPATH_DBG("CMDVALID stuck in mdio reg? (%llx)\n", val);
+			return ENODEV;
+		}
+	} while (1);
+}
+
+void ipath_set_ib_lstate(const ipath_type t, int which)
+{
+	struct ipath_devdata *dd = &devdata[t];
+	char *what;
+
+	/*
+	 * For all cases, we'll either be setting a new value of linkcmd, or
+	 * we want it to be NOP, so clear it here.
+	 * Similarly, we want the linkinitcmd to be NOP for everything
+	 * other than explictly than explictly changing linkinitcmd,
+	 * and for that case, we want to first clear any existing bits
+	 */
+	dd->ipath_ibcctrl &= ~((INFINIPATH_IBCC_LINKCMD_MASK <<
+				INFINIPATH_IBCC_LINKCMD_SHIFT) |
+			       (INFINIPATH_IBCC_LINKINITCMD_MASK <<
+				INFINIPATH_IBCC_LINKINITCMD_SHIFT));
+
+	if (which == INFINIPATH_IBCC_LINKCMD_INIT) {
+		dd->ipath_flags &= ~(IPATH_LINK_TOARMED | IPATH_LINK_TOACTIVE
+				     | IPATH_LINK_SLEEPING);
+		/* so we can watch for a transition */
+		dd->ipath_flags |= IPATH_LINKDOWN;
+		what = "INIT";
+	} else if (which == INFINIPATH_IBCC_LINKCMD_ARMED) {
+		dd->ipath_flags |= IPATH_LINK_TOARMED;
+		dd->ipath_flags &= ~(IPATH_LINK_TOACTIVE | IPATH_LINK_SLEEPING);
+		/*
+		 * this is mainly for loopback testing.  If INITCMD is
+		 * NOP or SLEEP, the link won't ever come up in loopback...
+		 */
+		if (!
+		    (dd->
+		     ipath_flags & (IPATH_LINKINIT | IPATH_LINKARMED |
+				    IPATH_LINKACTIVE))) {
+			_IPATH_SMADBG
+			    ("going to armed, but link not  yet up, set POLL\n");
+			dd->ipath_ibcctrl |=
+			    INFINIPATH_IBCC_LINKINITCMD_POLL <<
+			    INFINIPATH_IBCC_LINKINITCMD_SHIFT;
+		}
+		what = "ARMED";
+	} else if (which == INFINIPATH_IBCC_LINKCMD_ACTIVE) {
+		dd->ipath_flags |= IPATH_LINK_TOACTIVE;
+		dd->ipath_flags &= ~(IPATH_LINK_TOARMED | IPATH_LINK_SLEEPING);
+		what = "ACTIVE";
+	} else if (which & (INFINIPATH_IBCC_LINKINITCMD_MASK << INFINIPATH_IBCC_LINKINITCMD_SHIFT)) {	/* down, disable, etc. */
+		dd->ipath_flags &= ~(IPATH_LINK_TOARMED | IPATH_LINK_TOACTIVE);
+		if (((which & INFINIPATH_IBCC_LINKINITCMD_MASK) >>
+		     INFINIPATH_IBCC_LINKINITCMD_SHIFT) ==
+		    INFINIPATH_IBCC_LINKINITCMD_SLEEP) {
+			dd->ipath_flags |= IPATH_LINK_SLEEPING | IPATH_LINKDOWN;
+		} else
+			dd->ipath_flags |= IPATH_LINKDOWN;
+		dd->ipath_ibcctrl |=
+		    which & (INFINIPATH_IBCC_LINKINITCMD_MASK <<
+			     INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+		what = "DOWN";
+	} else {
+		what = "UNKNOWN";
+		_IPATH_INFO("Unknown link transition requested (which=0x%x)\n",
+			    which);
+	}
+
+	dd->ipath_ibcctrl |= ((uint64_t) which & INFINIPATH_IBCC_LINKCMD_MASK)
+	    << INFINIPATH_IBCC_LINKCMD_SHIFT;
+
+	_IPATH_SMADBG("Trying to move unit %u to %s, current ltstate is %s\n",
+			t, what, ipath_ibcstatus_str[(ipath_kget_kreg64(t, kr_ibcstatus)
+					   >> INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT)
+					  & INFINIPATH_IBCS_LINKTRAININGSTATE_MASK]);
+	ipath_kput_kreg(t, kr_ibcctrl, dd->ipath_ibcctrl);
+}
+
+static int ipath_bringup_link(const ipath_type t)
+{
+	struct ipath_devdata *dd = &devdata[t];
+	uint64_t val, ibc;
+	int ret = 0;
+
+	dd->ipath_control &= ~INFINIPATH_C_LINKENABLE;	/* hold IBC in reset */
+	ipath_kput_kreg(t, kr_control, dd->ipath_control);
+
+	/*
+	 * Note that prior to try 14 or 15 of IB, the credit scaling
+	 * wasn't working, because it was swapped for writes with the
+	 * 1 bit default linkstate field
+	 */
+
+	/* ignore pbc and align word */
+	val = dd->ipath_piosize - 2 * sizeof(uint32_t);
+	/*
+	 * for ICRC, which we only send in diag test pkt mode, and we don't
+	 * need to worry about that for mtu
+	 */
+	val += 1;
+	/*
+	 * set the IBC maxpktlength to the size of our pio buffers
+	 * the maxpktlength is in words.  This is *not* the IB data MTU
+	 */
+	ibc = (val / sizeof(uint32_t)) << INFINIPATH_IBCC_MAXPKTLEN_SHIFT;
+	/* in KB */
+	ibc |= 0x5ULL << INFINIPATH_IBCC_FLOWCTRLWATERMARK_SHIFT;
+	/* how often flowctrl sent
+	 * more or less in usecs; balance against watermark value, so that
+	 * in theory senders always get a flow control update in time to not
+	 * let the IB link go idle.
+	 */
+	ibc |= 0x3ULL << INFINIPATH_IBCC_FLOWCTRLPERIOD_SHIFT;
+	/* max error tolerance */
+	ibc |= 0xfULL << INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT;
+	/* use "real" buffer space for */
+	ibc |= 4ULL << INFINIPATH_IBCC_CREDITSCALE_SHIFT;
+	/* IB credit flow control. */
+	ibc |= 0xfULL << INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT;
+	/* initially come up waiting for TS1, without sending anything. */
+	dd->ipath_ibcctrl = ibc;
+	/* don't put linkinitcmd in ipath_ibcctrl, want that to stay a NOP */
+	ibc |=
+	    INFINIPATH_IBCC_LINKINITCMD_SLEEP <<
+	    INFINIPATH_IBCC_LINKINITCMD_SHIFT;
+	dd->ipath_flags |= IPATH_LINK_SLEEPING;
+	ipath_kput_kreg(t, kr_ibcctrl, ibc);
+
+	ret = ipath_bringup_serdes(t);
+
+	if (ret)
+		_IPATH_INFO("Could not initialize SerDes, not usable\n");
+	else {
+		dd->ipath_control |= INFINIPATH_C_LINKENABLE;	/* enable IBC */
+		ipath_kput_kreg(t, kr_control, dd->ipath_control);
+	}
+
+	return ret;
+}
+
+/*
+ * called from ipath_shutdown_link(), and from sma doing a LINKDOWN
+ * Left as a separate function for historical reasons, and may want
+ * it to do more than just call ipath_set_ib_lstate() again sometime
+ * in the future.
+ */
+void ipath_down_link(const ipath_type t)
+{
+	ipath_set_ib_lstate(t, INFINIPATH_IBCC_LINKINITCMD_SLEEP <<
+			    INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+}
+
+/*
+ * do this when driver is being unloaded, or perhaps for diags, and
+ * maybe when we get an interrupt of a fatal link error that requires
+ * bringing the linkd down and back up
+ */
+static int ipath_shutdown_link(const ipath_type t)
+{
+	uint64_t val;
+	struct ipath_devdata *dd = &devdata[t];
+	int ret = 0;
+
+	_IPATH_DBG("Shutting down the link\n");
+	ipath_down_link(t);
+
+	/*
+	 * we are shutting down, so tell the layered driver.  We don't
+	 * do this on just a link state change, much like ethernet,
+	 * a cable unplug, etc. doesn't change driver state
+	 */
+	if (dd->ipath_layer.l_intr)
+		dd->ipath_layer.l_intr(t, IPATH_LAYER_INT_IF_DOWN);
+
+	dd->ipath_control &= ~INFINIPATH_C_LINKENABLE;	/* disable IBC */
+	ipath_kput_kreg(t, kr_control, dd->ipath_control);
+
+	*dd->ipath_statusp &= ~(IPATH_STATUS_IB_CONF | IPATH_STATUS_IB_READY);
+
+	/*
+	 * clear SerdesEnable and turn the leds off; do this here because
+	 * we are unloading, so don't count on interrupts to move along
+	 */
+
+	ipath_quiet_serdes(t);
+	val = dd->ipath_extctrl &
+	    ~(INFINIPATH_EXTC_LEDPRIPORTGREENON |
+	      INFINIPATH_EXTC_LEDPRIPORTYELLOWON);
+	dd->ipath_extctrl = val;
+	ipath_kput_kreg(t, kr_extctrl, val);
+
+	if (dd->ipath_stats_timer_active) {
+		del_timer_sync(&dd->ipath_stats_timer);
+		dd->ipath_stats_timer_active = 0;
+	}
+	if (*dd->ipath_statusp & IPATH_STATUS_CHIP_PRESENT) {
+		/* can't do anything more with chip */
+		/* needs re-init */
+		*dd->ipath_statusp &= ~IPATH_STATUS_CHIP_PRESENT;
+		if (dd->ipath_kregbase) {
+			/*
+			 * if we haven't already cleaned up before these
+			 * are to ensure any register reads/writes "fail"
+			 * until re-init
+			 */
+			dd->ipath_kregbase = NULL;
+			dd->ipath_kregvirt = NULL;
+			dd->ipath_uregbase = 0ULL;
+			dd->ipath_sregbase = 0ULL;
+			dd->ipath_cregbase = 0ULL;
+			dd->ipath_kregsize = 0;
+		}
+#ifdef CONFIG_MTRR
+		if (dd->ipath_mtrr) {
+			_IPATH_VDBG("undoing WCCOMB on pio buffers\n");
+			mtrr_del(dd->ipath_mtrr, 0, 0);
+			dd->ipath_mtrr = 0;
+		}
+#endif
+	}
+
+	return ret;
+}
+
+/*
+ * when closing, free up any allocated data for a port, if the
+ * reference count goes to zero
+ * Note: this also frees the portdata itself!
+ */
+void ipath_free_pddata(struct ipath_devdata * dd, uint32_t port, int freehdrq)
+{
+	struct ipath_portdata *pd = dd->ipath_pd[port];
+
+	if (!pd)
+		return;
+	if (freehdrq)
+		/*
+		 * only clear and free portdata if we are going to
+		 * also release the hdrq, otherwise we leak the hdrq on each
+		 * open/close cycle
+		 */
+		dd->ipath_pd[port] = NULL;
+	/* cleanup locked pages private data structures */
+	ipath_upages_cleanup(pd);
+	if (freehdrq && pd->port_rcvhdrq) {
+		int i, n = 1 << pd->port_rcvhdrq_order;
+		_IPATH_VDBG("free closed port %d rcvhdrq @ %p (order=%u)\n",
+			    pd->port_port, pd->port_rcvhdrq,
+			    pd->port_rcvhdrq_order);
+		for (i = 0; i < n; i++)
+			ClearPageReserved(virt_to_page
+					  (pd->port_rcvhdrq + (i * PAGE_SIZE)));
+		free_pages((unsigned long)pd->port_rcvhdrq,
+			   pd->port_rcvhdrq_order);
+		pd->port_rcvhdrq = NULL;
+	}
+	if (port && pd->port_rcvegrbuf_pages) {	/* always free this, however */
+		void *virt;
+		unsigned e, i, n = 1 << pd->port_rcvegrbuf_order;
+		if (pd->port_rcvegrbuf_virt) {
+			for (e = 0; e < pd->port_rcvegrbuf_chunks; e++) {
+				virt = pd->port_rcvegrbuf_virt[e];
+				for (i = 0; i < n; i++)
+					ClearPageReserved(virt_to_page
+							  (virt +
+							   (i * PAGE_SIZE)));
+				_IPATH_VDBG
+				    ("egrbuf free_pages(%p, %x), chunk %u/%u\n",
+				     virt, pd->port_rcvegrbuf_order, e,
+				     pd->port_rcvegrbuf_chunks);
+				free_pages((unsigned long)virt,
+					   pd->port_rcvegrbuf_order);
+			}
+			vfree(pd->port_rcvegrbuf_virt);
+			pd->port_rcvegrbuf_virt = NULL;
+		}
+		pd->port_rcvegrbuf_chunks = 0;
+		_IPATH_VDBG("free closed port %d rcvegrbufs ptr array\n",
+			    pd->port_port);
+		/* now the pointer array. */
+		vfree(pd->port_rcvegrbuf_pages);
+		pd->port_rcvegrbuf_pages = NULL;
+	} else if (port == 0 && dd->ipath_port0_skbs) {
+		unsigned e;
+		struct sk_buff **skbs = dd->ipath_port0_skbs;
+
+		dd->ipath_port0_skbs = NULL;
+		_IPATH_VDBG("free closed port %d ipath_port0_skbs @ %p\n",
+			    pd->port_port, skbs);
+		for (e = 0; e < dd->ipath_rcvegrcnt; e++)
+			if (skbs[e])
+				dev_kfree_skb(skbs[e]);
+		vfree(skbs);
+	}
+	if (freehdrq) {
+		kfree(pd->port_tid_pg_list);
+		kfree(pd);
+	}
+}
+
+int __init infinipath_init(void)
+{
+	int r = 0, i;
+
+	_IPATH_DBG(KERN_INFO DRIVER_LOAD_MSG "%s", ipath_core_version);
+
+	ipath_init_picotime();	/* init cycles -> pico conversion */
+
+	/*
+	 * initialize the statusp to temporary storage so we can use it
+	 * everywhere without first checking.  When we "really" assign it,
+	 * we copy from _ipath_status
+	 */
+	for (i = 0; i < infinipath_max; i++)
+		devdata[i].ipath_statusp = &devdata[i]._ipath_status;
+
+	/*
+	 * init these early, in case we take an interrupt as soon as the irq
+	 * is setup.  Saw a spinlock panic once that appeared to be due to that
+	 * problem, when they were initted later on.
+	 */
+	spin_lock_init(&ipath_pioavail_lock);
+	spin_lock_init(&ipath_sma_lock);
+
+	pci_register_driver(&infinipath_driver);
+
+	driver_create_file(&(infinipath_driver.driver), &driver_attr_version);
+
+	if ((r = register_chrdev(ipath_major, MODNAME, &ipath_fops)))
+		_IPATH_ERROR("Unable to register %s device\n", MODNAME);
+
+
+	/*
+	 * never return an error, since we could have stuff registered,
+	 * resources used, etc., even if no hardware found.  This way we
+	 * can clean up through unload.
+	 */
+	return 0;
+}
+
+/*
+ * note: if for some reason the unload fails after this routine, and leaves
+ * the driver enterable by user code, we'll almost certainly crash and burn...
+ */
+static void __exit infinipath_cleanup(void)
+{
+	int r, m, port;
+
+	driver_remove_file(&(infinipath_driver.driver), &driver_attr_version);
+	if ((r = unregister_chrdev(ipath_major, MODNAME)))
+		_IPATH_DBG("unregister of device failed: %d\n", r);
+
+
+	/*
+	 * turn off rcv, send, and interrupts for all ports, all drivers
+	 * should also hard reset the chip here?
+	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
+	 * for all versions of the driver, if they were allocated
+	 */
+	for (m = 0; m < infinipath_max; m++) {
+		uint64_t val;
+		struct ipath_devdata *dd = &devdata[m];
+		if (dd->ipath_kregbase) {
+			/* in case unload fails, be consistent */
+			dd->ipath_rcvctrl = 0U;
+			ipath_kput_kreg(m, kr_rcvctrl, dd->ipath_rcvctrl);
+
+			/*
+			 * gracefully stop all sends allowing any in
+			 * progress to trickle out first.
+			 */
+			ipath_kput_kreg(m, kr_sendctrl, 0ULL);
+			val = ipath_kget_kreg64(m, kr_scratch);	/* flush it */
+			/*
+			 * enough for anything that's going to trickle
+			 * out to have actually done so.
+			 */
+			udelay(5);
+
+			/*
+			 * abort any armed or launched PIO buffers that
+			 * didn't go. (self clearing).	Will cause any
+			 * packet currently being transmitted to go out
+			 * with an EBP, and may also cause a short packet
+			 * error on the receiver.
+			 */
+			ipath_kput_kreg(m, kr_sendctrl, INFINIPATH_S_ABORT);
+
+			/* mask interrupts, but not errors */
+			ipath_kput_kreg(m, kr_intmask, 0ULL);
+			ipath_shutdown_link(m);
+
+			/*
+			 * clear all interrupts and errors.  Next time
+			 * driver is loaded, we know that whatever is
+			 * set happened while we were unloaded
+			 */
+			ipath_kput_kreg(m, kr_hwerrclear, -1LL);
+			ipath_kput_kreg(m, kr_errorclear, -1LL);
+			ipath_kput_kreg(m, kr_intclear, -1LL);
+			if (dd->__ipath_pioavailregs_base) {
+				kfree((void *)dd->__ipath_pioavailregs_base);
+				dd->__ipath_pioavailregs_base = NULL;
+				dd->ipath_pioavailregs_dma = NULL;
+			}
+
+			if (dd->ipath_pageshadow) {
+				struct page **tmpp = dd->ipath_pageshadow;
+				int i, cnt = 0;
+
+				_IPATH_VDBG
+				    ("Unlocking any expTID pages still locked\n");
+				for (port = 0; port < dd->ipath_cfgports;
+				     port++) {
+					int port_tidbase =
+					    port * dd->ipath_rcvtidcnt;
+					int maxtid =
+					    port_tidbase + dd->ipath_rcvtidcnt;
+					for (i = port_tidbase; i < maxtid; i++) {
+						if (tmpp[i]) {
+							ipath_putpages(1,
+								      &tmpp[i]);
+							tmpp[i] = NULL;
+							cnt++;
+						}
+					}
+				}
+				if (cnt) {
+					ipath_stats.sps_pageunlocks += cnt;
+					_IPATH_VDBG
+					    ("There were still %u expTID entries locked\n",
+					     cnt);
+				}
+				if (ipath_stats.sps_pagelocks
+				    || ipath_stats.sps_pageunlocks)
+					_IPATH_VDBG
+					    ("%llu pages locked, %llu unlocked via ipath_m{un}lock\n",
+					     ipath_stats.sps_pagelocks,
+					     ipath_stats.sps_pageunlocks);
+
+				_IPATH_VDBG
+				    ("Free shadow page tid array at %p\n",
+				     dd->ipath_pageshadow);
+				vfree(dd->ipath_pageshadow);
+				dd->ipath_pageshadow = NULL;
+			}
+
+			/*
+			 * free any resources still in use (usually just
+			 * kernel ports) at unload
+			 */
+			for (port = 0; port < dd->ipath_cfgports; port++)
+				ipath_free_pddata(dd, port, 1);
+			kfree(dd->ipath_pd);
+			/*
+			 * debuggability, in case some cleanup path
+			 * tries to use it after this
+			 */
+			dd->ipath_pd = NULL;
+		}
+
+		if (dd->pcidev) {
+			if (dd->pcidev->irq) {
+				_IPATH_VDBG("unit %u free_irq of irq %x\n", m,
+					    dd->pcidev->irq);
+				free_irq(dd->pcidev->irq, dd);
+			} else
+				_IPATH_DBG
+				    ("irq is 0, not doing free_irq for unit %u\n",
+				     m);
+			dd->pcidev = NULL;
+		}
+		if (dd->pci_registered) {
+			_IPATH_VDBG
+			    ("Unregistering pci infrastructure unit %u\n", m);
+			pci_unregister_driver(&infinipath_driver);
+			dd->pci_registered = 0;
+		} else
+			_IPATH_VDBG
+			    ("unit %u: no pci unreg, wasn't registered\n", m);
+		ipath_chip_cleanup(dd);	/* clean up any per-chip chip-specific stuff */
+	}
+	/*
+	 * clean up any chip-specific stuff for now, only one type of chip
+	 * for any given driver
+	 */
+	ipath_chip_done();
+
+	/* cleanup all our locked pages private data structures */
+	ipath_upages_cleanup(NULL);
+}
+
+/* This is a generic function here, so it can return device-specific
+ * info.  This allows keeping in sync with the version that supports
+ * multiple chip types.
+*/
+void ipath_get_boardname(const ipath_type t, char *name, size_t namelen)
+{
+	ipath_ht_get_boardname(t, name, namelen);
+}
+
+module_init(infinipath_init);
+module_exit(infinipath_cleanup);
+
+EXPORT_SYMBOL(infinipath_debug);
+EXPORT_SYMBOL(ipath_get_boardname);
+
