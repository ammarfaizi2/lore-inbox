Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTHJTem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 15:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTHJTem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 15:34:42 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:29957 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270626AbTHJTej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 15:34:39 -0400
Message-ID: <3F369EA1.9000309@yahoo.com>
Date: Sun, 10 Aug 2003 15:36:01 -0400
From: Brandon Stewart <rbrandonstewart@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: jgarzik@pobox.com, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Solution: 2.6.0x unbootable with Cyrix III (VIA Ezra C3) CPU
References: <3F35D17D.2020204@yahoo.com>
In-Reply-To: <3F35D17D.2020204@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some more digging, and, after a week of experimentation and 
searching, I finally found the solution. This message tells it all:

==============
Am Mit, 2003-06-18 um 16.18 schrieb Guennadi Liakhovetski:

/> / tried stepping 8. The fix was to upgrade libc. I've done this (to /
/> version libc6_2.3.1-16, but it didn't help. Any ideas? /

IIRC there were some versions of glibc in Debian which activated the 686
and higher optimized versions for the cmov-less Ezra. A workaround is to
(re)move /usr/lib/686.

-- 
Servus,
       Daniel

==============

Mandrake 9.1 has the exact same problem, but the extension directory is 
found in /lib/i686. I ran the following command:

mv /lib/i686 /lib/i686.invalid

and everything worked.

I am not sure why 2.6 activated this issue in glibc, where 2.4.21 
didn't. Perhaps this should be noted on the Halloween document?

I thank everyone that offered their assistance.

-Brandon

Brandon Stewart wrote:

> I reported this error earlier, but I now believe the problem may be 
> with the kernel rather than my own inability to set things up.
>
> The kernel will hang during processing of /sbin/init, but before the 
> INIT message appears on the console. Doing a magic sysreq reveals that 
> processing is stuck in /sbin/init. The call stack will show some of 
> the following functions, in no particular order:
>
> common_interrupt
> do_invalid_op
> do_IRQ
> do_notify_resume
> do_signal
> do_softirq
> do_timer
> error_code
> force_sig_info
> get_signal_to_deliver
> i8042_timer_func
> run_timer_softirq
> timer_interrupt
> update_wall_time
> work_notifysig
>
> Each time I do a sysreq, I get a different call stack. But it seems 
> the functions the call stack contains will be limited to those listed 
> above. The system is not deadlocked, I can still do capslock, and 
> CTRL-ALT-DLT will reboot the system.
>
> o The setup is Mandrake 9.1, with the latest patches.
> o The problem is not /sbin/init, because this machine boots just fine 
> with 2.4.21mdk. Furthermore, I downloaded and compiled from source 
> /sbin/init, making sure that gcc maintained i386 compatibility.
> o Downgrading the processor compatibility has no effect. The entire 
> kernel was compiled with i386 compatibility. But it doesn't matter 
> whether I use i586, Cyrix III, or i386, the boot still hangs.
> o It's unlikely a problem with my .config, because doing a make 
> oldconfig, adding only the minimal additional options to have a 
> functioning system (the CONSOLE parameters, for example), has the same 
> exact problem.
> o The problem is not with Mandrake 9.1 recompiling kernels, because I 
> was able to recompile and boot the 2.4.21mdk kernel.
> o The problem is not with Mandrake 9.1 recompiling 2.6 kernels, 
> because I was able to recompile and boot the 2.6 kernel on another 
> machine (Intel P4).
> o Recent versions of module-init-tools are installed, but it made no 
> difference between 9.9 and 9.11a.
> o The issue is the same in 2.6.0-test2 and 2.6.0-test3
>
> I have attached the .config I have been using. Keep in mind that the 
> standard Mandrake distribution config was no different. I think the 
> issue is compatibility with Cyrix III because of the do_invalid_op 
> instructions.
>
> Any help, suggestions, or pointers are appreciated.
>
> -Brandon


