Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWBPQLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWBPQLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWBPQLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:11:41 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:55722 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932307AbWBPQLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:11:40 -0500
Message-ID: <43F4A432.8070308@cosmosbay.com>
Date: Thu, 16 Feb 2006 17:11:30 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Fix file counting
References: <20060216153301.GA1352@in.ibm.com>
In-Reply-To: <20060216153301.GA1352@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 16 Feb 2006 17:11:30 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> Eric,
> 
> Going by your patch, I converted my nr-files patch to use
> percpu counters - except that I just used the existing
> percpu counter code. This patch is untested, just for comments.
> If you agree with the approach, we can go with it. I will
> get some benchmark numbers measured on a 16-CPU box.
> 
> Thanks
> Dipankar
> 
> 
> 
> The way we do file struct accounting is not very suitable for batched
> freeing. For scalability reasons, file accounting was constructor/destructor
> based. This meant that nr_files was decremented only when
> the object was removed from the slab cache. This is
> susceptible to slab fragmentation. With RCU based file structure,
> consequent batched freeing and a test program like Serge's,
> we just speed this up and end up with a very fragmented slab -
> 
> llm22:~ # cat /proc/sys/fs/file-nr
> 587730  0       758844
> 
> At the same time, I see only a 2000+ objects in filp cache.
> The following patch I fixes this problem. 
> 
> This patch changes the file counting by removing the filp_count_lock.
> Instead we use a separate percpu counter, nr_files, for now and all
> accesses to it are through get_nr_files() api. In the sysctl
> handler for nr_files, we populate files_stat.nr_files before returning
> to user.
> 
> Counting files as an when they are created and destroyed (as opposed
> to inside slab) allows us to correctly count open files with RCU.
> 
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> ---
> 
> 
> 
> 
>  fs/dcache.c          |    2 -
>  fs/file_table.c      |   80 +++++++++++++++++++++++++++++++--------------------
>  include/linux/file.h |    2 -
>  include/linux/fs.h   |    2 +
>  kernel/sysctl.c      |    5 ++-
>  net/unix/af_unix.c   |    2 -
>  6 files changed, 57 insertions(+), 36 deletions(-)
> 

Hi Dipankar

I believe your patch is good.

However there is a bug in get_empty_filp() :

if security_file_alloc(f) returns TRUE : The goto fail_sec;  is done and 
fail_sec: does a file_free(f)

This means an extra percpu_counter_mod(&nr_files, -1L); will be done.

So I think you must apply this patch too :

  fail_sec:
-	file_free(f);
+	kmem_cache_free(filp_cachep, f);
  fail:
  	return NULL;


(Ie no need for a delayed free done via rcu here, just a direct 
kmem_cache_free() call)

Eric
