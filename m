Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVBWVJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVBWVJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVBWVJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:09:21 -0500
Received: from station174.com ([203.194.240.137]:60593 "HELO station174.com")
	by vger.kernel.org with SMTP id S261592AbVBWVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:07:51 -0500
Message-ID: <421CF0C2.7010303@tommywatson.com>
Date: Wed, 23 Feb 2005 16:08:18 -0500
From: tom watson <lkml@tommywatson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050102
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/wan/z85230.c
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020005020905090006050005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005020905090006050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


While working on a driver for z85230 based board I noticed what looks 
like it could be a problem. If the interrupt handler is handling an 
interrupt on port b and an interrupt comes in for port a, it seems to me 
that the port b handler would be called instead of the port a handler, 
and possibly hang the board until reset.

Attached is a patch to set the irq methods back to port a before 
attempting to call them.

Cheers,
 Tom.


--------------020005020905090006050005
Content-Type: text/x-patch;
 name="z85230.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="z85230.c.patch"

--- linux-2.6.10/drivers/net/wan/z85230.c	2004-12-24 16:33:49.000000000 -0500
+++ /home/watsontj/z85230.c	2005-02-23 15:26:32.911085451 -0500
@@ -734,7 +734,7 @@
 	u8 intr;
 	static volatile int locker=0;
 	int work=0;
-	struct z8530_irqhandler *irqs=dev->chanA.irqs;
+	struct z8530_irqhandler *irqs;
 	
 	if(locker)
 	{
@@ -758,6 +758,8 @@
 		/* Now walk the chip and see what it is wanting - it may be
 		   an IRQ for someone else remember */
 		   
+		irqs=dev->chanA.irqs;
+
 		if(intr & (CHARxIP|CHATxIP|CHAEXT))
 		{
 			if(intr&CHARxIP)

--------------020005020905090006050005--
