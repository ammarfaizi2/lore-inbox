Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUCDLwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCDLwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:52:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:14226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261847AbUCDLv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:51:58 -0500
Date: Thu, 4 Mar 2004 03:52:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport compile error in 2.6.4-r2c (sparc64)
Message-Id: <20040304035207.5b526efc.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0403041144040.2398-100000@math.ut.ee>
References: <Pine.GSO.4.44.0403041144040.2398-100000@math.ut.ee>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> wrote:
>
>  drivers/parport/parport_sunbpp.c: In function `init_one_port':
>  drivers/parport/parport_sunbpp.c:338: warning: passing arg 2 of `request_irq' from incompatible pointer type
>  drivers/parport/parport_sunbpp.c: In function `parport_sunbpp_exit':
>  drivers/parport/parport_sunbpp.c:387: error: incompatible type for argument 1 of `list_empty'

Does this fix?


diff -puN drivers/parport/parport_sunbpp.c~parport_sunbpp-build-fix drivers/parport/parport_sunbpp.c
--- 25/drivers/parport/parport_sunbpp.c~parport_sunbpp-build-fix	2004-03-04 03:49:57.000000000 -0800
+++ 25-akpm/drivers/parport/parport_sunbpp.c	2004-03-04 03:50:48.000000000 -0800
@@ -44,9 +44,11 @@
 #define dprintk(x)
 #endif
 
-static void parport_sunbpp_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t parport_sunbpp_interrupt(int irq, void *dev_id,
+						struct pt_regs *regs)
 {
 	parport_generic_irq(irq, (struct parport *) dev_id, regs);
+	return IRQ_HANDLED;
 }
 
 static void parport_sunbpp_disable_irq(struct parport *p)
@@ -384,7 +386,7 @@ static int __init parport_sunbpp_init(vo
 
 static void __exit parport_sunbpp_exit(void)
 {
-	while (!list_empty(port_list)) {
+	while (!list_empty(&port_list)) {
 		Node *node = list_entry(port_list.next, Node, list);
 		struct parport *p = node->port;
 		struct parport_operations *ops = p->ops;

_

