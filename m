Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271023AbRHUBzr>; Mon, 20 Aug 2001 21:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271054AbRHUBzh>; Mon, 20 Aug 2001 21:55:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51473 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271023AbRHUBzZ>;
	Mon, 20 Aug 2001 21:55:25 -0400
Date: Mon, 20 Aug 2001 22:55:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820234822Z16360-32383+599@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108202247090.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Daniel Phillips wrote:

> The main possibility to screw up is if we scan the inactive lists too
> fast, which probably happens sometimes because it's all grossly
> uncalibrated right now.

I've explained this to you about 5 times now and I'll
tell it one last time.

The TARGET SIZE for the inactive_dirty list is 1 second
of pageout activity. This means that with the use-once
scheme read-ahead pages have at most 1 second to be used
while the system is under pressure.

This is not enough.  With disks being able to do at most
100 reads a second (7ms seek, 3ms rotational) you'll have
limited the system to 100 threads of streaming IO at
maximum, assuming that the readahead window is limited to
1 second worth of data.

This may seem a lot, but don't worry because the readahead
window ISN'T limited to 1 second worth of data. Think an
FTP server serving 10kB/second to each client with readahead
expanding to the standard 128kB maximum.

This means that at any point we'll have evicted 90% of the
still unused readahead pages, leading to heavy thrashing of
the readahead window and reducing the maximum load supported
by the system a full _10_ FTP clients!

> That's another issue, it needs fixing.  We'll never have really
> consistent, predictable aging or any other vm behaviour until the
> list scanning is operating in a rock-solid way.

The issue is that you completely ignore the fact that your
use-once scheme has to interact with the rest of the VM.

You also ignore the fact that you haven't yet made any
proposal on how to make the rest of the VM interact nicely
with the use-once idea, preventing things like the thrashing
of the readahead window, etc...

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

