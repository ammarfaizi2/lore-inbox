Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUGTGiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUGTGiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 02:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUGTGiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 02:38:02 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:45699 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265722AbUGTGh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 02:37:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Input patches
Date: Tue, 20 Jul 2004 01:37:54 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407200137.56150.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

Now that my driver core patches have been merged in Linus' tree I would
like finish merging input patches. Please do:

       bk pull bk//dtor.bkbits.net/input

You will pull the following patches (along with whatever was in Linus'
tree as of last evening):

01-drivers-makefile.patch
	- move input/serio closer to the top of drivers/Makefile so
	  serio_bus structure initialized early and is ready by the time
	  sunzilog and sunsu register their serio ports.

02-sunzilog-serio-register.patch
	- Do not attempt to register serio ports while holding a spinlock
          and with interrupts off. Fully initialize hardware first and
	  only then register. Cures lockup reported by WLI.

03-i8042-broken-mux-workaround.patch
	- Some MUXes get confused what AUX port the byte came from. Assume
	  that is came from the same port previous byte came from if it
	  arrived within HZ/10

04-serio-pause-rx.patch
	- Add serio_pause_rx and serio_continue_rx that take serio->lock and
	  can be used by drivers to protect their critical sections from
	  interrupt handler.

05-psmouse-set-state.patch
	- Use serio_pause_rx/serio_continue_rx when changing psmosuee state
	  (active, ignore)

06-psmouse-initializing.patch
	- Add a new state PSMOUSE_INITIALIZING and do not try to call protocol
	  handler for mice in this state. Shoudl help with OOPS caused by USB
	  Legacy emulation generating wierd data stream when probing for mouse

07-synaptics-passthrough-handling.patch
	- If data looks like a pass-through packet and tuchpad has pass-
          through capability do not pass it to the main handler if child port
          is disconnected. Let serio core sort it out and bind a proper driver
	  to the port

08-psmouse-reconnect.patch
	- Instead of wierd rule that connect should not activate mouse if
	  there is a pass-through port and have child do activation do the
	  following:
	  1. Connect/reconnect always activate port in question
	  2. If port is a pass-through port connect/reconnect will
             deactivate parent at the beginning of the probe and will
             activate it after everything is done.
	  This allows reliably reconnect children ports in response to user
          request (echo -n "reconnect" > /sys/bus...)
