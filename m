Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUEVSfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUEVSfl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEVSfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 14:35:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:51882 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261779AbUEVSfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 14:35:39 -0400
X-Authenticated: #1892127
In-Reply-To: <Pine.LNX.4.58.0405221505100.10292@scrub.local>
References: <Pine.LNX.4.44.0405170100430.766-100000@serv.local> <FD7764A6-AB9F-11D8-853B-0003931E0B62@gmx.li> <Pine.LNX.4.58.0405221505100.10292@scrub.local>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DA80EDE1-AC27-11D8-A69D-0003931E0B62@gmx.li>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: Re: hfsplus bugs in linux-2.6.5
Date: Sat, 22 May 2004 20:40:17 +0100
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.05.2004, at 14:32, Roman Zippel wrote:

>> I still wasn't able to reproduce it on another partition than my Mac 
>> OS
>> X root partition. :-(
>>
>> The symptoms are as follows: Whenever I try to write a sufficently
>> large file (always larger than 512k), or try to read a sufficiently
>> large file (say a 4 MB file) with any program, I get:
>>
>>    HFS+-fs: request for non-existent node 1929183232 in B*Tree
>
> It seems you have a very fragmented volume and it goes wrong when the
> driver tries to access the extent file. I tested this with HFS, but it
> seems not all fixes made it to the HFS+ driver.
> Fix is below.

Yes, that solved the problem! Thanks a lot for that fast fix! I'm glad 
that's finally resolved.


There is one more annoying thing with the hfsplus driver: the handling 
of HFSPLUS_VOL_INCNSTNT.
It seem that both Mac OS X's mount/unmount routines and fsck_hfs don't 
ever read or write this bit, in violation of Apple's own 
specifications. This means that when linux crashes, a mounted hfs+ 
volumes will from then on have the INCONSTNT bit set and linux will 
refuse to mount it read-write, even after Mac OS X fscked it and 
mounted it read/write. This situation can be resolved by running 
hpmount on that volume, which clears the INCONSTNT bit, but that's not 
user-friendly. I therefore propose this simple patch:

--- linux-2.6.6/fs/hfsplus/super.c.bak  Sat May 22 20:32:05 2004
+++ linux-2.6.6/fs/hfsplus/super.c      Sat May 22 20:34:48 2004
@@ -245,8 +245,7 @@
         if (!(*flags & MS_RDONLY)) {
                 struct hfsplus_vh *vhdr = HFSPLUS_SB(sb).s_vhdr;

-               if ((vhdr->attributes & 
cpu_to_be32(HFSPLUS_VOL_INCNSTNT)) ||
-                   !(vhdr->attributes & 
cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
+               if (!(vhdr->attributes & 
cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
                         printk("HFS+-fs warning: Filesystem was not 
cleanly unmounted, "
                                "running fsck.hfsplus is recommended.  
leaving read-only.\n");
                         sb->s_flags |= MS_RDONLY;
@@ -331,8 +330,7 @@
         sb->s_op = &hfsplus_sops;
         sb->s_maxbytes = MAX_LFS_FILESIZE;

-       if ((vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_INCNSTNT)) ||
-           !(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
+       if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
                 if (!silent)
                         printk("HFS+-fs warning: Filesystem was not 
cleanly unmounted, "
                                "running fsck.hfsplus is recommended.  
mounting read-only.\n");

