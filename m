Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272159AbTHKGG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272281AbTHKGG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:06:57 -0400
Received: from [66.212.224.118] ([66.212.224.118]:11023 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272159AbTHKGGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:06:52 -0400
Date: Mon, 11 Aug 2003 01:55:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, cmrivera@ufl.edu,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts
 seems correct
In-Reply-To: <Pine.LNX.4.53.0308110121090.19193@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0308110148080.19193@montezuma.mastecende.com>
References: <1060572792.1113.10.camel@boobies.awol.org> 
 <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>  <1060574873.684.41.camel@localhost>
  <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>  <1060576517.684.47.camel@localhost>
  <34268.4.4.25.4.1060576870.squirrel@www.osdl.org> <1060577118.684.52.camel@localhost>
 <Pine.LNX.4.53.0308110121090.19193@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Zwane Mwaikambo wrote:

> On i386 you can find out the last irq line number during MP table parsing 
> (ACPI bits are also in mpparse.c), for the hotplug case i suppose the 
> hotplug code could bump this up as devices get attached. But unless we do 
> dynamic NR_IRQs its all just too much effort.

Boring weekend...

Index: linux-2.6.0-test3-huge_kpage/fs/proc/proc_misc.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/fs/proc/proc_misc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 proc_misc.c
--- linux-2.6.0-test3-huge_kpage/fs/proc/proc_misc.c	10 Aug 2003 08:42:45 -0000	1.1.1.1
+++ linux-2.6.0-test3-huge_kpage/fs/proc/proc_misc.c	11 Aug 2003 05:49:54 -0000
@@ -411,8 +411,19 @@ static int kstat_read_proc(char *page, c
 	len += sprintf(page + len, "intr %u", sum);
 
 #if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
-	for (i = 0 ; i < NR_IRQS ; i++)
+{
+	static int last_irq = 0;
+	
+	for (i = last_irq; i < NR_IRQS; i++) {
+		if (irq_desc[i].action) {
+			if (i > last_irq)
+				last_irq = i;
+		}
+	}
+
+	for (i = 0 ; i <= last_irq ; i++)
 		len += sprintf(page + len, " %u", kstat_irqs(i));
+}
 #endif
 
 	len += sprintf(page + len,
