Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbRFTWHt>; Wed, 20 Jun 2001 18:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbRFTWG6>; Wed, 20 Jun 2001 18:06:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:27910 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264639AbRFTWGl>; Wed, 20 Jun 2001 18:06:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: [RFC] Early flush (was: spindown)
Date: Thu, 21 Jun 2001 00:09:35 +0200
X-Mailer: KMail [version 1.2]
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01062003503300.00439@starship> <993070731.3b310e8b4e51e@eargle.com>
In-Reply-To: <993070731.3b310e8b4e51e@eargle.com>
MIME-Version: 1.0
Message-Id: <0106210009350F.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 22:58, Tom Sightler wrote:
> Quoting Daniel Phillips <phillips@bonn-fries.net>:
> > I originally intended to implement a sliding flush delay based on disk
> > load.
> > This turned out to be a lot of work for a hard-to-discern benefit.  So
> > the
> > current approach has just two delays: .1 second and whatever the bdflush
> >
> > delay is set to.  If there is any non-flush disk traffic the longer
> > delay is
> > used.  This is crude but effective... I think.  I hope that somebody
> > will run
> > this through some benchmarks to see if I lost any performance.
> > According to
> > my calculations, I did not.  I tested this mainly in UML, and also ran
> > it
> > briefly on my laptop.  The interactive feel of the change is immediately
> >
> > obvious, and for me at least, a big improvement.
>
> Well, since a lot of this discussion seemed to spin off from my original
> posting last week about my particular issue with disk flushing I decided to
> try your patch with my simple test/problem that I experience on my laptop.
>
> One note, I ran your patch against 2.4.6-pre3 as that is what currently
> performs the best on my laptop.  It seems to apply cleanly and compiled
> without problems.
>
> I used this kernel on my laptop kernel on my laptop all day for my normal
> workload which consist ofa Gnome 1.4 desktop, several Mozilla instances,
> several ssh sessions with remote X programs displayed, StarOffice, VMware
> (running Windows 2000 Pro in 128MB).  I also preformed several compiles
> throughout the day.  Overall the machine feels slightly more sluggish I
> think due to the following two things:
>
> 1.  When running a compile, or anything else that produces lots of small
> disk writes, you tend to get lots of little pauses for all the little
> writes to disk. These seem to be unnoticable without the patch.

OK, this is because the early flush doesn't quit when load picks up again.  
Measuring only the io backlog, as I do now, isn't adequate for telling the 
difference between load initiated by the flush itself and other load, such as 
cpu bound process proceding to read another file, so that's why the flush 
doesn't stop flushing when other IO starts happening.  This has to be fixed.

In the mean time, you could try this simple tweak: just set the lower bound, 
currently 1/10th second a little higher:

-               unsigned check_interval = HZ/10, ...
+               unsigned check_interval = HZ/5, ...

This may be enough to bridge the little pauses in the the compiler's disk 
access pattern so the flush isn't triggered.  (This is not by any means a 
nice solution.)  If you set check_interval to HZ*5, you *should* get exactly 
the old behaviour, I'd be very interested to hear if you do.

Also, could you do your compiles with 'time' so you can quantify the results?

> 2.  Loading programs when writing activity is occuring (even light activity
> like during the compile) is noticable slower, actually any reading from
> disk is.

Hmm, let me think why that may be.  The loader doesn't actually read the 
program into memory, it just maps it and lets the pages fault in as they're 
called for.  So if readahead isn't perfect (it isn't) the io backlog may drop 
to 0 briefly just as the kflush decides to sample it, and it initiates a 
flush.  This flush cleans the whole dirty list out, stealing bandwidth from 
the reads.

> I also ran my simple ftp test that produced the symptom I reported earlier.
>  I transferred a 750MB file via FTP, and with your patch sure enough disk
> writing started almost immediately, but it still didn't seem to write
> enough data to disk to keep up with the transfer so at approximately the
> 200MB mark the old behavior still kicked in as it went into full flush
> mode, during the time network activity halted, just like before.  The big
> difference with the patch and without is that the patched kernel never
> seems to balance out, without the patch once the initial burst is done you
> get a nice stream of data from the network to disk with the disk staying
> moderately active.  With the patch the disk varies from barely active
> moderate to heavy and back, during the heavy the network transfer always
> pauses (although very briefly).
>
> Just my observations, you asked for comments.

Yes, I have to refine this.  The inner flush loop has to know how many io 
submissions are happening, from which it can subtract its own submissions and 
know sombebody else is submitting IO, at which point it can fall back to the 
good old 5 second buffer age limit.  False positives from kflush are handled 
as a fringe benefit, and flush_dirty_buffers won't do extra writeout.  This 
is easy and cheap.

I could get a lot fancier than this and caculate IO load averages, but I'd 
only do that after mining out the simple possibilities.  I'll probably have 
something new for you to try tomorrow, if you're willing.  By the way, I'm 
not addressing your fundamental problem, that's Rik's job ;-).  In fact, I 
define success in this effort by the extent to which I don't affect behaviour 
under load.

Oh, and I'd better finish configuring my kernel and boot my laptop with this, 
i.e., eat my own dogfood ;-)

--
Daniel
