Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTIBFkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTIBFkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:40:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:38814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263531AbTIBFkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:40:07 -0400
Date: Mon, 1 Sep 2003 22:40:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: bonganilinux@mweb.co.za, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [OOPS][RESEND] 2.6.0-test4-mm4
Message-Id: <20030901224016.1f469483.akpm@osdl.org>
In-Reply-To: <20030901223056.2700543d.akpm@osdl.org>
References: <E19tuSv-00059A-00@rammstein.mweb.co.za>
	<20030901153647.1ff6bf1d.akpm@osdl.org>
	<20030902064223.7a6dc372.bonganilinux@mweb.co.za>
	<20030901223056.2700543d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> This should fix it up.

oops, that had a use-after-free as well.

I don't really see a sane way of maintaining kobj->k_name going into
t->release(), so the release() implementations will just have to handle a
NULL kobj->k_name.


diff -puN lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix lib/kobject.c
--- 25/lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix	2003-09-01 22:20:27.000000000 -0700
+++ 25-akpm/lib/kobject.c	2003-09-01 22:36:16.000000000 -0700
@@ -443,15 +443,20 @@ void kobject_cleanup(struct kobject * ko
 {
 	struct kobj_type * t = get_ktype(kobj);
 	struct kset * s = kobj->kset;
+	char *name = NULL;
 
 	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
+
+	if (kobj->k_name != kobj->name)
+		name = kobj->k_name;
+	kobj->k_name = NULL;
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
 }
 
 /**

_

