Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTIBSUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTIBRtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:49:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:50571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263864AbTIBRkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:40:08 -0400
Date: Tue, 2 Sep 2003 10:23:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Curnow <Richard.Curnow@superh.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel bug in 2.6.0-test4-mm4 when removing USB flash disc
Message-Id: <20030902102316.57d30c54.akpm@osdl.org>
In-Reply-To: <20030902121727.GA340@malvern.uk.w2k.superh.com>
References: <20030902121727.GA340@malvern.uk.w2k.superh.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Curnow <Richard.Curnow@superh.com> wrote:
>
> kernel BUG at mm/slab.c:1623!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c013fa45>]    Not tainted VLI
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: 00000031   ebx: 000ab6b6   ecx: 00000001   edx: c04808ac
> esi: c04c6320   edi: 6b6b6b6b   ebp: d3e4fdbc   esp: d3e4fd8c
> ds: 007b   es: 007b   ss: 0068
> Stack: c03d54c0 6b6b6b6b ca451a04 c04c6320 d6a71000 0019aca8 00000286 d3e4fdbc 
>        c02a2ef1 ca451984 ca451a04 00000202 d3e4fdd0 c022e097 6b6b6b6b c04cc398 
>        cee44760 d3e4fddc c022e0be ca451a04 d3e4fde8 c02a325f ca451a04 d3e4fe1c 
> Call Trace:
>  [<c02a2ef1>] disk_release+0x29/0x34
>  [<c022e097>] kobject_cleanup+0x4b/0x5c

Thanks.  This should make it happy again:


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Richard Curnow <Richard.Curnow@superh.com> wrote:
>
> kernel BUG at mm/slab.c:1623!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c013fa45>]    Not tainted VLI
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: 00000031   ebx: 000ab6b6   ecx: 00000001   edx: c04808ac
> esi: c04c6320   edi: 6b6b6b6b   ebp: d3e4fdbc   esp: d3e4fd8c
> ds: 007b   es: 007b   ss: 0068
> Stack: c03d54c0 6b6b6b6b ca451a04 c04c6320 d6a71000 0019aca8 00000286 d3e4fdbc 
>        c02a2ef1 ca451984 ca451a04 00000202 d3e4fdd0 c022e097 6b6b6b6b c04cc398 
>        cee44760 d3e4fddc c022e0be ca451a04 d3e4fde8 c02a325f ca451a04 d3e4fe1c 
> Call Trace:
>  [<c02a2ef1>] disk_release+0x29/0x34
>  [<c022e097>] kobject_cleanup+0x4b/0x5c

Thanks.  This should make it happy again:


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

