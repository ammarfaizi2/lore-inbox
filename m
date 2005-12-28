Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVL1Jyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVL1Jyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 04:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVL1Jyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 04:54:33 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:40906 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932490AbVL1Jyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 04:54:32 -0500
Date: Wed, 28 Dec 2005 10:55:12 +0100
From: DervishD <lkml@dervishd.net>
To: Shaun <mailinglists@unix-scripts.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory, where's it going?
Message-ID: <20051228095512.GA25654@DervishD>
Mail-Followup-To: Shaun <mailinglists@unix-scripts.com>,
	linux-kernel@vger.kernel.org
References: <dotjb6$j8$1@sea.gmane.org> <20051228085328.GA25380@DervishD> <026801c60b8d$ef128360$6501a8c0@ndciwkst01>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <026801c60b8d$ef128360$6501a8c0@ndciwkst01>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Shaun :)

 * Shaun <mailinglists@unix-scripts.com> dixit:
> I understand the concept and why things are cached, i've just never
> seen it cache this much before..

    That's probably because most of the work the machine did was CPU
bound and not IO bound. If you run many IO bound apps, which read a
lot from disk, you fill cache pretty fast. That's normal.

    For example, if your machine is an FTP server which most of the
time serves the same 10 files, only those files will end up filling
the cache, and the machine will not eat much memory caching. This
way, you probably end up with lots of unused memory, because it is
not needed even for cache.

    On the other hand, if your machine is an FTP server mostly
inactive but you serve a file whose size is 1GB, you will use most of
the memory with cache.

> My concern is that 
> with bearly anything running on it i already have dug into swap.

    Swap memory is not used just when the machine has no free memory.
Although this is a rough explanation and doesn't describe exactly the
swap mechanism, some apps will remain into swap space even if there's
plenty of free RAM available, as long as they are not used. And
that's good, because an unused app should not eat memory even if
there's free memory.

    Think about this situation: you have a running app whose memory
comsumption is cyclic, it eats most of the memory for a few minutes
and after that it frees the memory. The other apps eat a whole bunch
of memory, but they're sleeping, and only run once a day. In that
scenario, if apps were put out of swap and into main memory as soon
as free memory is available, the system will be very busy moving
sleeping apps from swap into core and back. And it will be wasted
time, because the moved apps are sleeping.

    What the kernel does is that it sents unused pages of memory to
swap when another app needs the memory (it is a bit more complex than
that, but it will do for an explanation), and after that it doesn't
put back the pages into main memory when it's free again. Instead, it
puts back the pages when they're accessed again, not before.

    Main memory must be used for things like running apps and
caching, not for storing sleeping apps. The system runs faster that
way, because it uses the expensive RAM to actually do work, not as a
drawer to put there apps "just in case they're needed" ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
