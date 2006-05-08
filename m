Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWEHMhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWEHMhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 08:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWEHMhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 08:37:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29645 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932090AbWEHMhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 08:37:34 -0400
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Jason Schoonover <jasons@pioneer-pra.com>,
       Andrew Morton <akpm@osdl.org>, Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060508112831.GA14206@flint.arm.linux.org.uk>
References: <200605051010.19725.jasons@pioneer-pra.com>
	 <20060507095039.089ad37c.akpm@osdl.org>
	 <20060508111345.GA1875@harddisk-recovery.com>
	 <1147087356.2888.9.camel@laptopd505.fenrus.org>
	 <20060508112831.GA14206@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 08 May 2006 14:37:25 +0200
Message-Id: <1147091845.2888.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 12:28 +0100, Russell King wrote:
> On Mon, May 08, 2006 at 01:22:36PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-05-08 at 13:13 +0200, Erik Mouw wrote:
> > > On Sun, May 07, 2006 at 09:50:39AM -0700, Andrew Morton wrote:
> > > > This is probably because the number of pdflush threads slowly grows to its
> > > > maximum.  This is bogus, and we seem to have broken it sometime in the past
> > > > few releases.  I need to find a few quality hours to get in there and fix
> > > > it, but they're rare :(
> > > > 
> > > > It's pretty harmless though.  The "load average" thing just means that the
> > > > extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> > > > they'll later exit and clean themselves up.  They won't be consuming
> > > > significant resources.
> > > 
> > > Not completely harmless. Some daemons (sendmail, exim) use the load
> > > average to decide if they will allow more work.
> > 
> > and those need to be fixed most likely ;)
> 
> Why do you think that? 

I think that because the characteristics of modern hardware don't make
"load" a good estimator for finding out if the hardware can take more
jobs.

To explain why I'm thinking this I first need to do an ascii art graph

100
% |             ************************|
b |         ****
u |      ***
s |    **
y |   *
  |  *
  | *
  |*
  +------------------------------------------
       -> workload

on the Y axis is the percentage in use, on the horizontal axis the
amount of work that is done. (in the mail case, say emails per second).
Modern hardware has an initial ramp-up which is near linear in terms of
workload/use, but then a saturation area is reached at 100% where, even
though a system is 100% busy, more work can be added, upto a certain
point that I showed with a "|". This is due to the behavior of increased
batching that you get at higher utilization compared to the behavior at
lower utilizations. Both cpu caches, memory burst speeds-vs-latency, but
also disk streaming performance vs random seeks... all those will create
and increase this saturation space to the right. And all of those have
been increasing in the hardware the last 4+ years, with the result that
the saturation "reach" has increased to the right as well, by far.

How does this tie into "load" and using load for what exim/sendmail use
it for? Well.... Today "load" is a somewhat poor approximation of this
percentage-in-use[1], but... as per the graph and argument above, even
if it was a perfect representation of that, it still would not be a good
measure to determine if a system can do more work (per time unit) or
not.

[1] I didn't discuss the use of *what*; in reality that is a combination
of cpu, memory, disk and possibly network resources. Load tries to
combine cpu and disk into one number via a sheer addition; that's an
obviously rough estimate and I'm not arguing that it's not rough.


> Having a single CPU machine with a load average of 150 and still feel
> very interactive at the shell is extremely counter-intuitive.

Well it's also a sign that the cpu scheduler is prioritizing your shell
over the background "menial" work ;)



