Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVCYBH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVCYBH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCYBFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:05:34 -0500
Received: from digitalimplant.org ([64.62.235.95]:43137 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261334AbVCYBAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:00:31 -0500
Date: Thu, 24 Mar 2005 17:00:18 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Andrew Morton <akpm@osdl.org>
cc: Laurent Riffard <laurent.riffard@free.fr>, "" <rjw@sisk.pl>,
       "" <rlrevell@joe-job.com>, "" <alsa-devel@lists.sourceforge.net>,
       "" <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.12-rc1-mm2
In-Reply-To: <20050324154920.4e506d76.akpm@osdl.org>
Message-ID: <Pine.LNX.4.50.0503241658360.29178-100000@monsoon.he.net>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111682812.23440.6.camel@mindpipe>
 <20050324121722.759610f4.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl>
 <42434E59.2060805@free.fr> <20050324154920.4e506d76.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Mar 2005, Andrew Morton wrote:

> Laurent Riffard <laurent.riffard@free.fr> wrote:
> >
> > hello,
> >
> > Same kinds of problem here. It depends on the removed module. I mean:
> > "rmmod loop" or "rmmod pcspkr" works. But "rmmod snd_ens1371" or "rmmod
> > ohci1394" hangs.
> >
> > Sysrq-T when rmmoding snd_ens1371 :

<snip>

> It looks like we're getting stuck in the wait_for_completion() in the new
> klist_remove().

D'oh! It's getting hung while waiting to remove the current node from the
list (which it can't remove because it's being used). The patch below
should fix it.


	Pat


===== drivers/base/dd.c 1.3 vs edited =====
--- 1.3/drivers/base/dd.c	2005-03-21 12:25:04 -08:00
+++ edited/drivers/base/dd.c	2005-03-24 16:55:21 -08:00
@@ -177,7 +177,7 @@

 	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 	sysfs_remove_link(&dev->kobj, "driver");
-	klist_remove(&dev->knode_driver);
+	klist_del(&dev->knode_driver);

 	down(&dev->sem);
 	device_detach_shutdown(dev);
