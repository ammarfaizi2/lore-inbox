Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUHFLiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUHFLiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 07:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUHFLiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 07:38:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6280 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265808AbUHFLiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 07:38:13 -0400
Date: Fri, 6 Aug 2004 13:37:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806113755.GP10274@suse.de>
References: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de> <20040806104221.GL10274@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806104221.GL10274@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Jens Axboe wrote:
> > >> -	Only the first 14 bytes of SCSI Sense data is returned (reported
> > >>	in 1998) This is extremely important - it prevents me from unsing
> > >>	Linux as a development platform.	
> > >> 
> > >> 	Time to fix: about one month to rework the whole SCSI driver
> > >> 	stack.  With good luck, this may be done on 2 days.
> > 
> > >2.6 uses 96 byte sense buffers inside the command and copies back as
> > >much as specified in the sense buffer, I fear you have to qualify this
> > >bug some more (for SCSI). ide-cd uses 18 bytes.
> > 
> > If this is true, it could be documented by running "scgcheck". I would
> > be happy to include some text like "fixed in Linux-2.9.199" somewhere
> > in README.linux or README.ATAPI.
> 
> Great.

So I downloaded:

ftp://ftp.berlios.de/pub/cdrecord/alpha/cdrtools-2.01a35.tar.gz

and built it, ran scgcheck on a SCSI hard drive. And you pass in
->mx_sb_len == 16 to the sg driver, so that's why it's not copying more
than 16 bytes back to you. There are 18 available in that first test
case. Here's that test case:

Testing if at least CCS_SENSE_LEN (18) is supported...
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 00
---------->     Method 0x00: expected: 18 reported: 16 max found: 16
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 FF FF
---------->     Method 0xFF: expected: 18 reported: 16 max found: 16
---------->     Minimum standard (CCS) sense length failed
---------->     Wanted 18 sense bytes, got (16)
Testing for 32 bytes of sense data...
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00
---------->     Method 0x00: expected: 32 reported: 16 max found: 16
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 FF FF FF FF
FF FF FF FF FF FF FF FF FF FF FF FF
---------->     Method 0xFF: expected: 32 reported: 16 max found: 16
---------->     Wanted 32 sense bytes, got (16)
----------> Got a maximum of 16 sense bytes
----------> SCSI sense count test FAILED
----------> SCSI status byte test NOT YET READY

Changing your scsi-linux-sg.c to set max sense to 64:

Testing if at least CCS_SENSE_LEN (18) is supported...
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03
---------->     Method 0x00: expected: 18 reported: 18 max found: 18
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03
---------->     Method 0xFF: expected: 18 reported: 18 max found: 18
---------->     Wanted 18 sense bytes, got it.
Testing for 32 bytes of sense data...
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03 00 00
00 00 00 00 00 00 00 00 00 00 00 00
---------->     Method 0x00: expected: 32 reported: 18 max found: 18
Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03 FF FF
FF FF FF FF FF FF FF FF FF FF FF FF
---------->     Method 0xFF: expected: 32 reported: 18 max found: 18
---------->     Wanted 32 sense bytes, got (18)
----------> Got a maximum of 18 sense bytes
----------> SCSI sense count test PASSED
----------> SCSI status byte test NOT YET READY

and it passes just fine. What's the deal?

-- 
Jens Axboe

