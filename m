Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRCYPtT>; Sun, 25 Mar 2001 10:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132045AbRCYPtK>; Sun, 25 Mar 2001 10:49:10 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:22400 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S132044AbRCYPs7>; Sun, 25 Mar 2001 10:48:59 -0500
Message-Id: <l03130320b6e3b6e3feea@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.30.0103251549100.13864-100000@fs131-224.f-secure.com>
In-Reply-To: <l03130315b6e242006a4b@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Mar 2001 16:47:59 +0100
To: Szabolcs Szakacsits <szaka@f-secure.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >start your app, wait for malloc to fail, hit enter for the other app and
>> >watch you app to be OOM killed ;)
>>
>> That would only happen if memory_overcommit was turned on, in which case my
>> modification would have zero effect anyway (the overcommit test happens
>> before my code).
>
>Thanks for listening and trying out the above trivial code instead of
>wrong theoretical arguments ;)
>
>So again, Linux *always* overcommit memory, the
>/proc/sys/vm/overcommit_memory controls total overcommit or
>quasi-overcommit [ehen you make your check in vm_enough() the memory is
>already overcommitted].

OK, looks like I got mixed up between *reservation* (malloc) and
*allocation* (access), and we're checking allocated memory when we should
really be checking reserved.  Be patient - I haven't done much of this type
of thing...  but your argument turns out to be correct, and I eventually
figured it out for myself.  I certainly agree that the default should be to
assume that all reserved memory will be used.  Maybe even do little nasty
things like printk(KERN_WARN "root is overcommitting memory!\n"); in
appropriate places, to discourage overcommitting.

>The solution is something like,
>add optional non-overcommit support,
>	http://lwn.net/2000/0406/a/no-overcommit.html

This sounds like a good solution.  Saw the size of the patch, it's big and
touches lots of bits of VM code, but it looks as though parts of my ideas
will also fit in there and be helpful.

Hmm... so we get an adjusted or replaced OOM-kill-selection algorithm, my
out_of_memory() fix and runaway process clamp, and this big(ish)
memory-accounting patch.  Sounds like a good combination to me, fixing all
the problems I've heard about recently.

There are some unrelated performance problems I've encountered during my
testing (eg. kswapd gets incredibly inefficient when swap usage grows
beyond about 500Mb on my 256Mb physical machine, causing swap bandwidth to
fall way below the HDs' capabilities), which I'm going to ignore for now.
Probably whoever takes on the VM balancing problem can look into that, as
it's probably related to that rather than this...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


