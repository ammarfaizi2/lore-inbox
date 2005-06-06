Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVFFToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVFFToW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVFFToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:44:21 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:49545 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261634AbVFFToK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:44:10 -0400
Message-ID: <42A4A77A.5060101@colorfullife.com>
Date: Mon, 06 Jun 2005 21:43:54 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Oleg <graycardinal@pisem.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kmem_cache_create: duplicate cache fat_cache
References: <200505181217.29904.graycardinal@pisem.net> <87br779jen.fsf@devron.myhome.or.jp>
In-Reply-To: <87br779jen.fsf@devron.myhome.or.jp>
Content-Type: multipart/mixed;
 boundary="------------030202050706030905030801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202050706030905030801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OGAWA Hirofumi wrote:

>Ummm... why is this normal situation? Didn't you run the
>modules_install after changed .config?  Anyway, this patch returns
>NULL instead of calling BUG().  This case seems to also happen with
>user error.
>
>  
>
Either return NULL or ignore the collision. I don't know what's the 
better solution.

I'm open to either approach - it depends on what the kmem_cache_create() 
caller expects.

--
    Manfred

--------------030202050706030905030801
Content-Type: text/plain;
 name="patch-slab-nobug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-nobug"

--- 2.6/mm/slab.c	2005-06-05 17:29:01.000000000 +0200
+++ build-2.6/mm/slab.c	2005-06-06 21:34:38.000000000 +0200
@@ -1480,9 +1480,14 @@
 			} 	
 			if (!strcmp(pc->name,name)) { 
 				printk("kmem_cache_create: duplicate cache %s\n",name); 
-				up(&cache_chain_sem); 
-				unlock_cpu_hotplug();
-				BUG(); 
+				/* This is a severe bug, because it breaks
+				 * tuning by writing to /proc/slabinfo.
+				 * But everything else works, and since
+				 * duplicate caches typically happen if
+				 * someone inserts a module twice, we'll
+				 * continue.
+				 */
+				WARN_ON(1); 
 			}	
 		}
 		set_fs(old_fs);

--------------030202050706030905030801--
