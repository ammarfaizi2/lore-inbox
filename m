Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIWIpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIWIpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIWIpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:45:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1324
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1750814AbVIWIpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:45:50 -0400
Date: Fri, 23 Sep 2005 10:45:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Message-ID: <20050923084529.GD10859@x30.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 03:20:33AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 23 Sep 2005 10:36:16 +1000, Con Kolivas said:
> 
> (Adding Andrea to the To: list...)
> 
> > On Fri, 23 Sep 2005 05:59, Valdis.Kletnieks@vt.edu wrote:
> > > Am seeing reproducible wedging up when writing large (20M+) files to an
> > > ext3 file system.  Oddly enough, if something *else* writes files to the
> > > file system as well, it will unwedge for a while and make progress.  Also,

So you get a total hang? I guess there's a bug somewhere...

> I'm pretty convinced that for this patch to work, it *will* need feedback from
> the actual (not max) disk bandwidth and possibly the actual amount of RAM -
> what works on Andrea's 1G workstation with (presumably) a real disk system
> is waay too much for 256M and a single laptop-class disk.

That's not the problem here if you get a total hang. This heuristic should
only reduce the amount of dirty memory, it should never grind a task 
to a total hang, until some other task writes to the filesystem.

The sysrq shows the task sleeping in blk_congestion_wait.

> For now, I'm leaving centisecs set to 40, and will see how that works - most
> of my "problem cases" involve an FTP on a 10/100mbit connection, so that will
> get tried tomorrow.....

You should leave it to 0 until I find the buglet that hangs the system.

I'll have a look.

One other thing to change is to call balance_dirty only when the dirty
bit is toggled (so overwrites of dirty cache are not accounted, since
they generate no additional I/O on disk).

Thanks.
