Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVE0Hzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVE0Hzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVE0Hzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:55:41 -0400
Received: from brick.kernel.dk ([62.242.22.158]:16099 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261967AbVE0HzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:55:16 -0400
Date: Fri, 27 May 2005 09:56:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527075621.GR1435@suse.de>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527074712.GQ1435@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jens Axboe wrote:
> On Fri, May 27 2005, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > >That is the typical case, ata_qc_new() succeeds but we cannot issue the
> > >command yet. So where do you want this logic placed? You cannot drop the
> > >host_lock in-between, as that could potentially change the situation.
> > 
> > ata_scsi_translate() in libata-scsi.c, in between the call to 
> > ata_scsi_qc_new() and ata_qc_issue().
> > 
> > something like:
> > 
> > 	if (ata_scsi_qc_new() fails ||
> > 	    (depth > 0 && ata_check_non_ncq_cmd()))
> > 		complete SCSI command with 'queue full'
> 
> That is an improvement for SCSI originated commands, I can drop
> ATA_QCFLAG_DEFER then. Will make that change. But what about
> ata_qc_issue() from other places? That is the ugly code, which will hit
> the waiting currently.

Actually, slight "problem" there as well... We need to translate the
SCSI command prior to making this decision, as we may get both NCQ and
non-NCQ commands from that path as well. For now I'll just make the
distinction that fs based SCSI requests are the only NCQ candidates, ok?

-- 
Jens Axboe

