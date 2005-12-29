Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVL2Am3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVL2Am3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVL2AjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:17 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50408 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932570AbVL2AjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:09 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 20] ipath - MMIO copy routines
X-Mercurial-Node: ffbd416f30d4d7af37f21d55c7545b8edbbc232a
Message-Id: <ffbd416f30d4d7af37f2.1135816286@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:26 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 9e8d017ed298 -r ffbd416f30d4 drivers/infiniband/hw/ipath/ipath_copy.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_copy.c	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,612 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
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
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/bitops.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+
+#include <linux/crc32.h>        /* we can generate our own crc's for testing */
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/*
+ * Allocate a PIO send buffer, initialize the header and copy it out.
+ */
+static int layer_send_getpiobuf(struct copy_data_s *cdp)
+{
+	uint32_t device = cdp->device;
+	uint32_t extra_bytes;
+	uint32_t len, nwords;
+	uint32_t __iomem *piobuf;
+
+	if (!(piobuf = ipath_getpiobuf(device, NULL))) {
+		cdp->error = -EBUSY;
+		return cdp->error;
+	}
+
+	/*
+	 * Compute the max amount of data that can fit into a PIO buffer.
+	 * buffer size - header size - trigger qword length & flags - CRC
+	 */
+	len = devdata[device].ipath_ibmaxlen -
+		sizeof(struct ether_header_typ) - 8 - (SIZE_OF_CRC << 2);
+	if (len > devdata[device].ipath_rcvegrbufsize)
+		len = devdata[device].ipath_rcvegrbufsize;
+	if (len > (cdp->len + cdp->extra))
+		len = (cdp->len + cdp->extra);
+	/* Compute word aligment (i.e., (len & 3) ? 4 - (len & 3) : 0) */
+	extra_bytes = (4 - len) & 3;
+	nwords = (sizeof(struct ether_header_typ) + len + extra_bytes) >> 2;
+	cdp->hdr->lrh[2] = htons(nwords + SIZE_OF_CRC);
+	cdp->hdr->bth[0] = htonl((OPCODE_ITH4X << 24) + (extra_bytes << 20) +
+		IPS_DEFAULT_P_KEY);
+	cdp->hdr->sub_opcode = OPCODE_ENCAP;
+
+	cdp->hdr->bth[2] = 0;
+	/* Generate an interrupt on the receive side for the last fragment. */
+	cdp->hdr->iph.pkt_flags = ((cdp->len+cdp->extra) == len) ? INFINIPATH_KPF_INTR : 0;
+	cdp->hdr->iph.chksum = (uint16_t) IPS_LRH_BTH +
+		(uint16_t) (nwords + SIZE_OF_CRC) -
+		(uint16_t) ((cdp->hdr->iph.ver_port_tid_offset >> 16)&0xFFFF) -
+		(uint16_t) (cdp->hdr->iph.ver_port_tid_offset & 0xFFFF) -
+		(uint16_t) cdp->hdr->iph.pkt_flags;
+
+	_IPATH_VDBG("send %d (%x %x %x %x %x %x %x)\n", nwords,
+		cdp->hdr->lrh[0], cdp->hdr->lrh[1],
+		cdp->hdr->lrh[2], cdp->hdr->lrh[3],
+		cdp->hdr->bth[0], cdp->hdr->bth[1], cdp->hdr->bth[2]);
+	/*
+	 * Write len to control qword, no flags.
+	 * +1 is for the qword padding of pbc.
+	 */
+	writeq(nwords + 1ULL, (uint64_t __iomem *) piobuf);
+	/* we have to flush after the PBC for correctness on some cpus
+	 * or WC buffer can be written out of order */
+	mb();
+	piobuf += 2;
+	memcpy_toio32(piobuf, cdp->hdr, sizeof(struct ether_header_typ) >> 2);
+	cdp->csum_pio = &((struct ether_header_typ __iomem *) piobuf)->csum;
+	cdp->to = piobuf + (sizeof(struct ether_header_typ) >> 2);
+	cdp->flen = nwords - (sizeof(struct ether_header_typ) >> 2);
+	cdp->hdr->frag_num++;
+	return 0;
+}
+
+/*
+ * copy the last full dword when that's the "extra" word, preceding it
+ * with a memory fence, so that all prior data is written to the PIO
+ * buffer before the trigger word, to enforce the correct bus ordering
+ * of the WC buffer contents on the bus.
+ */
+static inline unsigned copy_extra_dword(struct copy_data_s *cdp, unsigned dosum)
+{
+	if (!cdp->flen && layer_send_getpiobuf(cdp) < 0)
+		return 1;
+	/* write the checksum before the last PIO write, if requested. */
+	if (dosum && cdp->flen == 1)
+		writel(csum_fold(cdp->csum), cdp->csum_pio);
+	mb();
+	writel(cdp->u.w, cdp->to++);
+	mb();
+	cdp->extra = 0;
+	cdp->flen -= 1;
+	return 0;
+}
+
+/*
+ * copy a PIO buffer's worth (or the skb fragment, at least) to the PIO
+ * buffer, adding a memory fence before the last word.  We need the fence
+ * as part of forcing the WC ordering on some cpus, for the cases where
+ * it will be the trigger word.  The final fence after the trigger word
+ * will be done either at the next chunk, or on final return from the caller
+ * Takes max byte count, returns byte count actually done (always rounded
+ * to dword multiple).
+ */
+static uint32_t copy_a_buffer(struct copy_data_s *cdp, void *p, uint32_t n,
+	unsigned dosum)
+{
+	uint32_t *p32;
+
+	if (!cdp->flen && layer_send_getpiobuf(cdp) < 0)
+		return -1;
+	if (n > cdp->flen)
+		n = cdp->flen;
+	if (dosum && cdp->flen == n)
+		writel(csum_fold(cdp->csum), cdp->csum_pio);
+	p32 = p;
+	memcpy_toio32(cdp->to, p32, n-1);
+	cdp->to += n-1;
+	mb();
+	writel(p32[n-1], cdp->to++);
+	mb();
+	_IPATH_PDBG("trigger write to pio %p\n", &p32[n-1]);
+	cdp->flen -= n;
+	n <<= 2;
+	cdp->offset += n;
+	cdp->len -= n;
+	return n;
+}
+
+/*
+ * Copy data out of one or a chain of sk_buffs, into the PIO buffer.
+ * Fragment an sk_buff into multiple IB packets if the amount of data is
+ * more than a single eager send.
+ * Offset and len are in bytes.
+ * Note that this function is recursive!
+ */
+static void copy_bits(const struct sk_buff *skb, unsigned int offset,
+    unsigned int len, struct copy_data_s *cdp)
+{
+	unsigned int start = skb_headlen(skb);
+	unsigned int i, copy;
+	uint32_t n;
+	uint8_t *p;
+
+	/* Copy header. */
+	if ((int)(copy = start - offset) > 0) {
+		if (copy > len)
+			copy = len;
+		p = skb->data + offset;
+		offset += copy;
+		len -= copy;
+		/* If the alignment buffer is not empty, fill it and write it out. */
+		if (cdp->extra) {
+			if (cdp->extra == 4) {
+				if (copy_extra_dword(cdp, 0))
+					return;
+			}
+			else while (copy != 0) {
+				cdp->u.buf[cdp->extra] = *p++;
+				copy--;
+				cdp->offset++;
+				cdp->len--;
+
+				if (++cdp->extra == 4) {
+					if (copy_extra_dword(cdp, 0))
+						return;
+					break;
+				}
+			}
+		}
+		while (copy >= 4) {
+			n = copy_a_buffer(cdp, p, copy>>2, 0);
+			if (n == -1)
+				return;
+			p += n;
+			copy -= n;
+		}
+		/*
+		 * Either cdp->extra is zero or copy is zero which means that
+		 * the loop here can't cause the alignment buffer to fill up.
+		 */
+		while (copy != 0) {
+			cdp->u.buf[cdp->extra++] = *p++;
+			copy--;
+			cdp->offset++;
+			cdp->len--;
+
+		}
+		if (len == 0)
+			return;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		unsigned int end;
+
+		end = start + frag->size;
+		if ((int)(copy = end - offset) > 0) {
+			uint8_t *vaddr;
+
+			if (copy > len)
+				copy = len;
+			vaddr = kmap_skb_frag(frag);
+			p = vaddr + frag->page_offset + offset - start;
+			offset += copy;
+			len -= copy;
+			/* If the alignment buffer is not empty, fill it and write it out. */
+			if (cdp->extra) {
+				if (cdp->extra == 4) {
+					if (copy_extra_dword(cdp, 0))
+						return;
+				}
+				else while (copy != 0) {
+					cdp->u.buf[cdp->extra] = *p++;
+					copy--;
+					cdp->offset++;
+					cdp->len--;
+
+					if (++cdp->extra == 4) {
+						if (copy_extra_dword(cdp, 0))
+							return;
+						break;
+					}
+				}
+			}
+			while (copy >= 4) {
+				n = copy_a_buffer(cdp, p, copy>>2, 0);
+				if (n == -1)
+					return;
+				p += n;
+				copy -= n;
+			}
+			/*
+			 * Either cdp->extra is zero or copy is zero which means that
+			 * the loop here can't cause the alignment buffer to fill up.
+			 */
+			while (copy != 0) {
+				cdp->u.buf[cdp->extra++] = *p++;
+				copy--;
+				cdp->offset++;
+				cdp->len--;
+			}
+			kunmap_skb_frag(vaddr);
+
+			if (len == 0)
+				return;
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
+			if ((int)(copy = end - offset) > 0) {
+				if (copy > len)
+					copy = len;
+				copy_bits(list, offset - start, copy, cdp);
+				if (cdp->error || (len -= copy) == 0)
+					return;
+			}
+			start = end;
+		}
+	}
+	if (len)
+		cdp->error = -EFAULT;
+}
+
+/*
+ * Copy data out of one or a chain of sk_buffs, into the PIO buffer, generating
+ * the checksum as we go.
+ * Fragment an sk_buff into multiple IB packets if the amount of data is
+ * more than a single eager send.
+ * Offset and len are in bytes.
+ * Note that this function is recursive!
+ */
+static void copy_and_csum_bits(const struct sk_buff *skb, unsigned int offset,
+    unsigned int len, struct copy_data_s *cdp)
+{
+	unsigned int start = skb_headlen(skb);
+	unsigned int i, copy;
+	unsigned int csum2;
+	uint32_t n;
+	uint8_t *p;
+
+	/* Copy header. */
+	if ((int)(copy = start - offset) > 0) {
+		if (copy > len)
+			copy = len;
+		p = skb->data + offset;
+		offset += copy;
+		len -= copy;
+		if (!cdp->checksum_calc) {
+			cdp->checksum_calc = 1;
+
+			csum2 = csum_partial(p, copy, 0);
+			cdp->csum = csum_block_add(cdp->csum, csum2, cdp->pos);
+			cdp->pos += copy;
+		}
+		/* If the alignment buffer is not empty, fill it and write it out. */
+		if (cdp->extra) {
+			if (cdp->extra == 4) {
+				if (copy_extra_dword(cdp, 1))
+					goto done;
+			}
+			else while (copy != 0) {
+				cdp->u.buf[cdp->extra] = *p++;
+				copy--;
+				cdp->offset++;
+				cdp->len--;
+				if (++cdp->extra == 4) {
+					if (copy_extra_dword(cdp, 1))
+						goto done;
+					break;
+				}
+			}
+		}
+
+		while (copy >= 4) {
+			n = copy_a_buffer(cdp, p, copy>>2, 1);
+			if (n == -1)
+				goto done;
+			p += n;
+			copy -= n;
+		}
+		/*
+		 * Either cdp->extra is zero or copy is zero which means that
+		 * the loop here can't cause the alignment buffer to fill up.
+		 */
+		while (copy != 0) {
+			cdp->u.buf[cdp->extra++] = *p++;
+			copy--;
+			cdp->offset++;
+			cdp->len--;
+		}
+
+		cdp->checksum_calc = 0;
+
+		if (len == 0)
+			goto done;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		unsigned int end;
+
+		end = start + frag->size;
+		if ((int)(copy = end - offset) > 0) {
+			uint8_t *vaddr;
+
+			if (copy > len)
+				copy = len;
+			vaddr = kmap_skb_frag(frag);
+			p = vaddr + frag->page_offset + offset - start;
+			offset += copy;
+			len -= copy;
+
+			if (!cdp->checksum_calc) {
+				cdp->checksum_calc = 1;
+
+				csum2 = csum_partial(p, copy, 0);
+				cdp->csum = csum_block_add(cdp->csum, csum2,
+					cdp->pos);
+				cdp->pos += copy;
+			}
+			/* If the alignment buffer is not empty, fill it and write it out. */
+			if (cdp->extra) {
+				if (cdp->extra == 4) {
+					if (copy_extra_dword(cdp, 1)) {
+						kunmap_skb_frag(vaddr);
+						goto done;
+					}
+				}
+				else while (copy != 0) {
+					cdp->u.buf[cdp->extra] = *p++;
+					copy--;
+					cdp->offset++;
+					cdp->len--;
+
+					if (++cdp->extra == 4) {
+						if (copy_extra_dword(cdp, 1)) {
+							kunmap_skb_frag(vaddr);
+							goto done;
+						}
+						break;
+					}
+				}
+			}
+			while (copy >= 4) {
+				n = copy_a_buffer(cdp, p, copy>>2, 1);
+				if (n == -1) {
+					kunmap_skb_frag(vaddr);
+					goto done;
+				}
+				p += n;
+				copy -= n;
+			}
+			/*
+			 * Either cdp->extra is zero or copy is zero which means that
+			 * the loop here can't cause the alignment buffer to fill up.
+			 */
+			while (copy != 0) {
+				cdp->u.buf[cdp->extra++] = *p++;
+				copy--;
+				cdp->offset++;
+				cdp->len--;
+			}
+			kunmap_skb_frag(vaddr);
+
+			cdp->checksum_calc = 0;
+
+			if (len == 0)
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
+			if ((int)(copy = end - offset) > 0) {
+				if (copy > len)
+					copy = len;
+				copy_and_csum_bits(list, offset - start, copy, cdp);
+				if (cdp->error || (len -= copy) == 0)
+					goto done;
+				offset += copy;
+			}
+			start = end;
+		}
+	}
+	if (len)
+		cdp->error = -EFAULT;
+done:
+	/* we have to flush after trigger word for correctness on some cpus
+	 * or WC buffer can be written out of order; needed even if
+	 * there was an error */
+	mb();
+}
+
+/*
+ * Note that the header should have the unchanging parts
+ * initialized but the rest of the header is computed as needed in
+ * order to break up skb data buffers larger than the hardware MTU.
+ * In other words, the Linux network stack MTU can be larger than the
+ * hardware MTU.
+ */
+int ipath_layer_send_skb(struct copy_data_s *cdata)
+{
+	int ret = 0;
+	uint16_t vlsllnh;
+	int device = cdata->device;
+
+	if (device >= infinipath_max) {
+		_IPATH_INFO("Invalid unit %u, failing\n", device);
+		return -EINVAL;
+	}
+	if (!(devdata[device].ipath_flags & IPATH_RCVHDRSZ_SET)) {
+		_IPATH_INFO("send while not open\n");
+		ret = -EINVAL;
+	}
+	else if ((devdata[device].ipath_flags & (IPATH_LINKUNK | IPATH_LINKDOWN))
+		|| devdata[device].ipath_lid == 0) {
+		/* lid check is for when sma hasn't yet configured */
+		ret = -ENETDOWN;
+		_IPATH_VDBG("send while not ready, mylid=%u, flags=0x%x\n",
+			devdata[device].ipath_lid, devdata[device].ipath_flags);
+	}
+	vlsllnh = *((uint16_t *) cdata->hdr);
+	if (vlsllnh != htons(IPS_LRH_BTH)) {
+		_IPATH_DBG("Warning: lrh[0] wrong (%x, not %x); not sending\n",
+			vlsllnh, htons(IPS_LRH_BTH));
+		ret = -EINVAL;
+	}
+	if (ret)
+		goto done;
+
+	cdata->error = 0;       /* clear last calls error  */
+
+	if (cdata->skb->ip_summed == CHECKSUM_HW) {
+		unsigned int csstart = cdata->skb->h.raw - cdata->skb->data;
+
+		/*
+		 * Computing the checksum is a bit tricky since if we fragment
+		 * the packet, the fragment that should contain the checksum
+		 * will have already been sent.  The solution is to store the checksum
+		 * in the header of the last fragment just before we write the
+		 * last data word which triggers the last fragment to be sent.
+		 * The receiver will check the header "tag" field, see that
+		 * there is a checksum, and store the checksum back into the packet.
+		 *
+		 * Save the offset of the two byte checksum.
+		 * Note that we have to add 2 to account for the two bytes of the
+		 * ethernet address we stripped from the packet and put in the header.
+		 */
+		cdata->hdr->csum_offset = csstart + cdata->skb->csum + 2;
+
+		if (cdata->offset < csstart)
+			copy_bits(cdata->skb, cdata->offset,
+				csstart - cdata->offset, cdata);
+
+		if (cdata->error) {
+			ret = cdata->error;
+			goto done;
+		}
+
+		if (cdata->offset < cdata->skb->len)
+			copy_and_csum_bits(cdata->skb, cdata->offset,
+				cdata->skb->len - cdata->offset, cdata);
+
+		if (cdata->error) {
+			ret = cdata->error;
+			goto done;
+		}
+
+		if (cdata->extra) {
+			while (cdata->extra < 4)
+				cdata->u.buf[cdata->extra++] = 0;
+			(void)copy_extra_dword(cdata, 1);
+		}
+	}
+	else {
+		copy_bits(cdata->skb, cdata->offset,
+			cdata->skb->len - cdata->offset, cdata);
+
+		if (cdata->error) {
+			ret = cdata->error;
+			goto done;
+		}
+
+		if (cdata->extra) {
+			while (cdata->extra < 4)
+				cdata->u.buf[cdata->extra++] = 0;
+			(void)copy_extra_dword(cdata, 1);
+		}
+	}
+
+	if (cdata->error) {
+		ret = cdata->error;
+		if (cdata->error != -EBUSY)
+			_IPATH_UNIT_ERROR(device,
+				"layer_send copy_bits failed with error %d\n",
+				-ret);
+	}
+
+	ipath_stats.sps_ether_spkts++;  /* another ether packet sent */
+
+done:
+	/* we have to flush after trigger word for correctness on some cpus
+	 * or WC buffer can be written out of order; needed even if
+	 * there was an error */
+	mb();
+	return ret;
+}
+
+EXPORT_SYMBOL(ipath_layer_send_skb);
+
