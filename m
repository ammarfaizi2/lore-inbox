Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVLTOdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVLTOdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVLTOdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:33:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:17333 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751086AbVLTOdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:33:53 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 09:33:41 -0500
Message-Id: <1135089221.13138.269.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 09:04 -0500, Steven Rostedt wrote:

> 
> Actually, no.  My test is to do a make install over NFS of a kernel that
> has already been built.
> 
> The times I'm getting for the SLAB is ~26 seconds, the time for the SLOB
> is 1 minute 32 seconds.  So your looking at >300% slowness here.  The test
> bed is a UP.  (I do that first before looking into SMP).
> 
> I'm still trying to keep the SLOB simple.  It's the lack of sleep that is
> making it hard ;)
> 

Amazing what you see after a few hours of sleep.  My bug that I was
looking for all yesterday happened to be a < when it should have been a
<=.

OK, it boots and runs. Now I just need to clean it up and prepare to
ship!  My test which is simply to run make install on a prebuilt kernel
over NFS.  The test box is:

bert:/home/rostedt/work/ernie/linux-2.6.15-rc5-rt2# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 736.045
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1472.74

The box where the kernel is NFS mounted is running the 2.6.15-rc4:

rostedt@gandalf:~/work/ernie/linux-2.6.15-rc5-rt2$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 43
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
stepping        : 1
cpu MHz         : 2210.221
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4424.61
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 43
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
stepping        : 1
cpu MHz         : 2210.221
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4419.74
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp



Here's the times for "time make install":  Three runs for each.

rt with slab:

run 1:
  real    0m27.327s
  user    0m15.151s
  sys     0m3.149s

run 2:
  real    0m26.952s
  user    0m15.171s
  sys     0m3.178s

run 3:
  real    0m27.269s
  user    0m15.175s
  sys     0m3.226s

rt with slob (plain):

run 1:
  real    1m26.845s
  user    0m16.173s
  sys     0m29.558s

run 2:
  real    1m27.895s
  user    0m16.532s
  sys     0m30.460s

run 3:
  real    1m25.645s
  user    0m16.468s
  sys     0m30.973s

rt with slob (new):

run 1:
  real    0m28.740s
  user    0m15.364s
  sys     0m3.866s

run 2:
  real    0m27.782s
  user    0m15.409s
  sys     0m3.885s

run 3:
  real    0m27.576s
  user    0m15.193s
  sys     0m3.933s

As you see, the new SLOB code runs almost as fast as the SLAB code.
With some more improvements, I'm sure it can get even faster.

I'll send out the patch real soon (after I wash and dry it).

Note: After I send out the patch, I'll give it a try on SMP.

-- Steve


