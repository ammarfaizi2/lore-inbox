Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262281AbSJJWpK>; Thu, 10 Oct 2002 18:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJJWpJ>; Thu, 10 Oct 2002 18:45:09 -0400
Received: from smtp07.iddeo.es ([62.81.186.17]:45445 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S262281AbSJJWpI>;
	Thu, 10 Oct 2002 18:45:08 -0400
Date: Fri, 11 Oct 2002 00:50:52 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Robert Love <rml@tech9.net>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on O_STREAMING (goodby read pauses)
Message-ID: <20021010225052.GE1676@werewolf.able.es>
References: <20021009222349.GA2353@werewolf.able.es> <1034203433.794.152.camel@phantasy> <20021010034057.GC8805@mark.mielke.cc> <20021010143927.GA2193@werewolf.able.es> <20021010180108.GB16962@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021010180108.GB16962@mark.mielke.cc>; from mark@mark.mielke.cc on Thu, Oct 10, 2002 at 20:01:08 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.10 Mark Mielke wrote:
>On Thu, Oct 10, 2002 at 04:39:27PM +0200, J.A. Magallon wrote:
>> On 2002.10.10 Mark Mielke wrote:
>> >I assume the stall is not 'while pages are sent to disk', but rather
>> >until kswapd gets around to freeing enough pages to allow memory to
>> >fill again. The stall is due to the pages being fully analyzed to
>> >determine which ones should go, and which ones shouldn't. O_STREAMING
>> >removes the pages ahead of time, so no analysis is ever required.
>> I can _hear_ the disk activity when the stall happens, so selecting what
>> to drop is fast, but then you have to write it...
>
>I don't think this is right. Prove me wrong by explaining how kswapd works,
>but if a page isn't dirty, there is no need to write it out to disk.
>

You suppose it is a page of code ? What about data that programs malloc() ???
You can also send data memory to swap. If you do not write it on disk,
how do you recover it ???

>My (perhaps incorrect) assumption is that kswapd prefers to swap on clean
>pages over dirty pages. If your pages are mostly clean, there is nothing
>to write to disk the clear majority of the time.
>
>Clean read-only pages should *never* be written to swap. They can be re-read
>from their source.

That is your fault, <read-only>. Pages maped read-only are those from 
binary executables or shared libraries, but, again, what about data ?

>
>I _think_ what you are seeing is that kswapd is not cleaning pages out
>fast enough, which means that *other* tasks executing need to have their
>*swapped out* pages *read* from disk. I.e. the churning you hear is probably
>mostly reads - not writes.
>

I look at gnome system monitor graph for mem. I start with a tiny amount of
used memory. Start the 1Gb read without O_STREAM, the blue area in monitor
starts to grow linearly in time, stars (*) from the reader appear at a
given rate, and as soon as it touches the top limit the stars stop, the disk
begins to thrash, and swap space used grows. After a 2-4 seconds, the stars
go again with the same rate. Tell me what is this but swapper writing pages,
and reading the new pages for my giga.

With O_STREAM, the 'blue bar' does not move from its place, and star rate
(ie, read rate from disk), stays uniform.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
