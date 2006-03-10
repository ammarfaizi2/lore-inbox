Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWCJAnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWCJAnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWCJAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:42:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:654 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752128AbWCJAfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:44 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 20] ipath - copy and send routines for sending an skb
X-Mercurial-Node: 227b3e7c27cef282100a970b13ef52742fa468d3
Message-Id: <227b3e7c27cef282100a.1141950933@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:33 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 19bdf20bc544 -r 227b3e7c27ce drivers/infiniband/hw/ipath/ipath_copy.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_copy.c	Thu Mar  9 16:15:23 2006 -0800
@@ -0,0 +1,504 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ * This file provides support for doing sk_buff buffer swapping between
+ * the low level driver eager buffers, and the network layer.  It's part
+ * of the core driver, rather than the ether driver, because it relies
+ * on variables and functions in the core driver.  It exports a single
+ * entry point for use in the ipath_ether module.
+ */
+
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+
+/**
+ * layer_send_getpiobuf - allocate, setup and copy out a PIO send buffer
+ * @dd: the infinipath device
+ * @cdp: the data to copy
+ *
+ * Allocate a PIO send buffer, initialize the header and copy it out.
+ */
+static int layer_send_getpiobuf(struct ipath_devdata *dd,
+				struct copy_data_s *cdp)
+{
+	u32 extra_bytes;
+	u32 len, nwords, hdrwords;
+	u32 __iomem *piobuf;
+
+	piobuf = ipath_getpiobuf(dd, NULL);
+	if (!piobuf) {
+		cdp->error = -EBUSY;
+		return cdp->error;
+	}
+
+	/*
+	 * Compute the max amount of data that can fit into a PIO buffer.
+	 * buffer size - header size - trigger qword length & flags - CRC
+	 */
+	len = dd->ipath_ibmaxlen -
+		sizeof(struct ether_header) - 8 - (SIZE_OF_CRC << 2);
+	if (len > dd->ipath_rcvegrbufsize)
+		len = dd->ipath_rcvegrbufsize;
+	if (len > (cdp->len + cdp->extra))
+		len = (cdp->len + cdp->extra);
+	/* Compute word aligment (i.e., (len & 3) ? 4 - (len & 3) : 0) */
+	extra_bytes = (4 - len) & 3;
+	nwords = (sizeof(struct ether_header) + len + extra_bytes) >> 2;
+	cdp->hdr->lrh[2] = htons(nwords + SIZE_OF_CRC);
+	cdp->hdr->bth[0] = htonl((OPCODE_ITH4X << 24) +
+				 (extra_bytes << 20) +
+				 IPS_DEFAULT_P_KEY);
+	cdp->hdr->sub_opcode = OPCODE_ENCAP;
+
+	cdp->hdr->bth[2] = 0;
+	/*
+	 * Generate an interrupt on the receive side for the last
+	 * fragment.
+	 */
+	cdp->hdr->iph.pkt_flags = ((cdp->len + cdp->extra) == len)
+		? INFINIPATH_KPF_INTR : 0;
+	cdp->hdr->iph.chksum =
+		(u16) IPS_LRH_BTH + (u16) (nwords + SIZE_OF_CRC) -
+		(u16) ((cdp->hdr->iph.ver_port_tid_offset >> 16) & 0xFFFF) -
+		(u16) (cdp->hdr->iph.ver_port_tid_offset & 0xFFFF) -
+		(u16) cdp->hdr->iph.pkt_flags;
+
+	ipath_cdbg(VERBOSE, "send %d (%x %x %x %x %x %x %x)\n", nwords,
+		   cdp->hdr->lrh[0], cdp->hdr->lrh[1],
+		   cdp->hdr->lrh[2], cdp->hdr->lrh[3],
+		   cdp->hdr->bth[0], cdp->hdr->bth[1], cdp->hdr->bth[2]);
+	/*
+	 * Write len to control qword, no flags.
+	 * +1 is for the qword padding of pbc.
+	 */
+	writeq(nwords + 1ULL, (u64 __iomem *) piobuf);
+	/* we have to flush after the PBC for correctness on some cpus
+	 * or WC buffer can be written out of order */
+	ipath_flush_wc();
+	piobuf += 2;
+	hdrwords = sizeof(struct ether_header) >> 2;
+	__iowrite32_copy(piobuf, cdp->hdr, hdrwords);
+	cdp->csum_pio = &((struct ether_header __iomem *)piobuf)->csum;
+	cdp->to = piobuf + hdrwords;
+	cdp->flen = nwords - hdrwords;
+	cdp->hdr->frag_num++;
+	return 0;
+}
+
+/**
+ * copy_extra_dword - copy the last full dword
+ * @dd: the infinipath device
+ * @cdp: the data to copy
+ * @dosum: write a checksum if true
+ *
+ * copy the last full dword when that's the "extra" word, preceding it
+ * with a memory fence, so that all prior data is written to the PIO
+ * buffer before the trigger word, to enforce the correct bus ordering
+ * of the WC buffer contents on the bus.
+ */
+static inline unsigned copy_extra_dword(struct ipath_devdata *dd,
+					struct copy_data_s *cdp,
+					unsigned dosum)
+{
+	if (!cdp->flen && layer_send_getpiobuf(dd, cdp) < 0)
+		return 1;
+	/* write the checksum before the last PIO write, if requested. */
+	if (dosum && cdp->flen == 1)
+		__raw_writel(csum_fold(cdp->csum), cdp->csum_pio);
+	cdp->extra = 0;
+	cdp->flen -= 1;
+	if (!cdp->flen) {	/* trigger word being written */
+		ipath_flush_wc();
+		__raw_writel(cdp->u.w, cdp->to++);
+		ipath_flush_wc();
+	} else			/* still more to copy to pio buf */
+		__raw_writel(cdp->u.w, cdp->to++);
+	return 0;
+}
+
+/**
+ * copy_a_buffer - copy a PIO buffer's worth to the PIO buffer
+ * @dd: the infinipath device
+ * @cdp: the destination
+ * @p: the data to copy
+ * @n: the amount to copy
+ * @dosum: write a checksum if true
+ *
+ * copy a PIO buffer's worth (or the skb fragment, at least) to the PIO
+ * buffer, adding a memory fence before the last word.  We need the fence
+ * as part of forcing the WC ordering on some cpus, for the cases where
+ * it will be the trigger word.  The final fence after the trigger word
+ * will be done either at the next chunk, or on final return from the caller
+ * Takes max byte count, returns byte count actually done (always rounded
+ * to dword multiple).
+ */
+static u32 copy_a_buffer(struct ipath_devdata *dd, struct copy_data_s *cdp,
+			 void *p, u32 n, unsigned dosum)
+{
+	u32 *p32;
+
+	if (!cdp->flen && layer_send_getpiobuf(dd, cdp) < 0)
+		return -1;
+	if (n > cdp->flen)
+		n = cdp->flen;
+	if (dosum && cdp->flen == n)
+		__raw_writel(csum_fold(cdp->csum), cdp->csum_pio);
+	p32 = p;
+	cdp->flen -= n;
+	if (!cdp->flen) {	/* trigger word being written */
+		__iowrite32_copy(cdp->to, p32, n - 1);
+		cdp->to += n - 1;
+		ipath_flush_wc();
+		__raw_writel(p32[n - 1], cdp->to++);
+		ipath_flush_wc();
+	} else {		/* still more to copy to pio buf */
+		__iowrite32_copy(cdp->to, p32, n);
+		cdp->to += n;
+	}
+	n <<= 2;
+	cdp->offset += n;
+	cdp->len -= n;
+	return n;
+}
+
+static inline int copy_bits_internal(struct ipath_devdata *dd,
+				     struct copy_data_s *cdp, u8 *p,
+				     unsigned *copyp, unsigned *offsetp,
+				     unsigned *lenp, int do_csum)
+{
+	unsigned copy = *copyp;
+	unsigned len = *lenp;
+	int ret = 1;
+
+	if (copy > len)
+		copy = len;
+	*offsetp += copy;
+	len -= copy;
+	if (do_csum && !cdp->checksum_calc) {
+		unsigned int csum2;
+
+		cdp->checksum_calc = 1;
+
+		csum2 = csum_partial(p, copy, 0);
+		cdp->csum = csum_block_add(cdp->csum, csum2, cdp->pos);
+		cdp->pos += copy;
+	}
+	/*
+	 * If the alignment buffer is not empty, fill it and write it
+	 * out.
+	 */
+	if (cdp->extra) {
+		if (cdp->extra == 4) {
+			if (copy_extra_dword(dd, cdp, 1))
+				goto done;
+		}
+		else while (copy != 0) {
+			cdp->u.buf[cdp->extra] = *p++;
+			copy--;
+			cdp->offset++;
+			cdp->len--;
+			if (++cdp->extra == 4) {
+				if (copy_extra_dword(dd, cdp, 1))
+					goto done;
+				break;
+			}
+		}
+	}
+
+	while (copy >= 4) {
+		u32 n = copy_a_buffer(dd, cdp, p, copy >> 2, 1);
+		if (n == -1)
+			goto done;
+		p += n;
+		copy -= n;
+	}
+	/*
+	 * Either cdp->extra is zero or copy is zero, which means that
+	 * the loop here can't cause the alignment buffer to fill up.
+	 */
+	while (copy != 0) {
+		cdp->u.buf[cdp->extra++] = *p++;
+		copy--;
+		cdp->offset++;
+		cdp->len--;
+	}
+
+	if (do_csum)
+		cdp->checksum_calc = 0;
+
+	if (len == 0)
+		goto done;
+
+	ret = 0;
+done:
+	*copyp = copy;
+	*lenp = len;
+	return ret;
+}
+
+/**
+ * copy_and_maybe_csum_bits - copy data into the PIO buffer
+ * @dd: the infinipath device
+ * @skb: the source sk_buff
+ * @offset: the offset within the source
+ * @len: the len of the data to copy
+ * @cdp: the destination
+ * @do_csum: write a checksum if true
+ *
+ * Copy data out of one or a chain of sk_buffs, into the PIO buffer,
+ * generating the checksum as we go if do_csum is non-zero.
+ * Fragment an sk_buff into multiple IB packets if the amount of data
+ * is more than a single eager send.
+ * Offset and len are in bytes.
+ * Note that this function is recursive!
+ */
+static void copy_and_maybe_csum_bits(struct ipath_devdata *dd,
+				     const struct sk_buff *skb,
+				     unsigned int offset,
+				     unsigned int len,
+				     struct copy_data_s *cdp,
+				     int do_csum)
+{
+	unsigned int start = skb_headlen(skb);
+	unsigned int i, copy;
+
+	/* Copy header. */
+	copy = start - offset;
+	if ((int) copy > 0) {
+		u8 *p = skb->data + offset;
+
+		if (copy_bits_internal(dd, cdp, p, &copy, &offset, &len,
+				       do_csum))
+			goto done;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		unsigned int end;
+
+		end = start + frag->size;
+		copy = end - offset;
+		if ((int) copy > 0) {
+			u8 *vaddr = kmap_skb_frag(frag);
+			u8 *p = vaddr + frag->page_offset + offset - start;
+			int ret;
+
+			ret = copy_bits_internal(dd, cdp, p, &copy,
+						 &offset, &len, do_csum);
+
+			kunmap_skb_frag(vaddr);
+
+			if (ret)
+				goto done;
+		}
+		start = end;
+	}
+
+	if (skb_shinfo(skb)->frag_list) {
+		struct sk_buff *list = skb_shinfo(skb)->frag_list;
+
+		for (; list; list = list->next) {
+			unsigned int end;
+
+			end = start + list->len;
+			copy = end - offset;
+			if ((int) copy > 0) {
+				if (copy > len)
+					copy = len;
+				copy_and_maybe_csum_bits(dd, list,
+							 offset - start,
+							 copy, cdp,
+							 do_csum);
+				len -= copy;
+				if (cdp->error || len == 0)
+					goto done;
+				offset += copy;
+			}
+			start = end;
+		}
+	}
+	if (len)
+		cdp->error = -EFAULT;
+done:
+	/* we have to flush after trigger word for correctness on some
+	 * cpus or WC buffer can be written out of order; needed even
+	 * if there was an error */
+	ipath_flush_wc();
+}
+
+static inline void copy_and_csum_bits(struct ipath_devdata *dd,
+				      const struct sk_buff *skb,
+				      unsigned int offset,
+				      unsigned int len,
+				      struct copy_data_s *cdp)
+{
+	copy_and_maybe_csum_bits(dd, skb, offset, len, cdp, 1);
+}
+
+static inline void copy_bits(struct ipath_devdata *dd,
+			     const struct sk_buff *skb,
+			     unsigned int offset,
+			     unsigned int len,
+			     struct copy_data_s *cdp)
+{
+	copy_and_maybe_csum_bits(dd, skb, offset, len, cdp, 0);
+}
+
+/**
+ * ipath_layer_send_skb - layered sk_buff send
+ * @dd: the infinipath device
+ * @cdata: the data to send
+ *
+ * This is called by the ipath_ether module.
+ *
+ * Note that the header should have the unchanging parts
+ * initialized but the rest of the header is computed as needed in
+ * order to break up skb data buffers larger than the hardware MTU.
+ * In other words, the Linux network stack MTU can be larger than the
+ * hardware MTU.
+ */
+int ipath_layer_send_skb(struct ipath_devdata *dd,
+			 struct copy_data_s *cdata)
+{
+	int ret = 0;
+	u16 vlsllnh;
+
+	if (!(dd->ipath_flags & IPATH_RCVHDRSZ_SET)) {
+		dev_info(&dd->pcidev->dev, "send while not open\n");
+		ret = -EINVAL;
+	}
+	else if ((dd->ipath_flags & (IPATH_LINKUNK | IPATH_LINKDOWN)) ||
+		 dd->ipath_lid == 0) {
+		/* lid check is for when sma hasn't yet configured */
+		ret = -ENETDOWN;
+		ipath_cdbg(VERBOSE, "send while not ready, mylid=%u, "
+			   "flags=0x%x\n", dd->ipath_lid, dd->ipath_flags);
+	}
+	vlsllnh = *((u16 *) cdata->hdr);
+	if (vlsllnh != htons(IPS_LRH_BTH)) {
+		ipath_dbg("Warning: lrh[0] wrong (%x, not %x); "
+			  "not sending\n", vlsllnh, htons(IPS_LRH_BTH));
+		ret = -EINVAL;
+	}
+	if (ret)
+		goto done;
+
+	cdata->error = 0;	/* clear last calls error  */
+
+	if (cdata->skb->ip_summed == CHECKSUM_HW) {
+		unsigned int csstart = cdata->skb->h.raw - cdata->skb->data;
+
+		/*
+		 * Computing the checksum is a bit tricky since if we
+		 * fragment the packet, the fragment that should contain the
+		 * checksum will have already been sent.  The solution is to
+		 * store the checksum in the header of the last fragment
+		 * just before we write the last data word which triggers
+		 * the last fragment to be sent.  The receiver will check
+		 * the header "tag" field, see that there is a checksum, and
+		 * store the checksum back into the packet.
+		 *
+		 * Save the offset of the two byte checksum.
+		 *
+		 * Note that we have to add 2 to account for the two bytes
+		 * of the ethernet address we stripped from the packet and
+		 * put in the header.
+		 */
+
+		cdata->hdr->csum_offset = csstart + cdata->skb->csum + 2;
+
+		if (cdata->offset < csstart)
+			copy_bits(dd, cdata->skb, cdata->offset,
+				  csstart - cdata->offset, cdata);
+
+		if (cdata->error) {
+			ret = cdata->error;
+			goto done;
+		}
+
+		if (cdata->offset < cdata->skb->len)
+			copy_and_csum_bits(dd, cdata->skb, cdata->offset,
+					   cdata->skb->len - cdata->offset,
+					   cdata);
+
+		if (cdata->error) {
+			ret = cdata->error;
+			goto done;
+		}
+
+		if (cdata->extra) {
+			while (cdata->extra < 4)
+				cdata->u.buf[cdata->extra++] = 0;
+			(void)copy_extra_dword(dd, cdata, 1);
+		}
+	} else {
+		copy_bits(dd, cdata->skb, cdata->offset,
+			  cdata->skb->len - cdata->offset, cdata);
+
+		if (cdata->error) {
+			ret = cdata->error;
+			goto done;
+		}
+
+		if (cdata->extra) {
+			while (cdata->extra < 4)
+				cdata->u.buf[cdata->extra++] = 0;
+			(void)copy_extra_dword(dd, cdata, 1);
+		}
+	}
+
+	if (cdata->error) {
+		ret = cdata->error;
+		if (cdata->error != -EBUSY)
+			ipath_dev_err(dd, "layer_send copy_bits failed "
+				      "with error %d\n", -ret);
+	}
+
+	/* another ether packet sent */
+	ipath_stats.sps_ether_spkts++;
+
+done:
+	/*
+	 * we have to flush after trigger word for correctness on
+	 * some cpus or WC buffer can be written out of order; needed
+	 * even if there was an error
+	 */
+	ipath_flush_wc();
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(ipath_layer_send_skb);
