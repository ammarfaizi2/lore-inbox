Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTIBUU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTIBUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:20:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:9351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264030AbTIBUUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:20:19 -0400
Date: Tue, 2 Sep 2003 13:03:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dale E Martin" <dmartin@cliftonlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more
 details)
Message-Id: <20030902130323.41d2fdca.akpm@osdl.org>
In-Reply-To: <20030902123050.GA854@cliftonlabs.com>
References: <20030902003146.GA870@cliftonlabs.com>
	<20030901182335.4c2e220f.akpm@osdl.org>
	<20030902123050.GA854@cliftonlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dale E Martin" <dmartin@cliftonlabs.com> wrote:
>
> And then I got one more at 590, inside i8042_check_mux:
>     DB();
>     if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
> 						  "i8042", i8042_request_irq_cookie))
>                 return -1;
> 		DB();
> 
> This last one did not show up, nor did any inside the conditional loops at
> line 878 or 883, nor at line 888.  So perhaps it was in request_irq that it
> locked up?

Looks like it.  Please add a DB() to the start of i8042_interrupt(),
see if we locked up in an interrupt storm.  Also sprinkle some in 
request_irq() I guess.  You know the deal ;)

There's an ugly in the irq code there: if i8042_check_mux() or
i8042_check_mux() are called while the device is open we end up freeing the
wrong IRQ.  It is unlikely to help though.


--- 25/drivers/input/serio/i8042.c~i8042-free_irq-fix	Tue Sep  2 12:55:23 2003
+++ 25-akpm/drivers/input/serio/i8042.c	Tue Sep  2 12:57:19 2003
@@ -581,6 +581,7 @@ void i8042_controller_cleanup(void)
 static int __init i8042_check_mux(struct i8042_values *values)
 {
 	unsigned char param;
+	static int i8042_check_mux_cookie;
 	int i;
 
 /*
@@ -588,9 +589,9 @@ static int __init i8042_check_mux(struct
  */
 
 	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
-				"i8042", i8042_request_irq_cookie))
+				"i8042", &i8042_check_mux_cookie))
                 return -1;
-	free_irq(values->irq, i8042_request_irq_cookie);
+	free_irq(values->irq, &i8042_check_mux_cookie);
 
 /*
  * Get rid of bytes in the queue.
@@ -653,6 +654,7 @@ static int __init i8042_check_mux(struct
 static int __init i8042_check_aux(struct i8042_values *values)
 {
 	unsigned char param;
+	static int i8042_check_aux_cookie;
 
 /*
  * Check if AUX irq is available. If it isn't, then there is no point
@@ -660,9 +662,9 @@ static int __init i8042_check_aux(struct
  */
 
 	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
-				"i8042", i8042_request_irq_cookie))
+				"i8042", &i8042_check_aux_cookie))
                 return -1;
-	free_irq(values->irq, i8042_request_irq_cookie);
+	free_irq(values->irq, &i8042_check_aux_cookie);
 
 /*
  * Get rid of bytes in the queue.

_

