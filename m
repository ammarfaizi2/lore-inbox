Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUJTAhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUJTAhD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269503AbUJTAd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:33:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:10932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267840AbUJTATc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:32 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315043649@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <1098231504304@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.8, 2004/09/09 10:02:27-07:00, johnpol@2ka.mipt.ru

[PATCH] W1: let W1 select NET.

On Wed, 2004-08-25 at 23:41, Greg KH wrote:
> On Wed, Aug 25, 2004 at 11:21:29PM +0400, Evgeniy Polyakov wrote:
> > On Wed, 25 Aug 2004 10:49:12 -0700
> > Greg KH <greg@kroah.com> wrote:
> >
> > > On Fri, Aug 13, 2004 at 02:35:40PM +0400, Evgeniy Polyakov wrote:
> > > > The patch below fixes this issue by letting W1 select NET.
> > > >
> > > > Patch was created by Adrian Bunk <bunk@fs.tum.de>.
> > >
> > > Nah, I'm going to hold off on this, it's not really needed (who
> > > doesn't build with NET enabled...)
> >
> > Hmmm, but someone really may want to build it without NET support.
> > I have an idea(I thought it out exactly for the case when you do not
> > apply it) to disable networking(netlink) support in compilation time if
> > CONFIG_NET is not defined.
> > And add some warning like:
> >
> > #ifndef CONFIG_NET
> > #warning Netlink support is disabled.
> > #endif
>
> That sounds like a good fix.



Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/Makefile     |    4 ++++
 drivers/w1/w1_netlink.c |    8 ++++++++
 2 files changed, 12 insertions(+)


diff -Nru a/drivers/w1/Makefile b/drivers/w1/Makefile
--- a/drivers/w1/Makefile	2004-10-19 16:55:26 -07:00
+++ b/drivers/w1/Makefile	2004-10-19 16:55:26 -07:00
@@ -2,6 +2,10 @@
 # Makefile for the Dallas's 1-wire bus.
 #
 
+ifneq ($(CONFIG_NET), y)
+EXTRA_CFLAGS	+= -DNETLINK_DISABLED
+endif
+
 obj-$(CONFIG_W1)	+= wire.o
 wire-objs		:= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
 
diff -Nru a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
--- a/drivers/w1/w1_netlink.c	2004-10-19 16:55:26 -07:00
+++ b/drivers/w1/w1_netlink.c	2004-10-19 16:55:26 -07:00
@@ -26,6 +26,7 @@
 #include "w1_log.h"
 #include "w1_netlink.h"
 
+#ifndef NETLINK_DISABLED
 void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
 {
 	unsigned int size;
@@ -53,3 +54,10 @@
 nlmsg_failure:
 	return;
 }
+#else
+#warning Netlink support is disabled. Please compile with NET support enabled.
+
+void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
+{
+}
+#endif

