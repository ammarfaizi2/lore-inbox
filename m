Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUH2TBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUH2TBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUH2TBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:01:42 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:60875 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S268265AbUH2TBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:01:38 -0400
Date: Sun, 29 Aug 2004 21:00:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829190050.GA31641@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829181627.GR5492@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 11:16:27 -0700, William Lee Irwin III wrote:
> On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:
> > I am confident that this problem (as far as process monitoring is
> > concerned) could be addressed with differential notification.
> 
> I'm a bit squeamish about that given that mmlist_lock and tasklist_lock
> are both problematic and yet another global structure to fiddle with in
> the process creation and destruction path threatens similar trouble.

The numbers looks so bad that for many cases it's going to be a
significant win if we simply call nproc_send_note in said paths. But
I'll admit that I've been entertaining thoughts about a global queue
or something to send notifications in batches.

> Also, what guarantee is there that the notification events come
> sufficiently slowly for a single task to process, particularly when that
> task may not have a whole cpu's resources to marshal to the task?

A more likely guarantee is that a process that can't keep up with
differential updates won't be able to process the whole list, either.
Well, unless the system is loaded with tons of short-lived processes
that wouldn't even make the full process list by the time it's pulled.
But in such a case, a complete list of task won't do you much good,
either, because by the time you are ready to query the kernel for
details the tasks are gone.

> Queueing them sounds less than ideal due to resource consumption, and
> if notifications are dropped most of the efficiency gains are lost. So
> I question that a bit.

Point. Task discovery is not an exact science anyway, though.

I'd still expect differential notification to be useful in most
non-pathological cases, but I concede it's nowhere as clear-cut as
nproc per se is.

> I have a vague notion that userspace should intelligently schedule
> inquiries so requests are made at a rate the app can process and so
> that the app doesn't consume excessive amounts of cpu. In such an
> arrangement screen refresh events don't trigger a full scan of the
> tasklist, but rather only an incremental partial rescan of it, whose
> work is limited for the above cpu bandwidth concerns.

While I'm not sure I understand how that partial rescan (or its limits)
would be defined, I agree with the general idea. There is indeed plenty
of room for improvement in a smart user space. For instance, most apps
show only the top n processes. So if an app shows the top 20 memory
users, it could use nproc to get a complete list of pid+vmrss, and then
request all the expensive fields only for the top 20 in that list.

> On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:
> > I'd much rather remove unnecessary overhead than optimize code for
> > overhead processing. Note that number() takes out 7% and that's the
> > _kernel_ printing numbers for user space to parse back. And __d_lookup
> > is another /proc souvenir you get to keep as long as you use /proc.
> 
> I'm expecting very very long lifetimes for legacy kernel versions and
> userspace predating the merge of nproc, so it's not entirely irrelevant,
> though backports aren't exactly something I relish.

Uhm... Optimized string parsing would require updated user space
anyway. OTOH, I can buy the legacy kernel argument, so if you want to
rewrite the user space tools, go wild :-). You may find that there are
issues more serious than string parsing:

$ ps --version
procps version 3.2.3
$ ps -o pid
  PID
 2089
 2139
$ strace ps -o pid 2>&1|grep 'open("/proc/'|wc -l
325

<whine>

> On Sun, Aug 29, 2004 at 07:52:45PM +0200, Roger Luethi wrote:
> > Well __task_mem is promiment here because I don't call other computation
> > functions. vmstat ain't cheap, and wchan is horribly expensive if the
> > kernel does the ksym translation. Etc. pp.
> 
> task_mem() is generally prominent when the processes have large numbers
> of vmas, and also due to acquisition of ->mmap_sem.

Makes sense. I just wanted to make sure I wasn't misleading you.

Roger
