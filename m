Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbTC1KHs>; Fri, 28 Mar 2003 05:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbTC1KHs>; Fri, 28 Mar 2003 05:07:48 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:48138 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S262862AbTC1KHr>; Fri, 28 Mar 2003 05:07:47 -0500
From: Tim Connors <tconnors@astro.swin.edu.au>
Message-Id: <200303281018.h2SAIxq29603@tellurium.ssi.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
In-Reply-To: <20030327113014$37b4@gated-at.bofh.it>
References: <20030326204012$188c@gated-at.bofh.it> <20030327091007$22a5@gated-at.bofh.it> <20030327113014$37b4@gated-at.bofh.it>
Date: Fri, 28 Mar 2003 21:18:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> Helge Hafting (helgehaf@aitel.hist.no) wrote:
>> Erik Hensema wrote:
>>> In all kernels I've tested writes to disk are delayed a long time even when
>>> there's no need to do so.
>>> 
>> Short answer - it is supposed to do that!
>> 
>>> A very simple test shows this: on an otherwise idle system, create a tar of
>>> a NFS-mounted filesystem to a local disk. The kernel starts writing out the
>>> data after 30 seconds, while a slow and steady stream would be much nicer
>>> to the system, I think.

Agreed. We have a cluster which is writing on average something like
20 Megs/sec/node. We had to lower the write threshold from 30% to 0%,
because with the constant writing, linux will buffer it for 30 secs,
fill up RAM, try to empty the write-cache, stall, wash, rinse,
repeat. Because it was being filled up at roughly the rate it was
being emptied, once it got 30% behind, there was no catching up, so
the realtime system would lose data. Ouch.

>> You're wrong then.  There's no need for a slow steady stream, why do
>> you want that.  Of course you can set up cron to run sync at
>> regular (short) intervals to achieve this.

Last time I checked, cron had 1 minute resolution.
 
> I see that. However, I don't see why the kernel is writing out data
> as agressively as it does now. Delaying a write for 30 seconds isn't the
> problem: the aggressive writes are. Since the disks are otherwise idle, the
> kernel can gently start writing out the dirty cache. No need to try and
> write 40 MB in 1 sec when you can write 10 MB/sec in 4 seconds.
> 
> [...]
> 
>> For more detailed information, read a book about how filesystems and
>> disk caching works.
> 
> I'm just reporting what's happening to me in practice, I don't really care
> about what should happen in theory.

Exactly. 

Helge's comment about /tmp files and rewriting files multiple times:
in real life, how often does this happen? How often do you overwrite
one file many times in 30 seconds? The occasional 20 kilobyte /tmp
file perhaps, but I doubt it matters in real life. In real life, when
writing to disk constantly (not just scientific applications - I
believe this happens in the real world too!), waiting for 30 seconds
is a liability!


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

White dwarf seeks red giant star
