Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTIBFaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263508AbTIBFaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:30:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:22681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263504AbTIBFao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:30:44 -0400
Date: Mon, 1 Sep 2003 22:30:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS][RESEND] 2.6.0-test4-mm4
Message-Id: <20030901223056.2700543d.akpm@osdl.org>
In-Reply-To: <20030902064223.7a6dc372.bonganilinux@mweb.co.za>
References: <E19tuSv-00059A-00@rammstein.mweb.co.za>
	<20030901153647.1ff6bf1d.akpm@osdl.org>
	<20030902064223.7a6dc372.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bonganilinux@mweb.co.za> wrote:
>
> > Is it repeatable?  Exactly which modules were you attempting to load at the
>  > time?  And please send your .config.
>  > 
>  > Thanks.
> 
> 
>  This is repeatable, each time it tries to load the alsa snd module.

OK, it's a straightforward use-after-free in kobject_cleanup().  I snarfed
a patch from Pat which allows arbitrary-length kobject names.  Maybe it
wasn't quite ready yet.

t->release points at cdev_dynamic_release(), which frees the kobj.

This should fix it up.

 lib/kobject.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -puN lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix lib/kobject.c
--- 25/lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix	2003-09-01 22:20:27.000000000 -0700
+++ 25-akpm/lib/kobject.c	2003-09-01 22:28:00.000000000 -0700
@@ -443,15 +443,22 @@ void kobject_cleanup(struct kobject * ko
 {
 	struct kobj_type * t = get_ktype(kobj);
 	struct kset * s = kobj->kset;
+	char *name = NULL;
 
 	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
+
+	if (kobj->k_name != kobj->name)
+		name = kobj->k_name;
+
 	if (t && t->release)
 		t->release(kobj);
 	if (s)
 		kset_put(s);
-	if (kobj->k_name != kobj->name)
-		kfree(kobj->k_name);
-	kobj->k_name = NULL;
+
+	if (name)
+		kfree(name);
+	else
+		kobj->k_name = NULL;
 }
 
 /**

_

