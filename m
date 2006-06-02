Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWFBVXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWFBVXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWFBVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:23:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32417 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030292AbWFBVX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:23:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:cc:subject:message-id:references:mime-version:content-type;
        b=iLSCNncOFG5EWgpVtjRVTXqpdRrTA7Rk5vowEtsggAqsh+zcQiN5tIxk1Lwb8hiYOZTdxQCvnHYPWqCrREamcX3kPI0bKvQTG0sYqyTDieqD5YWa3QDLSxpnPLdCEZwv3yiDdGpXCflmzBZ4Sc+MMH+IMwIezq+0NP4lIocet40=
Date: Fri, 2 Jun 2006 23:23:41 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>
Subject: [patch 4/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
Message-ID: <Pine.LNX.4.64.0606022322140.9307@localhost>
References: <20060602165336.147812000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes it possible for the 8250 serial driver to have it's interrupt handler
in both hard-irq and threaded context under PREEMPT_RT.

Index: linux-2.6.16-rt23.spin_mutex/drivers/serial/8250.c
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/drivers/serial/8250.c
+++ linux-2.6.16-rt23.spin_mutex/drivers/serial/8250.c
@@ -140,7 +140,7 @@ struct uart_8250_port {
  };

  struct irq_info {
-	spinlock_t		lock;
+	spin_mutex_t		lock;
  	struct list_head	*head;
  };

@@ -1287,6 +1287,47 @@ serial8250_handle_port(struct uart_8250_
  	spin_unlock(&up->port.lock);
  }

+
+static int serial8250_change_context(int irq, void *dev_id,
+				     enum change_context_cmd cmd)
+{
+	struct irq_info *i = dev_id;
+	struct list_head *l;
+
+	switch(cmd) {
+	case IRQ_TO_HARDIRQ:
+		/* Spin mutexes not available: */
+		if(!spin_mutexes_can_spin())
+			return -ENOSYS;
+
+		/* First do the inner locks */
+		l = i->head;
+		do {
+			struct uart_8250_port *up;
+			up = list_entry(l, struct uart_8250_port, list);
+			spin_mutex_to_spin(&up->port.lock);
+			l = l->next;
+		} while(l != i->head && l != NULL);
+		spin_mutex_to_spin(&i->lock);
+		break;
+	case IRQ_CAN_THREAD:
+		break;
+	case IRQ_TO_THREADED:
+		spin_mutex_to_mutex(&i->lock);
+		l = i->head;
+
+		do {
+			struct uart_8250_port *up;
+			up = list_entry(l, struct uart_8250_port, list);
+			spin_mutex_to_mutex(&up->port.lock);
+			l = l->next;
+		} while(l != i->head && l != NULL);
+		break;
+	}
+
+	return 0;
+}
+
  /*
   * This is the serial driver's interrupt routine.
   *
@@ -1393,8 +1434,10 @@ static int serial_link_irq_chain(struct
  		i->head = &up->list;
  		spin_unlock_irq(&i->lock);

-		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  irq_flags, "serial", i);
+		ret = request_irq2(up->port.irq, serial8250_interrupt,
+				   irq_flags | SA_MUST_THREAD_RT,
+				   "serial", i,
+				   serial8250_change_context);
  		if (ret < 0)
  			serial_do_unlink(i, up);
  	}
Index: linux-2.6.16-rt23.spin_mutex/include/linux/serial_core.h
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/include/linux/serial_core.h
+++ linux-2.6.16-rt23.spin_mutex/include/linux/serial_core.h
@@ -206,7 +206,7 @@ struct uart_icount {
  typedef unsigned int __bitwise__ upf_t;

  struct uart_port {
-	spinlock_t		lock;			/* port lock */
+	spin_mutex_t		lock;			/* port lock */
  	unsigned int		iobase;			/* in/out[bwl] */
  	unsigned char __iomem	*membase;		/* read/write[bwl] */
  	unsigned int		irq;			/* irq number */

--
