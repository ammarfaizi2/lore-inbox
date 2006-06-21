Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWFURjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWFURjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWFURjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:39:05 -0400
Received: from dlx132.neoplus.adsl.tpnet.pl ([83.24.53.132]:46061 "EHLO
	unknown.box") by vger.kernel.org with ESMTP id S932293AbWFURjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:39:01 -0400
Message-ID: <44998432.4070002@o2.pl>
Date: Wed, 21 Jun 2006 19:38:58 +0200
From: Artur Skawina <art_k@o2.pl>
User-Agent: Mail/News 3.0a1 (X11/20060416)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
References: <200606210329_MC3-1-C305-E008@compuserve.com> <20060621081539.GA14227@elte.hu>
In-Reply-To: <20060621081539.GA14227@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
>> Use a GDT entry's limit field to store per-cpu data for fast access 
>> from userspace, and provide a vsyscall to access the current CPU 
>> number stored there.
> 
> very nice idea! I thought of doing sys_get_cpu() too, but my idea was to 
> use the scheduler to keep a writable [and permanently pinned, 
> per-thread] VDSO data page uptodate with the current CPU# [and other 
> interesting data]. Btw., do we know how fast LSL is on modern CPUs?

a quick check on two p2/p4 boxes gives the cycle numbers below. syscall/io times for comparison.
Not that cheap, but still only ~1/4 of a syscall...

 P4   P2
 123  39  {movl $-47,%%eax ; movl $((27<<3)|3),%%edx ; lsll %%edx,%%eax ; jnz 1f ; andl $0xff,%%eax ; 1: ;}  (average: 155)

 959  287 {movl $20,%%eax ; int $0x80 ; # getpid() }  (average: 983)
 475  153 {movl $20,%%eax ; call *vsyscall ; # getpid() }  (average: 519)

 333  586 {outb %%al,$0x80;}  (average: 369)
3572  1181 {outb %%al,$0x80;outb %%al,$0x80;}  (average: 3628)
6755  1557 {outb %%al,$0x80;outb %%al,$0x80;outb %%al,$0x80;}  (average: 6866)

P2:
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.982
cache size      : 512 KB

P4:
cpu family      : 15
model           : 4
model name      : Intel(R) Celeron(R) CPU 2.53GHz
stepping        : 1
cpu MHz         : 2533.270
cache size      : 256 KB
