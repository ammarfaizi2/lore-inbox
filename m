Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268975AbUIHCcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268975AbUIHCcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268977AbUIHCcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:32:39 -0400
Received: from mail-09.iinet.net.au ([203.59.3.41]:35298 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S268975AbUIHCce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:32:34 -0400
Message-ID: <413E6C49.5080106@cyberone.com.au>
Date: Wed, 08 Sep 2004 12:19:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <nathanl@austin.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/2] cpu hotplug notifier for updating sched domains
References: <200409071849.i87Inw3f143238@austin.ibm.com>	 <413E55D8.8030608@cyberone.com.au> <1094608996.8015.5.camel@booger>
In-Reply-To: <1094608996.8015.5.camel@booger>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nathan Lynch wrote:

>On Tue, 2004-09-07 at 19:44, Nick Piggin wrote:
>
>>I think the next step is to now make the setup code only use cpu_online_map
>>

^^^ OK I see you've already done that. Sorry I should have looked at the
patches a bit closer. Your implementation looks very nice.

>>and get rid of everywhere I had been doing cpus_and(tmp, ..., 
>>cpu_online_map).
>>

^^^ This should still be done, of course. That can come later.

>>This may also make your patch 1/2 unnecessary? What do you think?
>>
>
>Well, we have to "lie" to arch_init_sched_domains a little bit when
>bringing a cpu online, by setting the soon-to-be-online cpu's bit in the
>argument mask.  So I think the first patch is still necessary.
>
>

Can't we do everything in the CPU_UP_ONLINE case though?


One other thing:

void __init sched_init_smp(void)
 {
+	lock_cpu_hotplug();
 	arch_init_sched_domains(cpu_online_map);
 	sched_domain_debug();
+	unlock_cpu_hotplug();
+
+	hotcpu_notifier(update_sched_domains, 0);
 }

Do you have a theoretical race here? Can we hotplug a CPU before the notifier
is registered? (I know we *can't* because it is still earlyish boot).

Can you move hotcpu_notifier under the cpu_hotplug lock? Seems not because
register_cpu_notifier takes the lock itself. Seems like a flaw in the API to
me. Probably the notifier chain should be protected by a lock that nests
inside the cpucontrol lock. Rusty?


