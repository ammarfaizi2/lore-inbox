Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTATRLx>; Mon, 20 Jan 2003 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTATRLx>; Mon, 20 Jan 2003 12:11:53 -0500
Received: from durendal.skynet.be ([195.238.3.91]:33314 "EHLO
	durendal.skynet.be") by vger.kernel.org with ESMTP
	id <S266292AbTATRLu> convert rfc822-to-8bit; Mon, 20 Jan 2003 12:11:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans Lambrechts <hans.lambrechts@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre3 smp_affinity, very strange
Date: Mon, 20 Jan 2003 17:41:02 +0100
User-Agent: KMail/1.4.3
References: <200301191645.03034.hans.lambrechts@skynet.be> <1043002445.1479.8.camel@laptop.fenrus.com>
In-Reply-To: <1043002445.1479.8.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301201741.02782.hans.lambrechts@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Manfred and Arjan for responding, and for the solution :-)

My box works now as before.

pc:~ # cat /proc/interrupts
           CPU0       CPU1
  0:       5894       5418    IO-APIC-edge  timer
  1:         57         40    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          2    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 12:        283        223    IO-APIC-edge  PS/2 Mouse
 14:          4          3    IO-APIC-edge  ide0
 16:       4044       3976   IO-APIC-level  aic7xxx
 18:         50         42   IO-APIC-level  eth0
NMI:      11227      11227
LOC:      11204      11203
ERR:          0
MIS:          0

Patch attached at the bottom of the page. If any comments, please cc me.
 
On Sunday 19 January 2003 19:54, you wrote:
> > Did the APIC or mpparse changes cause this?
>
> +#ifdef CONFIG_X86_CLUSTERED_APIC
> +static inline int target_cpus(void)
> +{
> +       static int cpu;
> +       switch(clustered_apic_mode){
> +               case CLUSTERED_APIC_NUMAQ:
> +                       /* Broadcast intrs to local quad only. */
> +                       return APIC_BROADCAST_ID_APIC;
> +               case CLUSTERED_APIC_XAPIC:
> +                       /*round robin the interrupts*/
> +                       cpu = (cpu+1)%smp_num_cpus;
> +                       return cpu_to_physical_apicid(cpu);
> +               default:
> +       }
> +       return cpu_online_map;
> +}
> +#else
> +#define target_cpus() (0x01)
> +#endif
> (2.4.21-pre3)
> that's wrong.....  0x01 -> 0xFF and it should be fixed

--- linux/include/asm-i386/smpboot.h    2003-01-20 16:45:13.000000000 +0100
+++ linux/include/asm-i386/smpboot.h.orig       2003-01-20 16:44:05.000000000 +0100
@@ -116,6 +116,6 @@
        return cpu_online_map;
 }
 #else
-#define target_cpus() (0xFFFFFFFF)
+#define target_cpus() (0x01)
 #endif
 #endif

