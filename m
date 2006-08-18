Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWHRJco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWHRJco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWHRJco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:32:44 -0400
Received: from smtp5.orange.fr ([193.252.22.26]:27023 "EHLO
	smtp-msa-out05.orange.fr") by vger.kernel.org with ESMTP
	id S1751321AbWHRJcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:32:43 -0400
X-ME-UUID: 20060818093241654.9FB8B1C00190@mwinf0503.orange.fr
Subject: Re: [PATCH] net: restrict device names from having whitespace
From: Xavier Bestel <xavier.bestel@free.fr>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Miller <davem@davemloft.net>, 7eggert@gmx.de, cate@debian.org,
       7eggert@elstempel.de, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155885446.7566.15.camel@capoeira>
References: <20060816133811.GA26471@nostromo.devel.redhat.com>
	 <Pine.LNX.4.58.0608161636250.2044@be1.lrz>
	 <1155799783.7566.5.camel@capoeira>
	 <20060817.162340.74748342.davem@davemloft.net>
	 <20060818022057.GA27076@nostromo.devel.redhat.com>
	 <44E68C4E.8070607@osdl.org> <20060817231127.6438324e@localhost.localdomain>
	 <1155885446.7566.15.camel@capoeira>
Content-Type: text/plain
Message-Id: <1155893550.7566.77.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 18 Aug 2006 11:32:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 09:17, Xavier Bestel wrote:
> On Fri, 2006-08-18 at 08:11, Stephen Hemminger wrote:
> > Don't allow spaces in network device names because it makes
> > it difficult to provide text interfaces via sysfs.
> 
> Personally I would at least avoid all chars <= ' ', because an interface
> name is meant to be displayed and these control chars do no good on a
> console nor in X.

Something like the following patch (short of a full in-kernel utf8
validator). That said it starts looking like policy in the kernel. Maybe
the "no space in devname" should just be enforced by some userspace
tool, not by the kernel itself ?

	Xav

diff --git a/net/core/dev.c b/net/core/dev.c
index d95e262..906cbf3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -636,10 +636,23 @@ struct net_device * dev_get_by_flags(uns
  */
 int dev_valid_name(const char *name)
 {
-	return !(*name == '\0' 
-		 || !strcmp(name, ".")
-		 || !strcmp(name, "..")
-		 || strchr(name, '/'));
+	if(!*name)		/* empty string */
+		return 0;
+	if(*name == '.') {	/* . or .. */
+		if(!name[1])
+			return 0;
+		if(name[1] == '.' && !name[2])
+			return 0;
+	}
+	/* control char, space or slash */
+	while(*name) {
+		if(*name == '/')
+			return 0;
+		if(*name <= ' ')
+			return 0;
+		++name;
+	}
+	return 1;
 }
 
 /**


