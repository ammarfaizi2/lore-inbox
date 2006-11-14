Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966354AbWKNVPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966354AbWKNVPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966360AbWKNVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:15:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:9815 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966354AbWKNVPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:15:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NfFlB3Mi7lgNoGucsFCS8nKVMIqQU/9QGKSNavejYX01WGbc14YW5g8NPhEslIjwU6e6cYNWBLw92mjhA/9YvhDTr7ycfvUuMFNTI5Lr2F6b+/hnJu8Ev4axyv51pOec2FYH5q/wp9kH/aD6MhoA0Ag6Ks7yNxp/epvPZytzkto=
Date: Wed, 15 Nov 2006 06:15:09 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Don Mullis <dwm@meer.net>
Subject: [PATCH -mm] failslab: remove __GFP_HIGHMEM filtering
Message-ID: <20061114211509.GB20524@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Don Mullis <dwm@meer.net>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114200249.GM22565@stusta.de> <20061114211259.GA20524@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114211259.GA20524@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Filtering __GFP_HIGHMEM flag for slab allocations is useless.
Because no one sets __GFP_HIGHMEM for slab allocator, unlike
for page allocator.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 Documentation/fault-injection/fault-injection.txt |    2 --
 mm/slab.c                                         |   17 ++---------------
 2 files changed, 2 insertions(+), 17 deletions(-)

Index: work-fault-inject/mm/slab.c
===================================================================
--- work-fault-inject.orig/mm/slab.c
+++ work-fault-inject/mm/slab.c
@@ -3105,15 +3105,10 @@ static struct failslab_attr {
 
 	struct fault_attr attr;
 
-	u32 ignore_gfp_highmem;
 	u32 ignore_gfp_wait;
-
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
-
-	struct dentry *ignore_gfp_highmem_file;
 	struct dentry *ignore_gfp_wait_file;
-
-#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+#endif
 
 } failslab = {
 	.attr = FAULT_ATTR_INITIALIZER,
@@ -3131,8 +3126,6 @@ static int should_failslab(struct kmem_c
 		return 0;
 	if (flags & __GFP_NOFAIL)
 		return 0;
-	if (failslab.ignore_gfp_highmem && (flags & __GFP_HIGHMEM))
-		return 0;
 	if (failslab.ignore_gfp_wait && (flags & __GFP_WAIT))
 		return 0;
 
@@ -3156,15 +3149,9 @@ static int __init failslab_debugfs(void)
 		debugfs_create_bool("ignore-gfp-wait", mode, dir,
 				      &failslab.ignore_gfp_wait);
 
-	failslab.ignore_gfp_highmem_file =
-		debugfs_create_bool("ignore-gfp-highmem", mode, dir,
-				      &failslab.ignore_gfp_highmem);
-
-	if (!failslab.ignore_gfp_wait_file ||
-			!failslab.ignore_gfp_highmem_file) {
+	if (!failslab.ignore_gfp_wait_file) {
 		err = -ENOMEM;
 		debugfs_remove(failslab.ignore_gfp_wait_file);
-		debugfs_remove(failslab.ignore_gfp_highmem_file);
 		cleanup_fault_attr_dentries(&failslab.attr);
 	}
 
Index: work-fault-inject/Documentation/fault-injection/fault-injection.txt
===================================================================
--- work-fault-inject.orig/Documentation/fault-injection/fault-injection.txt
+++ work-fault-inject/Documentation/fault-injection/fault-injection.txt
@@ -86,7 +86,6 @@ configuration of fault-injection capabil
 	specifies the maximum stacktrace depth walked during search
 	for a caller within [address-start,address-end).
 
-- /debug/failslab/ignore-gfp-highmem:
 - /debug/fail_page_alloc/ignore-gfp-highmem:
 
 	Format: { 0 | 1 }
@@ -167,7 +166,6 @@ echo 10 > /debug/$FAILNAME/probability
 echo 100 > /debug/$FAILNAME/interval
 echo -1 > /debug/$FAILNAME/times
 echo 2 > /debug/$FAILNAME/verbose
-echo 1 > /debug/$FAILNAME/ignore-gfp-highmem
 echo 1 > /debug/$FAILNAME/ignore-gfp-wait
 
 blacklist()
