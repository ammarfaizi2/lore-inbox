Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRAaVgg>; Wed, 31 Jan 2001 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129158AbRAaVg1>; Wed, 31 Jan 2001 16:36:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129091AbRAaVfw>;
	Wed, 31 Jan 2001 16:35:52 -0500
Message-ID: <20010131223506.E231@bug.ucw.cz>
Date: Wed, 31 Jan 2001 22:35:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI fix + comments
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch fixes ACPI oops on my toshiba.. This should go to Linus.

--- clean/drivers/acpi/cmbatt.c	Wed Jan 31 16:14:26 2001
+++ linux/drivers/acpi/cmbatt.c	Wed Jan 31 21:03:47 2001
@@ -163,11 +167,13 @@
 	result->battery_capacity_granularity_1=objs[7].integer.value;
 	result->battery_capacity_granularity_2=objs[8].integer.value;
 
+#define Xstrncpy(a, b, c) if (b) strncpy(a,b,c); else strncpy(a, "unknown", c);
+
 	/* BUG: trailing NULL issue */
-	strncpy(result->model_number, objs[9].string.pointer, MAX_BATT_STRLEN-1);
-	strncpy(result->serial_number, objs[10].string.pointer, MAX_BATT_STRLEN-1);
-	strncpy(result->battery_type, objs[11].string.pointer, MAX_BATT_STRLEN-1);
-	strncpy(result->oem_info, objs[12].string.pointer, MAX_BATT_STRLEN-1);
+	Xstrncpy(result->model_number, objs[9].string.pointer, MAX_BATT_STRLEN-1);
+	Xstrncpy(result->serial_number, objs[10].string.pointer, MAX_BATT_STRLEN-1);
+	Xstrncpy(result->battery_type, objs[11].string.pointer, MAX_BATT_STRLEN-1);
+	Xstrncpy(result->oem_info, objs[12].string.pointer, MAX_BATT_STRLEN-1);
 	
 	kfree(buf.pointer);
 


And working around error in running sta makes it actually
usefull. This is ugly workaround, should not be applied to official
tree.

--- clean/drivers/acpi/namespace/nsxfobj.c	Wed Jan 31 16:14:33 2001
+++ linux/drivers/acpi/namespace/nsxfobj.c	Wed Jan 31 20:55:01 2001
@@ -591,14 +591,16 @@
 	 * Run _STA to determine if device is present
 	 */
 
+	printk("Running sta on %x: ", node);
 	status = acpi_cm_execute_STA (node, &flags);
 	if (ACPI_FAILURE (status)) {
-		return (status);
+		printk("error (%x)\n", status);
+		/* return (status); */
 	}
 
 	if (!(flags & 0x01)) {
 		/* don't return at the device or children of the device if not there */
-
+		printk("not there\n");
 		return (AE_CTRL_DEPTH);
 	}

And now questions: Why are numbers reported in hexadecimal? Reporting
voltage in hexadecimal is nice nonsense to me...

I believe that we should keep description: value format, and switch to
decimal. Plus, units are nonsensical in some cases:

Remaining Capacity: 59a
		    ~~~ should be in mAh, probably
Battery discharging
Battery rate 7c5
             ~~~ should be in either Ampers or Wats
Battery capacity 59a mA
                     ~~ capacity is in miliAmps * hours, or mAh (or we
could use wats, because we know voltage)
Battery voltage 2b8e volts
                     ~~~~~~ should be milivolts, or mV

_info is not much better:

Last Full Capacity e43 mA /hr
		       ~~~~~~ I believe this is meant to be mA *hr (or mAh)
Design Capacity fa0 mA /hr
                    ~~~~~~ same here
Secondary Battery Technology
Design Voltage 2a30 mV
Design Capacity Warning 74
Design Capacity Low 0
Battery Capacity Granularity 1 40
Battery Capacity Granularity 2 40
model number
serial number
battery type
OEM info unknown

(Oh, btw, those are actuall values from my toshiba satellite. It seems
it does not want to talk about its serial/model numbers; OEM info is
even NULL...)
								Pavel
PS: What should be difference between _info and _status? Both contain
fields that change with time...
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org


----- End forwarded message -----

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
