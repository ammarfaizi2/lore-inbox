Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbTCPJIw>; Sun, 16 Mar 2003 04:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbTCPJIw>; Sun, 16 Mar 2003 04:08:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:34321 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262633AbTCPJIv>;
	Sun, 16 Mar 2003 04:08:51 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1 
In-reply-to: Your message of "Sun, 16 Mar 2003 00:36:09 -0800."
             <20030316083609.GE20188@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Mar 2003 20:19:31 +1100
Message-ID: <16504.1047806371@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 00:36:09 -0800, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Mon, 10 Mar 2003 20:24:57 -0800, William Lee Irwin III wrote:
>>> Enable NUMA-Q's to run with more than 32 cpus by introducing a bitmap
>> Any main line code that explicitly refers to cpu_online_map is an
>> ongoing maintenance problem.  Nothing should refer to cpu_online_map
>> except the encapsulating macros such as cpu_online().
>
>That was a bit too braindead of a translation, yes. But it is x86 arch
>code so it shouldn't be that large of an issue for big MIPS boxen etc.
>I'll search & replace for stuff of this kind and wipe it out anyway.

Good, it lets us optimize for 1/32/64/lots of cpus.  NR_CPUS > 8 *
sizeof(unsigned long) is the interesting case, it needs arrays.

>This suggests a "cpumask strategy". Care to share more, like your take
>on such things as
>	p = req->task;
>	cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
>	rq_dest = cpu_rq(cpu_dest);
>in kernel/sched.c?

That definitely needs encapsulation to handle cpus_allowed etc. being
arrays.  A function to generate the logical and of p->cpus_allowed and
cpu_online_map and return cpumask_t * is easy.  Doing ffs on that
result will not work, it assumes NR_CPUS fits in a word.  Add
ffs_cpumask(cpumask_t *).

