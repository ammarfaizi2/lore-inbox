Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVHaCEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVHaCEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 22:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHaCEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 22:04:01 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:36247 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932330AbVHaCEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 22:04:00 -0400
Subject: jack, PREEMPT_DESKTOP, delayed interrupts?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: jackit-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       cc@ccrma.Stanford.EDU
Content-Type: text/plain
Organization: 
Message-Id: <1125453795.25823.121.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Aug 2005 19:03:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm starting to look at a strange problem. The configuration is:
hardware: AMD X2 4400+ dual core, NForce3 chipset, Midiman 66 soundcard
software: 2.6.13 smp + patch-2.6.13-rt1, PREEMPT_DESKTOP
          jack 0.100.4, current cvs
          alsa 1.0.10rc1

This is the sequence of events. Start Jack inside Qjackctl (a Jack Audio
Connection Kit GUI front end) with 2 x 128 frames, start Ardour (a
digital audio workstation) - load a very simple recording session, start
Hydrogen (a drum machine). Play around with them, everything seems to
work fine. No glitches, very solid performance. 

Do a "tar cvf usr.tar /usr" just to read/write a lot to disk (this
within the same SATA disk). Watch memory being used in a system monitor
applet up to 100%. After a while, hard to say how long (maybe 10/15
minutes?) the system eventually can get into a state where Jack starts
printing messages of the type "delay of 3856.000 usecs exceeds estimated
spare time of 2653.000; restart ..." (if I understand correctly this
means interrupts are being delayed on their way to Jack, or at least
Jack thinks they are arriving too late), along with some less frequent
xun notices. 

Now the strange thing is that this condition seems to be persistent.
Nothing I do after it starts to happen seems to halt those messages.
Including stopping Jack and starting it again, and even (tried it once)
stopping the alsa sound driver and loading it again. Nothing out of the
ordinary in dmesg or /var/log/messages. I would guess that something
"breaks" inside the kernel with regards to interrupt handling and/or
whatever Jack uses to measure time inside the kernel? Interrupts are
prioritized correctly (rtc, then audio and jack runs at lower realtime
priority than the audio interrupts), everything else looks fine. 

I could not get this to happen while running a uniprocessor kernel on
the same machine but I may not have tried long enough. I do see a "delay
exceeds" or "xun" message every once in a while but not a steady,
unstoppable stream of them. 

This seemed to be much worse, or easier to trigger, when running an
older realtime-preempt-2.6.12-final-V0.7.51-27 smp kernel. 

I don't know what information may be useful to even start making some
sense out of this. 

-- Fernando


