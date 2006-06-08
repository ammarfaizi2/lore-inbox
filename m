Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWFHO6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWFHO6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWFHO6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:58:39 -0400
Received: from xenotime.net ([66.160.160.81]:22203 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964854AbWFHO6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:58:38 -0400
Date: Thu, 8 Jun 2006 08:01:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, mingo@elte.hu, laurent.riffard@free.fr, barryn@pobox.com,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       jbeulich@novell.com, arjan@linux.intel.com
Subject: Re: [PATCH] ide-cd: use blk_get_request()
Message-Id: <20060608080124.cad1317a.rdunlap@xenotime.net>
In-Reply-To: <20060608063000.GG5207@suse.de>
References: <20060605110046.2a7db23f.akpm@osdl.org>
	<986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com>
	<20060606072628.GA28752@elte.hu>
	<4485E0D3.8080708@free.fr>
	<20060606205801.GC17787@elte.hu>
	<4485F5E2.5040708@free.fr>
	<20060606220507.GA19882@elte.hu>
	<20060606152930.adc58fe4.akpm@osdl.org>
	<20060607062208.GZ6693@suse.de>
	<20060607202223.3478c8ad.rdunlap@xenotime.net>
	<20060608063000.GG5207@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 08:30:00 +0200 Jens Axboe wrote:

> On Wed, Jun 07 2006, Randy.Dunlap wrote:
> > On Wed, 7 Jun 2006 08:22:08 +0200 Jens Axboe wrote:
> > 
> > > On Tue, Jun 06 2006, Andrew Morton wrote:
> > > > 
> > > > Note that Laurent is also passing through ide_cdrom_packet(), which has a
> > > > `struct request' on the stack.  The kernel does this in a lot of places,
> > > > and at 168 bytes on x86, it'd really be best if we were to dynamically
> > > > allocate these things.
> > > 
> > > That's an old peeve of mine, on-stack requests... It's nasty from
> > > several angles, stack usage just being one of them. Perhaps I'll give it
> > > a go for 2.6.18 and add checks for request being thrown at the block
> > > layer which didn't originate from get_request().
> > 
> > This is a start at converting ide-cd.c to use blk_get_request().
> > How does it look so far?
> > It builds, but I have not tested it yet.
> > And of course, there are other drivers to be modified as well.
> > 
> > ---
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Convert struct request req; on function stacks to
> > use allocation via blk_get_request() to
> > (a) reduce stack pressure and
> > (b) use centralized blk_ functions and
> > (c) allow for block IO tracing.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  drivers/ide/ide-cd.c |  258 +++++++++++++++++++++++++++++++++------------------
> >  1 files changed, 170 insertions(+), 88 deletions(-)
> > 
> > --- linux-2617-rc6.orig/drivers/ide/ide-cd.c
> > +++ linux-2617-rc6/drivers/ide/ide-cd.c
> > @@ -2033,24 +2033,32 @@ int msf_to_lba (byte m, byte s, byte f)
> >  
> >  static int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
> >  {
> > -	struct request req;
> > +	struct request *req;
> >  	struct cdrom_info *info = drive->driver_data;
> >  	struct cdrom_device_info *cdi = &info->devinfo;
> > +	request_queue_t *q = cdi->disk->queue;
> > +	int stat;
> >  
> > -	cdrom_prepare_request(drive, &req);
> > -
> > -	req.sense = sense;
> > -	req.cmd[0] = GPCMD_TEST_UNIT_READY;
> > -	req.flags |= REQ_QUIET;
> > +	req = blk_get_request(q, READ, GFP_KERNEL);
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	cdrom_prepare_request(drive, req);
> 
> This cannot work, have you seen what cdrom_prepare_request() does?

Obviously not.
(It calls ide_init_drive_cmd(), which clears the <request>.)

Thanks.
---
~Randy
