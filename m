Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVCOEe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVCOEe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVCOEe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:34:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:14518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262238AbVCOEeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:34:14 -0500
Date: Mon, 14 Mar 2005 20:33:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.11-mm3 breaks compile of drivers/char/esp.c
Message-Id: <20050314203357.75aacaaf.akpm@osdl.org>
In-Reply-To: <200503121839.36970.bero@arklinux.org>
References: <200503121839.36970.bero@arklinux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> drivers/char/esp.c: In function 'rs_stop':
>  drivers/char/esp.c:213: error: 'struct esp_struct' has no member named 'lock'
>  drivers/char/esp.c:219: error: 'struct esp_struct' has no member named 'lock'
>  drivers/char/esp.c: In function 'rs_start':
>  drivers/char/esp.c:230: error: 'struct esp_struct' has no member named 'lock'
>  drivers/char/esp.c:236: error: 'struct esp_struct' has no member named 'lock'

Seems that Alan's diff was missing the changes to the header file.  Like
this?

--- 25/include/linux/hayesesp.h~esp-build-fix	2005-03-14 20:31:18.000000000 -0800
+++ 25-akpm/include/linux/hayesesp.h	2005-03-14 20:31:30.000000000 -0800
@@ -77,6 +77,7 @@ struct hayes_esp_config {
 
 struct esp_struct {
 	int			magic;
+	spinlock_t		lock;
 	int			port;
 	int			irq;
 	int			flags; 		/* defined in tty.h */
_
 

I didn't pick this up because ESPSERIAL is still BROKEN_ON_SMP.  Alan,
should we remove that now?

