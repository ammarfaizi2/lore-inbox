Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbTCSIGJ>; Wed, 19 Mar 2003 03:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbTCSIGJ>; Wed, 19 Mar 2003 03:06:09 -0500
Received: from newglider.melbpc.org.au ([203.12.152.9]:64778 "EHLO
	relay9.melbpc.org.au") by vger.kernel.org with ESMTP
	id <S262943AbTCSIF6>; Wed, 19 Mar 2003 03:05:58 -0500
Message-ID: <3E782567.3020008@melbpc.org.au>
Date: Wed, 19 Mar 2003 19:08:07 +1100
From: Tim Josling <tej@melbpc.org.au>
Organization: Melbourne PC User Group
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Philip.Blundell@pobox.com
Subject: [PATCH] to drivers/parport/ieee1284_ops.c to fix timing dependend
X-RAVMilter-Version: 8.3.4(snapshot 20020706) (relay9)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 [PATCH] to drivers/parport/ieee1284_ops.c to fix timing dependent printer
 hang
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Philip (Blundell),

I have an HP1100 printer and since I upgraded to a faster CPU the 
printer has started hanging. The problem persisteed across 2.0 2.2 and 
2.4 kernel versions. I am running Red Hat Linux 8.0 on a Compaq Armada E500.

The problem occurs intermittently. The symptom is that the 'buffer 
contains data' light stays on on the printer, but data transfer stops.

I traced the problem to drivers/parport/ieee1284_ops.c function 
parport_ieee1284_write_compat. The problem occurs when the parallel port 
is not using interrupts. If the printer takes a while to respond the 
routine parport_wait_event gets called, if count == 0. However this 
routine generally waits almost no time.

Anyway, if 32 repeats of this occur e.g. for a complex document where 
the printer is slow, 'wait' ends up as a negative number from repeated 
doublings due to the way twos complement arithmetic works in C. In this 
case the routine never returns. So no more data gets sent to the printer.

Originally I fixed the problem by adding code to ensure that 'wait' 
never got set to anything above 10 seconds (10 * HZ). However the patch 
I have sent you does something different, it just ensures that 
parport_wait_event never gets called for printer without interrupt. I 
have tested this on documents which reproduce the problem

Clearly I am not an expert on the parport code, so my patch may be 
incorrect. I have traces using extra printks I put in the code, showing 
the wait variable being doubled to negative value, available on request.

Definitely my patch does fix a real problem on my system.

As far as I can tell from browsing the patches since 2.4.18, there has 
not been any other fix for this problem to date.

I would appreciate if any replues could be cc'd to me, though I will 
look at the archives to see any responses.

Regards,
Tim Josling

--- ChangeLog.original    2003-03-16 09:18:07.000000000 +1100
+++ ChangeLog    2003-03-16 09:20:35.000000000 +1100
@@ -1,3 +1,9 @@
+2003-03-16  Tim Josling  <tej@melbpc.org.au>
+
+    * ieee1284_ops.c (parport_ieee1284_write_compat): Avoid calling
+    parport_wait_event if interrupts are not enabled for device, avoid
+    output hang.
+
  2002-04-25  Tim Waugh  <twaugh@redhat.com>

      * parport_serial.c, parport_pc.c: Move some SIIG cards around.


--- ieee1284_ops.c.original    2003-03-16 08:27:33.000000000 +1100
+++ ieee1284_ops.c    2003-03-16 09:17:23.000000000 +1100
@@ -93,7 +93,7 @@
                             first time around the loop, don't let go of
                             the port.  This way, we find out if we have
                             our interrupt handler called. */
-            if (count && no_irq) {
+            if (count || no_irq) {
                  parport_release (dev);
                  __set_current_state (TASK_INTERRUPTIBLE);
                  schedule_timeout (wait);

