Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318627AbSICDLl>; Mon, 2 Sep 2002 23:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318635AbSICDLl>; Mon, 2 Sep 2002 23:11:41 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:8466 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318627AbSICDLk>; Mon, 2 Sep 2002 23:11:40 -0400
Date: Mon, 2 Sep 2002 20:16:08 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
Message-ID: <20020903031608.GC14810@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com> <3D72E267.6090502@wmich.edu> <20020902093910.G781@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902093910.G781@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 09:39:10AM +0200, Ingo Oeser wrote:
> Hi Ed,
> Hi Rik,
> Hi lkml,
> 
> On Mon, Sep 02, 2002 at 12:00:39AM -0400, Ed Sweetman wrote:
> > I dont experience audio cutouts with anything i do, even the really 
> > abusive things to the computer.  I've only had it cut out when using 
> > bonnie or dbench and that's something you should expect. So what i see 
> > as responsiveness is switching windows on the same desktop and switching 
> > between virtual desktops.  I see responsiveness as the time between i do 
> > something and the time it takes to redraw it. Using a G450, I expect a 
> > certain level of hardware performance and half a second or so to redraw 
> > a screen is not what i call responsive for a Tbird system. This is of 
> > course all X related because i dont see much or any problem with the 
> > console and with the kernel. At least nothing compared to X latencies.
>  
> This is not only X. The problem is the software layering bloat.
> Thats a design mistake we copied from W*ndows in our Linux
> applications.
> 
> Take your favorite - and I mean your favorite, not the easiest -
> application, find the handler for the problem event, try to do a
> really complete call graph trough all software layers involved
> (say from read(inputdevice_fd) to get the event up to
> write(outputdevice_fd) to write to the framebuffer) and count
> cycles. Don't forget the cache misses due to following pointers,
> which lead to random, non-local memory access patterns 
> (read: a VM and cache nightmare).
> 
> Once you really finish this boring task completely you know our
> real performance problem.
> 
> Felix von Leitner did a nice presentation on our 
> Chemnitzer Linux Tag (but in German) and many experienced
> programmers and software enginieers were really stunned.
> 
> So the problem is not really the kernel or the X layer. The
> NUMBER of abstraction layers is the issue to attack.
> 
> People tend to import big bloated libraries or even completely
> overkill operating systems just because it has ONE SIMPLE
> property the actually need[1]. This must change.

I dont' believe it is really X11.  The real killer of
perceived performance seems to be the pager.  Great strides
have been made here but i find that file I/O seems to be
replacing often used pages so that when i change desktops or
touch something that i haven't used for a while it stalls
while my disk drive sounds like a nest of hornets.  I
shouldn't see THAT much difference in behavior between a 10
minute and a 2 minute interval when i have plenty of memory
to hold my working set.  Backups and updatedb are guaranteed
to effect this.

It is of course most noticable with the large multi-layered
GUI apps because a single event faults far too many pages as
it works its way sparsely through the multiple libraries and
their respecitive data.  Readahead would help more if there
was better locality.

Unfortunately there isn't much we are going to be able to do
about this at the application level.  Perhaps the libraries
could be optimized by reducing the layering but that is a
matter for other lists.

The one thing the kernel can do is to not reclaim my often
used pages when the pagecache is full of stale data that is
unlikely to be reused.  Yes, i know this is HARD to do but
it needs to be better.  I appreciate all those with
headaches from trying to fix this.

There was a patch that went by here recently that looked
promising to me.  If i recall correctly it put newly read
pages onto a special list so that if they didn't get read
again before reaching the bottom the were reused.  Otherwise
the wound up on the LRU.  

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
