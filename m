Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268017AbUHFOMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268017AbUHFOMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUHFOMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:12:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54714 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268056AbUHFOMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:12:14 -0400
Date: Fri, 6 Aug 2004 16:11:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806141154.GB10274@suse.de>
References: <200408061345.i76DjkT5005999@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061345.i76DjkT5005999@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Joerg Schilling wrote:
> 
> >From: Jens Axboe <axboe@suse.de>
> 
> >So I downloaded:
> 
> >ftp://ftp.berlios.de/pub/cdrecord/alpha/cdrtools-2.01a35.tar.gz
> 
> >and built it, ran scgcheck on a SCSI hard drive. And you pass in
> >->mx_sb_len == 16 to the sg driver, so that's why it's not copying more
> >than 16 bytes back to you. There are 18 available in that first test
> >case. Here's that test case:
> 
> >Testing if at least CCS_SENSE_LEN (18) is supported...
> >Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 00
> >---------->     Method 0x00: expected: 18 reported: 16 max found: 16
> >Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 FF FF
> >---------->     Method 0xFF: expected: 18 reported: 16 max found: 16
> >---------->     Minimum standard (CCS) sense length failed
> >---------->     Wanted 18 sense bytes, got (16)
> >Testing for 32 bytes of sense data...
> >Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 00 00 00
> >00 00 00 00 00 00 00 00 00 00 00 00
> >---------->     Method 0x00: expected: 32 reported: 16 max found: 16
> >Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 FF FF FF FF
> >FF FF FF FF FF FF FF FF FF FF FF FF
> >---------->     Method 0xFF: expected: 32 reported: 16 max found: 16
> >---------->     Wanted 32 sense bytes, got (16)
> >----------> Got a maximum of 16 sense bytes
> >----------> SCSI sense count test FAILED
> >----------> SCSI status byte test NOT YET READY
> 
> >Changing your scsi-linux-sg.c to set max sense to 64:
> 
> >Testing if at least CCS_SENSE_LEN (18) is supported...
> >Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03
> 
> Wonderful, so you just found another bug in the Linux kernel include files.
> 
> To fix: edit sg.h in the Linux kernel source tree and fix the value for
> SG_MAX_QUEUE or if you believe you cannot change it, create a new #define
> and document it......

SG_MAX_SENSE, yes? It's your bug if you are using that and using the
newer interface, it only applies to the old sg_header interface. As
scsi-linux-sg is using SG_IO, it has no relevance whatsoever. Internally
SCSI uses a much bigger sense buffer, so as long as you supply a big
enough user buffer it works.

A 1 minute grep of the sources could have told you this. I always get
the feeling that you'd rather see the bugs persist rather than have them
fixed, so you have more to complain about on Linux.

> BTW: as you did not mention the DMA residual count problem, I asume that
> it is still present.

I haven't looked that far yet, I might next week. That your scgcheck
doesn't work without /dev/sg* means I can't check on ide-cd,
unfortunately.

-- 
Jens Axboe

