Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVFHV2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVFHV2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVFHV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:28:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:26822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261902AbVFHV15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:27:57 -0400
Date: Wed, 8 Jun 2005 14:26:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Greg KH <greg@kroah.com>
Subject: Re: BUG in i2c_detach_client
Message-Id: <20050608142631.7e956792.akpm@osdl.org>
In-Reply-To: <200506081033.12445.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<200506081033.12445.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade <ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> wrote:
>
> 2.6.12-rc5-mm1 didn't crash.
> 
>  kernel BUG at include/linux/list.h:166!
>  invalid operand: 0000 [#1]
>  PREEMPT
>  CPU:    0
>  EIP:    0060:[<c0319cd4>]    Not tainted VLI
>  EFLAGS: 00010a83   (2.6.12-rc6-mm1)
>  EIP is at i2c_detach_client+0xb4/0x110
>  eax: dfc0bcc0   ebx: c15fc26c   ecx: c15fc264   edx: c04378d0
>  esi: c15fc14c   edi: c0437720   ebp: 00000000   esp: dff81f10
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 1, threadinfo=dff80000 task=c14dca00)
>  Stack: dfff6110 dfc0bdb4 00000286 00000286 c15fc26c c15fc14c c15fc160 ffffffed
>         c031d512 c15fc160 c03edac1 c15fc26c 00000000 0000002d 00000001 0000002d
>         c0437720 00000000 c0437c5c 00000001 00000000 c031b100 00000000 00000000
>  Call Trace:
>   [<c031d512>] asb100_detect+0x442/0x520

Were there no interesting printks before this BUG hit?

It's due to the kernel running list_del() on a list_head which isn't on a list.

Seems there is an error-path bug in that driver, but I don' thtink the fix
will fix it.  Please test?


From: Andrew Morton <akpm@osdl.org>

Fix error backing-out code in asb100.c

Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/i2c/chips/asb100.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN drivers/i2c/chips/asb100.c~asb100-fix drivers/i2c/chips/asb100.c
--- 25/drivers/i2c/chips/asb100.c~asb100-fix	2005-06-08 14:23:52.000000000 -0700
+++ 25-akpm/drivers/i2c/chips/asb100.c	2005-06-08 14:24:13.000000000 -0700
@@ -690,18 +690,20 @@ static int asb100_detect_subclients(stru
 	if ((err = i2c_attach_client(data->lm75[0]))) {
 		dev_err(&new_client->dev, "subclient %d registration "
 			"at address 0x%x failed.\n", i, data->lm75[0]->addr);
-		goto ERROR_SC_2;
+		goto ERROR_SC_3;
 	}
 
 	if ((err = i2c_attach_client(data->lm75[1]))) {
 		dev_err(&new_client->dev, "subclient %d registration "
 			"at address 0x%x failed.\n", i, data->lm75[1]->addr);
-		goto ERROR_SC_3;
+		goto ERROR_SC_4;
 	}
 
 	return 0;
 
 /* Undo inits in case of errors */
+ERROR_SC_4:
+	i2c_detach_client(data->lm75[1]);
 ERROR_SC_3:
 	i2c_detach_client(data->lm75[0]);
 ERROR_SC_2:
_

