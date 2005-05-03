Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVECOGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVECOGC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVECOGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:06:02 -0400
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:48290 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261562AbVECOFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:05:50 -0400
Message-ID: <42778532.7090806@lifl.fr>
Date: Tue, 03 May 2005 16:05:38 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Philippe Marquet <Philippe.Marquet@lifl.fr>, "Christophe Osuna"@lifl.fr,
       Christophe.Osuna@lifl.fr, Julien Soula <soula@lifl.fr>,
       Jean-Luc Dekeyser <dekeyser@lifl.fr>, paul.mckenney@us.ibm.com
Subject: [0/3] ARTiS, an asymmetric real-time scheduler
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to present "ARTiS", a research project that we developed at the
LIFL, within the HYADES project. The goal was to provide a system which
can be hard real-time and in the same time permit high performance
computing.

The main idea of our approach is to insert asymmetry into an SMP
computer. While the several processors allows us to get HPC, the
asymmetry provides real-time capabilities. In order to guarantee that
the RT tasks can always be scheduled with a low latency, we forbid _all_
the other tasks to take a lock or disable the preemption on some
specified CPUs. Basically, there is a set of "RT CPUs" and a set of
"Non-RT CPUs". When a normal task is executed on a RT CPU and happen to
call either inc_preempt_count() or __local_irq_save(), then it is
automatically migrated to a Non-RT CPU, where the syscall will be
continued. Still, the RT CPUs can execute all computation from any task.
For more detailed description, please have a look at the research papers
available at http://www.lifl.fr/west/artis .

So we currently have an implementation for kernel 2.6.11, available on
the x86 and IA-64 architectures. It's a proof of concept with rough
edges. Even after the code clean-up, I guess some people will scream
when looking at the code, it's not the most beautiful one ever done.
Nevertheless, it works. When ARTiS is activated your system shouldn't
crash more often than usual and tasks scheduled FIFO with priority 99
will get much better latencies than before.

The modifications are mostly situated in the scheduler. The migration
from an RT CPU to a Non-RT CPU is done asynchronously (there is a
special queue which can be read/write without lock). There is also a big
part which tries to enhance the load-balancer wrt the RT and to the
asymmetry. Following to this email, there will be the core patch as well
as the patches for architecture dependent parts (which are rather small).

It worth noting that even if ARTiS was designed for SMP systems, it
works also on a SMT processor (although it seems that for now it's
better not to select the SMT additions to avoid crash). It has been
tested on Pentium HyperThreaded. Then ARTiS can be seen more like just a
firm (or hard if you have hopes) real-time patch that works with any
tasks written for Linux.

The latency measurements which have been conducted on a quadri-processor
IA-64 give results of scheduling always under 105µs instead of 1200µs
for a preemptible kernel. On a Pentium 4 HT, latencies are always under
40µs instead of 14000µs. The measurement tool (realfeel-pfm) that we 
used is available for both x86 and IA-64 architectures. On the latter 
one there is an additional measure of the "kernel latency" which is 
quite interesting too.

In addition, a load-balancer evaluator, lbµ is also available. It's
completely architecture independent but don't hope too much from it, it
just let you always run the same load on the system and collect some
statistic. Apart from this, all needs to be done by the user.

If you want to try it, have a look first at the documentation available
in Documentation/artis.txt . There is also information available on the
research project webpage http://www.lifl.fr/west/artis while you can
follow the development at this page: https://gna.org/projects/artis .

We hope that some people can find interest on this project. Any remark
or comment is very welcome,
Eric Piel


