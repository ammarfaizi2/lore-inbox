Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131971AbRAQKlX>; Wed, 17 Jan 2001 05:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbRAQKlP>; Wed, 17 Jan 2001 05:41:15 -0500
Received: from oriloff.manu.com.au ([203.37.120.101]:32779 "EHLO manu.com.au")
	by vger.kernel.org with ESMTP id <S131971AbRAQKk6>;
	Wed, 17 Jan 2001 05:40:58 -0500
From: Nathan Hand <nathanh@manu.com.au>
Date: Wed, 17 Jan 2001 21:40:47 +1100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ewrk3 update for 2.4
Message-ID: <20010117214047.C10192@manu.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Following patch updates ISA ewrk3 driver for 2.4. Still no SMP support
sadly. Though if you're using an ewrk3 card on an SMP machine then you
have bigger problems than a non-working driver.


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ewrk3.c.diff"

--- ewrk3.c.orig	Wed Jan 17 09:56:45 2001
+++ ewrk3.c	Wed Jan 17 10:05:21 2001
@@ -819,24 +819,24 @@
 					}
 					outb(page, EWRK3_TQ);	/* Start sending pkt */
 				} else {
-					writeb((char) (TCR_QMODE | TCR_PAD | TCR_IFC), (char *) buf);	/* ctrl byte */
+					isa_writeb((char) (TCR_QMODE | TCR_PAD | TCR_IFC), buf);	/* ctrl byte */
 					buf += 1;
-					writeb((char) (skb->len & 0xff), (char *) buf);		/* length (16 bit xfer) */
+					isa_writeb((char) (skb->len & 0xff), buf);		/* length (16 bit xfer) */
 					buf += 1;
 					if (lp->txc) {
-						writeb((char) (((skb->len >> 8) & 0xff) | XCT), (char *) buf);
+						isa_writeb((char) (((skb->len >> 8) & 0xff) | XCT), buf);
 						buf += 1;
-						writeb(0x04, (char *) buf);	/* index byte */
+						isa_writeb(0x04, buf);	/* index byte */
 						buf += 1;
-						writeb(0x00, (char *) (buf + skb->len));	/* Write the XCT flag */
+						isa_writeb(0x00, (buf + skb->len));	/* Write the XCT flag */
 						isa_memcpy_toio(buf, skb->data, PRELOAD);	/* Write PRELOAD bytes */
 						outb(page, EWRK3_TQ);	/* Start sending pkt */
 						isa_memcpy_toio(buf + PRELOAD, skb->data + PRELOAD, skb->len - PRELOAD);
-						writeb(0xff, (char *) (buf + skb->len));	/* Write the XCT flag */
+						isa_writeb(0xff, (buf + skb->len));	/* Write the XCT flag */
 					} else {
-						writeb((char) ((skb->len >> 8) & 0xff), (char *) buf);
+						isa_writeb((char) ((skb->len >> 8) & 0xff), buf);
 						buf += 1;
-						writeb(0x04, (char *) buf);	/* index byte */
+						isa_writeb(0x04, buf);	/* index byte */
 						buf += 1;
 						isa_memcpy_toio(buf, skb->data, skb->len);		/* Write data bytes */
 						outb(page, EWRK3_TQ);	/* Start sending pkt */
@@ -968,9 +968,9 @@
 					pkt_len = inb(EWRK3_DATA);
 					pkt_len |= ((u_short) inb(EWRK3_DATA) << 8);
 				} else {
-					rx_status = readb(buf);
+					rx_status = isa_readb(buf);
 					buf += 1;
-					pkt_len = readw(buf);
+					pkt_len = isa_readw(buf);
 					buf += 3;
 				}
 
@@ -1204,7 +1204,7 @@
 			if (lp->shmem_length == IO_ONLY) {
 				outb(0xff, EWRK3_DATA);
 			} else {	/* memset didn't work here */
-				writew(0xffff, p);
+				isa_writew(0xffff, (int) p);
 				p++;
 				i++;
 			}
@@ -1221,8 +1221,8 @@
 				outb(0x00, EWRK3_DATA);
 			}
 		} else {
-			memset_io(lp->mctbl, 0, (HASH_TABLE_LEN >> 3));
-			writeb(0x80, (char *) (lp->mctbl + (HASH_TABLE_LEN >> 4) - 1));
+			isa_memset_io((int) lp->mctbl, 0, (HASH_TABLE_LEN >> 3));
+			isa_writeb(0x80, (int) (lp->mctbl + (HASH_TABLE_LEN >> 4) - 1));
 		}
 
 		/* Update table */
@@ -1251,7 +1251,7 @@
 					outw((short) ((long) lp->mctbl) + byte, EWRK3_PIR1);
 					outb(tmp, EWRK3_DATA);
 				} else {
-					writeb(readb(lp->mctbl + byte) | bit, lp->mctbl + byte);
+					isa_writeb(isa_readb((int)(lp->mctbl + byte)) | bit, (int)(lp->mctbl + byte));
 				}
 			}
 		}

--cvVnyQ+4j833TQvp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
