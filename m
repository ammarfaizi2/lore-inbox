Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUAFPY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAFPY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:24:26 -0500
Received: from faraday.dhtns.com ([64.246.11.56]:45720 "EHLO faraday.dhtns.com")
	by vger.kernel.org with ESMTP id S264526AbUAFPYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:24:24 -0500
Date: Tue, 6 Jan 2004 10:24:23 -0500
From: Elliott Bennett <lkml@dhtns.com>
To: linux-kernel@vger.kernel.org
Cc: Christophe Saout <christophe@saout.de>
Subject: Re: JFS resize=0 problem in 2.6.0
Message-ID: <20040106152423.GA27239@faraday.dhtns.com>
References: <20031228153028.GB22247@faraday.dhtns.com> <1073082782.28665.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073082782.28665.16.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 11:33:03PM +0100, Christophe Saout wrote:
> Am So, den 28.12.2003 schrieb lkml@dhtns.com um 16:30:
> 
> > Let me know if I'm missing the goal of the code here, but lines 261-273
> > of linux-2.6.0/fs/jfs/super.c are:
> > 
> > case Opt_resize:
> > {
> > 	char *resize = args[0].from;
> > 	if (!resize || !*resize) {    /* LINE 264 HERE */
> > 		*newLVSize = sb->s_bdev->bd_inode->i_size >>
> > 			sb->s_blocksize_bits;
> > 		if (*newLVSize == 0)
> > 			printk(KERN_ERR
> > 			"JFS: Cannot determine volume size\n");
> > 	} else
> > 		*newLVSize = simple_strtoull(resize, &resize, 0);
> > 	break;
> > }
> > 
> > It seems to me that line 264 is attempting to test for the mount 
> > paramater "resize=0", and when it comes across this, resize to the full
> > size of the volume.  However, this doesn't work.  I believe it should
> > test for the char '0'  (*resize=='0'), not against literal zero.  
> 
> literal zero is the end of the string.
> 
> So the code checks for resize= and not resize=0.
> 
> I think your fix is wrong because it would also recognize resize=0123
> because it only tests the first character.
> 
> -           if (!resize || !*resize) {
> +           if (!resize || !*resize || *resize=='0')
> 
> It should probably be
> 
> +           if (!resize || !*resize || (*resize=='0' && !resize[1]))
> 
> Or better: check the integer value that is returned by simple_strtoull.
> 
> But did you test what resize= does?
> 
> 

Good catch!  I'm embarrassed that I didn't see that.  

As for "resize=", it seems to fail.  Probably because it doesn't match
the "resize=%u" pattern:

root@tesla:~# mount -o remount,resize= /mnt
mount: /mnt not mounted already, or bad option

Someone posted a patch the other day that supposedly handles both
"resize=0" and "resize" alone..I believe by simply adding it to the
pattern list.

-Elliott
