Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUAOFXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 00:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbUAOFXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 00:23:35 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:37523 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S264296AbUAOFXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 00:23:31 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: setjmp/longjmp hooks for kgdb 2.0.2
Date: Thu, 15 Jan 2004 10:52:30 +0530
User-Agent: KMail/1.5
References: <20040114165034.GB17509@stop.crashing.org>
In-Reply-To: <20040114165034.GB17509@stop.crashing.org>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401151052.30740.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

It's nice to see someone working on integrating powerpc kgdb with mainline 
kgdb. There are a lot of features (like thread lists, gdb deatch-reattach, 
automodule loading) powerpc kgdb will inherit automatically from common core.

setjmp, longjmp isn't required. search_exception_tables take care of invalid 
memory accesses by kgdb.

In arch/ppc/mm/fault.c:do_page_fault, call bad_page_fault if 
debugger_memerr_expected is non-zero instead of holding mmap_sem. 

bad_page_fault calls search_exception_tables at the begining. It takes care of 
invalid memory addresses by kgdb as kgdb uses get_user, put_user to access 
memory when the access can fail.

For powerpc arch specific code (like entry.S) look at 
http://kgdb.sourceforge.net/linux-2.4.23-kgdb-1.9.patch
It contains powerpc arch specific code for kgdb. I was never able to test this 
code, so I don't know whether it works.

If you modify kgdb core as well as arch specific files, please try to send 
separate patches. Single patch will require me to do more work when I merge 
it against separate patches.

Thanks.

On Wednesday 14 Jan 2004 10:20 pm, Tom Rini wrote:
> Hello.  I'm currently starting down the road to adding PPC32 support to
> kgdb 2.0.x.  The first patch I've got for you adds in hooks to allow for
> doing setjmp/longjmp, if the arch wants to do so.  This isn't tested,
> yet (I haven't gotten that far in fixing ppc32 backend bits) but should
> be OK.  Comments?
>
> ===== include/linux/kgdb.h 1.1 vs edited =====
> --- 1.1/include/linux/kgdb.h	Tue Jan 13 11:09:23 2004
> +++ edited/include/linux/kgdb.h	Wed Jan 14 09:02:54 2004
> @@ -81,6 +81,10 @@
>  	int  (*remove_break) (unsigned long addr, int type);
>  	void (*correct_hw_break) (void);
>  	void (*handler_exit) (void);
> +	void (*setjmp) (long *buf);
> +	void (*longjmp) (long *buf, int val);
> +	void (*clearjmp) (void);
> +	int  (*issetjmp) (void);
>  	void (*shadowinfo)(struct pt_regs *regs, char *buffer, unsigned
> threadid); struct task_struct *(*get_shadow_thread)(struct pt_regs *regs,
> int threadid); struct pt_regs *(*shadow_regs)(struct pt_regs *regs, int
> threadid); ===== kernel/kgdbstub.c 1.1 vs edited =====
> --- 1.1/kernel/kgdbstub.c	Tue Jan 13 11:09:24 2004
> +++ edited/kernel/kgdbstub.c	Wed Jan 14 09:02:33 2004
> @@ -72,6 +72,7 @@
>  int kgdb_initialized = 0;
>  int kgdb_enter = 0;
>  static const char hexchars[] = "0123456789abcdef";
> +static u_int fault_jmp_buf[100];
>
>  int get_char(char *addr, unsigned char *data, int can_fault);
>  int set_char(char *addr, int data, int can_fault);
> @@ -255,6 +256,9 @@
>  	int i;
>  	unsigned char ch;
>
> +	if (kgdb_ops->setjmp)
> +		kgdb_ops->setjmp((long *)fault_jmp_buf);
> +
>  	for (i = 0; i < count; i++) {
>
>  		if (get_char(mem++, &ch, can_fault) < 0)
> @@ -263,6 +267,10 @@
>  		*buf++ = hexchars[ch >> 4];
>  		*buf++ = hexchars[ch % 16];
>  	}
> +
> +	if (kgdb_ops->clearjmp)
> +		kgdb_ops->clearjmp();
> +
>  	*buf = 0;
>  	return (buf);
>  }
> @@ -275,12 +283,19 @@
>  	int i;
>  	unsigned char ch;
>
> +	if (kgdb_ops->setjmp)
> +		kgdb_ops->setjmp((long *)fault_jmp_buf);
> +
>  	for (i = 0; i < count; i++) {
>  		ch = hex(*buf++) << 4;
>  		ch = ch + hex(*buf++);
>  		if (set_char(mem++, ch, can_fault) < 0)
>  			break;
>  	}
> +
> +	if (kgdb_ops->clearjmp)
> +		kgdb_ops->clearjmp();
> +
>  	return (mem);
>  }
>
> @@ -295,6 +310,9 @@
>
>  	*longValue = 0;
>
> +	if (kgdb_ops->setjmp)
> +		kgdb_ops->setjmp((long *)fault_jmp_buf);
> +
>  	while (**ptr) {
>  		hexValue = hex(**ptr);
>  		if (hexValue >= 0) {
> @@ -306,6 +324,9 @@
>  		(*ptr)++;
>  	}
>
> +	if (kgdb_ops->clearjmp)
> +		kgdb_ops->clearjmp();
> +
>  	return (numChars);
>  }
>
> @@ -579,6 +600,11 @@
>  	static char tmpstr[256];
>  	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
>  	int kgdb_usethreadid = 0;
> +
> +	if (kgdb_ops->issetjmp && kgdb_ops->issetjmp()) {
> +		kgdb_ops->longjmp((long*)fault_jmp_buf, 1);
> +		panic("longjmp failed!");
> +	}
>
>  	/*
>  	 * Interrupts will be restored by the 'trap return' code, except when
>
> Also, how should I send a patch that touches both things in the core,
> i386 and x86_64 patches (# HW breakpoints is arch-dependant.) ?  Thanks.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

