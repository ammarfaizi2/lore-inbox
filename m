Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUEXH4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUEXH4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEXH4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:56:47 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50840 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261628AbUEXH4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:56:44 -0400
To: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] Bug Fix: 2.6.{5,6,7-rc1}: i8042 module unload bug
References: <xb77jvkscop.fsf@savona.informatik.uni-freiburg.de> <xb7oepax34q.fsf@savona.informatik.uni-freiburg.de> <Pine.GSO.4.58.0405030953100.11293@stekt37> <xb7ad0pu40e.fsf@savona.informatik.uni-freiburg.de> <xb71xlwtz9s.fsf@savona.informatik.uni-freiburg.de>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 24 May 2004 09:56:42 +0200
Message-ID: <xb7hdu6i7gl.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm wondering why 2.6.7-rc1 does NOT contain the following patch.

        See: http://lkml.org/lkml/2004/5/10/63


--- linux-2.6.7-rc1/drivers/input/serio/i8042.c
+++ linux-2.6.7-rc1.i8042-shutdown-fix/drivers/input/serio/i8042.c
@@ -990,24 +990,28 @@
 	unregister_reboot_notifier(&i8042_notifier);
 
 	if (i8042_pm_dev)
 		pm_unregister(i8042_pm_dev);
 
 	if (i8042_sysdev_initialized) {
 		sysdev_unregister(&device_i8042);
 		sysdev_class_unregister(&kbc_sysclass);
 	}
 
-	del_timer_sync(&i8042_timer);
-
 	i8042_controller_cleanup();
 	
+	/* we must delete the timer AFTER the i8042 chip is cleaned up,
+	   so as to prevent any more interrupts to invoke i8042_interrupt()
+	   which then schedules newer timer events.
+	*/
+	del_timer_sync(&i8042_timer);
+
 	if (i8042_kbd_values.exists)
 		serio_unregister_port(&i8042_kbd_port);
 
 	if (i8042_aux_values.exists)
 		serio_unregister_port(&i8042_aux_port);
 	
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists)
 			serio_unregister_port(i8042_mux_port + i);
 



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

