Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSBGHaj>; Thu, 7 Feb 2002 02:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSBGHa3>; Thu, 7 Feb 2002 02:30:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24072 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285338AbSBGHaL>;
	Thu, 7 Feb 2002 02:30:11 -0500
Date: Thu, 7 Feb 2002 08:29:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Ralf Oehler <R.Oehler@GDAmbH.com>, Scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Message-ID: <20020207082957.Z16105@suse.de>
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com> <20020206165911.A27458@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020206165911.A27458@eng2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06 2002, Patrick Mansfield wrote:
> On Tue, Feb 05, 2002 at 03:32:10PM +0100, Ralf Oehler wrote:
> > Hi, List
> > 
> > I think, I found a very simple solution for this annoying BUG().
> > 
> > Since at least kernel 2.4.16 there is a BUG() in pci.h,
> > that crashes the kernel on any attempt to read a SCSI-Sector
> > from an erased MO-Medium and on any attempt to read
> > a sector from a SCSI-disk, which returns "Read-Error".
> > 
> > There seems to be a thinko in the corresponding code, which 
> > does not take into account the case where a SCSI-READ
> > does not return any data because of a "sense code: read error"
> > or a "sense code: blank sector".
> 
> > Regards,
> >         Ralf

Sorry guys, I should have written a followup yesterday. I did solved
Ralf's problem for him. It was due to some paths not agreeing on when to
use clustering for a request and when not to -- for some historical
reason, MO drives have clustering disabled. The easy (and correct
solution, IMO) is to just allow clustering if the host permits it. So
the patch to solve the problem is as follows, also sent to Marcelo
yesterday.

--- /opt/kernel/linux-2.4.18-pre8/drivers/scsi/scsi_merge.c	Thu Oct 25 23:05:31 2001
+++ drivers/scsi/scsi_merge.c	Wed Feb  6 10:49:50 2002
@@ -150,14 +150,7 @@
 	panic("DMA pool exhausted");
 }
 
-/*
- * FIXME(eric) - the original disk code disabled clustering for MOD
- * devices.  I have no idea why we thought this was a good idea - my
- * guess is that it was an attempt to limit the size of requests to MOD
- * devices.
- */
-#define CLUSTERABLE_DEVICE(SH,SD) (SH->use_clustering && \
-				   SD->type != TYPE_MOD)
+#define CLUSTERABLE_DEVICE(SH,SD) (SH->use_clustering)
 
 /*
  * This entire source file deals with the new queueing code.

-- 
Jens Axboe

