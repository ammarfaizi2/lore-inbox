Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRHZCt4>; Sat, 25 Aug 2001 22:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271247AbRHZCtp>; Sat, 25 Aug 2001 22:49:45 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:51122 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271246AbRHZCt3>;
	Sat, 25 Aug 2001 22:49:29 -0400
Date: Sun, 26 Aug 2001 04:49:42 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826044942.G29129@cerebro.laendle>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva> <20010826013155Z16205-32383+1383@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010826013155Z16205-32383+1383@humbolt.nl.linux.org>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 03:38:34AM +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:
> Let's test the idea that readahead is the problem.  If it is, then disabling 
> readahead should make the lowlevel disk throughput match the highlevel 
> throughput.  Marc, could you please try it with this patch:

No, I rebooted the machine before your mail and sinc wehtis is a production
server.. ;)

Anyway, I compiled and bootet into linux-2.4.8-ac9. I jused ac8 on my
desktop machines and was not pleased with absolute performance but, unlike
the linus' series, I can listen to mp3's while working which was the
killer feature for me ;)

anyway, AFAIU, one can tune raedahead dynamically under the ac9 series by
changing:

isldoom:/proc/sys/vm# cat max-readahead 
31

If this is equivalent to your patch, then fine. if not I will test it at
a later time. Now, a question: how does the per-block-device read-ahead
fit into this picture?  Is it being ignored? I fiddled with it (under
2.4.8pre4) but couldn't see any difference.

Anyway, after booting and waiting a minute, I had 574 active connections
and 3.6MB/s (btw, filesize is usually hundreds of megabytes, so most of
the work is actually pure read/write. in these tests, I had a userspace
"bounce buffer" of 128k per socket and, unlike earlier tests, 256kb
tcp-wmem).

Now:

isldoom:/proc/sys/vm# echo 511 >max-readahead  

this gave me - after some warming up - 3MB/s at 636 connections (which
doesn't mean very much - could be pure chance).

isldoom:/proc/sys/vm# echo 0 >max-readahead 

now 1.6MB/s at 645 connections. read-ahead seems to be very useful (at
least on ac kernels and under medium load).

free showed me 160mb free, which, at these connection counts, might be
enough for read-ahead to work effectively (remember my other tests were at
higher load, but I cannot choose this freely ;)

Now the interesting part. setting read-ahead to 31 again, I increased the
number of reader threads from one to 64 and got 3.8MB (@450 connections, I
had to restart the server).

So the ac9 kernel seems to work much better (than the linus' series),
although the number of connections was below the critical limit. I'll
check this when I get higher loads again.

At least I now have reasonable behaviour - more parallel reads => slightly
better performance.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
