Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279218AbRJWDEM>; Mon, 22 Oct 2001 23:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279219AbRJWDEC>; Mon, 22 Oct 2001 23:04:02 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:54025 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S279218AbRJWDDw>; Mon, 22 Oct 2001 23:03:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: <linux-kernel@vger.kernel.org>
Subject: time tells all about kernel VM's
Date: Mon, 22 Oct 2001 23:04:25 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011023030353Z279218-17408+3723@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've all seen benchmarks and "load tests" and "real world runthroughs" on 
the rik and aa kernel VM's.  But time does tell all.  I've had 
2.4.12-ac3-hogstop up and running for over 5 days.   The first hiccup i found 
was a day or so ago when trying out defragging an ext2 fs on a hdd just for 
the hell of it.  I have 770MB of ram and 128MB of swap (since my other 128MB 
of swap was on the drive i was defragging and i had swapoff'd it).   First 
the kernel created about 600MB of buffer in addition to the application 
specified 128MB of buffer i had it using (e2defrag -p 16384).   This brought 
the system to a crawl.  So in some twisted reality that may be considered 
normal kernel behavior, so i let it pass.  Then i created an insanely large 
ps and tried loading it in ghostview, magnified it a couple times in 
kghostview and what happens?  I wish i could tell you but i cant because the 
system immediately went unresponsive and started swapping at a turtles pace.  
I can tell what didn't happen though.  

A.  OOM did not kick in and kill kghostview.  Why you may ask?  Read on to B. 
B.  The VM has this need to redistribute cache and buffer so that an OOM 
situation doesn't take place until all the ram is basically being used.  The 
problem is that currently the VM will swap out stuff it isn't using and 
without buffer it must read from the drive (which is being used to swap) 
which takes more cpu which isn't there because the app is locking the kernel 
up trying to allocate memory (see why dbench causes mp3 skips).  So what 
happens is that the kernel cant swap because the hdd io is being strangled by 
the process that's going out of control (kghostview) which means that the VM 
is stuck doing this redistribution at a snails pace and the OOM situation 
never occurs (or occurs many days later when you've died of starvation).  
Leaving you deadlocked on a kernel with a VM that is supposed to conquer this 
situation and make it a thing of the past.  

So what happens after a few days of uptime is that we see where the VM has 
slight weaknesses that magnify over time and aren't aparent on the normal run 
of tests done on each new release to decide if it's good or not.  
Perhaps if i had not had any swap loaded at all this situation would have 
been avoided.   
I see this as a pretty serious bug 
