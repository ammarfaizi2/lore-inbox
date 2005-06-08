Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVFHW5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFHW5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFHW5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:57:51 -0400
Received: from CPE00095b3131a0-CM0011ae8cd564.cpe.net.cable.rogers.com ([70.29.53.229]:28032
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261367AbVFHW4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:56:55 -0400
From: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: BUG in i2c_detach_client
Date: Wed, 8 Jun 2005 18:56:44 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Greg KH <greg@kroah.com>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200506081033.12445.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <20050608142631.7e956792.akpm@osdl.org>
In-Reply-To: <20050608142631.7e956792.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081856.45334.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On June 8, 2005 05:26 pm, Andrew Morton wrote:
> Were there no interesting printks before this BUG hit?
Nope :-(

> It's due to the kernel running list_del() on a list_head which isn't on a list.
> 
> Seems there is an error-path bug in that driver, but I don' thtink the fix
> will fix it.  Please test?
Will do. But I don't think that's it. I've been adding printks to determine the
execution path and it goes through the ERROR3 path in asb100_detect(), which means
AFACT that the error path in asb100_detect_subclients() isn't taken:

ERROR3:
        i2c_detach_client(data->lm75[0]);
        kfree(data->lm75[1]);
        kfree(data->lm75[0]);
ERROR2:
        i2c_detach_client(new_client); // <--- BUG() in here.
ERROR1:
        kfree(data);
ERROR0:
        return err;

But the ERROR2 path does work despite the location of the bug. If I apply:

--- 2.6.12-rc6-mm1/drivers/i2c/chips/asb100.c   2005-06-08 17:46:02.123864000 -0400
+++ linux/drivers/i2c/chips/asb100.c    2005-06-08 17:59:21.461819500 -0400
@@ -811,6 +811,7 @@ static int asb100_detect(struct i2c_adap
        if ((err = i2c_attach_client(new_client)))
                goto ERROR1;

+        goto ERROR2;
        /* Attach secondary lm75 clients */
        if ((err = asb100_detect_subclients(adapter, address, kind,
                        new_client)))
@@ -874,7 +875,6 @@ static int asb100_detach_client(struct i
 {
        int err;

-       hwmon_device_unregister(client->class_dev);

        if ((err = i2c_detach_client(client))) {
                dev_err(&client->dev, "client deregistration failed; "

No bug(). But the ERROR3 path doesn't:
--- 2.6.12-rc6-mm1/drivers/i2c/chips/asb100.c   2005-06-08 17:46:02.123864000 -0400
+++ linux/drivers/i2c/chips/asb100.c    2005-06-08 17:58:15.749712750 -0400
@@ -815,6 +815,7 @@ static int asb100_detect(struct i2c_adap
        if ((err = asb100_detect_subclients(adapter, address, kind,
                        new_client)))
                goto ERROR2;
+        goto ERROR3;

        /* Initialize the chip */
        asb100_init_client(new_client);
@@ -874,7 +875,6 @@ static int asb100_detach_client(struct i
 {
        int err;

-       hwmon_device_unregister(client->class_dev);

        if ((err = i2c_detach_client(client))) {
                dev_err(&client->dev, "client deregistration failed; "

causes a BUG(). I've yet to track the problem down further. Unfortunately
I have no more time today, I'll play with it again tomorrow.

Regards,
Andrew
