Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVKTWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVKTWid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVKTWic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:38:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6045 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750894AbVKTWic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:38:32 -0500
Date: Sun, 20 Nov 2005 16:38:29 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051120223829.GA9601@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115055107.GB3252@IBM-BWN8ZTBWAO1> <20051113152214.GC2193@spitz.ucw.cz> <9901B851-17B2-4AEB-813F-A92560DFE289@mac.com> <20051116203603.GA12505@elf.ucw.cz> <1132174090.5937.14.camel@localhost> <20051119233010.GA3361@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119233010.GA3361@spitz.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (pavel@ucw.cz):
> Hi!
> 
> > > Hmm... it is hard to judge a patch without context. Anyway, can't we
> > > get process snasphot/resume without virtualizing pids? Could we switch
> > > to 128-bits so that pids are never reused or something like that?
> > 
> > That might work fine for a managed cluster, but it wouldn't be a good
> > fit if you ever wanted to support something like a laptop in
> > disconnected operation, or if you ever want to restore the same snapshot
> > more than once.  There may also be some practical userspace issues
> > making pids that large.
> > 
> > I also hate bloating types and making them sparse just for the hell of
> > it.  It is seriously demoralizing to do a ps and see
> > 7011827128432950176177290 staring back at you. :)
> 
> Well, doing cat /var/something/foo.pid, and seeing pid of unrelated process
> is wrong, too... especially if you try to kill it....

Good point.  However the foo.pid scheme is incompatible with
checkpoint/restart and migration regardless.

	a. what good is trying to kill something using such a file if
	the process is checkpointed+killed, to be restarted later?
	b. it is expected that any files used by a checkpointable
	processes exist on a network fs, so that the fd can be moved.
	What good is foo.pid if it's on a network filesystem?

So if you wanted to checkpoint and restart/migrate a process with a
foo.pid type of file, you might need to start it with a private
tmpfs in a private namespace.  That part is trivial to do as part
of the management tools, though checkpointing a whole tmpfs per process
could be unfortunate.

-serge
