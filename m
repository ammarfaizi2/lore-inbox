Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130571AbRAJW3f>; Wed, 10 Jan 2001 17:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRAJW3Z>; Wed, 10 Jan 2001 17:29:25 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12294 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130571AbRAJW3P>;
	Wed, 10 Jan 2001 17:29:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Nathan Walp <faceprint@faceprint.com>
cc: Hans Grobler <grobh@sun.ac.za>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Oops in 2.4.0-ac5 
In-Reply-To: Your message of "Wed, 10 Jan 2001 15:23:14 CDT."
             <3A5CC4B2.74B911BD@faceprint.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 09:29:07 +1100
Message-ID: <3360.979165747@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001 15:23:14 -0500, 
Nathan Walp <faceprint@faceprint.com> wrote:
>Here it is... I opted to cut out the 1200-odd warnings, which from the
>look of them were all because i'm running it under 2.4.0-ac4 (which
>boots fine).

ksymoops defaults to using /proc entries from the current system.  This
is fine for most people but you have to override the default when
decoding an oops from another kernel.

  ksymoops -KL -m /boot/System.map-2.4.0-ac5

ignores the running ksyms and lsmod files, removing your warnings.

>>>EIP; c01129ba <setup_apic_nmi_watchdog+a/90>   <=====
>Trace; c0100191 <L6+0/2>
>Code;  c01129ba <setup_apic_nmi_watchdog+a/90>
>00000000 <_EIP>:
>Code;  c01129ba <setup_apic_nmi_watchdog+a/90>   <=====
>   0:   0f 30                     wrmsr     <=====
>Code;  c01129bc <setup_apic_nmi_watchdog+c/90>

This is why my original NMI for UP code in kdb uses wrmsr_eio() instead
of wrmsr.  wrmsr_eio() catches errors where the APIC does not support
the msr and returns EIO instead of oopsing and taking the kernel with
it.  I could never persuade Ingo to use wrmsr_eio() and check the
return code, maybe this will change his mind.  Extract from kdb v1.7.

/*
 * {rd,wr}msr_eio by HPA, moved from arch/i386/msr.c to here.
 * Keith Owens.
 */

/* Note: "err" is handled in a funny way below.  Otherwise one version
   of gcc or another breaks. */

extern inline int wrmsr_eio(u32 reg, u32 eax, u32 edx)
{
  int err;

  asm volatile(
	      "1:      wrmsr\n"
	      "2:\n"
	      ".section .fixup,\"ax\"\n"
	      "3:      movl %4,%0\n"
	      "        jmp 2b\n"
	      ".previous\n"
	      ".section __ex_table,\"a\"\n"
	      "        .align 4\n"
	      "        .long 1b,3b\n"
	      ".previous"
	      : "=&bDS" (err)
	      : "a" (eax), "d" (edx), "c" (reg), "i" (-EIO), "0" (0));

  return err;
}

.....

/*
 * Activate or deactivate NMI watchdog via a local APIC.
 */

int setup_apic_nmi_watchdog(int value)
{
       int ret, eax;

       if (!test_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability))
	       return(-EIO);
       if (nmi_watchdog_source && nmi_watchdog_source != 1)
	       return(0);      /* Not using local APIC */
       /* Disable performance counters 0, 1 for all NMI changes */
       nmi_watchdog = proc_nmi_watchdog = nmi_watchdog_source = 0;
       if ((ret = wrmsr_eio(EVNTSEL0, 0, 0)) ||
	   (ret = wrmsr_eio(EVNTSEL1, 0, 0)) ||
	   (ret = wrmsr_eio(PERFCTR0, 0, 0)) ||
	   (ret = wrmsr_eio(PERFCTR1, 0, 0)))
	       goto exit;
       if (!value)
	       return(0);
       /* Must set before activation to catch first NMI */
       nmi_watchdog = proc_nmi_watchdog = nmi_watchdog_source = 1;
       eax = 1 << 20           /* Interrupt on overflow */
	   | 1 << 17           /* OS mode */
	   | 1 << 16           /* User mode */
	   | 0x79;             /* Event, cpu clocks not halted */
       if ((ret = wrmsr_eio(EVNTSEL1, eax, 0))
	|| (ret = set_nmi_counter_local()))
	       goto exit;
       apic_write_around(APIC_LVTPC, APIC_DM_NMI);
       eax = 1 << 22;          /* Enable performance counters, only using ctr1 */
       ret = wrmsr_eio(EVNTSEL0, eax, 0);
exit:
       if (ret)
	       nmi_watchdog = proc_nmi_watchdog = nmi_watchdog_source = 0;
       else
	       printk(KERN_INFO "Activated NMI via local APIC\n");
       return(ret);
}



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
