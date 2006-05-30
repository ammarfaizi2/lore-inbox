Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWE3FwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWE3FwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWE3FwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:52:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:32024 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932075AbWE3FwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:52:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r5040ctOoVBfl4qz9xbwevQSLz8Fr5HMtLvtm2lRFCPdbrJHZfJ2TABOH7HewIbZQciCkk2Cve6U+twrikSB+Za0263Med9/zjxpG5xaryltwYTMSozE7P2vpF0L3/0KnIpAcTDW555Iyh931eQq22QRN5RcRuUkIr5ObpjUzwg=
Message-ID: <6bffcb0e0605292252y2b04f76agff7043dfd3c805e0@mail.gmail.com>
Date: Tue, 30 May 2006 07:52:15 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
In-Reply-To: <20060529230908.GC333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060529212109.GA2058@elte.hu>
	 <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
	 <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/05/06, Dave Jones <davej@redhat.com> wrote:
> On Tue, May 30, 2006 at 12:41:08AM +0200, Ingo Molnar wrote:
>
>  > > =====================================================
>  > > [ BUG: possible circular locking deadlock detected! ]
>  > > -----------------------------------------------------
>  > > modprobe/1942 is trying to acquire lock:
>  > > (&anon_vma->lock){--..}, at: [<c10609cf>] anon_vma_link+0x1d/0xc9
>  > >
>  > > but task is already holding lock:
>  > > (&mm->mmap_sem/1){--..}, at: [<c101e5a0>] copy_process+0xbc6/0x1519
>  > >
>  > > which lock already depends on the new lock,
>  > > which could lead to circular deadlocks!
>  >
>  > hm, this one could perhaps be a real bug. Dave: lockdep complains about
>  > having observed:
>  >
>  >      anon_vma->lock  =>   mm->mmap_sem
>  >      mm->mmap_sem    =>   anon_vma->lock
>  >
>  > locking sequences, in the cpufreq code. Is there some special runtime
>  > behavior that still makes this safe, or is it a real bug?
>
> I'm feeling a bit overwhelmed by the voluminous output of this checker.
> Especially as (directly at least) cpufreq doesn't touch vma's, or mmap's.
>
> The first stack trace it shows has us down in the bowels of cpu hotplug,
> where we're taking the cpucontrol sem.  The second stack trace shows
> us in cpufreq_update_policy taking a per-cpu data->lock semaphore.
>
> Now, I notice this is modprobe triggering this, and this *looks* like
> we're loading two modules simultaneously (the first trace is from a
> scaling driver like powernow-k8 or the like, whilst the second trace
> is from cpufreq-stats).

/etc/init.d/cpuspeed starts very early
$ ls /etc/rc5.d/ | grep cpu
S06cpuspeed

I have this in my /etc/rc.local
modprobe -i cpufreq_conservative
modprobe -i cpufreq_ondemand
modprobe -i cpufreq_powersave
modprobe -i cpufreq_stats
modprobe -i cpufreq_userspace
modprobe -i freq_table

>
> How on earth did we get into this situation?

Just before gdm starts, while /etc/rc.local is processed.

> module loading is supposed
> to be serialised on the module_mutex no ?
>
> It's been a while since a debug patch has sent me in search of paracetamol ;)
>
>                 Dave

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
