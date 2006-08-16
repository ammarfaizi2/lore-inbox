Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWHPJ1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWHPJ1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWHPJ1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:27:46 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:16306 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1751050AbWHPJ1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:27:45 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1 -resend] Char: mxser, upgrade to 1.9.1
Date: Wed, 16 Aug 2006 11:27:32 +0200
User-Agent: KMail/1.9.4
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@moxa.com.tw
References: <mxser191resend3_ee43092305ba163fd5d4@wsc.cz> <200608160831.12848.arekm@pld-linux.org> <20060815234512.0d3bc1d7.akpm@osdl.org>
In-Reply-To: <20060815234512.0d3bc1d7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608161127.32849.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 08:45, Andrew Morton wrote:

> > > Perhaps we could create an mxser-new.c and offer that in config, plan
> > > to remove mxser.c N months hence?
> >
> > I can test the updated driver with  MOXA CP-168U series board if it will
> > compile on 2.6.12.6.
>
> Thanks.
>
> > Unfortunately I can't change kernel to latest one there.
> > Will testing on 2.6.12.6 be enough for you?
[...]
> Perhaps it'll work if you apply the patch to 2.6.18-rc4 then copy the
> patched files over to 2.6.12..

I've copied 2.6.18rc4+1.9.1 update applied to 2.6.12 + applied patch below, started minicom
and tried to write something... at that moment machine blew up - instantly rebooted.
Nothing on serial console unfortunately. 

mxser.c from 2.6.18rc4 without proposed 1.9.1 patch works fine (+ problem described
here http://lkml.org/lkml/2005/11/2/175 no longer happens).

--- mxser.c.new.org     2006-08-16 10:50:44.578413363 +0200
+++ mxser.c     2006-08-16 10:54:07.399361546 +0200
@@ -85,7 +85,7 @@
 #define RELEVANT_IFLAG(iflag)  (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|\
                                          IXON|IXOFF))

-#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED : IRQF_DISABLED)
+#define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? SA_SHIRQ : SA_INTERRUPT)

 #define C168_ASIC_ID    1
 #define C104_ASIC_ID    2
@@ -1108,7 +1108,8 @@
                 */
                timeout = jiffies + HZ;
                while (!(inb(info->base + UART_LSR) & UART_LSR_TEMT)) {
-                       schedule_timeout_interruptible(5);
+                       set_current_state(TASK_INTERRUPTIBLE);
+                       schedule_timeout(5);
                        if (time_after(jiffies, timeout))
                                break;
                }
@@ -1129,8 +1130,10 @@
        info->event = 0;
        info->tty = NULL;
        if (info->blocked_open) {
-               if (info->close_delay)
-                       schedule_timeout_interruptible(info->close_delay);
+               if (info->close_delay) {
+                       set_current_state(TASK_INTERRUPTIBLE);
+                       schedule_timeout(info->close_delay);
+               }
                wake_up_interruptible(&info->open_wait);
        }

@@ -1870,7 +1873,8 @@
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
                printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
-               schedule_timeout_interruptible(char_time);
+               set_current_state(TASK_INTERRUPTIBLE);
+               schedule_timeout(char_time);
                if (signal_pending(current))
                        break;
                if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -2054,7 +2058,7 @@

        spin_lock_irqsave(&info->slock, flags);

-       recv_room = tty->receive_room;
+       recv_room = tty->ldisc.receive_room(tty);
        if ((recv_room == 0) && (!info->ldisc_stop_rx)) {
                /* mxser_throttle(tty); */
                mxser_stoprx(tty);

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
