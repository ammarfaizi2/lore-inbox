Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUGOAE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUGOAE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUGOAE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:04:58 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:16568 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266001AbUGOAE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:04:56 -0400
Date: Thu, 15 Jul 2004 02:04:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715000438.GS974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089848823.15336.3895.camel@abyss.home>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 04:47:04PM -0700, Peter Zaitsev wrote:
> To be honest I do not really understand this OOM without swap problem at
> all, why is it possible to move pages from ZONE_NORMAL to swap but not
> to other zones ? 

the oom without swap you reproduced is not related to ZONE_NORMAL
shortage. The pages in ZONE_NORMAL never goes into swap.

the ZONE_NORMAL oom is a separate issue from the oom killing you
reproduced. with 2.6.7 if you were hitting the ZONE_NORMAL shortage your
machine would lockup and it would never oom-kill anything (Andrew just
changed that in kernel CVS, so thanks to that change a ZONE_NORMAL
shortage will not deadlock anymore in 2.6.8, but OTOH in 2.6.8 adding
swap will not be enough anymore to workaround the oom-killing you
reproduced).

About the ZONE_NORMAL shortage without swap, rather than running
cpu-cache-hungry memcopies from lowmemzone to highmem (or even worse to
pass through swap like it happens in 2.6 mainline with swap enabled), I
believe it's better to reserve some ram in the lowmem zone, 800M of ram
on a 32G box should be a cheap price to pay compared to the cpu/IO cost
involved in moving memory around during the bench.
