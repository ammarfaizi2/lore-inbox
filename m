Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVAQBix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVAQBix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 20:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVAQBhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 20:37:41 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:38549
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262664AbVAQBhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 20:37:24 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <41EADA11.70403@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
	 <41E7A7A6.3060502@opersys.com>
	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>
	 <41E8358A.4030908@opersys.com>
	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>
	 <41E899AC.3070705@opersys.com>
	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>
	 <41EA0307.6020807@opersys.com>
	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 02:37:22 +0100
Message-Id: <1105925842.13265.364.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 16:18 -0500, Karim Yaghmour wrote:

> We already do write a heartbeat event periodically to have readable
> traces in the case where the lower 32 bits of the TSC wrap-around.

Which is every 1.42 seconds on a 3GHz machine. I guess we don't have
GB's of data when the 1.42 seconds elapse without an event.

> > Userspace can then easily restore the original order of events.
> 
> As above, restoring the original order of events is fine if you are
> looking at mbs or kbs of data. It's just totally unrealistic for
> the amounts of data we want to handle.

I still don't see the point. The implicit ability of LTT to allow
tracing of up to 8192 bytes user data, strings and XML makes this
neccecary. I do not see any neccecarity to integrate this special usage
modes instead of an generic usable instrumentation implementation.

If relayfs is giving those users the ability to do so then they can do
it, but I object the fact that LTT/relayfs is occupying the place of a
more generic implementation in the way it is implemeted now.

For normal event tracing you have about 32-64 byte of data per event. So
disabling interrupts in order to copy this amount of imformation into a
buffer is cheaper on most architectures than doing the whole magic in
LTT and relayfs. This also keeps your buffers consistent and does not
need any magic for postprocessing. 

Sorting out disabled events in the hot path and moving the if
(pid/gid/grp) whatever stuff into userspace postprocessing is not an
alien request.

You are talking of Gigabytes of data. In what time ?

Let's do some math.

For simplicity all events use 64 Byte event space.

~ 64kB/sec for 1000 events/s (event frequency   1kHz) ( 1 ms)
1024kB/sec for  16 events/ms (event frequency  16kHz) (62 us)
2048kB/sec for  32 events/ms (event frequency  32kHz) (31 us)
4096kB/sec for  64 events/ms (event frequency  64kHz) (15 us)
8192kB/sec for 128 events/ms (event frequency 128kHz) ( 8 us)

where a 100Mbit network can theoretically transport 10240kB/sec and
practically does 4000-8000 kB/sec. 

An event frequency of 8us even on a 3 GHz machine is complete illusion,
because we spend already a couple of usecs in servicing the legacy 8254
timer.

So the realistic assumption on a 3Ghz machine is definitely below 64kHz,
which means we have to handle max. 4Mb of data per second. 

I'm not impressed. Disabling interrupts for a couple of nano seconds to
store the trace data in the buffer does not hurt at all. Running through
a big bunch of out of cache line instructions does.

If you try to trace more than this amount you are toast anyway.

Please beware me of "reality has bitten" arguments. The whole if(..)
scenario in _ltt_event_log() is doing postprocessing, which can be done
in userspace. I don't care about the required time as long as it does
not introduce additional burden into the kernel.

> Also note that there are people who currently use this already,
> so there will be some unhappy campers.

Be aware that there are some unhappy campers in the kernel community too
when the special purpose tracing is included instead of a general usable
framework.

tglx


