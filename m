Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265789AbSJTJpx>; Sun, 20 Oct 2002 05:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265793AbSJTJo2>; Sun, 20 Oct 2002 05:44:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56875 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265789AbSJTJnc>; Sun, 20 Oct 2002 05:43:32 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <Pine.LNX.4.44.0210150928340.1038-100000@cherise.pdx.osdl.net>
	<m1d6q6xovl.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Oct 2002 03:47:56 -0600
In-Reply-To: <m1d6q6xovl.fsf@frodo.biederman.org>
Message-ID: <m1k7kdwier.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Assuming it is worth it to split remove into 2 parts, we need
the following so rmmod calls ->shutdown.  Otherwise we will get
code duplication in the drivers.

And then we need all of the patches that split remove into 2 parts,
in the drivers.

Eric

diff -uNr linux-2.5.44/drivers/base/bus.c linux-2.5.44.shutdown/drivers/base/bus.c
--- linux-2.5.44/drivers/base/bus.c    Sat Oct 19 00:57:58 2002
+++ linux-2.5.44.shutdown/drivers/base/bus.c    Sun Oct 20 03:44:46 2002
@@ -164,6 +164,8 @@
        if (drv) {
                list_del_init(&dev->driver_list);
                devclass_remove_device(dev);
+               if (drv->shutdown && device_present(drv))
+                       drv->shutdown(dev);
                if (drv->remove)
                        drv->remove(dev);
                dev->driver = NULL;
