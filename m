Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUDRAXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUDRAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:23:47 -0400
Received: from florence.buici.com ([206.124.142.26]:32640 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264088AbUDRAXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:23:44 -0400
Date: Sat, 17 Apr 2004 17:23:43 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Singer <elf@buici.com>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418002343.GA16025@flea>
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417165151.24b1fed5.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 04:51:51PM -0700, Andrew Morton wrote:
> Marc Singer <elf@buici.com> wrote:
> >
> > On Sat, Apr 17, 2004 at 04:21:25PM -0700, Andrew Morton wrote:
> > > Marc Singer <elf@buici.com> wrote:
> > > >
> > > >  I'd say that there is no statistically significant difference between
> > > >  these sets of times.  However, after I've run the test program, I run
> > > >  the command "ls -l /proc"
> > > > 
> > > >  				 swappiness
> > > >  			60 (default)		0
> > > >  			------------		--------
> > > >  elapsed time(s)		18			1
> > > >  			30			1
> > > >  			33			1
> > > 
> > > How on earth can it take half a minute to list /proc?
> > 
> > I've watched the vmscan code at work.  The memory pressure is so high
> > that it reclaims mapped pages zealously.  The program's code pages are
> > being evicted frequently.
> 
> Which tends to imply that the VM is not reclaiming any of that nfs-backed
> pagecache.

I don't think that's the whole story.  They question is why.

> > I've been wondering if the swappiness isn't a red herring.  Is it
> > reasonable that the distress value (in refill_inactive_zones ()) be
> > 50?
> 
> I'd assume that setting swappiness to zero simply means that you still have
> all of your libc in pagecache when running ls.

Perhaps.  I think it is more important that it is still mapped.

> 
> What happens if you do the big file copy, then run `sync', then do the ls?

It still takes a long time.  I'm watching the network load as I
perform the ls.  There's almost 20 seconds of no screen activity while
NFS reloads the code. 

> 
> Have you experimented with the NFS mount options?  v2? UDP?

Doesn't seem to matter.  I've used v2, v3, UDP and TCP.

I have more data.

All of these tests are performed at the console, one command at a
time.  I have a telnet daemon available, so I open a second connection
to the target system.  I run a continuous loop of file copies on the
console and I execute 'ls -l /proc' in the telnet window.  It's a
little slow, but it isn't unreasonable.  Hmm.  I then run the copy
command in the telnet window followed by the 'ls -l /proc'.  It works
fine.  I logout of the console session and perform the telnet window
test again.  The 'ls -l /proc takes 30 seconds.

When there is more than one process running, everything is peachy.
When there is only one process (no context switching) I see the slow
performance.  I had a hypothesis, but my test of that hypothesis
failed.
