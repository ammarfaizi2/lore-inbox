Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUEJXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUEJXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUEJXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:54:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39912 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261752AbUEJXxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:53:46 -0400
Date: Tue, 11 May 2004 01:53:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.4 patch] Re: CONFIG_ATALK cannot be compiled as a module
Message-ID: <20040510235343.GD18093@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2.4.24)
Reply-To: 
In-Reply-To: <200404242155.06101.kiza@gmx.net>

On Sat, Apr 24, 2004 at 09:55:06PM +0200, Oliver Feiler wrote:
> Hi Adrian,
> 
> On Saturday 24 April 2004 20:23, Adrian Bunk wrote:
> 
> > > when selecting CONFIG_ATALK as a module the symbols register_snap_client
> > > and unregister_snap_client will be unresolved. As I understand it they
> > > are in net/802/psnap.c which does not get compiled when Appletalk is
> > > selected as a module. Compiling into the kernel works fine.
> > >...
> >
> > thanks for this report and sorry for the late answer.
> >
> > I wasn't able to reproduce your problem.
> >
> > Please send your .config.
> 
> Attached. Upgraded the server to 2.4.26 in the meantime and threw out 
> appletalk again since we didn't need it in the end.
> 
> A quick test with compiling it as a module produced the same unresolved 
> symbols. Unless I missed another config option to set?
> 
> I don't need to set CONFIG_DEV_APPLETALK as well, right? Regardless, just 
> tried, same effect.
> 
> Btw, I think I didn't mention earlier, the kernel is patched with i2c-2.8.3. 
> Patch generated with mkpatch from the package and applied.


The patch below that should fix it.

diffstat output:
 net/802/Makefile |   60 ++++++++++++++---------------------------------
 net/Makefile     |    2 -
 2 files changed, 20 insertions(+), 42 deletions(-)

patch description:
- net/Makefile: there might be modules in net/802/
- net/802/Makefile: deuglyfy it and make it more similar to the
                    2.6 version


> Thanks!
> 
> 	Oliver


cu
Adrian

--- linux-2.4.27-pre2-full/net/802/Makefile.old	2004-05-11 01:09:46.000000000 +0200
+++ linux-2.4.27-pre2-full/net/802/Makefile	2004-05-11 01:17:00.000000000 +0200
@@ -11,48 +11,26 @@
 
 export-objs = llc_macinit.o p8022.o psnap.o fc.o
 
-obj-y	= p8023.o
+obj-y			:= p8023.o
+
+obj-$(CONFIG_SYSCTL)	+= sysctl_net_802.o
+
+subdir-$(CONFIG_LLC)	+= transit
+obj-$(CONFIG_LLC)	+= llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
+obj-$(CONFIG_LLC)	+= p8022.o psnap.o
+
+obj-$(CONFIG_TR)	+= p8022.o psnap.o tr.o
+
+obj-$(CONFIG_NET_FC)	+=                 fc.o
+
+obj-$(CONFIG_FDDI)	+=                 fddi.o
+
+obj-$(CONFIG_HIPPI)	+=                 hippi.o
+
+obj-$(CONFIG_IPX)	+= p8022.o psnap.o
+
+obj-$(CONFIG_ATALK)	+= p8022.o psnap.o
 
-obj-$(CONFIG_SYSCTL) += sysctl_net_802.o
-obj-$(CONFIG_LLC) += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
-ifeq ($(CONFIG_SYSCTL),y)
-obj-y += sysctl_net_802.o
-endif
-
-ifeq ($(CONFIG_LLC),y)
-subdir-y += transit
-obj-y += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
-SNAP = y
-endif
-
-ifdef CONFIG_TR
-obj-y += tr.o
-	SNAP=y
-endif
-
-ifdef CONFIG_NET_FC
-obj-y += fc.o
-endif
-
-ifdef CONFIG_FDDI
-obj-y += fddi.o
-endif
-
-ifdef CONFIG_HIPPI
-obj-y += hippi.o
-endif
-
-ifdef CONFIG_IPX
-	SNAP=y
-endif
-
-ifdef CONFIG_ATALK
-	SNAP=y
-endif
-
-ifeq ($(SNAP),y)
-obj-y += p8022.o psnap.o
-endif
 
 include $(TOPDIR)/Rules.make
 
--- linux-2.4.27-pre2-full/net/Makefile.old	2004-05-11 01:43:31.000000000 +0200
+++ linux-2.4.27-pre2-full/net/Makefile	2004-05-11 01:44:02.000000000 +0200
@@ -7,7 +7,7 @@
 
 O_TARGET :=	network.o
 
-mod-subdirs :=	ipv4/netfilter ipv6/netfilter ipx irda bluetooth atm netlink sched core sctp
+mod-subdirs :=	ipv4/netfilter ipv6/netfilter ipx irda bluetooth atm netlink sched core sctp 802
 export-objs :=	netsyms.o
 
 subdir-y :=	core ethernet
