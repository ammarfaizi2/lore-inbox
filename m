Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWEaEjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWEaEjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWEaEjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:39:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18050 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751678AbWEaEjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:39:08 -0400
Date: Wed, 31 May 2006 14:38:49 +1000
From: Nathan Scott <nathans@sgi.com>
To: Janos Haar <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: XFS related hang (was Re: How to send a break? - dump from frozen 64bit linux)
Message-ID: <20060531143849.C478554@wobbly.melbourne.sgi.com>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs> <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu> <1149038431.21827.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1149038431.21827.20.camel@localhost.localdomain>; from rostedt@goodmis.org on Tue, May 30, 2006 at 09:20:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 09:20:31PM -0400, Steven Rostedt wrote:
> Added all those listed in the MAINTAINERS file for XFS.

Thanks Steve.

> On Tue, 2006-05-30 at 15:03 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 30 May 2006 12:22:01 +0200, Janos Haar said:
> > Half the processes on the box seem wedged at that same mutex_lock. I can't
> > seem to find an xfs_qm_shake in my source tree though.

Its in fs/xfs/quota/xfs_qm.c.

> kswapd0       D ffff81011fe03c38     0   297      1          1287    19 (L-TLB)
> ffff81011fe03c38 0000000000000004 000000000000000a ffff81011f92ba68
>        ffff81011f92b850 ffffffff805a23a0 0000149f99fa7d7c 000000000003bcde
>        000000002f2c46e0 ffff81008bc37180
> Call Trace: <ffffffff804e5522>{schedule_timeout+34}
>        <ffffffff80269f87>{xfs_qm_dqunpin_wait+220} <ffffffff80140e74>{debug_mutex_free_waiter+141}

So, we're waiting here on a synchronisation variable that'll
be released once the dquot metadata buffer write completes.

> So it is now waiting to be woken up by something that calls:
> 
> xfs_qm_dquot_logitem_unpin  which seems to be the function to wake it
> up.

Mhmm, that'd be called by the I/O completion handler on the buffer
containing that dquot.

> And decyphering all the macro crap it seems that the function that wakes
> it up is xfs_trans_chunk_committed, or xfs_trans_uncommit.

Right (the former, at this point in the code).

> The above xfs_qm_dqunpin_wait still looks awfully racy, and the
> xfs_log_force, which I'm assuming wakes up whoever is suppose to wake up
> kswapd0, doesn't have a return code check.  So if it failed to do

The logforce isn't race-critical here - its ensuring writeout
of previously logged buffers is started before we go to sleep
waiting for the driver to wake us up when its done.

An earlier I/O error on the journal is the only thing the log
force can return as an error there, which isnt useful at that
point anyway (we're in a kernel thread trying to free mem).

> whatever the hell it's doing (that code gives me a headache), it looks

Heh, likewise.  I have voodoo dolls of one or two of the early
XFS folks that I like to poke with needles occasionally.. :)

> like this guy might sleep forever holding a lock that will prevent
> others from freeing kernel memory.

It will sleep until the previously initiated buffer write is done.
AFAICT, we aren't seeing the I/O completion here for some reason...
which points more to a possible device driver or h/ware issue (that
is the usual root cause of this sort of hang, anyway).

cheers.

-- 
Nathan
