Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJ2UAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJ2UAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbUJ2T7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:59:23 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:59056 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261875AbUJ2TzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:55:11 -0400
X-Ironport-AV: i="3.86,110,1096866000"; 
   d="scan'208"; a="99833181:sNHT32356940"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Fri, 29 Oct 2004 14:55:10 -0500
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcS98TGneZx/IxNIT1OIKOiGJl9rHw==
From: <Tim_T_Murphy@Dell.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Oct 2004 19:55:10.0649 (UTC) FILETIME=[32932A90:01C4BDF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am new to the list, hope this is ok..
I've read about several problems others are having with the new 2.6 serial driver in the list, and tried to see if their solutions solved my issue also, but unfortunately none that I have tried yet have helped.

We're migrating our applications for the Dell Remote Access Controller (DRAC) to run on a 2.6 kernel from a 2.4 kernel. Communication between the apps and the DRAC happen over a ppp link which is established via a service startup script; the script uses setserial to prepare an unused tty (based on the assigned hardware information, obtained via lspci), and the script then calls pppd to finish/establish the link.

Everything works fine with the UP kernel -- Although, there is a message in syslog regarding a spinlock (issued at approximately the same point in time where the SMP kernel hangs):
---
Oct 29 13:34:47 racjag-1 kernel: CSLIP: code copyright 1989 Regents of the University of California
Oct 29 13:34:47 racjag-1 kernel: PPP generic driver version 2.4.2
Oct 29 13:34:47 racjag-1 udev[3875]: creating device node '/dev/ppp'
Oct 29 13:34:47 racjag-1 pppd[3884]: pppd 2.4.2 started by root, uid 0
Oct 29 13:34:47 racjag-1 racser: pppd startup succeeded
Oct 29 13:34:48 racjag-1 chat[3886]: send (CLIENT^M)
Oct 29 13:34:48 racjag-1 chat[3886]: expect (CLIENTSERVER)
Oct 29 13:34:48 racjag-1 kernel: drivers/serial/serial_core.c:102: spin_lock(drivers/serial/serial_core.c:023f2548) already locked by drivers/serial/8250.c/1015
Oct 29 13:34:48 racjag-1 kernel: drivers/serial/8250.c:1017: spin_unlock(drivers/serial/serial_core.c:023f2548) not locked
Oct 29 13:34:48 racjag-1 chat[3886]: CLIENTSERVER
Oct 29 13:34:48 racjag-1 chat[3886]:  -- got it 
Oct 29 13:34:48 racjag-1 chat[3886]: send ()
Oct 29 13:34:48 racjag-1 pppd[3884]: Serial connection established.
Oct 29 13:34:48 racjag-1 pppd[3884]: Using interface ppp0
Oct 29 13:34:48 racjag-1 pppd[3884]: Connect: ppp0 <--> /dev/ttyS2
Oct 29 13:34:49 racjag-1 pppd[3884]: local  IP address 192.168.234.235
Oct 29 13:34:49 racjag-1 pppd[3884]: remote IP address 192.168.234.236
---

With the SMP kernel, it hangs very soon after starting pppd.
I enabled DEBUG in the serial driver and captured the syslog when the problem happens, but this is not detailed enough for me to finger the exact problem:
---
Oct 28 14:04:52 racjag-1 kernel: CSLIP: code copyright 1989 Regents of the University of California
Oct 28 14:04:52 racjag-1 kernel: PPP generic driver version 2.4.2
Oct 28 14:04:52 racjag-1 udev[3621]: creating device node '/dev/ppp'
Oct 28 14:05:19 racjag-1 kernel: uart_open(2) called
Oct 28 14:05:19 racjag-1 kernel: Trying to free nonexistent resource <00000000-00000007>
Oct 28 14:05:19 racjag-1 kernel: uart_close(2) called
Oct 28 14:05:19 racjag-1 kernel: uart_flush_buffer(2) called
Oct 28 14:05:19 racjag-1 kernel: uart_open(2) called
Oct 28 14:05:19 racjag-1 kernel: uart_close(2) called
Oct 28 14:05:19 racjag-1 kernel: uart_flush_buffer(2) called
Oct 28 14:05:19 racjag-1 pppd[3681]: pppd 2.4.1 started by root, uid 0
Oct 28 14:05:19 racjag-1 kernel: uart_open(2) called
Oct 28 14:05:19 racjag-1 racser: pppd startup succeeded
Oct 28 14:05:20 racjag-1 kernel: uart_open(2) called
Oct 28 14:05:20 racjag-1 kernel: uart_close(2) called
Oct 28 14:05:20 racjag-1 chat[3683]: send (CLIENT^M)
---
The system hangs right there; must press and hold power to get the system to shut down.

Any suggestions to narrow down the cause?  Please cc my email as I do not subscribe to this list.
Thanks,
Tim

