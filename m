Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUKPN1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUKPN1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUKPN1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:27:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261696AbUKPN1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:27:19 -0500
Date: Tue, 16 Nov 2004 07:33:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041116093311.GD11482@logos.cnet>
References: <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113144743.GL20754@zaphods.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 03:47:43PM +0100, Stefan Schmidt wrote:
> On Fri, Nov 12, 2004 at 11:09:29PM +1100, Nick Piggin wrote:
> > OK. Occasional page allocation failures are not a problem, although
> > if it is an order-0 allocation it may be an idea to increase
> > min_free_kbytes a bit more.
> What about more than occasional but more like constant errors? ;)
> 
> > I think you said earlier that you had min_free_kbytes set to 8192?
> > Well after applying my patch, the memory watermarks get squashed
> > down, so you'd want to set it to at least 16384 afterward. Maybe
> > more.
> I took the default from 2.6.10-rc1-bk19 with your patch and doubled it. No
> luck with the following values subsequently applied:
> #vm.min_free_kbytes=3831
> #vm.min_free_kbytes=7662
> #vm.min_free_kbytes=15324
> #vm.min_free_kbytes=61296
> vm.min_free_kbytes=65535
> Did not help against the page allocation errors or boosting up the machines
> performance.

Nick, such high reservations should have protected the system from OOM.

> I got XFS filesystem corruption in the end which (just) perhaps was triggered by
> page allocation errors for it says:
> XFS internal error XFS_WANT_CORRUPTED_RETURN after several page allocation
> errors for the application having XFS in its stack trace leading to:
> kernel: xfs_force_shutdown(sdd5,0x8) called from line 1091 of file
>         fs/xfs/xfs_trans.c.  Return address = 0xc0212e5c
> kernel: Filesystem "sdd5": Corruption of in-memory data detected.
>         Shutting down filesystem: sdd5
> kernel: Please umount the filesystem, and rectify the problem(s)
> 
> Corruption of in-memory data sounds like something we would not want to
> happen, right?

Definately. I suspect XFS is unable to handle OOM graciously, or some other
problem.

> I attached full traces to http://oss.sgi.com/bugzilla/show_bug.cgi?id=345 which
> is an rather old ticket dealing with page allocation errors and xfs but
> perhaps it does fit.
> 
> 	Stefan
