Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSKVP3n>; Fri, 22 Nov 2002 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSKVP3n>; Fri, 22 Nov 2002 10:29:43 -0500
Received: from guru.webcon.net ([66.11.168.140]:22758 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S264945AbSKVP3l>;
	Fri, 22 Nov 2002 10:29:41 -0500
Date: Fri, 22 Nov 2002 10:36:41 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: p4-clockmod doing the Right Thing[tm]?
In-Reply-To: <Pine.LNX.4.44.0211220113330.1639-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0211221010380.14300-100000@light.webcon.net>
References: <Pine.LNX.4.44.0211220113330.1639-100000@montezuma.mastecende.com>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2002, Zwane Mwaikambo wrote:

> On Tue, 19 Nov 2002, Ian Morgan wrote:
> 
> > # cat /proc/cpufreq
> >           minimum CPU frequency  -  maximum CPU frequency  -  policy
> > CPU  0     2405487 kHz ( 100 %)  -    2706165 kHz (112 %)  -  powersave
> 
> Can you try this patch?
> 
> Index: linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 p4-clockmod.c
> --- linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c	18 Nov 2002 01:39:49 -0000	1.1.1.1
> +++ linux-2.4.20-rc1-ac4/arch/i386/kernel/p4-clockmod.c	22 Nov 2002 06:12:11 -0000
> @@ -209,7 +209,7 @@
>  	if (number_states)
>  		return;
>  
> -	policy->max = (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / stock_freq)) + 1);
> +	policy->max = ((stock_freq / 8) * (((unsigned int) ((policy->max * 80) / stock_freq)))/10);
>  	return;
>  }

Yes, that looks sane.. essentially back to a *8 instead of *9.

Previously the policy->max could keep growing out of control, but now will
be nicely capped at stock_freq (if I'm reading that right).


Ok, applying patch now:
Oh wow.. I now have a 19.25 GHz P4!! Woohoo! :-)

          minimum CPU frequency  -  maximum CPU frequency  -  policy
CPU  0      2406217 kHz ( 12 %)  -   19249737 kHz (100 %)  -  performance

OK thta makes no sense. This minor patch could not possibly account for this
wild change in numbers. Looks like  the stock_freq is now totally out of
whack right after p4-clockmod is loaded.

Now just rmmod and modprobe again, and lo and behold:

          minimum CPU frequency  -  maximum CPU frequency  -  policy
CPU  0     19249837 kHz ( 12 %)  -  153998696 kHz ( 16 %)  -  performance

962 GHz P4!!! AAAAAAAAAAAAAAAAA!!!

Ok, well it's obvious now that some data structure is not being properly
cleared/initialized when loading the module, because rmmod/modprobe cycles
keep growing the stock_freq out of control.

# # trying to force min/max back into sane bounds:
# echo "1000000:2000000:performance" > cpufreq
Segmentation fault

Nov 22 10:29:00 light kernel: kernel BUG at p4-clockmod.c:198!
Nov 22 10:29:00 light kernel: invalid operand: 0000
Nov 22 10:29:00 light kernel: CPU:    0
Nov 22 10:29:01 light kernel: EIP:    0010:[<e08b9408>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 22 10:29:01 light kernel: EFLAGS: 00010202
Nov 22 10:29:01 light kernel: eax: d1781f24   ebx: 092dd568   ecx: e08b92f0
Nov 22 10:29:01 light kernel: esi: 0000001c   edi: 00000001   ebp: d1781f24
Nov 22 10:29:01 light kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 10:29:01 light kernel: Process tcsh (pid: 15386, stackpage=d1781000)
Nov 22 10:29:01 light kernel: Stack: 00000000 00000000 d1781f24 0000001c
d1781f6
Nov 22 10:29:01 light kernel:        00000000 d1781f24 d1781f24 0000001c
d1781f6
Nov 22 10:29:01 light kernel:        0000001c 00000001 000f4240 001e8480
0000000
Nov 22 10:29:01 light kernel: Call Trace:    [<c0129766>] [<c0129197>]
Nov 22 10:29:01 light kernel:   [<c013e893>] [<c0107307>]
Nov 22 10:29:01 light kernel: Code: 0f 0b c6 00 22 97 8b e0 e9 1f ff ff ff

>>EIP; e08b9408 <[p4-clockmod]cpufreq_p4_verify+118/130>   <=====
Trace; c0129766 <cpufreq_set_policy+96/1f0>
Trace; c0129197 <cpufreq_proc_write+87/90>
Trace; c013e893 <sys_write+a3/140>
Trace; c0107307 <system_call+33/38>
Code;  e08b9408 <[p4-clockmod]cpufreq_p4_verify+118/130>
00000000 <_EIP>:
Code;  e08b9408 <[p4-clockmod]cpufreq_p4_verify+118/130>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e08b940a <[p4-clockmod]cpufreq_p4_verify+11a/130>
   2:   c6 00 22                  movb   $0x22,(%eax)
Code;  e08b940d <[p4-clockmod]cpufreq_p4_verify+11d/130>
   5:   97                        xchg   %eax,%edi
Code;  e08b940e <[p4-clockmod]cpufreq_p4_verify+11e/130>
   6:   8b e0                     mov    %eax,%esp
Code;  e08b9410 <[p4-clockmod]cpufreq_p4_verify+120/130>
   8:   e9 1f ff ff ff            jmp    ffffff2c <_EIP+0xffffff2c>

And of course now rmmod p4-clockmod is device locked. Time for a reboot,
methinks.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------
