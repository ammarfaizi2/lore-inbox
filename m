Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWAYIvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWAYIvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWAYIvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:51:13 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:7370 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750927AbWAYIvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:51:12 -0500
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) -
	safe_smp_processor_id
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       ebiederm@xmission.com, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
In-Reply-To: <1138176439.3001.26.camel@laptopd505.fenrus.org>
References: <1138171868.2370.62.camel@localhost.localdomain>
	 <20060124231052.7c9fcbec.akpm@osdl.org> <200601250853.48193.ak@suse.de>
	 <20060124235901.719aa375.akpm@osdl.org>
	 <1138176439.3001.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 25 Jan 2006 17:50:17 +0900
Message-Id: <1138179017.7159.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 09:07 +0100, Arjan van de Ven wrote:
> On Tue, 2006-01-24 at 23:59 -0800, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > On Wednesday 25 January 2006 08:10, Andrew Morton wrote:
> > > 
> > > > It assumes that all x86 SMP machines have APICs.  That's untrue of Voyager.
> > > > I think we can probably live with this assumption - others would know
> > > > better than I.
> > > 
> > > Early x86s didn't have APICs and they are still often disabled on not so 
> > > old mobile CPUs.  I don't think it's a good assumption to make for i386.
> > > 
> > 
> > But how many of those do SMP?
> 
> even on SMP boxes you regularly need to (runtime) disable apics. Several
> boards out there just have busted apics, or at least when used with
> linux. "noapic" is one of the more frequent things distro support people
> tell customers over the phone....
Checking whether ioapic_setup_disabled is set should suffice, right?
Does the patch below look good?

diff -urNp linux-2.6.16-rc1/arch/i386/kernel/smp.c linux-2.6.16-rc1-sov/arch/i386/kernel/smp.c
--- linux-2.6.16-rc1/arch/i386/kernel/smp.c	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc1-sov/arch/i386/kernel/smp.c	2006-01-25 17:49:52.000000000 +0900
@@ -628,3 +628,32 @@ fastcall void smp_call_function_interrup
 	}
 }
 
+static int convert_apicid_to_cpu(int apic_id)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (x86_cpu_to_apicid[i] == apic_id)
+		return i;
+	}
+	return -1;
+}
+
+int safe_smp_processor_id(void)
+{
+	int apicid, cpuid;
+
+	if (ioapic_setup_disabled())
+		return smp_processor_id();
+
+	if (!boot_cpu_has(X86_FEATURE_APIC))
+		return 0;
+
+	apicid = hard_smp_processor_id();
+	if (apicid == BAD_APICID)
+		return 0;
+
+	cpuid = convert_apicid_to_cpu(apicid);
+
+	return cpuid >= 0 ? cpuid : 0;
+}
diff -urNp linux-2.6.16-rc1/include/asm-i386/smp.h linux-2.6.16-rc1-sov/include/asm-i386/smp.h
--- linux-2.6.16-rc1/include/asm-i386/smp.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc1-sov/include/asm-i386/smp.h	2006-01-25 18:00:04.000000000 +0900
@@ -90,12 +90,14 @@ static __inline int logical_smp_processo
 
 #endif
 
+extern int safe_smp_processor_id(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
 
+#define safe_smp_processor_id() 0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */


