Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266061AbTFWOoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266062AbTFWOoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:44:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266061AbTFWOoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:44:54 -0400
Subject: Re: [PATCH 2.5.72] Fix boot deadlock on MTRR main.c:ipi_handler
From: Mark Haverkamp <markh@osdl.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'mochel@osdl.org'" <mochel@osdl.org>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780E040A0D@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780E040A0D@orsmsx116.jf.intel.com>
Content-Type: text/plain
Message-Id: <1056380401.25352.0.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 08:00:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 19:20, Perez-Gonzalez, Inaky wrote:
> Hi All
> 
> Stomped over this one this morning; tried to boot 
> 2.5.72 (config attached) into my 2xP3 Coppermine 
> 933 MHz and it would get stuck just after printing 
> the mttr banner. 
> 
> The NMI watchdog would kick in and print a dump 
> pointing to arch/i386/kernel/cpu/mtrr/main.c:ipi_handler:
> 
> NMI Watchdog detected LOCKUP on CPU1, eip c0113b70, registers:
> CPU:    1
> EIP:    0060:[<c0113b70>]    Not tainted
> EFLAGS: 00000082
> EIP is at ipi_handler+0x60/0x80
> eax: c014b2fe   ebx: c2bf5f60   ecx: 000002ff   edx: 00000000
> esi: 00000086   edi: c2bf2000   ebp: c2bf3f5c   esp: c2bf3f44
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c2bf2000 task=c2bf72d0)
> Stack: c0464228 00000046 c0495088 00000001 c2bf2000 00000000 c2bf3f70
> c0118412 
>        c2bf5f60 c01072a0 c2bf2000 c2bf3fac c010a50e c01072a0 00000000
> c2bf2000 
>        c2bf2000 c2bf2000 c2bf3fac 00000000 0000007b c2bf007b fffffffb
> c01072d0 
> Call Trace:
>  [<c0118412>] smp_call_function_interrupt+0x42/0xa0
>  [<c01072a0>] default_idle+0x0/0x40
>  [<c010a50e>] call_function_interrupt+0x1a/0x20
>  [<c01072a0>] default_idle+0x0/0x40
>  [<c01072d0>] default_idle+0x30/0x40
>  [<c010736a>] cpu_idle+0x4a/0x60
>  [<c012532d>] printk+0x1dd/0x290
> 
> Code: f3 90 8b 43 04 85 c0 75 f7 56 9d 83 c4 10 5b 5e 5d c3 a1 44 
> console shuts up ...
> 
> Sooo .. decided to do the binary search thingie and tracked
> it down to patch-2.5.70-bk15-bk15.gz, change set 1.28 
> (http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/cpu/mtrr/main
> .c@1.28?nav=index.html|tags|ChangeSet@1.1215.18.33..|cset@1.1215.114.28),
> 
> where mtrr_init() is changed from being a core_initcall to be a
> subsys_initcall(). Reverting that changes Fixes It For Me (tm)
> both in 2.5.70-bk16 and 2.5.72. No adversities seen so far.
> 
> Please apply:
> 
> --- arch/i386/kernel/cpu/mtrr/main.c~	2003-06-16 21:19:39.000000000 -0700
> +++ arch/i386/kernel/cpu/mtrr/main.c	2003-06-19 18:52:38.000000000 -0700
> @@ -701,5 +701,5 @@
>      "write-back",               /* 6 */
>  };
>  
> -subsys_initcall(mtrr_init);
> +core_initcall(mtrr_init);

This fixes a boot hang problem that I have been seeing on my three
machines.

-- 
Mark Haverkamp <markh@osdl.org>

