Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTK0A7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 19:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTK0A7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 19:59:48 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:10624
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S264394AbTK0A7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 19:59:46 -0500
Message-ID: <3FC54C7E.50904@free.fr>
Date: Thu, 27 Nov 2003 01:59:42 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [kernel panic @ reboot in usbcore] 2.6.0-test10-mm1 (culprit:
 modem_run)
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com> <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It worked, but I had -- as expected -- to write the oops by hand.
(user request to Randy: would it be possible to have an option in 
kmsgdump to only write the first oops on floppy ???)

I it have all on paper, but I'm too lazy to write the full stack right 
now (available later on request: I have to go to bed now 8):

------------------------------------------------------------------
CPU: 0
EIP: 0060 : [<d0ae9822>]
EFLAGS: 00010246
EIP is at releaseintf+0x62/0x80 [usbcore]
eax:00000000 ebx:ceddc224 ecx:cs6D5DC0 edx:00000000
esi:ceddc200 edi:00000000 ebp:cd647f0c esp:cd647ef8
ds: 007b es:007b ss:0068

Process: modem_run (pid: 1121, threadinfo=cd646000, task=ce644040)
Stack: c016ffe3 ce0bfb24 ce6d5dc0 ...
[...]

Call trace
[<c016ffe3>] iput+0x63/0x80
[<d0ae9c27>] usbdev_release+0xb7/0xc0 [usbcore]
[<c0157a5c>] __fput+0x10c/0x120
[<c0156047>] filp_close+0x57/0x80
[<c0123d17>] put_files_struct+0x67/0xd0
[<c012491e>] do_exit+0x3a/0xb0
[<c0124c4a>] do_group_exit+0x3a/0xb0
[<c02a302e>] sysenter_past_esp+0x43/0x65
-------------------------------------------------------------------

The modem_run process is the one uploading the firmware for my 
speedtouch dsl modem. I'm using the kernel-space speedtouch driver, with 
modem_run from http://speedtouch.sourceforge.net/
Manually shutting down the network and killing modem_run before 
rebooting makes the oops disapear.

  However, I believe the fact that modem_run can cause a kernel panic is 
still a bug that should be fixed. I'm willing to test any patch to fix 
this issue that has ennoyed me since a long time (in the meantime, I'll 
work around this in my shutdown scripts). :-)



Zwane Mwaikambo wrote:
> On Wed, 26 Nov 2003, Vince wrote:
> 
> 
>>>*groan* do you have a PDA?
>>>
>>
>>Nope. I could probably borrow a laptop to a friend but am not excited at
>>the idea of having to setup some serial console thing (I do not even
>>have a serial cable). Dump to floppy/swap/disk would be much easier in
>>my case... if it could me made to work, of course ;-)
> 
> 
> Those oopses looked rather spurious, i'm not sure what help those other
> methods would be here. Try applying the following patch and be sure to
> have access to the console. You may have to hand transcribe...
> 
> Index: linux-2.6.0-test10-mm1-bochs/arch/i386/kernel/traps.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.6.0-test10-mm1/arch/i386/kernel/traps.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 traps.c
> --- linux-2.6.0-test10-mm1-bochs/arch/i386/kernel/traps.c	26 Nov 2003 05:28:50 -0000	1.1.1.1
> +++ linux-2.6.0-test10-mm1-bochs/arch/i386/kernel/traps.c	26 Nov 2003 18:17:37 -0000
> @@ -329,6 +329,10 @@ void die(const char * str, struct pt_reg
>  	if (in_interrupt())
>  		panic("Fatal exception in interrupt");
> 
> +	local_irq_disable();
> +	while (1)
> +		__asm__ __volatile__("hlt");
> +
>  	if (panic_on_oops) {
>  		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
>  		set_current_state(TASK_UNINTERRUPTIBLE);


