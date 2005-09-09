Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVIIBiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVIIBiG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVIIBiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:38:06 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:51429 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965231AbVIIBiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:38:04 -0400
Date: Fri, 9 Sep 2005 10:38:04 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
In-Reply-To: <20050908050232.3681cf0c.pj@sgi.com>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	<20050908002323.181fd7d5.pj@sgi.com>
	<20050908081819.2EA4E70031@sv1.valinux.co.jp>
	<20050908050232.3681cf0c.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050909013804.1B64B70037@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005 05:02:32 -0700
Paul Jackson <pj@sgi.com> wrote:

> These subcpusets, if I understand correctly, are a bit different
> from ordinary cpusets.  For instance, it seems one cannot make child
> cpusets of them, and one cannot change most of their properties,
> such as cpus, mems, cpu_exclusive, mem_exclusive, or notify_on_release.
> 
> Also the mems and cpus of each subcpuset are required to be
> exactly equal to the corresponding values of its parent.

That's right.

> One of my passions is to avoid special cases across API boundaries.
> 
> I am proposing that you don't do subcpusets like this.
> 
> Consider the following alternative I will call 'cpuset meters'.
> 
> For each resource named 'R' (cpu and mem, for instance):
>  * Add a boolean flag 'meter_R' to each cpuset.  If set, that R is
>    metered, for the tasks in that cpuset or any descendent cpuset.
>  * If a cpuset is metered, then files named meter_R_guar, meter_R_lim
>    and meter_R_cur appear in that cpuset to manage R's usage by tasks
>    in that cpuset and descendents.
>  * There are no additional rules that restrict the ability to change
>    various other cpuset properties such as cpus, mems, cpu_exclusive,
>    mem_exclusive, or notify_on_release, when a cpuset is metered.
>  * It might be that some (or by design all) resource controllers do
>    not allow nesting metered cpusets.  I don't know.  But one should
>    (if one has permission) be able to make child cpusets of a metered
>    cpuset, just like one can of any other cpuset.
>  * A metered cpuset might well have cpus or mems that are not the
>    same as its parent, just like an unmetered cpuset ordinarly does.

Jackson-san's idea looks good for me because users don't need
to create special cpusets (parents of subcpusets or subcpusets).
>From the point of users, maybe they wouldn't like to create 
special cpusets.

As for the resource controller that I've posted, it assumes
that there are groups of tasks that share the same cpumasks/nodemasks,
and that there are no hierarchy in that groups in order to make
things easier.  I'll investigate how I can attach the resource
controller to the cpuset meters.

> If I understand correctly, one could place a job that managed its
> own child cpusets into a metered cpuset, but not into a subcpuset.
> Even if you wanted to allow it, it seems jobs in subcpusets cannot
> make child cpusets or modify the properties of their current cpuset.
> Is that correct?

Correct.  Subcpusets can't make child cpusets, and they don't have
cpumask/nodemask properties actually.  Properties like cpumasks/nodemask 
of subcpusets are the same as their parent and subcpusets can't modify
those properties.

Thanks,

KUROSAWA, Takahiro
