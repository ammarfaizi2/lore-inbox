Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTA0LTt>; Mon, 27 Jan 2003 06:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTA0LTt>; Mon, 27 Jan 2003 06:19:49 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:52352 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S267157AbTA0LTs> convert rfc822-to-8bit;
	Mon, 27 Jan 2003 06:19:48 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: aeb@cwi.nl
Subject: [PATCH] fs/partitions/msdos.c Guard against negative sizes
Date: Mon, 27 Jan 2003 12:30:05 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301271230.05814.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andries,

I've recently had a partly destroyed pc where the partition size was negative. 
I was at that time running a dos recovery disk and having severe problems - 
it would not boot.

So I had the idea of looking into the linux kernel to see how it would handle 
these. I wrote some checks in fs/partitions/msdos.c.
I'm not sure if just dropping this partitions is the right thing to do - but 
as I don't know what could break if there are wrong entries I propose the 
following patch: (incomplete - should check in many more places)


If there is a better way of handling this I'd like to know.


Regards,

Phil



diff -u linux-2.5.59/fs/partitions/msdos.c.orig 
linux-2.5.59/fs/partitions/msdos.c
--- linux-2.5.59/fs/partitions/msdos.c.orig     Mon Jan 27 12:22:45 2003
+++ linux-2.5.59/fs/partitions/msdos.c  Mon Jan 27 12:24:28 2003
@@ -133,6 +133,8 @@
                           these sometimes contain random garbage */
                        offs = START_SECT(p)*sector_size;
                        size = NR_SECTS(p)*sector_size;
+                       if (size<0)
+                               continue;
                        next = this_sector + offs;
                        if (i >= 2) {
                                if (offs + size > this_size)
@@ -423,7 +425,7 @@
        for (slot = 1 ; slot <= 4 ; slot++, p++) {
                u32 start = START_SECT(p)*sector_size;
                u32 size = NR_SECTS(p)*sector_size;
-               if (!size)
+               if (size <= 0)
                        continue;
                if (is_extended_partition(p)) {
                        /* prevent someone doing mkfs or mkswap on an


