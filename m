Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTFJBOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 21:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFJBOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 21:14:40 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:3203
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262430AbTFJBOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 21:14:38 -0400
Date: Mon, 9 Jun 2003 21:17:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.GSO.3.96.1030609135224.2806A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.50.0306092112250.19137-100000@montezuma.mastecende.com>
References: <Pine.GSO.3.96.1030609135224.2806A-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, Maciej W. Rozycki wrote:

>  Why do you consider the systems broken?

Not necessarily broken, just no reporting of APIC capability. Not that i 
should expect better from Intel (c.f. HT bit, SEP on PPro etc)

> > Regardless i'll update the patch.
> 
>  Great!

How about we only clear smp_found_config when forced.

Index: linux-2.5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.42
diff -u -p -B -r1.42 apic.c
--- linux-2.5/arch/i386/kernel/apic.c	26 May 2003 23:59:58 -0000	1.42
+++ linux-2.5/arch/i386/kernel/apic.c	10 Jun 2003 00:14:37 -0000
@@ -602,6 +602,15 @@ static void apic_pm_activate(void) { }
  */
 int dont_enable_local_apic __initdata = 0;
 
+static int __init nolapic_setup(char *str)
+{
+	dont_enable_local_apic = 1;
+	smp_found_config = 0;
+	return 1;
+}
+
+__setup("nolapic", nolapic_setup);
+
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
@@ -609,7 +618,7 @@ static int __init detect_init_APIC (void
 
 	/* Disabled by DMI scan or kernel option? */
 	if (dont_enable_local_apic)
-		return -1;
+		goto no_apic;
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
@@ -665,6 +674,7 @@ static int __init detect_init_APIC (void
 	return 0;
 
 no_apic:
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	printk("No local APIC present or hardware disabled\n");
 	return -1;
 }
Index: linux-2.5/Documentation/kernel-parameters.txt
===================================================================
RCS file: /home/cvs/linux-2.5/Documentation/kernel-parameters.txt,v
retrieving revision 1.24
diff -u -p -B -r1.24 kernel-parameters.txt
--- linux-2.5/Documentation/kernel-parameters.txt	6 Jun 2003 15:55:40 -0000	1.24
+++ linux-2.5/Documentation/kernel-parameters.txt	10 Jun 2003 00:14:38 -0000
@@ -625,6 +625,9 @@ running once the system is up.
 
 	nointroute	[IA-64]
 
+	nolapic		[IA-32, APIC]
+			Disable Local APIC.
+
 	nomce		[IA-32] Machine Check Exception
 
 	noresume	[SWSUSP] Disables resume and restore original swap space.
