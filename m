Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEGIbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEGIbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUEGIbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:31:25 -0400
Received: from se2.ruf.uni-freiburg.de ([132.230.2.222]:23241 "EHLO
	se2.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261205AbUEGIbV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:31:21 -0400
X-Scanned: Fri, 7 May 2004 10:30:40 +0200 Nokia Message Protector V1.3.30 2004040916 - RELEASE
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>, Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: [PATCH] Bug Fix: 2.6.5 broken module dependencies: i8042 and atkbd?
References: <xb7oepax34q.fsf@savona.informatik.uni-freiburg.de> <Pine.GSO.4.58.0405030953100.11293@stekt37> <xb7ad0pu40e.fsf@savona.informatik.uni-freiburg.de>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 07 May 2004 10:30:39 +0200
Message-ID: <xb71xlwtz9s.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Dan> I've successfully and repeated hanged vanilla 2.6.5 kernel.
    Dan> Here is how I do it:

    Dan> 1) Configure and compile kernel (on Intel x86) so that
    Dan>    'serio', 'i8042', 'atkbd' are all modules.  i.e.
    Dan>    CONFIG_SERIO_I8042=m CONFIG_SERIO=m CONFIG_KEYBOARD_ATKBD=m

    Dan> 2) Boot the compiled kernel.  
    Dan> 3) Log in from network.  
    Dan> 4) modprobe the following modules in order: serio, i8042, atkbd

    Dan> 5) Now, keyboard works, as expected.  6) rmmod i8042 ===>
    Dan>    hangs.  CAPSLOCK doesn't respond (of course, i8042 is
    Dan>    rmoved), machine doesn't respond to ping (why?), although my
    Dan>    PCMCIA network card still blinks and the hardware indicate of
    Dan>    PCMCIA activity also blinks.  But (un)plugging the PCMCIA
    Dan>    card gives no response.

    Dan> The same is observed in 2.6.6-rc3.

I've found and fixed the bug.

It has  nothing to  do with module  dependencies.  Rather, it's  a bug
with improper shutdown of a timer.


Cause: When the i8042 module  is unloaded, the i8042_exit() shuts down
       it  timer  by calling  del_timer_sync().   However, after  that
       call, there can still be interrupts from the i8042 chip (due to
       keyboard  or  mouse activities).   Such  interrupts invoke  the
       interrupt   handler   i8042_interrupt(),   which   would   call
       mod_timer() to reschedule a  new timer event.  But i8042_exit()
       won't want  for this new timer  event.  It may  exit before the
       event arrives.   The module is unloaded  as i8042_exit() exits,
       but this  can happen  before the new  timer event comes.   As a
       result,  when  the timer  expires,  the  kernel  tries to  call
       i8042_timer_func(), which has been unloaded!  This results in a
       complete freeze.

The Fix: is  to make sure interrupts from the  i8042 chip are disabled
         before calling  del_timer_sync() to  clean up the  timer.  In
         i8042_exit(), this  is as easy  as swapping the order  of the
         calls to del_timer_sync() and i8042_controller_cleanup().


The Patch:



--- i8042.c	2004/05/06 13:24:46	1.1
+++ i8042.c	2004/05/06 15:17:50	1.2
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

