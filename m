Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVFMVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVFMVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFMVjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:39:23 -0400
Received: from smtp838.mail.sc5.yahoo.com ([66.163.171.25]:58016 "HELO
	smtp838.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261432AbVFMVib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:38:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Input sysbsystema and hotplug
Date: Mon, 13 Jun 2005 16:38:08 -0500
User-Agent: KMail/1.8.1
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613212654.GB11182@vrfy.org>
In-Reply-To: <20050613212654.GB11182@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131638.09140.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 16:26, Kay Sievers wrote:
> On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > 
> > where inputX are class devices, mouse and event are subclasses of input
> > class and mouseX and eventX are again class devices.
> 
> We don't support childs of class devices until now. Would be nice maybe, but
> someone needs to add that to the driver-core first and we would need to make
> a bunch of userspace stuff aware of it ...
> 

Something like patch below will suffice I think (not tested).

-- 
Dmitry

 drivers/base/class.c   |    5 ++++-
 include/linux/device.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -145,7 +145,10 @@ int class_register(struct class * cls)
 	if (error)
 		return error;
 
-	subsys_set_kset(cls, class_subsys);
+	if (cls->parent)
+		subsys_set_kset(cls, cls->parent->subsys);
+	else
+		subsys_set_kset(cls, class_subsys);
 
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -145,6 +145,7 @@ struct class {
 	char			* name;
 
 	struct subsystem	subsys;
+	struct class		* parent;
 	struct list_head	children;
 	struct list_head	interfaces;
 	struct semaphore	sem;	/* locks both the children and interfaces lists */
