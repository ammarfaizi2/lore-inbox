Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVAKRHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVAKRHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVAKRGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:06:21 -0500
Received: from maxipes.logix.cz ([217.11.251.249]:43143 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S262832AbVAKREC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:04:02 -0500
Date: Tue, 11 Jan 2005 18:03:57 +0100 (CET)
From: Michal Ludvig <michal@logix.cz>
To: "David S. Miller" <davem@davemloft.net>
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: PadLock processing multiple blocks at a time
In-Reply-To: <20041130222442.7b0f4f67.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
References: <Xine.LNX.4.44.0411301009560.11945-100000@thoron.boston.redhat.com>
 <Pine.LNX.4.61.0411301722270.4409@maxipes.logix.cz>
 <20041130222442.7b0f4f67.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have got some improvements for VIA PadLock crypto driver.

1. Generic extension to crypto/cipher.c that allows offloading the 
   encryption of the whole buffer in a given mode (CBC, ...) to the 
   algorithm provider (i.e. PadLock). Basically it extends 'struct 
   cipher_alg' by some new fields:

@@ -69,6 +73,18 @@ struct cipher_alg {
                          unsigned int keylen, u32 *flags);
        void (*cia_encrypt)(void *ctx, u8 *dst, const u8 *src);
        void (*cia_decrypt)(void *ctx, u8 *dst, const u8 *src);
+       size_t cia_max_nbytes;
+       size_t cia_req_align;
+       void (*cia_ecb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
+                       size_t nbytes, int encdec, int inplace);
+       void (*cia_cbc)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
+                       size_t nbytes, int encdec, int inplace);
+       void (*cia_cfb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
+                       size_t nbytes, int encdec, int inplace);
+       void (*cia_ofb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
+                       size_t nbytes, int encdec, int inplace);
+       void (*cia_ctr)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
+                       size_t nbytes, int encdec, int inplace);
 };

  If cia_<mode> is non-NULL that function is used instead of the 
  software <mode>_process chaining function (e.g. cbc_process()). In the 
  case of PadLock it can significantly speed-up the {en,de}cryption.

2. On top of this I have an extension of the padlock module to support 
   this scheme.

I will send both patches in separate follow ups.

The speedup gained by this change is quite significant (measured with 
bonnie on ext2 over dm-crypt with aes128):

			No encryption	2.6.10-bk1	multiblock
Writing with putc()	10454 (100%)	7479  (72%)	9353  (89%)
Rewriting		16510 (100%)	7628  (46%)	10611 (64%)
Writing intelligently	61128 (100%)	21132 (35%)	48103 (79%)
Reading with getc()	9406  (100%)	6916  (74%)	8801  (94%)
Reading intelligently	35885 (100%)	15271 (43%)	23202 (65%)

Numbers are in kB/s, percents show the slowdown from plaintext run. 
As can be seen, the multiblock encryption is significantly faster 
in comparsion to the already comitted single-block-at-a-time 
processing.

More statistics (e.g. comparsion with aes.ko and aes-i586.ko) are 
available at http://www.logix.cz/michal/devel/padlock/bench.xp

Dave, if you're OK with these changes, please merge them.

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
