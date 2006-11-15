Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966707AbWKOJXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966707AbWKOJXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966718AbWKOJXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:23:36 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:51737 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S966717AbWKOJXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:23:36 -0500
Date: Wed, 15 Nov 2006 10:24:09 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: "Kay Sievers" <kay.sievers@vrfy.org>
Cc: "Greg KH" <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20061115102409.6e6e5dc0@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	<20061115065052.GC23810@kroah.com>
	<20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
	<3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 09:44:33 +0100,
"Kay Sievers" <kay.sievers@vrfy.org> wrote:

> Udev and HAL, both will need an event for the moving, with the old
> DEVPATH value in the environment. We want something like a "rename" or
> "move" event. Without that, weird things will happen in userspace,
> because the devpath is used as the key to the device during the whole
> device lifetime. The only weird exception today is the netif rename
> case, which is already handled by special code in udev.

Something like below (completely untested as my test box is currently
inaccessible)? Wouldn't we need something similar for kobject_rename()
as well?

---
 include/linux/kobject.h |    1 +
 lib/kobject.c           |    1 +
 2 files changed, 2 insertions(+)

--- linux-2.6-CH.orig/include/linux/kobject.h
+++ linux-2.6-CH/include/linux/kobject.h
@@ -47,6 +47,7 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
+	KOBJ_MOVE	= (__force kobject_action_t) 0x08,	/* device move */
 };
 
 struct kobject {
--- linux-2.6-CH.orig/lib/kobject.c
+++ linux-2.6-CH/lib/kobject.c
@@ -379,6 +379,7 @@ int kobject_move(struct kobject *kobj, s
 	old_parent = kobj->parent;
 	kobj->parent = new_parent;
 	kobject_put(old_parent);
+	kobject_uevent(kobj, KOBJ_MOVE);
 out:
 	kobject_put(kobj);
 	return error;
