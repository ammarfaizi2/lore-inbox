Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUABWdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUABWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:33:22 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:13184 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265665AbUABWc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:32:56 -0500
Subject: Re: JFS resize=0 problem in 2.6.0
From: Christophe Saout <christophe@saout.de>
To: lkml@dhtns.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031228153028.GB22247@faraday.dhtns.com>
References: <20031228153028.GB22247@faraday.dhtns.com>
Content-Type: text/plain
Message-Id: <1073082782.28665.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 23:33:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 28.12.2003 schrieb lkml@dhtns.com um 16:30:

> Let me know if I'm missing the goal of the code here, but lines 261-273
> of linux-2.6.0/fs/jfs/super.c are:
> 
> case Opt_resize:
> {
> 	char *resize = args[0].from;
> 	if (!resize || !*resize) {    /* LINE 264 HERE */
> 		*newLVSize = sb->s_bdev->bd_inode->i_size >>
> 			sb->s_blocksize_bits;
> 		if (*newLVSize == 0)
> 			printk(KERN_ERR
> 			"JFS: Cannot determine volume size\n");
> 	} else
> 		*newLVSize = simple_strtoull(resize, &resize, 0);
> 	break;
> }
> 
> It seems to me that line 264 is attempting to test for the mount 
> paramater "resize=0", and when it comes across this, resize to the full
> size of the volume.  However, this doesn't work.  I believe it should
> test for the char '0'  (*resize=='0'), not against literal zero.  

literal zero is the end of the string.

So the code checks for resize= and not resize=0.

I think your fix is wrong because it would also recognize resize=0123
because it only tests the first character.

-           if (!resize || !*resize) {
+           if (!resize || !*resize || *resize=='0')

It should probably be

+           if (!resize || !*resize || (*resize=='0' && !resize[1]))

Or better: check the integer value that is returned by simple_strtoull.

But did you test what resize= does?


