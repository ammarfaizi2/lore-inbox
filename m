Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVALCQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVALCQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVALCQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:16:58 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:61167 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263005AbVALCOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:14:16 -0500
Message-Id: <200501120213.j0C2DjGO008084@localhost.localdomain>
To: Matt Mackall <mpm@selenic.com>
cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Tue, 11 Jan 2005 15:06:42 PST."
             <20050111230642.GD2940@waste.org> 
Date: Tue, 11 Jan 2005 21:13:44 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.197.39.54] at Tue, 11 Jan 2005 20:14:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And that is a failure of imagination on the part of the JACK

Please be careful with your words. Based on your comments below, it
appears that you've never read any of the technical docs on it, and
almost certainly never read the source code.

>developers. Simply add a library function to libjack or whatever:
>
> jack_make_me_important(...); /* pretty please */

like:

  int jack_set_client_capabilities (jack_engine_t *engine, jack_client_id_t id);

along with various other things that will ultimately get the client to
call functions like:

   int jack_drop_real_time_scheduling (pthread_t thread);
   int jack_acquire_real_time_scheduling (pthread_t thread, int priority);

these functions are exported to clients, because some clients have
other threads that require RT scheduling.

>A client starts at normal priority, asks jack nicely to promote it to
>RT, then jackd, if so configured/enabled, calls the wrapper with a PID

a PID? clients are multithreaded, and only specific threads run with
RT scheduling (normally just the one created for them by
libjack). So you presumably mean a TID, which in turn creates a
problem for any system (e.g. 2.4) where all threads share the PID, and
sched_setscheduler() really does use the PID as a PID, not a TID.

but its gets worse. JACK clients need to drop RT scheduling under
certain, well-defined circumstances. how do they get it back under
this scheme?

--p
