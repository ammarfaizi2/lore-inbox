Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311271AbSCLQc2>; Tue, 12 Mar 2002 11:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311272AbSCLQcS>; Tue, 12 Mar 2002 11:32:18 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:5386 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S311271AbSCLQcN>; Tue, 12 Mar 2002 11:32:13 -0500
Date: Tue, 12 Mar 2002 17:32:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: __get_user usage in mm/slab.c
In-Reply-To: <20020312162316.A3505@averell>
Message-ID: <Pine.LNX.4.21.0203121724500.21155-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Mar 2002, Andi Kleen wrote:

> I guess set_fs(KERNEL_DS); __*_user() will not catch exceptions on m68k
> currently, right? 

It will, so the patch below is enough. Linus, could you please it?
If we only have a few users of this, I agree with David, that this is
enough. Should it become more common in generic code, it should at least
be documented somewhere.

bye, Roman

Index: mm/slab.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/slab.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 slab.c
--- mm/slab.c	2002/03/12 13:28:52	1.1.1.5
+++ mm/slab.c	2002/03/12 15:25:00
@@ -839,6 +839,8 @@
 	down(&cache_chain_sem);
 	{
 		struct list_head *p;
+		mm_segment_t fs = get_fs();
+		set_fs(KERNEL_DS);
 
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
@@ -857,6 +859,7 @@
 				BUG(); 
 			}	
 		}
+		set_fs(fs);
 	}
 
 	/* There is no reason to lock our new cache before we
@@ -1964,8 +1967,11 @@
 	name = cachep->name; 
 	{
 	char tmp; 
+	mm_segment_t fs = get_fs();
+	set_fs(KERNEL_DS);
 	if (__get_user(tmp, name)) 
 		name = "broken"; 
+	set_fs(fs);
 	} 	
 
 	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",


