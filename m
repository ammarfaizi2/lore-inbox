Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTHBQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbTHBQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 12:33:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31236 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269589AbTHBQdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 12:33:55 -0400
Date: Sat, 2 Aug 2003 17:33:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-test1, PCMCIA cards require two insertions
Message-ID: <20030802173352.A1895@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030725210242.GH15537@iarc.uaf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030725210242.GH15537@iarc.uaf.edu>; from cswingle@iarc.uaf.edu on Fri, Jul 25, 2003 at 01:02:42PM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 01:02:42PM -0800, Christopher Swingley wrote:
> I'm running 2.6.0-test1 on an SiS based laptop with all the PCMCIA 
> network and serial drivers built into the kernel.  When the system boots 
> with a PCMCIA cardbus card in place, the card doesn't show up.  I unplug 
> the card and plug it back in, and then the kernel "sees" it and it 
> works.  If I unplug it again, I have to go through a plug - unplug - 
> plug cycle before it recognizes it.  As if it only recognizes the card 
> on even numbered insertion events.

Hmm, weird - I'm not seeing that behaviour here.  Can you report back
with kernel messages with the following patch applied please?

--- linux/drivers/pcmcia/cs.c.old	Sat Aug  2 17:25:45 2003
+++ linux/drivers/pcmcia/cs.c	Sat Aug  2 17:32:49 2003
@@ -579,6 +579,7 @@
 
 static void socket_shutdown(struct pcmcia_socket *skt)
 {
+printk("socket_shutdown: skt %p\n", skt);
 	socket_remove_drivers(skt);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(cs_to_timeout(shutdown_delay));
@@ -590,7 +591,7 @@
 static int socket_reset(struct pcmcia_socket *skt)
 {
 	int status, i;
-
+printk("socket_reset: skt %p\n", skt);
 	skt->socket.flags |= SS_OUTPUT_ENA | SS_RESET;
 	skt->ops->set_socket(skt, &skt->socket);
 	udelay((long)reset_time);
@@ -622,6 +623,7 @@
 	int status, i;
 
 	skt->ops->get_status(skt, &status);
+printk("socket_setup: skt %p status %08x\n", skt, status);
 	if (!(status & SS_DETECT))
 		return CS_NO_CARD;
 
@@ -704,7 +706,7 @@
 static int socket_insert(struct pcmcia_socket *skt)
 {
 	int ret;
-
+printk("socket_insert: skt %p\n", skt);
 	if (!try_module_get(skt->owner))
 		return CS_NO_CARD;
 
@@ -728,6 +730,7 @@
 
 static int socket_suspend(struct pcmcia_socket *skt)
 {
+printk("socket_suspend: skt %p state %08x\n", skt, skt->state);
 	if (skt->state & SOCKET_SUSPEND)
 		return CS_IN_USE;
 
@@ -748,7 +751,7 @@
 static int socket_resume(struct pcmcia_socket *skt)
 {
 	int ret;
-
+printk("socket_resume: skt %p state %08x\n", skt, skt->state);
 	if (!(skt->state & SOCKET_SUSPEND))
 		return CS_IN_USE;
 
@@ -782,6 +785,7 @@
 
 static void socket_remove(struct pcmcia_socket *skt)
 {
+printk("socket_remove: skt %p\n", skt);
 	socket_shutdown(skt);
 	module_put(skt->owner);
 }
@@ -808,6 +812,7 @@
 		}
 
 		skt->ops->get_status(skt, &status);
+printk("socket %p status %08x\n", skt, status);
 		if ((skt->state & SOCKET_PRESENT) &&
 		     !(status & SS_DETECT))
 			socket_remove(skt);
@@ -866,6 +871,7 @@
 
 void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
 {
+printk("parse_events: socket %p thread %p events %08x\n", s, s->thread, events);
 	if (s->thread) {
 		spin_lock(&s->thread_lock);
 		s->thread_events |= events;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

