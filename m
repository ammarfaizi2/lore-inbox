Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754574AbWKHMkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbWKHMkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754577AbWKHMkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:40:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:50744 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754574AbWKHMkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:40:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qyaLmr94YT0fYiVGiFyjGqVH+ZcY/ikUdZphuA0RhPVnfWX7Z6q9lf5Dg4zMU+R24FTDPsZ7mqJg/zVD8NCtwjWL74TNo/h9DOVm2VP/qN0N29+v4CHqXToWquI8L4xDNqMINLu9ZQrfOthvgS12i7gSXeB4ZDGo6GsfAxx5Y3o=
Date: Wed, 8 Nov 2006 21:40:10 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] input: check whether serio dirver registration is completed
Message-ID: <20061108124010.GD14871@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061107120605.GA13896@localhost> <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com> <20061108123636.GA14871@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108123636.GA14871@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a flag to serio driver indicating whether registration is
complete and check that flag in serio_unregister_driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/input/serio/serio.c |    7 ++++++-
 include/linux/serio.h       |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: work-fault-inject/include/linux/serio.h
===================================================================
--- work-fault-inject.orig/include/linux/serio.h
+++ work-fault-inject/include/linux/serio.h
@@ -68,6 +68,7 @@ struct serio_driver {
 	void (*cleanup)(struct serio *);
 
 	struct device_driver driver;
+	int registered;
 };
 #define to_serio_driver(d)	container_of(d, struct serio_driver, driver)
 
Index: work-fault-inject/drivers/input/serio/serio.c
===================================================================
--- work-fault-inject.orig/drivers/input/serio/serio.c
+++ work-fault-inject/drivers/input/serio/serio.c
@@ -804,6 +804,8 @@ static void serio_add_driver(struct seri
 		printk(KERN_ERR
 			"serio: driver_register() failed for %s, error: %d\n",
 			drv->driver.name, error);
+	else
+		drv->registered = 1;
 }
 
 int __serio_register_driver(struct serio_driver *drv, struct module *owner)
@@ -830,7 +832,10 @@ start_over:
 		}
 	}
 
-	driver_unregister(&drv->driver);
+	if (drv->registered) {
+		driver_unregister(&drv->driver);
+		drv->registered = 0;
+	}
 	mutex_unlock(&serio_mutex);
 }
 
