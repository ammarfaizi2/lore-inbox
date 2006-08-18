Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWHRGLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWHRGLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWHRGLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:11:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932152AbWHRGLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:11:47 -0400
Date: Thu, 17 Aug 2006 23:11:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Miller <davem@davemloft.net>, xavier.bestel@free.fr, 7eggert@gmx.de,
       cate@debian.org, 7eggert@elstempel.de, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: restrict device names from having whitespace
Message-ID: <20060817231127.6438324e@localhost.localdomain>
In-Reply-To: <44E68C4E.8070607@osdl.org>
References: <20060816133811.GA26471@nostromo.devel.redhat.com>
	<Pine.LNX.4.58.0608161636250.2044@be1.lrz>
	<1155799783.7566.5.camel@capoeira>
	<20060817.162340.74748342.davem@davemloft.net>
	<20060818022057.GA27076@nostromo.devel.redhat.com>
	<44E68C4E.8070607@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow spaces in network device names because it makes
it difficult to provide text interfaces via sysfs.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 net/core/dev.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d95e262..56c8afb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -79,6 +79,7 @@ #include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/ctype.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/string.h>
@@ -636,10 +637,25 @@ struct net_device * dev_get_by_flags(uns
  */
 int dev_valid_name(const char *name)
 {
-	return !(*name == '\0' 
-		 || !strcmp(name, ".")
-		 || !strcmp(name, "..")
-		 || strchr(name, '/'));
+	if (*name == '\0')	 /* null string */
+		return 0;
+
+	if (*name == '.') {
+		if (name[1] == '\0')	/* can't have . in directory */
+			return 0;
+		if (name[1] == '.' && name[2] == '\0')
+			return 0;	/* or .. */
+	}
+
+	/* Check for blanks and slash because it confuses sysfs interfaces */
+	do {
+		if (*name == '/')
+			return 0;
+		if (isspace(*name))
+			return 0;
+	} while (*++name);
+
+	return 1;
 }
 
 /**
-- 
1.4.0

