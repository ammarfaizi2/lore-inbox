Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWCFUf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWCFUf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWCFUf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:35:57 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:12953 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932257AbWCFUf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:35:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=paRzptoRj3kVt2K6tDWbAcA7wwHCvlAUtSHyVNnT9PGjhAQJua49gMk1iJmbctkpdITny7RSX8st9xMfrkC/9jMiSaoqXQTVSlDx5jManixellWJh25Tbb1+7203SNkJeZzV0LY2UxIB9h5p+MIe+kTDyfMW0aLcK9EBwHIq5V8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Date: Mon, 6 Mar 2006 21:36:16 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603062136.17098.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 21:06, Linus Torvalds wrote:
> 
> On Mon, 6 Mar 2006, Linus Torvalds wrote:
> > 
> > So it's either an aic7xxx bug, or it's generic SCSI.
> > 
> > Considering that we've had other slab corruption issues (the reason I was 
> > looking closely at yours), generic SCSI isn't out of the question.
> > 
> > If you were a git user, doing a bisection run would be useful since you 
> > seem to be able to recreate it at will. Oh, well. Testign that one patch 
> > would still help.
> 
> Hmm.. This appended patch may or may not help.
> 
> It overwrites the SCSI command "req" pointer when the request has been 
> done. The request cannot be used afterwards, so anybody accessing it would 
> be a bug. I think.
> 

With the retry code removed and your req poisoning patch on top I just got this :

Slab corruption: start=f727c5a8, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934db>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f727c55c, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813ee>](free_fdtable_rcu+0x6e/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f727c5f4, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813ee>](free_fdtable_rcu+0x6e/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=f727c5a8, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934db>](sr_do_ioctl+0x11b/0x270)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f727c55c, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813ee>](free_fdtable_rcu+0x6e/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f727c5f4, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813ee>](free_fdtable_rcu+0x6e/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

and another, probably unrelated, thing I just noticed in my dmesg output:

initcall at 0xc0428240: init_hpet_clocksource+0x0/0x90(): returned with error code -19


> HOWEVER. I noticed something else strange. Your slab corruption report 
> says
> 
> 	Slab corruption: start=f72948a0, len=64
> 	Redzone: 0x5a2cf071/0x5a2cf071.
> 	Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
> 	...
> 
> and the scary thing is that "len=64". 
> 
> The thing is, SCSI uses "SCSI_SENSE_BUFFERSIZE" to determine the maximum 
> sense size to copy, and what do we have, if not
> 
> 	include/scsi/scsi_cmnd.h:#define SCSI_SENSE_BUFFERSIZE  96
> 
> ie a 64-byte buffer is simply TOO DAMN SMALL!
> 
> Now, the thing is, the 64 comes from "sizeof(struct request_sense)", which 
> is what "struct packet_command *" uses. We can change that sizeof() to 
> just use SCSI_SENSE_BUFFERSIZE, but that still makes me worry about 

Building a kernel with that change on top of the other ones atm.


 / Jesper

