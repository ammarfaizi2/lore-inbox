Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273043AbRIWAo0>; Sat, 22 Sep 2001 20:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273047AbRIWAoQ>; Sat, 22 Sep 2001 20:44:16 -0400
Received: from mailf.telia.com ([194.22.194.25]:38354 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S273043AbRIWAn7>;
	Sat, 22 Sep 2001 20:43:59 -0400
Message-Id: <200109230042.f8N0gw129012@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: safemode <safemode@speakeasy.net>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        george anzinger <george@mvista.com>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Sun, 23 Sep 2001 02:38:06 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> <20010922211919Z272247-760+15646@vger.kernel.org> <200109222340.BAA37547@blipp.internet5.net>
In-Reply-To: <200109222340.BAA37547@blipp.internet5.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 September 2001 01.40, safemode wrote:
> ok. The preemption patch helps realtime applications in linux be a little
> more close to realtime.  I understand that.  But your mp3 player shouldn't
> need root permission or renicing or realtime priority flags to play mp3s. 
> To test how well the latency patches are working you should be running
> things all at the same priority.  The main issue people are having with
> skipping mp3s is not in the decoding of the mp3 or in the retrieving of the
> file, it's in the playing in the soundcard.  That's being affected by
> dbench flooding the system with irq requests.  I'm inclined to believe it's
> irq requests because the _only_ time i have problems with mp3s (and i dont
> change priority levels) is when A. i do a cdparanoia -Z -B "1-"    or
> dbench 32.   I bet if someone did these tests on scsi hardware with the
> latency patch, they'd find much better results than us users of ide
> devices.

No, irq might have something to do with it but it is unlikely since the
stops are too long.

Much more likely is:
a) when running without priority altered:
MP3 playing requires processing, this will lower the process priority
relative processes that does little processing - like dbench processes.
Running with negative nice will help this, but is no guarantee. Running
with RT priority is.
[this is where the various low latency patches helps]

b) several processes are doing disk operations simultaneously.
This will put preassure on the VM to free pages fast enough. It will
also put preassure on the disk IO to read from disk fast enough -
these requests are not prioritized with the process priority in mind.
If there are no pages free we have to wait...
[if you run the latencytest program with no audiofile, to use a sine,
 you will not hear dropouts... it runs with RT prio with resident memory]

This second problem is MUCH harder to solve.
Multimedia applications could reserve memory - for their critical code
including buffers... (but this will require suid helpers...)
SGIs filesystem XFS is said to be able to guarantee bandwith to an
application.

Riels schedule in __alloc_pages probably helps the case with competing
regular processes a lot. Not allowing memory allocators to run their
whole time slot. The result should be a way to prioritize memory allocs
relative your priority. (yield part might be possible/good to remove)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
