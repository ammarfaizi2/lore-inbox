Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTB0XTS>; Thu, 27 Feb 2003 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTB0XTR>; Thu, 27 Feb 2003 18:19:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:24712 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267274AbTB0XTO>;
	Thu, 27 Feb 2003 18:19:14 -0500
Date: Thu, 27 Feb 2003 15:26:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduling questions
Message-Id: <20030227152604.334c292a.akpm@digeo.com>
In-Reply-To: <20030227222440.14610.qmail@linuxmail.org>
References: <20030227222440.14610.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Feb 2003 23:29:27.0815 (UTC) FILETIME=[120F8170:01C2DEB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> Hello, 
>  
> I have just installed 2.5.63-mm1 on my system and have been performing a very simple benchmarks. Here are 
> my first results when compared against a RedHat 2.4.20-2.54 kernel: 
>  
> (All times expressed as total times) 
>  
> 1. time dd if=/dev/zero of=/tmp/p bs=1024k count=256 
> 2.5.63-mm1 -> 0m12.737s 
> 2.4.20-2.54 -> 0m17.704s 

It's hard to compare 2.4 and 2.5 on this one.  2.5 will start writing to disk
much earlier, and that additional I/O can sometimes get in the way of other
disk operations.  The end result is that the test exits leaving more (or
less) dirty data in memory and the time for writing that out is not
accounted.

You need to either run a much longer test, or include a `sync' in the
timings.

But in this case (assuming you're using ext3), the difference is probably
explained by a timing fluke - the test on 2.4 kernel happened to cover three
ext3 commit intervals while the 2.5 test squeezed itself into two.

Hard to say - there are a lot of variables here.

> 2. time cp /tmp/p /tmp/q 
> 2.5.63-mm1 -> 0m41.108s 
> 2.4.20-2.54 -> 0m51.939s 

Could be ext3 effects as well.  Also maybe some differences in page aging
implementations.

> 3. time cmp /tmp/p /tmp/q 
> 2.5.63-mm1 -> 1m7.349s 
> 2.4.20-2.54 -> 0m58.966s 

cmp needs to use a larger buffer ;)

> 4. time cmp /dev/zero /tmp/q 
> 2.5.63-mm1 -> 0m17.965s 
> 2.4.20-2.54 -> 0m14.038s 

Again, depends on how much of /tmp/q was left in pagecache.

> The question is, why, apparently, is anticipatory scheduling perfomring
> worse than 2.4.20?

It doesn't seem to be from the above numbers?

> Indeed, this can be tested interactively with an application like Evolution:
> I have configured Evolution to use 2 dictionaries (English and Spanish) for
> spell checking in e-mail messages. When running 2.4.20, if I choose to reply
> to a large message, it only takes a few seconds to read both dictionaries
> from disk and perform the spell checking. 
> However, on 2.5.63-mm1 the same process takes considerably longer. Any
> reason for this? 

Could you boot with elevator-deadline and retest?

How large are the dictionary files?
