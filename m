Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313896AbSEDDQN>; Fri, 3 May 2002 23:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315176AbSEDDQN>; Fri, 3 May 2002 23:16:13 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:36129 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S313896AbSEDDQL>; Fri, 3 May 2002 23:16:11 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A781780F9@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'davem@redhat.com'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'ak@muc.de'" <ak@muc.de>
Subject: RE: my slab cache broken on sparc64
Date: Fri, 3 May 2002 22:15:56 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>It would work if the access was surrounded by:
>
>	old_fs = get_fs();
>	set_fs(KERNEL_DS);
>	... get_user(kernel_pointer) ...
>	set_fs (old_fs);
>
>But it is not.

For what it's worth to you, the below patch fixes this issue, at least on my
box.  I have patched and tested on my Ultra5.  Thanks for the help!

Bruce H.

--- linus-2.5/mm/slab.c	Wed May  1 08:38:46 2002
+++ sparctest/mm/slab.c	Fri May  3 22:59:24 2002
@@ -846,11 +846,14 @@
 			/* This happens when the module gets unloaded and
doesn't
 			   destroy its slab cache and noone else reuses the
vmalloc
 			   area of the module. Print a warning. */
+			mm_segment_t old_fs = get_fs();
+			set_fs(KERNEL_DS);
 			if (__get_user(tmp,pc->name)) { 
 				printk("SLAB: cache with size %d has lost
its name\n", 
 					pc->objsize); 
 				continue; 
-			} 	
+			}
+			set_fs(old_fs); 	
 			if (!strcmp(pc->name,name)) { 
 				printk("kmem_cache_create: duplicate cache
%s\n",name); 
 				up(&cache_chain_sem); 
@@ -1963,10 +1966,13 @@
 
 	name = cachep->name; 
 	{
-	char tmp; 
+	char tmp;
+	mm_segment_t old_fs = get_fs();
+	set_fs(KERNEL_DS);
 	if (__get_user(tmp, name)) 
-		name = "broken"; 
-	} 	
+		name = "broken";
+	set_fs(old_fs); 
+	}
 
 	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
 		name, active_objs, num_objs, cachep->objsize,
