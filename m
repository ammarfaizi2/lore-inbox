Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUFVSLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUFVSLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUFVSKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:10:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:23477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265048AbUFVRnP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:15 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926110190@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:50 -0700
Message-Id: <10879261102820@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.53, 2004/06/04 14:53:48-07:00, Frank.A.Uepping@t-online.de

[PATCH] Driver Core: fix struct device::release issue

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


On Saturday 27 March 2004 02:14, Greg KH wrote:
> On Sat, Mar 06, 2004 at 12:47:24PM +0100, Frank A. Uepping wrote:
> > Hi,
> > if device_add fails (e.g. bus_add_device returns an error) then the release
> > method will be called for the device. Is this a bug or a feature?
>
> Are you sure this will happen?  device_initialize() gets a reference
> that is still present after device_add() fails, right?  So release()
> will not get called.
At the label PMError, kobject_unregister is called, which decrements the
recount by 2, which will result in calling release at label Done (put_device).

kobject_unregister should be superseded by kobject_del.
Here is a patch:


 drivers/base/core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Jun 22 09:48:10 2004
+++ b/drivers/base/core.c	Tue Jun 22 09:48:10 2004
@@ -245,7 +245,7 @@
  BusError:
 	device_pm_remove(dev);
  PMError:
-	kobject_unregister(&dev->kobj);
+	kobject_del(&dev->kobj);
  Error:
 	if (parent)
 		put_device(parent);

