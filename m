Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUELJln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUELJln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 05:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUELJln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 05:41:43 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:31139 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264912AbUELJll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 05:41:41 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Fernando Paredes <Fernando.Paredes@Sun.COM>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Toshiba keyboard lockups
Date: Wed, 12 May 2004 11:49:37 +0200
User-Agent: KMail/1.5
References: <40A162BA.90407@sun.com>
In-Reply-To: <40A162BA.90407@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121149.37334.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 of May 2004 01:33, Fernando Paredes wrote:
> There was a previous thread on this, last month.
>
> I updated to 2.6.6 and I still get these random lockups. Nothing in
> dmesg or /var/log/messages. Too annoying as I have to reboot the machine
> constantly. Does anyone know the status on this? Is t a toshiba hardware
> bug (is that possible?) or a bug in serio.c or keybd.c?

It's most probably Toshiba-related, because it does not happen on other 
hardware, it seems.

I've got a simple patch from Grzegorz Kulewski to help trace the problem, but 
I haven't got a lockup since.  The patch is as follows:

--- /usr/src/linux-2.6.5/drivers/input/serio/serio.c.orig	2004-04-04 
05:36:15.000000000 +0200
+++ /usr/src/linux-2.6.5/drivers/input/serio/serio.c	2004-04-09 
18:28:50.268521936 +0200
@@ -166,6 +166,11 @@ static int serio_thread(void *nothing)
 static void serio_queue_event(struct serio *serio, int event_type)
 {
 	struct serio_event *event;
+	
+	if (event_type == SERIO_RESCAN || event_type == SERIO_RECONNECT) {
+		printk(KERN_WARNING "serio: RESCAN || RECONNECT requested: %d!\n", 
event_type);
+		dump_stack();
+	}
 
 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
 		event->type = event_type;

Please try to apply it and you should get something in the logs when a lockup 
occurs (ie. kernel warning + call trace).

RJW

