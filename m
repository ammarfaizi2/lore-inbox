Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSGICLG>; Mon, 8 Jul 2002 22:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSGICLG>; Mon, 8 Jul 2002 22:11:06 -0400
Received: from zok.SGI.COM ([204.94.215.101]:14257 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317283AbSGICLF>;
	Mon, 8 Jul 2002 22:11:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [patch] 2.5.25 net/core/Makefile 
In-reply-to: Your message of "Tue, 09 Jul 2002 02:36:28 +0200."
             <20020709023628.A1697@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 12:13:30 +1000
Message-ID: <23502.1026180810@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002 02:36:28 +0200, 
Dave Jones <davej@suse.de> wrote:
>On Tue, Jul 09, 2002 at 10:30:31AM +1000, Keith Owens wrote:
> > > > The valid combination of CONFIG_NET=n, CONFIG_LLC undefined incorrectly
> > >And this breaks the valid combination of CONFIG_NET=y, CONFIG_LLC undef'd
>
> > ??? That is the bug that I reported.  My patch fixes that bug.
>
>Same bug maybe, but triggered in different ways.
>Note the CONFIG_NET change between your report and mine.

Sorry, missed that change the first time.

The problem is net/802/Makefile which includes p8022 for any of
CONFIG_LLC, CONFIG_TR, CONFIG_IPX or CONFIG_ATALK.  p8022 calls
llc_register_sap which is in ext8022.o, that file is built by
net/core/Makefile but only for CONFIG_LLC.  It worked before because of
the wrong test in net/core/Makefile which always built ext8022.o.

Davem - we could unconditionally build ext8022.o when CONFIG_NET=y or
we could do this

Index: 25.1/net/core/Makefile
--- 25.1/net/core/Makefile Wed, 19 Jun 2002 14:11:35 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
+++ 25.1(w)/net/core/Makefile Tue, 09 Jul 2002 12:10:53 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
@@ -16,7 +16,8 @@ obj-$(CONFIG_FILTER) += filter.o
 
 obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
 
-ifneq ($(CONFIG_LLC),n)
+# See p8022 in net/802/Makefile for config options to check
+ifneq ($(subst n,,$(CONFIG_LLC)$(CONFIG_TR)$(CONFIG_IPX)$(CONFIG_ATALK)),)
 obj-y += ext8022.o
 endif
 
Index: 25.1/net/802/Makefile
--- 25.1/net/802/Makefile Fri, 21 Jun 2002 10:09:01 +1000 kaos (linux-2.5/r/c/0_Makefile 1.3 444)
+++ 25.1(w)/net/802/Makefile Tue, 09 Jul 2002 12:10:38 +1000 kaos (linux-2.5/r/c/0_Makefile 1.3 444)
@@ -6,6 +6,7 @@ export-objs		:= llc_macinit.o p8022.o ps
 
 obj-y			:= p8023.o
 
+# Check the p8022 selections against net/core/Makefile.
 obj-$(CONFIG_SYSCTL)	+= sysctl_net_802.o
 obj-$(CONFIG_LLC)	+= p8022.o psnap.o llc_sendpdu.o llc_utility.o \
 			   		   cl2llc.o llc_macinit.o	



