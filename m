Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752410AbWCFTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbWCFTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbWCFTvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:51:25 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:53556 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751770AbWCFTvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:51:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n+kb1QcmtJDoFfsDMTQGmGANak8ysOZJPJmwpkbqQDVk6Fr2krpLIEPe3v9H3fyiYbM4+0Mbec7J2eGPR9RNx+EC0MH2yymNWrAl2xXxAGrTpqk3KBEDRnes/iX7IVDkEed33K0jPS6VcFYcsQTxk7nP9dSu3bASKNwPpBmTMQQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Date: Mon, 6 Mar 2006 20:51:45 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
References: <200603060117.16484.jesper.juhl@gmail.com> <200603061943.35502.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603062051.45555.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 20:32, Linus Torvalds wrote:
> 
> On Mon, 6 Mar 2006, Jesper Juhl wrote:
> >
> > Not a git user (I need to become one but haven't found the time to read up 
> > on it yet), but no problem, I'll dig out the patch and try reverting it.
> 
> It's attached here.
> 
Thanks.


> NOTE! I'm not at all sure it's the re-try logic. It could be something 
> else. Anything that completes the request before it's actually totally 
> done - or possibly re-uses the sense data for something else would be 
> wrong and buggy.
> 
Ohh well, let's work on the assumption that it is the re-try logic first, 
then try something else if it turns out it isn't. I have no problem testing
a bunch of patches if needed.

<...>
> This is different. But it looks similar. It looks like the thing was 
> actually re-allocated for something else (posix acl data?) but then 

I doubt it's POSIX ACL data : 

juhl@dragon:~/download/kernel/linux-2.6.16-rc5-mm2$ grep -i ACL .config
# CONFIG_FS_POSIX_ACL is not set


> overwritten. However, the overwritten data does look like SCSI sense 
> information again ("Invalid field in cdb"), so I think it's the same 
> thing despite the fact that it had gotten re-allocated for something else.
> 
> > Would gathering more of these help you out?
> 
> It's always interesting when trying to find the pattern, but I think the 
> pattern is already pretty clear. sr_do_ioctl() seems to be the thing, and 
> sense data is written too late.
> 
Ok, it's reproducible on demand (at least I've now reproduced it on 6 more
boots), so if you need any more just let me know and I'll gather a few.


> > I have no USB, SATA or similar devices in the box, only a floppy drive, a 
> > SCSI harddisk, a SCSI CD writer and a SCSI DVD-ROM.
> 
> Well, the fact that you have a CDSI CD-writer and a SCSI DVD-ROM explains 
> the thing, so that's all good.
> 
> > scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
> >         <Adaptec 29160N Ultra160 SCSI adapter>
> >         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> So it's either an aic7xxx bug, or it's generic SCSI.
> 
> Considering that we've had other slab corruption issues (the reason I was 
> looking closely at yours), generic SCSI isn't out of the question.
> 
> If you were a git user, doing a bisection run would be useful since you 

Well, now is probably as good a time as any for becoming a git user, 
tracking my own patches as individual plain-text files is getting 
un-managable and as you say, bisection would be useful to be able to do.
I'll dig up some git docs and start reading.


> seem to be able to recreate it at will. Oh, well. Testign that one patch 
> would still help.
> 
Hmm, that patch does not apply to the 2.6.16-rc5-mm2 kernel : 

patching file drivers/scsi/scsi_lib.c
Hunk #1 succeeded at 260 (offset 1 line).
Hunk #2 FAILED at 473.
Hunk #3 FAILED at 1394.
2 out of 3 hunks FAILED -- saving rejects to file drivers/scsi/scsi_lib.c.rej
patching file include/linux/blkdev.h
Hunk #1 succeeded at 190 (offset 6 lines).

I'll go see if the problem also exists in mainline - will report on that 
shortly.


 /Jesper


