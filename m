Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbUAIV0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUAIV0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:26:11 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60348 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264318AbUAIV0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:26:03 -0500
Subject: Re: [PATCH][SELINUX] 2/7 Add netif controls
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
In-Reply-To: <20040109125718.5266c3f4.akpm@osdl.org>
References: <Xine.LNX.4.44.0401091009440.21309@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
	 <20040109125718.5266c3f4.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1073683548.29816.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 09 Jan 2004 16:25:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-09 at 15:57, Andrew Morton wrote:
> The selinux makefiles seem a little unusual.  Can this not use the usual
> 
> 	obj-$(CONFIG_FOO) += bar.o
> 
> ?
> 
> Similarly, security/Makefile uses:
> 
> 	ifeq ($(CONFIG_SECURITY_SELINUX),y)
> 		obj-$(CONFIG_SECURITY_SELINUX)	+= selinux/built-in.o
> 	endif
> 
> why the `ifeq'?

Hmm...possible diff below against 2.6.1 for the security and selinux
makefiles.

Index: linux-2.6/security/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/Makefile,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 Makefile
--- linux-2.6/security/Makefile	29 Sep 2003 13:14:38 -0000	1.1.1.3
+++ linux-2.6/security/Makefile	9 Jan 2004 21:06:46 -0000
@@ -12,8 +12,6 @@
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 # Must precede capability.o in order to stack properly.
-ifeq ($(CONFIG_SECURITY_SELINUX),y)
-	obj-$(CONFIG_SECURITY_SELINUX)	+= selinux/built-in.o
-endif
+obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
Index: linux-2.6/security/selinux/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- linux-2.6/security/selinux/Makefile	12 Aug 2003 13:05:04 -0000	1.1.1.1
+++ linux-2.6/security/selinux/Makefile	9 Jan 2004 21:06:08 -0000
@@ -4,7 +4,9 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-objs := avc.o hooks.o selinuxfs.o
+selinux-y := avc.o hooks.o selinuxfs.o
+
+selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
 
 EXTRA_CFLAGS += -Isecurity/selinux/include
 
Index: linux-2.6/security/selinux/ss/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/Makefile,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 Makefile
--- linux-2.6/security/selinux/ss/Makefile	9 Jan 2004 14:24:58 -0000	1.1.1.2
+++ linux-2.6/security/selinux/ss/Makefile	9 Jan 2004 21:06:15 -0000
@@ -5,9 +5,7 @@
 EXTRA_CFLAGS += -Isecurity/selinux/include
 obj-y := ss.o
 
-ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
+ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
 
-ifeq ($(CONFIG_SECURITY_SELINUX_MLS),y)
-ss-objs += mls.o
-endif
+ss-$(CONFIG_SECURITY_SELINUX_MLS) += mls.o
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

