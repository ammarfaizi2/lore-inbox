Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132090AbRA3VDR>; Tue, 30 Jan 2001 16:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131998AbRA3VDH>; Tue, 30 Jan 2001 16:03:07 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:48132 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131141AbRA3VC4>; Tue, 30 Jan 2001 16:02:56 -0500
Date: Tue, 30 Jan 2001 21:00:17 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: <yodaiken@fsmlabs.com>
cc: Joe deBlaquiere <jadb@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Nigel Gamble <nigel@nrg.org>, <linux-kernel@vger.kernel.org>,
        <linux-audio-dev@ginette.musique.umontreal.ca>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <20010130135154.B27260@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.30.0101302054440.1119-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 yodaiken@fsmlabs.com wrote:

> So then a >100us delay is ok ?
> 
> I have a dumb RT perspective: either you have to make the deadline or you don't.
> If you have to make the deadline, then why are you checking need_resched?

In the case I'm describing, it _works_ if you have a >100us delay. We ask
the chip to do something, and we expect it to take about 100us, so we come
back and start polling for completion after that time.  Actually, we tune
our estimate of how long to back off, depending on how long we've actually
spent polling for completion on previous attempts. But if you _always_
have a 10ms delay, each time you only really needed to wait 100us, then
the performance is appalling.

I'd like to be nice, but I don't want to drop my performance by 100x 
without good reason. Hence the check for need_resched.

Don't confuse this with the code which was mentioned before, which needs 
to send many different words to the chip consecutively. That is done while 
holding a spin_lock. We don't drop the lock and wait between commands in 
that situation.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
