Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVETNQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVETNQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVETNQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:16:37 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:61192 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261462AbVETNQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:16:24 -0400
To: Oleg <graycardinal@pisem.net>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: PROBLEM: kmem_cache_create: duplicate cache fat_cache
References: <200505181217.29904.graycardinal@pisem.net>
	<87br779jen.fsf@devron.myhome.or.jp>
	<200505201831.27842.graycardinal@pisem.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 20 May 2005 22:16:22 +0900
In-Reply-To: <200505201831.27842.graycardinal@pisem.net> (Oleg's message of "Fri, 20 May 2005 18:31:27 +0400")
Message-ID: <87u0ky82c9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg <graycardinal@pisem.net> writes:

> Thank you, but "goto opps", not "goto oops" in patch.

Ahh, sorry. I attached a fixed patch.

>>Didn't you run the  modules_install after changed .config?
> No, I'm don't run modules_install. I'm build all modules first and use it (if required) for all my kernel's... And I have one init script, where :
> ...
> /sbin/modprobe vfat
> ...
> I want test to load any modules. Why not ?

If you use the different config kernel, it may use the different
structures size etc., it's obviously wrong and this miss match can be
the cause of Oops.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 mm/slab.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN mm/slab.c~slab-dont-call-bug mm/slab.c
--- linux-2.6.12-rc4/mm/slab.c~slab-dont-call-bug	2005-05-20 22:04:21.000000000 +0900
+++ linux-2.6.12-rc4-hirofumi/mm/slab.c	2005-05-20 22:04:51.000000000 +0900
@@ -1488,8 +1488,10 @@ next:
 				printk("kmem_cache_create: duplicate cache %s\n",name); 
 				up(&cache_chain_sem); 
 				unlock_cpu_hotplug();
-				BUG(); 
-			}	
+				set_fs(old_fs);
+				cachep = NULL;
+				goto opps;
+			}
 		}
 		set_fs(old_fs);
 	}
_
