Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUGPNil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUGPNil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUGPNil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:38:41 -0400
Received: from aun.it.uu.se ([130.238.12.36]:2501 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266482AbUGPNih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:38:37 -0400
Date: Fri, 16 Jul 2004 15:38:21 +0200 (MEST)
Message-Id: <200407161338.i6GDcLoN013486@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: trini@kernel.crashing.org
Subject: Re: 2.6.8-rc1-mm1 "Badness in schedule" on ppc32
Cc: akpm@osdl.org, jhf@rivenstone.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004 13:27:05 -0700, Tom Rini wrote:
>On Thu, Jul 15, 2004 at 09:08:27PM +0200, Mikael Pettersson wrote:
>
>> On Thu, 15 Jul 2004 02:00:01 +0200 (MEST), Mikael Pettersson wrote:
>> >On 2004-07-14 22:01:50, Tom Rini wrote:
>> >>On Fri, Jul 09, 2004 at 02:11:03PM -0700, Andrew Morton wrote:
>> >>
>> >>> 
>> >>> jhf@rivenstone.net (Joseph Fannin) wrote:
>> >>> > 
>> >>> > On Thu, Jul 08, 2004 at 11:50:25PM -0700, Andrew Morton wrote:
>> >>> > > 
>> >>> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
>> >>> > 
>> >>> > > +detect-too-early-schedule-attempts.patch
>> >>> > > 
>> >>> > > Catch attempts to call the scheduler before it is ready to go.
>> >>> > 
>> >>> > With this patch, my Powermac (ppc32) spews 711 (I think)
>> >>> > warning messages during bootup.
>> >>> 
>> >>> hm, OK.  It could be that the debug patch is a bit too aggressive, or that
>> >>> ppc got lucky and happens to always be in state TASK_RUNNING when these
>> >>> calls to schedule() occur.
>> >>> 
>> >>> Maybe this task incorrectly has _TIF_NEED_RESCHED set?
>> >>> 
>> >>> Anyway, ppc guys: please take a look at the results from
>> >>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken \
>> >>> -out/detect-too-early-schedule-attempts.patch and check that the kernel really \
>> >>> should be calling schedule() at this time and place, let us know?
>> >>
>> >>Now that kallsyms data is OK, I took a quick look.. and all of this
>> >>comes from generic code, at least on the machine I tried.  So if the
>> >>code shouldn't be calling schedule() then, it's a more generic problem..
>> >>
>> >>... or I'm not following.
>> >
>> >On my ppc32 (G3 PowerMac) 2.6.8-rc1-mm1 throws a large number of
>> >"Badness in schedule" during boot. Below are the ones I managed
>> >to capture: they contain both generic traces, and traces involving
>> >Mac-only drivers.
>> >
>> >Some of the traces involve the PDC202XX_NEW driver; I'll move that
>> >card into an x86 PC tomorrow to see if the traces reappear or not;
>> >if they don't then it does look like a PPC32-specific problem.
>> 
>> Tried that now but I've been unable to trigger any
>> "Badness in schedule" messages on the x86 box.
>> Looks like PPC32 has a problem in -mm.
>
>On x86, could you force the PDC202XX_NEW to dump_stack in the function
>in question?  Perhaps there's a calling order issue on ppc.  Thanks.

I hacked pdc202xx_init_one() to dump_stack(), and upped ppc's
log buffer size to capture all badness messages. The ppc boot
log is a bit large, so I put both the ppc and x86 logs in
<http://www.csd.uu.se/~mikpe/linux/2.6.8-rc1-mm1-scheduler-badness/>.

All badness calls appear to emanate from sleeps/waits in init code
called from init/main.c:init(), which itself runs in a kernel thread.
It seems extremely fishy that the kernel considers the scheduler
off-limits even though threads have been created and started.

The init thread is itself created in init/main.c:rest_init():
>static void noinline rest_init(void)
>{
>	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
>	numa_default_policy();
>	system_state = SYSTEM_BOOTING_SCHEDULER_OK;
>	unlock_kernel();
> 	cpu_idle();
>} 
system_state is changed only after the init thread is created.
Unless kernel_thread guarantees some execution ordering between
parent and child, I don't see how this could be race-free.

But I also don't see why ppc and x86 behave so differently here.

/Mikael
