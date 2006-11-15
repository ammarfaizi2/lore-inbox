Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030800AbWKOSO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030800AbWKOSO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030802AbWKOSO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:14:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:31465 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030800AbWKOSOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:14:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=C/HdiLHjGWlY95lrz9InUoTgOr/b8m7aYGZg+rhHnb/IW6SQSi626Do+wyqVg99YcDy7KHYH80IR6FmFRaO4dizn4GjLyUr32L9WAa2INQ+PlRY5915TIaOUP3X3vaFVlGpFIbeaTUdzD8SWopsmiqqWZU5qhgSuJwMVmMu1R2E=
Date: Wed, 15 Nov 2006 15:14:27 -0300
From: Naranjo Manuel Francisco <naranjo.manuel@gmail.com>
To: <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/serial/aircable.c: inconsequent NULL checking
Message-ID: <20061115151427.47ffdd75@manuel>
In-Reply-To: <360bc8300611151008v44e12cebx65688233fc614906@mail.gmail.com>
References: <20061111161300.GB8809@stusta.de>
	<360bc8300611151008v44e12cebx65688233fc614906@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.5.2 (GTK+ 2.10.6; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2006/11/11, Adrian Bunk <bunk@stusta.de>:
> > The Coverity checker spotted the following in
> > drivers/usb/serial/aircable.c:
> >
> > <--  snip  -->
> >
> > ...
> > static void aircable_read(void *params)
> > {
> > ...


Hi everyone,
Sorry for the long time response but here is the patch, I think this way should work, if anyone has any suggestion let me know. What I do now is, in case I don't have the tty available I reschedule the work, I have tried it and it works with no problem, I even tried removing the device, and didn't find anything strange.

Manuel Naranjo

Signed-off-by: Naranjo Manuel <naranjo.manuel@gmail.com>

----

--- linux2/drivers/usb/serial/aircable.c.orig	2006-11-15 15:03:40.000000000 -0300
+++ linux2/drivers/usb/serial/aircable.c	2006-11-12 21:59:05.000000000 -0300
@@ -270,8 +270,11 @@ static void aircable_read(void *params)
 	 */
 	tty = port->tty;
 
-	if (!tty)
+	if (!tty){
 		schedule_work(&priv->rx_work);
+		err("%s - No tty available", __FUNCTION__);
+		return ;
+	}
 
 	count = min(64, serial_buf_data_avail(priv->rx_buf));
 

