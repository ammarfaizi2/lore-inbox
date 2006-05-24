Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWEXRqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWEXRqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWEXRqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:46:23 -0400
Received: from web50104.mail.yahoo.com ([206.190.38.32]:45656 "HELO
	web50104.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932736AbWEXRqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:46:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eUluHmOH7yGZ19pcaDGhVfd5lKyoPkYyGLZLkG49VbtXz/X3jOuc/hHszuaANmr4UFh34ptoncmEC8S7AlhgbYRiCgE+xNnsdeY817b6jvWHhE/dY61hw8YRx06YJqOTQ/3SZuK9LUsOTS5NdoRBhGcdzuR/htKCsUOFXG2F3k0=  ;
Message-ID: <20060524174622.35756.qmail@web50104.mail.yahoo.com>
Date: Wed, 24 May 2006 10:46:22 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 2/6]  EDAC mc numbers refactor 1-of-2
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is part 1 of a 2-part patch set.  The code changes are split into two
parts to make the patches more readable.

Remove add_mc_to_global_list().  
In next patch, this function will be reimplemented with different semantics.

Signed-of-by: Doug Thompson <norsk5@xmission.com>


Index: linux-2.6.17-rc3/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.17-rc3.orig/drivers/edac/edac_mc.c
+++ linux-2.6.17-rc3/drivers/edac/edac_mc.c
@@ -1390,49 +1390,6 @@ static struct mem_ctl_info *find_mci_by_
 	return NULL;
 }
 
-static int add_mc_to_global_list(struct mem_ctl_info *mci)
-{
-	struct list_head *item, *insert_before;
-	struct mem_ctl_info *p;
-	int i;
-
-	if (list_empty(&mc_devices)) {
-		mci->mc_idx = 0;
-		insert_before = &mc_devices;
-	} else {
-		if (find_mci_by_dev(mci->dev)) {
-			edac_printk(KERN_WARNING, EDAC_MC,
-				"%s (%s) %s %s already assigned %d\n",
-				mci->dev->bus_id, dev_name(mci->dev),
-				mci->mod_name, mci->ctl_name,
-				mci->mc_idx);
-			return 1;
-		}
-
-		insert_before = NULL;
-		i = 0;
-
-		list_for_each(item, &mc_devices) {
-			p = list_entry(item, struct mem_ctl_info, link);
-
-			if (p->mc_idx != i) {
-				insert_before = item;
-				break;
-			}
-
-			i++;
-		}
-
-		mci->mc_idx = i;
-
-		if (insert_before == NULL)
-			insert_before = &mc_devices;
-	}
-
-	list_add_tail_rcu(&mci->link, insert_before);
-	return 0;
-}
-
 static void complete_mc_list_del(struct rcu_head *head)
 {
 	struct mem_ctl_info *mci;



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

