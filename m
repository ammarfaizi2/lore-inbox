Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423097AbWJYIKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423097AbWJYIKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423102AbWJYIKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:10:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13710 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423097AbWJYIKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:10:13 -0400
Date: Wed, 25 Oct 2006 10:10:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061025081001.GL5851@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl> <20061024163345.GG11034@melbourne.sgi.com> <20061024213737.GD5662@elf.ucw.cz> <20061025001331.GP8394166@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025001331.GP8394166@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Do you mean calling sys_sync() after the userspace has been frozen
> > > > may not be sufficient?
> > > 
> > > In most cases it probably is, but sys_sync() doesn't provide any
> > > guarantees that the filesystem is not being used or written to after
> > > it completes. Given that every so often I hear about an XFS filesystem
> > > that was corrupted by suspend, I don't think this is sufficient...
> > 
> > Userspace is frozen. There's noone that can write to the XFS
> > filesystem.
> 
> Sure, no new userspace processes can write data, but what about the
> internal state of the filesystem?
> 
> All a sync guarantees is that the filesystem is consistent when the
> sync returns and XFS provides this guarantee by writing all data and
> ensuring all metadata changes are logged so if a crash occurs it can
> be recovered (which provides the sync guarantee). hence after a
> sys_sync(), XFS will still have lots of dirty metadata that needs to
> be written to disk at some time in the future so the transactions
> can be removed from the log.
> 
> This dirty metadata can be flushed at any time, and the dirty state
> is kept in XFS structures and not always in page structures (think
> multipage metadata buffers). Hence I cannot see how suspend can
> guarantee that it has saved all the dirty data in XFS, nor
> restore it correctly on resume. Once you toss dirty metadata that
> is currently in the log, further operations will result in that log
> transaction being overwritten without it ever being written to disk.
> That then means any subsequent operations after resume will corrupt
> the filesystem....
> 
> Hence the only way to correctly rebuild the XFS state on resume is
> to quiesce the filesystem on suspend and thaw it on resume so as to
> trigger log recovery.

No, during suspend/resume, memory image is saved, and no state is
lost. We would not even have to do sys_sync(), and suspend/resume
would still work properly.

sys_sync() is there only to limit damage in case of suspend/resume
failure.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
