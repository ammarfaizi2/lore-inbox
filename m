Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVJFM62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVJFM62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVJFM62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:58:28 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:19856 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750856AbVJFM6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:58:21 -0400
Message-ID: <434520FF.8050100@sw.ru>
Date: Thu, 06 Oct 2005 17:05:03 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       "Andrey Savochkin" <saw@sawoct.com>, st@sw.ru
Subject: SMP syncronization on AMD processors (broken?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Andrew and others,

Please help with a not simple question about spin_lock/spin_unlock on 
SMP archs. The question is whether concurrent spin_lock()'s should 
acquire it in more or less "fair" fashinon or one of CPUs can starve any 
arbitrary time while others do reacquire it in a loop.

The question raised because the situation we observe on AMD processors 
is really strange and makes us believe that something is wrong in 
kerne/in processor or our minds. Below goes an explanation:

The whole story started when we wrote the following code:

void XXX(void)
{
	/* ints disabled */
restart:
	spin_lock(&lock);
	do_something();
	if (!flag)
		need_restart = 1;
	spin_unlock(&lock);
	if (need_restart)
		goto restart;	<<<< LOOPS 4EVER ON AMD!!!
}

void YYY(void)
{
	spin_lock(&lock);	<<<< SPINS 4EVER ON AMD!!!
	flag = 1;
	spin_unlock(&lock);
}

function XXX() starts on CPU0 and begins to loop since flag is not set, 
then CPU1 calls function YYY() and it turns out that it can't take the 
lock any arbitrary time.

Other observations:
- This does not happen on Intel processors, more over on Intel 2 CPUs 
take locks in a fair manner, exactly one by one!
- If do_something() = usleep(3) we observed that XXX() loops forever, 
while YYY spins 4EVER on the same lock...
- cpu_relax() doesn't help after spin_unlock()...
- wbinvd() after spin_unlock() helpes and 2 CPUs began to take the lock 
in a fair manner.

How can this happen? Is it regulated somehow by SMP specifications?

Kirill
P.S. Below is provided /proc/cpuinfo of machines affected.

-----------------------------------------------------------------------------

[root@ts25 ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2
cpu MHz         : 2010.433
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext lm 
3dnowext 3dnow pni
bogomips        : 3981.31

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2
cpu MHz         : 2010.433
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext lm 
3dnowext 3dnow pni
bogomips        : 3964.92

-----------------------------------------------------------------------------

[root@opteron root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 1992.595
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow
bogomips        : 3915.77

