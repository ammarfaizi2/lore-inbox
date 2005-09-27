Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVI0LjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVI0LjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVI0LjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:39:04 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:27283 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S964904AbVI0LjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:39:03 -0400
Date: Tue, 27 Sep 2005 20:39:02 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
In-Reply-To: <20050927013751.47cbac8b.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050927113902.C78A570046@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jackson-san,

Thank you for the review.  I'll fix the bugs that you have found.

On Tue, 27 Sep 2005 01:37:51 -0700
Paul Jackson <pj@sgi.com> wrote:

> The above reminds me of a bug fix that you provided in the previous
> patch set, for the case *ppos >= eof.  I wonder if we have duplicated
> code here.

Ah, yes, we need to fix the bug in the cpuset code introduced by me...

> I see that the cpu controller patch, as it must, has hooks in the
> critical scheduler paths.  How much does this slow down a system
> if CONFIG_CPUMETER is enabled, but the system is running in the
> default cpuset and cpumeter configuration, such as it would be
> after a reboot, before any intentional administration to setup
> particular cpusets or meters is attempted?

I don't have any benchmark numbers yet, but the cpu controller code
will add some if statements and will not hold any spinlocks to the 
scheduler in the default configuration.

> Looking back at your nice opening picture, I see you write:
> >   cpus/mems/meter_cpu/... and do not have their specific values.
> > - The metered CPUSETS can have their children
> >   (this is not allowed in SUBCPUSETS).
> > - meter_cpu in the children of metered CPUSETS can not be modified
> >   (can not create normal CPUSETS under metered CPUSETS).
> 
> This seems more restrictive than necessary.  Indeed, it reminds
> me of some of the concerns I had with the previous SUBCPUSET
> proposal.  I think we should only need the following:

I have a few questions for your idea to make the design 
in my mind clearer.

>  * Some cpuset C in the hierarchy is marked cpu_exclusive (hence
>    its ancestors are also so marked.)
>  * None of C's descendents are cpu_exclusive.  This will make
>    cpuset C define a sched domain.
>  * Each of the -immediate- children of C are marked meter_cpu.

Can the cpuset C have immediate children with meter_cpu=0?
Or should it be prohibited to set meter_cpu=0 for the immediate 
children of C?

If it is prohibited to set meter_cpu=0 for the immediate children 
of C, cpuset_create() needs a check whether the siblings are
metered or not.  If the siblings are metered, the newly created 
cpuset should also be metered.  And probably it is not allowed 
to set meter_cpu=1 if the sibling cpusets have meter_cpu=0.

>  * But C is not marked meter_cpu, none of the ancestors of C
>    are marked meter_cpu, and none of the descendents of C's
>    children are marked meter_cpu.  Just C's children as so marked.

Good idea, but I'd like to make sure...
Is it prohibited for any decendant of C's children to set meter_cpu=1 ?

>  * C's immediate children must have the same CPU's as C.  Children
>    of these children can have any CPU's (that are a subset of C's,
>    of course.)
>  * Each of C's immediate children gets a certain portion of the
>    CPU time, as specified in its meter_cpu_* files, to be shared
>    amongst all tasks running in that cpuset, or any descendent of
>    that cpuset.
>  * This should allow for creating normal cpusets under metered
>    cpusets.


Best regards,
-- 
KUROSAWA, Takahiro
