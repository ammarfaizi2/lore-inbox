Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVKUP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVKUP75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVKUP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:59:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932344AbVKUP74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:59:56 -0500
Date: Mon, 21 Nov 2005 16:59:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [2.6 patch] do not select NET_CLS
Message-ID: <20051121155955.GW16060@stusta.de>
References: <437BBC59.70301@g-house.de> <20051116235813.GS5735@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116235813.GS5735@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>...
> But there's a change in 2.6.15-rc1 that makes this issue much worse:
> It is no longer user-visible.
> 
> tristate's select'ing bool's that do not change parts of the (modular) 
> driver but compile additional code into the kernel are simply wrong.

The patch below (should apply against 2.6.15-rc2) fixes this issue.

cu
Adrian


<--  snip  -->


2.6.15-rc changes NET_CLS to being automatically select'ed when needed.

This patch confuses users since NET_CLS is a bool, and compiling an 
additional module that select's NET_CLS causes unresolved symbols since 
it's not user-visible that adding a module changes the kernel image.

This patch therefore changes NET_CLS back to the 2.6.14 status quo of 
being an user-visible option.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/sched/Kconfig |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- linux-2.6.15-rc1-mm2-full/net/sched/Kconfig.old	2005-11-21 16:39:04.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/net/sched/Kconfig	2005-11-21 16:41:59.000000000 +0100
@@ -254,11 +254,23 @@
 comment "Classification"
 
 config NET_CLS
-	boolean
+	bool "Packet classifier API"
+	help
+	  The CBQ scheduling algorithm requires that network packets which are
+	  scheduled to be sent out over a network device be classified
+	  according to some criterion. If you say Y here, you will get a
+	  choice of several different packet classifiers with the following
+	  questions.
+
+	  This will enable you to use Differentiated Services (diffserv) and
+	  Resource Reservation Protocol (RSVP) on your Linux router.
+	  Documentation and software is at
+	  <http://diffserv.sourceforge.net/>.
+
+if NET_CLS
 
 config NET_CLS_BASIC
 	tristate "Elementary classification (BASIC)"
-	select NET_CLS
 	---help---
 	  Say Y here if you want to be able to classify packets using
 	  only extended matches and actions.
@@ -268,7 +280,6 @@
 
 config NET_CLS_TCINDEX
 	tristate "Traffic-Control Index (TCINDEX)"
-	select NET_CLS
 	---help---
 	  Say Y here if you want to be able to classify packets based on
 	  traffic control indices. You will want this feature if you want
@@ -280,7 +291,6 @@
 config NET_CLS_ROUTE4
 	tristate "Routing decision (ROUTE)"
 	select NET_CLS_ROUTE
-	select NET_CLS
 	---help---
 	  If you say Y here, you will be able to classify packets
 	  according to the route table entry they matched.
@@ -293,7 +303,6 @@
 
 config NET_CLS_FW
 	tristate "Netfilter mark (FW)"
-	select NET_CLS
 	---help---
 	  If you say Y here, you will be able to classify packets
 	  according to netfilter/firewall marks.
@@ -303,7 +312,6 @@
 
 config NET_CLS_U32
 	tristate "Universal 32bit comparisons w/ hashing (U32)"
-	select NET_CLS
 	---help---
 	  Say Y here to be able to classify packetes using a universal
 	  32bit pieces based comparison scheme.
@@ -326,7 +334,6 @@
 
 config NET_CLS_RSVP
 	tristate "IPv4 Resource Reservation Protocol (RSVP)"
-	select NET_CLS
 	select NET_ESTIMATOR
 	---help---
 	  The Resource Reservation Protocol (RSVP) permits end systems to
@@ -341,7 +348,6 @@
 
 config NET_CLS_RSVP6
 	tristate "IPv6 Resource Reservation Protocol (RSVP6)"
-	select NET_CLS
 	select NET_ESTIMATOR
 	---help---
 	  The Resource Reservation Protocol (RSVP) permits end systems to
@@ -356,7 +362,6 @@
 
 config NET_EMATCH
 	bool "Extended Matches"
-	select NET_CLS
 	---help---
 	  Say Y here if you want to use extended matches on top of classifiers
 	  and select the extended matches below.
@@ -541,6 +546,8 @@
 	  automaticaly selected if needed but can be selected manually for
 	  statstical purposes.
 
+endif # NET_CLS
+
 endif # NET_SCHED
 
 endmenu

