Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUL0PXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUL0PXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUL0PXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:23:43 -0500
Received: from sonolo.xs4all.nl ([80.126.206.91]:54028 "EHLO sendmail.metro.cx")
	by vger.kernel.org with ESMTP id S261906AbUL0PXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:23:20 -0500
Date: Mon, 27 Dec 2004 16:20:54 +0100
From: "K.F.J. Martens" <kmartens@sonologic.nl>
To: linux-mtd@lists.infradead.org
Cc: dwmw2@redhat.com, trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in 2.6.10 mtd driver for physmem mapped flash chips
Message-ID: <20041227152054.GA14835@metro.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Key: http://www.metro.cx/pubkey-gmc.asc
X-Helo-Milter-Helo: dave.dh.sono
X-Helo-Milter-Hostname: dave.dh.sono
X-Helo-Milter-Ip: 10.1.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below fixes a small but fatal bug in the code that handles
non-buswidth-aligned writes. The problem is that the code used the same
index in both map_word and buf, therefore putting the wrong words in the
map_word that partially contains old data and partially contains new
data. The result: corrupt data is being written.

Signed-off-by: Koen Martens <kmartens@sonologic.nl>

--- linux-2.6.10/include/linux/mtd/map.h        2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.10-gmc/include/linux/mtd/map.h    2004-12-27 15:59:02.631211329 +0100
@@ -322,7 +322,7 @@ static inline map_word map_word_load_par
                        bitpos = (map_bankwidth(map)-1-i)*8;
 #endif
                        orig.x[0] &= ~(0xff << bitpos);
-                       orig.x[0] |= buf[i] << bitpos;
+                       orig.x[0] |= buf[i-start] << bitpos;
                }
        }
        return orig;

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, embedded systems, unix expertise, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/
