Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUKJESE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUKJESE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKJESE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:18:04 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:60506 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261875AbUKJERi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:17:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Date: Tue, 9 Nov 2004 23:17:31 -0500
User-Agent: KMail/1.6.2
Cc: Tejun Heo <tj@home-tj.org>, LKML <linux-kernel@vger.kernel.org>
References: <20041104185826.GA17756@kroah.com> <d120d50004110508333c183cc1@mail.gmail.com> <20041110004052.GB8672@kroah.com>
In-Reply-To: <20041110004052.GB8672@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411092317.33300.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 07:40 pm, Greg KH wrote:
> > I think we just have lay down the rules that one needs to get a reference
> > to an object in the following cases:
> > - object creation (first reference)
> > - linking some other object to the object in question. Every link to the
> > ? object should increase reference count.
> > - before passing object to another thread of execution to guarantee that
> > ? the object will live long enough for both threads.
> 
> The rules are defined. ?See my OLS 2004 paper on krefs for details.
> 

So that means you will patches like the one below, right?

-- 
Dmitry


===================================================================


ChangeSet@1.1964, 2004-11-09 23:14:31-05:00, dtor_core@ameritech.net
  Driver core: remove unnecessary get_driver/put_driver from driver.c
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 driver.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-11-09 23:16:43 -05:00
+++ b/drivers/base/driver.c	2004-11-09 23:16:43 -05:00
@@ -26,13 +26,7 @@
 
 int driver_create_file(struct device_driver * drv, struct driver_attribute * attr)
 {
-	int error;
-	if (get_driver(drv)) {
-		error = sysfs_create_file(&drv->kobj, &attr->attr);
-		put_driver(drv);
-	} else
-		error = -EINVAL;
-	return error;
+	return sysfs_create_file(&drv->kobj, &attr->attr);
 }
 
 
@@ -44,10 +38,7 @@
 
 void driver_remove_file(struct device_driver * drv, struct driver_attribute * attr)
 {
-	if (get_driver(drv)) {
-		sysfs_remove_file(&drv->kobj, &attr->attr);
-		put_driver(drv);
-	}
+	sysfs_remove_file(&drv->kobj, &attr->attr);
 }
 
 
