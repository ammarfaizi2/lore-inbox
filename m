Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272230AbTHRSoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTHRSoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:44:06 -0400
Received: from [63.247.75.124] ([63.247.75.124]:55190 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272230AbTHRSoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:44:03 -0400
Date: Mon, 18 Aug 2003 14:44:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
Message-ID: <20030818184403.GL24693@gtf.org>
References: <20030818180941.GJ24693@gtf.org> <Pine.LNX.4.44.0308181117540.5929-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308181117540.5929-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 11:21:07AM -0700, Linus Torvalds wrote:
> 
> On Mon, 18 Aug 2003, Jeff Garzik wrote:
> > 
> > Should we just make schedule_delayed_work(foo, 1) the default for a 
> > schedule_work() call?
> 
> Why? There are cases where you may really want to get the work done asap,
> so the regular "schedule_work()" is the right thing. While the "delayed"  

schedule_work() is _not_ for that.  As currently implemented, you have
no guarantees that your schedule_work()-initiated work will even
begin in this century.

Drivers are using schedule_work() to create process contexts where
they can sleep, potentially for many seconds.  On a single cpu
system, or a loaded SMP system, schedule_work() from one of the
drivers you converted could easily be delayed for 30 seconds or more.
schedule_work() is not a fast path.

If work needs to happen ASAP, then you really want to replace those
schedule_work() calls with schedule_tasklet() calls that do the
"must be done asap" work, and then schedule_work() the stuff that
requires process context...  So, too, I would have thought that
bottom-half completion routines mapped more directly to
schedule_tasklet() anyway.

	Jeff



