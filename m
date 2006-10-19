Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWJSD1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWJSD1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 23:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWJSD1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 23:27:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30479 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030293AbWJSD1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 23:27:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CxU0lsEL8FNqxRRG1OyunjNyemR4YABRio7cJJpONR7ztHHHTMbyCP1Td7ZDKMWysfxMxsPpYrPhIFBvcWPlV2IPiL7JtwAbm8HOe9KnlIQ4ANyTSQ9e+mJwNTyl85H1qNB/M7xhzshRw5REOu5FUcgqiYB8UZMAePGJN0MCW/s=
Date: Thu, 19 Oct 2006 12:28:01 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] i2c: Fix return value check
Message-ID: <20061019032801.GB20695@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <20061017062449.GA13100@localhost> <20061018165450.35e0c5d4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018165450.35e0c5d4.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 04:54:50PM +0200, Jean Delvare wrote:

> > Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>
> 
> Typo ;)

Thank you. My template was broken.

> Patch looks correct, however class devices are going away soon, and
> this patch will conflict with Greg's work:
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver-class/i2c-dev-device.patch
> 
> So your patch should apply on top of Greg's, if still needed after his
> changes. It might even be later folded into Greg's patch to make things
> easier to handle.

I made the patch on top of i2c-dev-device.patch

Subject: i2c: Fix return value check

device_create() returns error code as pointer on failures.
This patch checks the return value of device_create() by using IS_ERR().

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/i2c/i2c-dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/i2c/i2c-dev.c
===================================================================
--- work-fault-inject.orig/drivers/i2c/i2c-dev.c
+++ work-fault-inject/drivers/i2c/i2c-dev.c
@@ -417,8 +417,8 @@ static int i2cdev_attach_adapter(struct 
 	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
 				     MKDEV(I2C_MAJOR, adap->nr),
 				     "i2c-%d", adap->nr);
-	if (!i2c_dev->dev) {
-		res = -ENODEV;
+	if (IS_ERR(i2c_dev->dev)) {
+		res = PTR_ERR(i2c_dev->dev);
 		goto error;
 	}
 	res = device_create_file(i2c_dev->dev, &dev_attr_name);
