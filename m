Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQLDRKR>; Mon, 4 Dec 2000 12:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbQLDRKH>; Mon, 4 Dec 2000 12:10:07 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:6416 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129573AbQLDRJy>;
	Mon, 4 Dec 2000 12:09:54 -0500
Message-ID: <3A2BC8B0.FA7A1F56@ihug.co.nz>
Date: Tue, 05 Dec 2000 05:39:12 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-ac4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Again

Some more details, now that I scraped a few minutes on the weekend to
look into this.
Same hardware configuration as my earlier post; with a newer bios
version on the motherboard; with no improvement.

Some long winded test results, and my conclusions:
[abridged] output from diff for one flawed copy:
===
linux/fs/cramfs/inflate/inffixed.h
-    {{{84,7}},99}, {{{0,8}},127}, {{{0,8}},63}, {{{0,9}},223},
+    {{{84,7}},99}, {{{0,8}},127}{0,8}},63}, {{{0,9}},223},
linux/fs/jffs/intrep.c
-                       jffs_fmfree_partly(fmc, fm, total_data_size);
-                       jffs_fm_write_unlock(fmc);
+                       jffs_fmfree_partly(fmc, fm,
total_data_sizport                  jffs_fm_write_unlock(fmc);
linux/kernel/resource.c
-int allocate_resource(struct resource *root, struct resource *new,
+int allocate_rrce(struct resource *root, struct resource *new,
===
Closer inspection of the three "corrupt" files, using the command
od -tc <file> | less
revealed that in all cases, the corruption was the four bytes
immediately preceding an exact multiple of 4096 - the block size for the
(ext2) fs...
I may well go back and read the "corruption" thread which gave me the
idea for the comparison when I wake up :(
for inffixed.h, the correct dump reads
0017740   {   {   {   8   4   ,   7   }   }   ,   9   9   }   ,       { 
0017760   {   {   0   ,   8   }   }   ,   1   2   7   }   ,       {   { 
0020000   {   0   ,   8   }   }   ,   6   3   }   ,       {   {   {   0 
0020020   ,   9   }   }   ,   2   2   3   }   ,  \n                   { 
and the flawed dump reads
0017740   {   {   {   8   4   ,   7   }   }   ,   9   9   }   ,       { 
0017760   {   {   0   ,   8   }   }   ,   1   2   7   }  \0  \0  \0  \0 
0020000   {   0   ,   8   }   }   ,   6   3   }   ,       {   {   {   0 
0020020   ,   9   }   }   ,   2   2   3   }   ,  \n                   { 
0x0020000 -> 131072 -> 32 x 4k

likewise for intrep.c
0177740   r   t   l   y   (   f   m   c   ,       f   m   ,       t   o 
0177760   t   a   l   _   d   a   t   a   _   s   i   z   e   )   ;  \n 
0200000  \t  \t  \t   j   f   f   s   _   f   m   _   w   r   i   t   e 
0200020   _   u   n   l   o   c   k   (   f   m   c   )   ;  \n  \t  \t 
and the flawed dump reads
0177740   r   t   l   y   (   f   m   c   ,       f   m   ,       t   o 
0177760   t   a   l   _   d   a   t   a   _   s   i   z   p   o   r   t 
0200000  \t  \t  \t   j   f   f   s   _   f   m   _   w   r   i   t   e 
0200020   _   u   n   l   o   c   k   (   f   m   c   )   ;  \n  \t  \t 
0x0200000 -> 2097152 -> 512 x 4k


I have a couple more examples; the corruption is still present after a
reboot; but I have yet to see what fsck makes of it...
[Addendum: corruption is still present after fsck]

So, in summary; when using the HPT366 controller with my claimed ATA66
drive; using an SMP kernel with two Celeron 466's (at 466), under load I
find intermittant corruption of the ext2 filesystem.
always four bytes; and apparently commonly (maybe always?) the four
before an exact multiple of 4096 bytes - the filesystem block size.
The values that are written instead of the correct data do not appear to
be random; but rather data from the (memory) cache; I've noticed one or
two previously that look "familiar"; but that may just be my tired eyes.

That's all I can think (ramble?) of at this time; Awaiting bright ideas;
or more free time to fiddle more. Thanks in Advance (for all the bright
ideas :) )


Gerard Sharp 
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
