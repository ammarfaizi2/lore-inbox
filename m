Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbSIXVk0>; Tue, 24 Sep 2002 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261830AbSIXVk0>; Tue, 24 Sep 2002 17:40:26 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:36664 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S261826AbSIXVkY>;
	Tue, 24 Sep 2002 17:40:24 -0400
Subject: Re: 2.4.19: oops in ide-scsi
From: James Stevenson <james@stev.org>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87smzzksri.fsf@ceramic.fifi.org>
References: <87n0q8tcs8.fsf@ceramic.fifi.org>
	<1032891985.2035.1.camel@god.stev.org>  <87smzzksri.fsf@ceramic.fifi.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Sep 2002 22:41:46 +0100
Message-Id: <1032903706.2445.4.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-24 at 22:00, Philippe Troin wrote:
> James Stevenson <james@stev.org> writes:
> 
> > Hi
> > 
> > i am glad somebody else sees the same crash as me the
> > request Q gets set to NULL for some reson then tries to
> > increment a stats counter in the null pointer.
> > i know what the bug is i just dont know how to fix it :>
> 
> I'm not sure which Q you're talking about.
> Is that rq (in idescsi_pc_intr())?

the crash happens on

if (status & ERR_STAT)
	rq->errors++;

because 
struct request *rq = pc->rq;
is NULL



from ide-scsi.c

static ide_startstop_t idescsi_pc_intr (ide_drive_t *drive)
{
	idescsi_scsi_t *scsi = drive->driver_data;
	byte status, ireason;
	int bcount;
	idescsi_pc_t *pc=scsi->pc;
	struct request *rq = pc->rq;
	unsigned int temp;

// SNIPED some code

	if ((status & DRQ_STAT) == 0) {					/* No more interrupts */
		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
			printk (KERN_INFO "Packet command completed, %d bytes transferred\n",
pc->actually_transferred);
		ide__sti();
		if (status & ERR_STAT)
			rq->errors++;
		idescsi_end_request (1, HWGROUP(drive));
		return ide_stopped;
	}
	bcount = IN_BYTE (IDE_BCOUNT




