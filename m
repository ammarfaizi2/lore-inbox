Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWHJJU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWHJJU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWHJJU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:20:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751482AbWHJJU0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:20:26 -0400
Date: Thu, 10 Aug 2006 02:19:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 - OOM storm
Message-Id: <20060810021957.38c82311.akpm@osdl.org>
In-Reply-To: <44DAF6A4.9000004@free.fr>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<44DAF6A4.9000004@free.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 11:04:36 +0200
Laurent Riffard <laurent.riffard@free.fr> wrote:

> Le 06.08.2006 12:08, Andrew Morton a écrit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/26.18-rc3-mm2/
> 
> Hello,
> 
> On my system, a cron runs every day to check the integrity of
> installed RPMS, it runs "rpm -v" on each package, which computes
> MD5 hash for each installed file and compares this result, the file 
> size and modification time with values stored in RPM database.
> 
> This is the workload. Since 2.6.18-rc3-mm2, this processus eats 
> all the memory and triggers OOM.
> 
> On my system, "free -t" output normally looks like this ("cached" value 
> is about half of RAM):
> # free -t 
>              total       used       free     shared    buffers     cached
> Mem:        515032     508512       6520          0      22992     256032
> -/+ buffers/cache:     229488     285544
> Swap:      1116428        324    1116104
> Total:     1631460     508836    1122624
> 
> After the rpm database check, "free -t" says:
>              total       used       free     shared    buffers     cached
> Mem:        515032     507124       7908          0       8132     398296
> -/+ buffers/cache:     100696     414336
> Swap:      1116428      34896    1081532
> Total:     1631460     542020    1089440
> 
> And the value of "cached" won't decrease.
> 

Yes, I was just trying to reproduce this.  No luck so far.  Will try your
.config tomorrow.

It would be interesting to try disabling CONFIG_ADAPTIVE_READAHEAD -
perhaps that got broken.

Also, are you able to determine whether the problem is specific to `rpm
-V'?  Are you able to make the leak trigger using other filesystem
workloads?

If it's specific to `rpm -V' then perhaps direct-io is somehow causing
pagecache leakage.  That would be a bit odd.



btw, it's not necessary to go all the way to oom to work out if the
pagecache leak is happening.  After booting, do

	echo 3 > /proc/sys/vm/drop_pagecache

and record the `Cached' figure in /proc/meminfo.  After running some test,
run `echo 3 > /proc/sys/vm/drop_pagecache' again and check
/proc/meminfo:Cached.  If it dodn't do gown to a similarly low figure,
we're leaking pagecache.

btw2: please use /proc/meminfo output rather than free(1).  Because free(1)
shows less info, and it does mysterious mangling of the info which it does
read in ways which confuse me.

Thanks.

