Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUGSHbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUGSHbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 03:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUGSHbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 03:31:42 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:20620 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264770AbUGSHbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 03:31:40 -0400
Message-ID: <40FB78D5.1070604@yahoo.com.au>
Date: Mon, 19 Jul 2004 17:31:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
CC: Dave Hansen <haveblue@us.ibm.com>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sched domains bringup race?
References: <1089944026.32312.47.camel@nighthawk> <20040718134559.A25488@unix-os.sc.intel.com>
In-Reply-To: <20040718134559.A25488@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S wrote:
> On Thu, Jul 15, 2004 at 07:13:46PM -0700, Dave Hansen wrote:
> 
>>I keep getting oopses for the non-boot CPU in find_busiest_group(). 
>>This occurs the first time that the CPU goes idle.  Those groups are set
>>up in sched_init_smp(), which is called after smp_init():
>>
>>static int init(void * unused)
>>{
>>	...
>>        fixup_cpu_present_map();
>>        smp_init();
>>        sched_init_smp();
>>
>>But, the idle threads for the secondary CPUs are initialized in
>>smp_init().  So, what happens when a CPU tries to schedule (using sched
>>domains) before sched_init_smp() completes?  I think it goes boom! :)
>>
>>Anyway, I was thinking that we should just hold the runqueue lock on the
>>non-boot CPUs until the sched domain init code is done.  Does that sound
>>feasible?
> 
> 
> Even on my system which is Intel 865 chipset (P4 with HT enabled system) 
> I see a bug check somewhere in the schedular_tick during boot.
> However if I move the sched_init_smp() after do_basic_setup() the
> kernel boots without any problem. Any clue here?
> 
>  static int init(void * unused)
>  {
>  	...
>          fixup_cpu_present_map();
>          smp_init();
> 	 populate_rootfs();
> 	 do_basic_setup();
>  
>          sched_init_smp();

There shouldn't be any problem doing that if we have to, obviously we
need to know why. Is it possible that cpu_sibling_map, or one of the
CPU masks isn't set up correctly at the time of the call?
