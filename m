Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUBYKas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBYKas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:30:48 -0500
Received: from web11807.mail.yahoo.com ([216.136.172.161]:19723 "HELO
	web11807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261151AbUBYKaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:30:46 -0500
Message-ID: <20040225103043.44010.qmail@web11807.mail.yahoo.com>
Date: Wed, 25 Feb 2004 11:30:43 +0100 (CET)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: BOOT_CS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

me wrote:
> Keep initrd few Mb after kernel because I do not know where exactly
> to uncompress it - anyway the kernel will itself move it where it
> wants it.

hpa wrote:
> If you absolutely want to do this -- for pretty much no reason -- you
> can either decompress it twice, decompress it to nowhere (after all,
> the kernel will decompress it when it starts) or move it into place
> before starting the kernel.

  There is another reason to keep the two parts together, but I
 acknowledge this one is fadding away: the problem appears when loading
 Linux (+ initrd) from a DOS floppy or from operating system dated 98
 "reboot to DOS" menu.
 You then usually have an environment whith EMM386 active and the
 processor in virtual 86 mode + paged memory. Most of the times you
 also have a disk cache software loaded first just after the BIOS
 ROM, at the place you want to load Linux.
 You can still have hope: it has always been possible to do DMA in a
 XMS allocated memory (himem.sys managed) so the physical address is
 equal to the virtual address in these blocks.

 What I did is simply load and uncompress Linux to a legally allocated
 HIMEM block (so that is a 100 % compatible DOS software, you can use
 a network disk or a disk cache for that) and check everything is right
 before disabling interruption, switch back to real mode with
 4 Gb segments of non paged memory, copy the block at the right place, 
 and start Linux in protected mode.
 You have to remember keeping the code short in between the back switch
 to real mode and the start of Linux because the data (Linux kernel)
 is at a clear physical address, but your code itself is in a 4 Kbyte
 page which is available - but the page after it may not be loaded
 so no more code...

 When the problem of loading the initrd happen, you have two choice:
 load another XMS block or use the same one as the kernel.
 And here is the problem: if you load another XMS block with the
 initrd, which is usually smaller than the kernel (Kb size wise),
 you may get it in a block of XMS at the _beginning_ of extended
 memory in physical address - because of the first fit algorithm of
 himem.sys. Then, to move the kernel at its final position, you have
 to first move the initrd out of the way to not overwrite it, it
 begins to be complex to write this bit of assembler and debug at
 this point is not so easy.
 That is the short version why in some cases I did not try to load the
 initrd at the end of memory (just allocating one big block of XMS memory
 with a hole of few Mbytes in between the two - and then move the
 complete block - the complete block could not be of the size of the
 total memory). And if it is not always done, to move initrd at end,
 no need to do it only sometimes.
 Note also that in this corner case the size of the RAM may be tricky
 and could be given as a Linux command line parameter, so the position
 of the initrd is not trivial. I do not want to load the initrd after the
 RAM itself...

  Was just for info, not for flamewar,
  Etienne.

Yahoo! Mail - Votre e-mail personnel et gratuit qui vous suit partout !
 Créez votre adresse sur http://mail.yahoo.fr
