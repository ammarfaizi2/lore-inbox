Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWGWLxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWGWLxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWGWLxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 07:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751013AbWGWLxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 07:53:33 -0400
Date: Sun, 23 Jul 2006 04:46:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, torvalds@osdl.org,
       bunk@stusta.de, lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-Id: <20060723044637.3857d428.akpm@osdl.org>
In-Reply-To: <20060723081604.GD27566@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de>
	<20060722173649.952f909f.akpm@osdl.org>
	<20060723081604.GD27566@kiste.smurf.noris.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006 10:16:04 +0200
Matthias Urlichs <smurf@smurf.noris.de> wrote:

> > Are you able to compare the present bootlog with the 2.6.17 bootlog?
> > 
> Sure. The diff says:
> 
>  checking TSC synchronization across 4 CPUs:
> +CPU#0 had 748437 usecs TSC skew, fixed it up.
> +CPU#1 had 748437 usecs TSC skew, fixed it up.
> +CPU#2 had -748437 usecs TSC skew, fixed it up.
> +CPU#3 had -748437 usecs TSC skew, fixed it up.
>  Brought up 4 CPUs
> -migration_cost=4000,8000
> +migration_cost=85,1724
> 
> ... but apparently, that skew is not corrected.
> 
> These numbers do match the difference in observed "date" outputs.

>From this I'll assume that

- CPU0 and CPU1 share a TSC and CPU2 and CPU3 share another TSC.

- write_tsc() simply doesn't work on this machine.

- Earlier kernels weren't able to modify the TSC either.

- Earlier kernels didn't use the TSC as a time source whereas this one
  does, hence the problems which you're observing.


Some or all of the below might be wrong, but I don't think so:


I assume that booting with clock=pit or clock=pmtmr fixes it?

It would be useful to check your 2.6.17 boot logs, see if we can work out
what 2.6.17 was using for a clock source.

We need to fix that "fixed it up" message because it just ain't so.

The new clocksouce code needs to detect this and to mark the TSC source as
unstable, or otherwise unusable.

We _could_ fix the TSC skew up, by adjusting the rdtsc output by the
tsc_values[] entry wherever we read the TSC.

It would of course be better to make write_tsc() work.  I wonder why it
doesn't?

