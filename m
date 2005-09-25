Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVIYHir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVIYHir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 03:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVIYHir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 03:38:47 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:52880 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751230AbVIYHiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 03:38:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AhmUTSFFCLYpe2H7RnBNcCFkut5/94I0aclHovxToA93vwnXxaHpeWfob5AEgwrMmtFpiHm63Ivx/DA2uMxfewlz/yKEcclPXHZ7lE9PrjlbYENDbWusbKrcZtkWMnRIb2puMhpScqq0PjgZdFkYjw3Y0vOLbjjav2MdEnyN7LQ=  ;
Message-ID: <4336542D.4000102@yahoo.com.au>
Date: Sun, 25 Sep 2005 17:39:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: zwane@linuxpower.ca, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6 04/04] brsem: convert cpucontrol to brsem
References: <20050925064218.E7558977@htj.dyndns.org> <20050925064218.642A9DFD@htj.dyndns.org>
In-Reply-To: <20050925064218.642A9DFD@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

> +/*
> + * cpucontrol is a brsem used to synchronize cpu hotplug events.
> + * Invoking lock_cpu_hotplug() read-locks cpucontrol and no
> + * hotplugging events will occur until it's released.
> + *
> + * Unfortunately, brsem itself makes use of lock_cpu_hotplug() and
> + * performing brsem write-lock operations on cpucontrol deadlocks.
> + * This is avoided by...
> + *
> + * a. guaranteeing that cpu hotplug events won't occur during the
> + *    write-lock operations, and
> + *
> + * b. skipping lock_cpu_hotplug() inside brsem.
> + *
> + * #a is achieved by acquiring and releasing cpucontrol_mutex outside
> + * cpucontrol write-lock.  #b is achieved by skipping
> + * lock_cpu_hotplug() inside brsem if the current task is
> + * cpucontrol_mutex holder (is_cpu_hotplug_holder() test).
> + *
> + * Also, note that cpucontrol is first initialized with
> + * BRSEM_BYPASS_INITIALIZER and then initialized again with
> + * __create_brsem() instead of simply using create_brsem().  This is
> + * necessary as cpucontrol brsem gets used way before brsem subsystem
> + * becomes up and running.
> + *
> + * Until brsem is properly initialized, all brsem ops succeed
> + * unconditionally.  cpucontrol becomes operational only after
> + * cpucontrol_init() is finished, which should be called after
> + * brsem_init_early().
> + */

Mmm, this is just insane IMO.

Note that I happen to also think the idea (brsems) have merit, and
that cpucontrol may be one of the places where a sane implementation
would actually be useful... but at least when you're introducing
this kind of complexity anywhere, you *really* need to be able to
back it up with numbers.

As far as the VFS race fix goes, I guess Al or someone else will
comment on its correctness. But I think it might be nicer to first
fix it with a regular rwsem and then show some numbers to justify
its conversion to a brsem.

If you need interruptible rwsems, I almost got an implementation
working a while back, and David Howells recently said he was
interested in doing them... so that's not an impossibility.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
