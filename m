Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbTCIVeB>; Sun, 9 Mar 2003 16:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbTCIVeB>; Sun, 9 Mar 2003 16:34:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:21698 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262634AbTCIVeA>;
	Sun, 9 Mar 2003 16:34:00 -0500
Date: Sun, 9 Mar 2003 13:45:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around console initialization ordering problem
Message-Id: <20030309134506.5809262b.akpm@digeo.com>
In-Reply-To: <20030309163242.GA2335@averell>
References: <20030309163242.GA2335@averell>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 21:44:33.0638 (UTC) FILETIME=[1291D060:01C2E685]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> 
> Works around the console ordering problem in 2.5.64-bk3. Following 
> the similar fix I did for x86-64.
> ...
> +	if (!strstr(saved_command_line, "console="))
> +	     strcat(saved_command_line, " console=tty0");
> +

We can do it by shuffling the link order:


diff -puN drivers/Makefile~console-ordering-fix drivers/Makefile
--- 25/drivers/Makefile~console-ordering-fix	2003-03-09 02:48:33.000000000 -0800
+++ 25-akpm/drivers/Makefile	2003-03-09 02:48:33.000000000 -0800
@@ -11,9 +11,10 @@ obj-$(CONFIG_ACPI)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
+obj-y				+= char/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
-obj-y				+= base/ char/ block/ misc/ net/ media/
+obj-y				+= base/ block/ misc/ net/ media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_IDE)		+= ide/

_

