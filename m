Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTFBQRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTFBQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:17:37 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:60288
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263620AbTFBQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:17:24 -0400
Date: Mon, 2 Jun 2003 12:20:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: mikpe@csd.uu.se
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, "" <alan@lxorguk.ukuu.org.uk>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
In-Reply-To: <16091.25998.133420.280664@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.50.0306021218210.18864-100000@montezuma.mastecende.com>
References: <200306012308.h51N8K6j001404@harpo.it.uu.se> <1054511535.6676.85.camel@pc>
 <Pine.LNX.4.50.0306011950080.31534-100000@montezuma.mastecende.com>
 <16091.25998.133420.280664@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003 mikpe@csd.uu.se wrote:

> Looks good to me. Add a __setup to set dont_enable_local_apic and this
> should be sufficient for users of severely broken HW or emulations.

This should do it then;

Thanks,
	Zwane

Index: linux-2.5/Documentation/kernel-parameters.txt
===================================================================
RCS file: /home/cvs/linux-2.5/Documentation/kernel-parameters.txt,v
retrieving revision 1.36
diff -u -p -B -r1.36 kernel-parameters.txt
--- linux-2.5/Documentation/kernel-parameters.txt	2 Jun 2003 02:49:19 -0000	1.36
+++ linux-2.5/Documentation/kernel-parameters.txt	2 Jun 2003 15:20:46 -0000
@@ -624,6 +624,9 @@ running once the system is up.
 
 	nointroute	[IA-64]
 
+	nolapic		[IA-32, APIC]
+			Disable Local APIC.
+
 	nomce		[IA-32] Machine Check Exception
 
 	noresume	[SWSUSP] Disables resume and restore original swap space.
Index: linux-2.5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.54
diff -u -p -B -r1.54 apic.c
--- linux-2.5/arch/i386/kernel/apic.c	31 May 2003 19:01:05 -0000	1.54
+++ linux-2.5/arch/i386/kernel/apic.c	2 Jun 2003 15:20:47 -0000
@@ -602,6 +602,14 @@ static void apic_pm_activate(void) { }
  */
 int dont_enable_local_apic __initdata = 0;
 
+static int __init nolapic_setup(char *str)
+{
+	dont_enable_local_apic = 1;
+	return 1;
+}
+
+__setup("nolapic", nolapic_setup);
+
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
@@ -609,7 +617,7 @@ static int __init detect_init_APIC (void
 
 	/* Disabled by DMI scan or kernel option? */
 	if (dont_enable_local_apic)
-		return -1;
+		goto no_apic;
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
@@ -665,6 +673,7 @@ static int __init detect_init_APIC (void
 	return 0;
 
 no_apic:
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	printk("No local APIC present or hardware disabled\n");
 	return -1;
 }
-- 
function.linuxpower.ca
