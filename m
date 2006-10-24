Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWJXVnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWJXVnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWJXVnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:43:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55760 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161247AbWJXVnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:43:39 -0400
Date: Tue, 24 Oct 2006 23:43:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       David Chinner <dgc@sgi.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024214322.GA5652@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl> <20061024170633.GA17956@infradead.org> <20061024212648.GB5662@elf.ucw.cz> <20061024213342.GA22552@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024213342.GA22552@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue 2006-10-24 22:33:42, Christoph Hellwig wrote:
> On Tue, Oct 24, 2006 at 11:26:48PM +0200, Pavel Machek wrote:
> > > No, that's definitly not enough.  You need to freeze_bdev to make sure
> > > data is on disk in the place it's expected by the filesystem without
> > > starting a log recovery.
> > 
> > I believe log recovery is okay in this case.
> > 
> > It can only happen when kernel dies during suspend or during
> > resume... And log recovery seems okay in that case. We even guarantee
> > that user did not loose any data -- by using sys_sync() after userland
> > is stopped -- but let's not overdo over protections.
> 
> You're still entirely missing the problem.
> 
> Take a look at http://www.opengroup.org/onlinepubs/007908799/xsh/sync.html
> and the linux sync(2) manpage.  The only thing sync guarantees is writing
> out all in-memory data to disk.  It doesn't even gurantee completion,
> although we've been synchronous in Linux for a while.

Ok, I assume sys_sync is synchronous, but that's okay.

> What it does not gurantee is where on disk the data is located.  Now for
> a journaling filesystem pushing everything to the log is the easiest way
> to complete sync, and it's perfectly valid - if the system crashes after
> the sync and before data is written back to it's normal place on disk
> the system notices it's not been unmounted cleanly and will do a log
> recovery.  In the suspend case however the system neither crashes nor
> is unmounted - thus the filesystem doesn't know it has to recover the
> log.  We have to choices to fix this:
> 
>  (1) force a log recovery of an already mounted and in use filesystem
>  (2) make sure data is in the right place before suspending
> 
> (1) is pretty nasty, and hard to do across filesystems.  (2) is already
> implemented and easily useable by the suspend code.

No, there's no need to do either (1) or (2) in "machine suspended and
resumed successfully". In that case, machine just continues as if no
suspend has happened.

In fact I could remove sys_sync() from freezer. suspend code would
still be correct.

That sys_sync() only matters in case of suspend but machine died
during resume... and in that case we know we crashed, and journal
recovery is okay.

I do know how journaling works (from 10000feet, anyway), and it is
okay in this case.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
