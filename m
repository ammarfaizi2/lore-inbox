Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUGPNs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUGPNs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUGPNs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:48:28 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:21876 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266339AbUGPNs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:48:26 -0400
Message-ID: <40F7DCA6.6030804@yahoo.com.au>
Date: Fri, 16 Jul 2004 23:48:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: trini@kernel.crashing.org, akpm@osdl.org, jhf@rivenstone.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm1 "Badness in schedule" on ppc32
References: <200407161338.i6GDcLoN013486@harpo.it.uu.se>
In-Reply-To: <200407161338.i6GDcLoN013486@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Thu, 15 Jul 2004 13:27:05 -0700, Tom Rini wrote:

[ much needed cutting ]

>>On x86, could you force the PDC202XX_NEW to dump_stack in the function
>>in question?  Perhaps there's a calling order issue on ppc.  Thanks.
> 
> 
> I hacked pdc202xx_init_one() to dump_stack(), and upped ppc's
> log buffer size to capture all badness messages. The ppc boot
> log is a bit large, so I put both the ppc and x86 logs in
> <http://www.csd.uu.se/~mikpe/linux/2.6.8-rc1-mm1-scheduler-badness/>.
> 
> All badness calls appear to emanate from sleeps/waits in init code
> called from init/main.c:init(), which itself runs in a kernel thread.
> It seems extremely fishy that the kernel considers the scheduler
> off-limits even though threads have been created and started.
> 
> The init thread is itself created in init/main.c:rest_init():
> 
>>static void noinline rest_init(void)
>>{
>>	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
>>	numa_default_policy();
>>	system_state = SYSTEM_BOOTING_SCHEDULER_OK;
>>	unlock_kernel();
>>	cpu_idle();
>>} 
> 
> system_state is changed only after the init thread is created.
> Unless kernel_thread guarantees some execution ordering between
> parent and child, I don't see how this could be race-free.
> 
> But I also don't see why ppc and x86 behave so differently here.
> 

You must have missed my mail to the linuxppc list.

sched-clean-init-idle (which is in -mm) has the following hunk to
schedule() which should catch all unsafe calls to it, I think.

+    /*
+     * The idle thread is not allowed to schedule!
+     * Remove this check after it has been exercised a bit.
+     */
+    if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
+        printk(KERN_ERR "bad: scheduling from the idle thread!\n");
+        dump_stack();
+    }
+

So the system_state patch can be dropped.

