Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUEVC2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUEVC2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbUEVCZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:25:49 -0400
Received: from pop.gmx.de ([213.165.64.20]:8076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264834AbUEVCXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:23:03 -0400
X-Authenticated: #1892127
In-Reply-To: <Pine.LNX.4.44.0405170100430.766-100000@serv.local>
References: <Pine.LNX.4.44.0405170100430.766-100000@serv.local>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FD7764A6-AB9F-11D8-853B-0003931E0B62@gmx.li>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: Re: hfsplus bugs in linux-2.6.5
Date: Sat, 22 May 2004 04:27:44 +0100
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17.05.2004, at 00:19, Roman Zippel wrote:

>> Here's how to trigger a hfsplus bug in linux-2.6.5:
>> [...]
>> mkdir a; mkdir b
>> mv a b
>
> Thanks for the report, renames of directories were broken, the patch 
> below
> fixes this. Could you please try again, if it solves your problem?

Your patch fixes the above problem, thanks.

Unfortunately, the first bug I encountered (which lead me to 
stress-test hfsplus support in the first place) is still present.

I still wasn't able to reproduce it on another partition than my Mac OS 
X root partition. :-(

The symptoms are as follows: Whenever I try to write a sufficently 
large file (always larger than 512k), or try to read a sufficiently 
large file (say a 4 MB file) with any program, I get:

   HFS+-fs: request for non-existent node 1929183232 in B*Tree

after which the I/O operation fails like this:

   dd: writing 'bla': Cannot allocate memory

The number of the non-existent node will not change until I do a fsck.

After linux handled the partition, Apple's fsck_hfs will always report 
errors, which it usually can't fix, but TechTool Deluxe can.

In the past, hpfsck (from ftp.penguinppc.org/users/hasi/) would report 
lots of cases of:

   Backpointers in Node 239 index 70 out of order (0x1001e982 >= 
0x1002298e)

with differing indices but constant node number (until the next fsck).

However, lately, all I get is:

   [...]
   *** Checking Backup Volume Header:
   Unexpected Volume signature '  ' expected 'H+'
   hpfsck: hpfsck: This is not a HFS+ volume (Unknown error 4294967295)


However, I think I have narrowed it down somewhat: If I apply:

diff -ur linux-2.6.6/fs/hfsp.bak/bfind.c linux-2.6.6/fs/hfsplus/bfind.c
--- linux-2.6.6/fs/hfsp.bak/bfind.c     Fri May 21 11:38:33 2004
+++ linux-2.6.6/fs/hfsplus/bfind.c      Fri May 21 15:31:16 2004
@@ -64,7 +64,7 @@
                 else
                         e = rec - 1;
         } while (b <= e);
-       //printk("%d: %d,%d,%d\n", bnode->this, b, e, rec);
+       printk("problem is here: %d: %d,%d,%d\n", bnode->this, b, e, 
rec);
         if (rec != e && e >= 0) {
                 len = hfs_brec_lenoff(bnode, e, &off);
                 keylen = hfs_brec_keylen(bnode, e);

then, this new printk happens often. More importantly, it happens 
ALWAYS before the "request for non-existent node" message and 
subsequent failure.


I guess that sometimes, the bnodes aren't ordered correctly, and 
therefore we don't find the correct one. If the while loop is 
terminated without "goto done;", shouldn't we fall back to checking all 
bnodes for a matching key, in case the inodes aren't ordered correctly? 
I've tried to implement exactly that, but this resulted in lots of 
Oopses - I guess I'd have to dig deeper, guess less, and understand 
more to find out more. Unfortunately, I can't debug the problem while 
it's happening, because my ibook doesn't have a serial port...


How could I get to the root of the problem?

Thanks,

Martin

