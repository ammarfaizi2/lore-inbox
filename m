Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137190AbRATJio>; Sat, 20 Jan 2001 04:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137212AbRATJie>; Sat, 20 Jan 2001 04:38:34 -0500
Received: from mailout3-1.nyroc.rr.com ([24.92.226.168]:24569 "EHLO
	mailout3-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S137190AbRATJiY>; Sat, 20 Jan 2001 04:38:24 -0500
Message-ID: <01da01c082c5$2c155e60$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Michael Lindner" <mikel@att.net>, "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694357.1A7C6AAC@att.net>
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  available
Date: Sat, 20 Jan 2001 04:41:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kernel have you been using? I have reproduced your problem on a
standard 2.2.18 kernel (elapsed time ~10sec). However, using a 2.4.0 kernel
with HZ=1000, I see a 100x improvement (elapsed time ~0.1 sec; note that
increasing HZ alone should only give a 10x improvement). Perhaps the
scheduler was fixed in 2.4.0?

2.2.18 very definitely has some scheduling anomalies. In your benchmark,
select() or poll() takes 10ms, as can be observed with strace -T. Skipping
the select() and blocking in read() gives the same behavior. This leads me
to believe the scheduler is at fault, and not select(), poll(), or read().

When run without strace, 2.4.0 appears to have no problems with your
benchmark. Elapsed time is 0.1 sec -- this may be the full potential of my
machine (PII/450). Removing select() and blocking in read() results in a
further improvement, to 0.07 sec.

Strace disturbs the behavior of 2.4.0 in strange ways. Running the benchmark
under strace with 2.4.0 causes the scheduler delays to return -- ~1ms delays
appear in select() or write(). This is confusing - it appears that context
switches can happen inside write() as well as select(), a result I don't
understand at all (the socket buffers never completely fill since you only
write 1000 bytes to each one).

Other notes: poll() behaves same as select(). Using the SCHED_FIFO class and
mlockall() has no effect on this benchmark. Setting the sockets non-blocking
also has no effect.

I wish I had the Linux Trace Toolkit handy; it would give a much better idea
of what's going on than strace...

Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
