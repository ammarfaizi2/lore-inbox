Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVHIGQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVHIGQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 02:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHIGQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 02:16:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbVHIGQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 02:16:16 -0400
Date: Mon, 8 Aug 2005 23:14:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, nacc@us.ibm.com, domen@coderock.org
Subject: Re: [patch 16/16] block/ps2esdi: replace sleep_on() with
 wait_event()
Message-Id: <20050808231443.3a74c512.akpm@osdl.org>
In-Reply-To: <20050808223100.045700000@homer>
References: <20050808222936.090422000@homer>
	<20050808223100.045700000@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
>  Use wait_event() instead of the deprecated sleep_on(). In all
>  replacements, wait_event() expects the condition to *stop* on, so the existing
>  conditional is negated and passed as the parameter. I am not sure if these
>  changes are appropriate, as the condition to pass to wait_event() to guarantee
>  the same behavior; I think this is the best choice, though.
> 
>  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>  Signed-off-by: Domen Puncer <domen@coderock.org>
>  ---
>   ps2esdi.c |    7 +++----
>   1 files changed, 3 insertions(+), 4 deletions(-)
> 
>  Index: quilt/drivers/block/ps2esdi.c
>  ===================================================================
>  --- quilt.orig/drivers/block/ps2esdi.c
>  +++ quilt/drivers/block/ps2esdi.c
>  @@ -43,6 +43,7 @@
>   #include <linux/init.h>
>   #include <linux/ioport.h>
>   #include <linux/module.h>
>  +#include <linux/delay.h>
>   
>   #include <asm/system.h>
>   #include <asm/io.h>
>  @@ -461,8 +462,7 @@ static void __init ps2esdi_get_device_cf
>   	cmd_blk[1] = 0;
>   	no_int_yet = TRUE;
>   	ps2esdi_out_cmd_blk(cmd_blk);
>  -	if (no_int_yet)
>  -		sleep_on(&ps2esdi_int);
>  +	wait_event(ps2esdi_int, !no_int_yet);
>   
>   	if (ps2esdi_drives > 1) {
>   		printk("%s: Drive 1\n", DEVICE_NAME);	/*BA */
>  @@ -470,8 +470,7 @@ static void __init ps2esdi_get_device_cf
>   		cmd_blk[1] = 0;
>   		no_int_yet = TRUE;
>   		ps2esdi_out_cmd_blk(cmd_blk);
>  -		if (no_int_yet)
>  -			sleep_on(&ps2esdi_int);
>  +		wait_event(ps2esdi_int, !no_int_yet);
>   	}			/* if second physical drive is present */
>   	return;
>   }

hm, what a racy driver.

	wake_up(&ps2esdi_int);
	no_int_yet = FALSE;

these should be in the other order, no?

Anyway, I think I'll duck this patch until someone can say "it works".

