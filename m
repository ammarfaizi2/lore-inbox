Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTDKEuD (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 00:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTDKEuD (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 00:50:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:11673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264144AbTDKEuB (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 00:50:01 -0400
Message-ID: <32880.4.64.197.106.1050037303.squirrel@webmail.osdl.org>
Date: Thu, 10 Apr 2003 22:01:43 -0700 (PDT)
Subject: Re: proc_misc.c bug
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rddunlap@osdl.org>
In-Reply-To: <20030410154902.32f48f9c.rddunlap@osdl.org>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
        <1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
        <20030410154902.32f48f9c.rddunlap@osdl.org>
X-Priority: 3
Importance: Normal
Cc: <alan@lxorguk.ukuu.org.uk>, <davidm@hpl.hp.com>, <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 10 Apr 2003 22:44:17 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> | On Thu, 2003-04-10 at 23:02, David Mosberger wrote:
> | > The workaround below is to allocate 4KB per 8 CPUs.  Not really a | >
> solution, but the fundamental problem is that /proc/interrupts | > shouldn't
> use a fixed buffer size in the first place.  I suppose | > another solution
> would be to use vmalloc() instead.  It all feels like | > bandaids though.
> |
> | How about switching to Al's seqfile interface ?
>
> It's already using it, but it uses the simple/single version of it, which
> doesn't automagically extend the output buffer area when
> it's full, so a max size buffer has to be allocated for it
> up front.
>
> I'll look at changing it unless somebody beats me (to it :).

OK, I've looked at it and concluded that it's not bad the way it is
(after David's patch is applied).  However, that really depends on
whether the static NR_CPUS is well-tuned or not.
If it's not tuned, then modifying the output to use the iterative
seq_file methods would make sense.
But if it's not tuned, someone is (usually) wasting lots of memory anyway.

[adding this:]
Or a better approximation instead of NR_CPUS might be to add and use
something a bit more intelligent about how many interrupts are
in use.  However, this makes my later argument not so strong.

The reason that I say it's not bad the way it is is that
it does one kmalloc() for the output buffer and then it can run
quickly and do its job [but it's limited to the original kmalloc
buffer size].   If it's modified to use seq_file iteration,
it will start out with kmalloc(PAGE_SIZE) in seq_read(), and when
that fills up, a buffer twice that size is kmalloc-ed, repeat....
with earlier buffers being freed first.

Does someone want to disagree now?  go a() instead.  It all feels like | >
bandaids though.
> |
> | How about switching to Al's seqfile interface ?
>
> It's already using it, but it uses the simple/single version of it, which
> doesn't automagically extend the output buffer area when
> it's full, so a max size buffer has to be allocated for it
> up front.
>
> I'll look at changing it unless somebody beats me (to it :).

OK, I've looked at it and concluded that it's not bad the way it is
(after David's patch is applied).  However, that really depends on
whether the static NR_CPUS is well-tuned or not.
If it's not tuned, then modifying the output to use the iterative
seq_file methods would make sense.
But if it's not tuned, someone is (usually) wasting lots of memory anyway.

[adding this:]
Or a better approximation instead of NR_CPUS might be to add and use
something a bit more intelligent about how many interrupts are
in use.  However, this makes my later argument not so strong.

The reason that I say it's not bad the way it is is that
it does one kmalloc() for the output buffer and then it can run
quickly and do its job [but it's limited to the original kmalloc
buffer size].   If it's modified to use seq_file iteration,
it will start out with kmalloc(PAGE_SIZE) in seq_read(), and when
that fills up, a buffer twice that size is kmalloc-ed, repeat....
with earlier buffers being freed first.

Does someone want to disagree now?  go ahead...i'm listening.
Maybe the reason to modify it is that NR_CPUS is not a good
approximation/hint/clue.

~Randy



