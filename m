Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318615AbSGZWya>; Fri, 26 Jul 2002 18:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318616AbSGZWy3>; Fri, 26 Jul 2002 18:54:29 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:17043 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318615AbSGZWy1>;
	Fri, 26 Jul 2002 18:54:27 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 26 Jul 2002 16:50:35 -0600
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020726165035.Q13656@host110.fsmlabs.com>
References: <20020726143345.E13656@host110.fsmlabs.com> <20020726233339.D21176@suse.de> <20020726162645.N13656@host110.fsmlabs.com> <20020727004711.F21176@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020727004711.F21176@suse.de>; from davej@suse.de on Sat, Jul 27, 2002 at 12:47:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it on another Vaio here and found my explanation was unclear when
he misunderstood me, too.

} Ah, I completely misunderstood the problem. The Gnome-applets are
} polling, and hence seeing the change I guess.  Your suspicion seems to
} be correct, and I was wrong, my z600 needs your patch too.

The patch with the DMI checking is below.  It's probably better done this
way anyway since there are likely other systems out there that do this as
well.  It's a rarely used feature it seems.

If you could try it out and see if it works for you I'd appreciate it.  I'd
like to get it included in 2.4 with Marcelo so I don't have to keep it around.

diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Fri Jul 26 16:48:55 2002
+++ b/arch/i386/kernel/apm.c	Fri Jul 26 16:48:55 2002
@@ -1313,6 +1313,34 @@
 			break;
 		}
 	}
+
+	/*
+	 * The Sony Vaio doesn't seem to want to send us a notify
+	 * about AC line power status changes.  So, we have to keep track
+	 * of it by hand and emulate it here.
+	 *   -- Cort <cort@fsmlabs.com>
+	 */
+	if ( apm_bios_power_change_bug ) {
+		static int last_status = 0;
+		u_short status, bat, life;
+
+		/* get the current power state */
+		if ( apm_get_power_status(&status, &bat, &life) !=
+		     APM_SUCCESS ) {
+			printk("%s:%s error checking power status\n",
+			       __FILE__,__FUNCTION__);
+		}
+		
+		/* has the status changed since we were last here? */
+		if (((status >> 8) & 0xff) != last_status) {
+			last_status = (status >> 8) & 0xff;
+			
+			/* fake a APM_POWER_STATUS_CHANGE event */
+			send_event(APM_POWER_STATUS_CHANGE);
+			queue_event(APM_POWER_STATUS_CHANGE, NULL);
+		}
+		
+	}
 }
 
 static void apm_event_handler(void)
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Fri Jul 26 16:48:55 2002
+++ b/arch/i386/kernel/dmi_scan.c	Fri Jul 26 16:48:55 2002
@@ -12,6 +12,7 @@
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
+int apm_bios_power_change_bug = 0;
 
 struct dmi_header
 {
@@ -346,6 +347,27 @@
 	return 0;
 }
 
+
+/*
+ * Some Vaio laptops don't notify the kernel of a power status change
+ * such as on-AC/on-battery.  This detects some of the faulty machines
+ * and sets a variable that lets arch/i386/kernel/apm.c deal with it.
+ *
+ * I've seen this with the Vaio z505js PCG-5201 and PCG-SR33:
+ 
+ * model PCG-Z505JS(UC), bios Phoenix Technologies LTD version R0121Z1
+ * model PCG-SR33(UC), bios Phoenix Technologies LTD version R0211D1
+ *   -- Cort <cort@fsmlabs.com>
+ */ 
+static __init int sony_vaio_apm_change(struct dmi_blacklist *d)
+{
+	apm_bios_power_change_bug = 1;
+	printk(KERN_WARNING "%s detected: APM power status change workaround enabled\n",
+	       d->ident);
+	return 0;
+}
+
+
 /*
  * The Intel 440GX hall of shame. 
  *
@@ -611,6 +633,12 @@
 	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
 			MATCH(DMI_SYS_VENDOR, "IBM"),
 			NO_MATCH, NO_MATCH, NO_MATCH
+			} },
+
+	{ sony_vaio_apm_change, "Sony Vaio", {	/* APM won't send power change events */
+			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			NO_MATCH, NO_MATCH
 			} },
 
 	{ NULL, }
diff -Nru a/include/asm-i386/system.h b/include/asm-i386/system.h
--- a/include/asm-i386/system.h	Fri Jul 26 16:48:55 2002
+++ b/include/asm-i386/system.h	Fri Jul 26 16:48:55 2002
@@ -356,6 +356,7 @@
 
 extern unsigned long dmi_broken;
 extern int is_sony_vaio_laptop;
+extern int apm_bios_power_change_bug;
 
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
