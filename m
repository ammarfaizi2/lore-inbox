Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278525AbRJPFHe>; Tue, 16 Oct 2001 01:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278524AbRJPFHY>; Tue, 16 Oct 2001 01:07:24 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:55050 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S278091AbRJPFHO>;
	Tue, 16 Oct 2001 01:07:14 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200110160507.f9G57f509413@oboe.it.uc3m.es>
Subject: Re: very slow RAID-1 resync
In-Reply-To: <Pine.LNX.4.33.0110151653120.13462-100000@windmill.gghcwest.com>
 from "Jeffrey W. Baker" at "Oct 15, 2001 05:02:21 pm"
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Date: Tue, 16 Oct 2001 07:07:41 +0200 (MET DST)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jeffrey W. Baker wrote:"
> I just plugged in a new RAID-1(+0, 2 2-disk stripe sets mirrored) to a
> 2.4.12-ac3 machine.  The md code decided it was going to resync the mirror
> at between 100KB/sec and 100000KB/sec.  The actual rate was 100KB/sec,
> while the device was otherwise idle.  By increasing
> /proc/.../speed_limit_min, I was able to crank the resync rate up to
> 20MB/sec, which is slightly more reasonable but still short of the
> ~60MB/sec this RAID is capable of.
> 
> So, two things: there is something wrong with the resync code that makes
> it run at the minimum rate even when the device is idle, and why is the
> resync proceeding so slowly?

This has  been the trend throughout the 2.4 series. 2.4.0 was quite
snappish at resyncs and speed has generally dropped from version to
version. I recall seeing a speed halving somewhere early in the series
(2.4.2?).

> raid1d and raid1syncd are barely getting any CPU time on this otherwise
> idle SMP system.
> 
> There must be some optimization to mostly skip the sync on an array of new
> drives, ja?

Not that I have seen. Raid resyncs are throttled via a braking mechanism
in the generic md code (I think it's called fooresyncbar). It attempts
to guage the current resync speed and compares with the min and max values
and either calls for more resyncs or schedules. But even removing this
brake from the code doesnt't spped things up, so I am mystified as to
where the throttling effect comes from. It must be somewhere else in
the structire of the code.

Another problem is that there seem sto be some kind of state .. if the
raid resync starts while the machine is under load, then it runs slowly
and continues at that rate even when the other load is removed.

Peter
