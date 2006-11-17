Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933661AbWKQPPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933661AbWKQPPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933655AbWKQPPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:15:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61902 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933666AbWKQPPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:15:00 -0500
Date: Fri, 17 Nov 2006 16:14:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Message-ID: <20061117151441.GB8859@elf.ucw.cz>
References: <200611160912.51226.rjw@sisk.pl> <20061117005052.GK11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117005052.GK11034@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-17 11:50:52, David Chinner wrote:
> On Thu, Nov 16, 2006 at 09:12:49AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following two patches introduce a mechanism that should allow us to
> > avoid suspend-related corruptions of XFS without the freezing of bdevs which
> > Pavel considers as too invasive (apart from this, the freezing of bdevs may
> > lead to some undesirable interactions with dm and for now it seems to be
> > supported for real by XFS only).
> 
> Has this been tested and proven to fix the problem with XFS? It's
> been asserted that this will fix XFS and suspend, but it's
> not yet been proven that this is even the problem.
> 
> I think the problem is a race between sys_sync, the kernel thread
> freeze and the xfsbufd flushing async, delayed write metadata
> buffers resulting in a inconsistent suspend image being created.
> If this is the case, then freezing the workqueues does not
> fix the problem. i.e:
> 
> suspend				xfs
> -------				---
> sys_sync completes
> 				xfsbufd flushes delwri metadata
> kernel thread freeze
> workqueue freeze
> suspend image start
> 				async I/O starts to complete
> suspend image finishes
> 				async I/O all complete

This can't happen, because creating suspend image is atomic. (No
interrupts, no DMAs, no drivers running).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
