Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289108AbSAVA22>; Mon, 21 Jan 2002 19:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289104AbSAVA2S>; Mon, 21 Jan 2002 19:28:18 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47370 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289106AbSAVA2C>; Mon, 21 Jan 2002 19:28:02 -0500
Message-ID: <3C4CB1FB.6AD8496E@linux-m68k.org>
Date: Tue, 22 Jan 2002 01:27:39 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> > don't you?  As for the measured benefit, there have been a steady stream of
> > postive reports on lkml.
> 
> I have not seen a single well structured benchmark that shows a significant
> difference. I've seen lots of benchmarks with odd mixes of different patches
> showing something unknown. How about a simple clear dbench?

So let's explore the benchmark argument a bit. A usual some things need
to be clarified first.
It would be useful to know what we actually want to measure in the
benchmark. The main goal is to reduce scheduling latencies, so it would
make sense to test this. Results can be found at
http://www.gardena.net/benno/linux/audio/ and
http://kpreempt.sourceforge.net/. I haven't found a direct compare of
preemp+lockbreak and ll patch, but I wouldn't expect major differences
and it isn't really important. It is only important that both approaches
improve the scheduling latency considerably.
Now what in this thread is mostly mentioned are i/o benchmarks.
Improving i/o performance isn't really the main goal of the patches, so
it's only important that i/o performance isn't harmed. So far I haven't
seen any results indicating something like this, so case closed.
Victor, could you please explain, what are you trying to prove with the
benchmark argument??? I see you arguing a lot, but I don't really see
for what.
Finally my theory, why preempt performs better. If we assume that the
kernel spends too much time in kernel space, we only need to look at the
ll patch for possible latency problems. My favourites are two places -
copy_(to|from)_user and page table scan. Both are likely places for
loads like grep or kernel compile. I can see two possible effects here.
First lots of small i/o can be issued faster instead copying data
around. Second we spent too much time scanning the page tables looking
for freeable pages, while already enough i/o is scheduled, so instead
something useful is done and we just wait for the i/o to finish. Anyway,
anyone who really wants to know it, could modify the profiling code and
test where in kernel we schedule so often.

bye, Roman
