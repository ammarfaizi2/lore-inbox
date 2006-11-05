Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161347AbWKEWVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbWKEWVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161706AbWKEWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:21:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54182 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161347AbWKEWVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:21:51 -0500
Message-Id: <200611052223.kA5MNfBn028173@sous-sol.org>
Subject: patch fix-sys_move_pages-when-a-null-node-list-is-passed.patch queued to -stable tree
To: sfr@canb.auug.org.au, akpm@osdl.org, chrisw@sous-sol.org, clameter@sgi.com,
       linux-kernel@vger.kernel.org
Cc: <stable@kernel.org>
From: chrisw@sous-sol.org
Date: Sun, 05 Nov 2006 14:23:41 -0800
In-Reply-To: <20061103144243.4601ba76.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: Fix sys_move_pages when a NULL node list is passed.

to the 2.6.18-stable tree.  Its filename is

     fix-sys_move_pages-when-a-null-node-list-is-passed.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From stable-bounces@linux.kernel.org  Thu Nov  2 19:46:17 2006
Date: Fri, 3 Nov 2006 14:42:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Lameter <clameter@sgi.com>
Message-Id: <20061103144243.4601ba76.sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Fix sys_move_pages when a NULL node list is passed.

sys_move_pages() uses vmalloc() to allocate an array of structures
that is fills with information passed from user mode and then passes to
do_stat_pages() (in the case the node list is NULL).  do_stat_pages()
depends on a marker in the node field of the structure to decide how large
the array is and this marker is correctly inserted into the last element
of the array.  However, vmalloc() doesn't zero the memory it allocates
and if the user passes NULL for the node list, then the node fields are
not filled in (except for the end marker).  If the memory the vmalloc()
returned happend to have a word with the marker value in it in just the
right place, do_pages_stat will fail to fill the status field of part
of the array and we will return (random) kernel data to user mode.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/migrate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18.2.orig/mm/migrate.c
+++ linux-2.6.18.2/mm/migrate.c
@@ -950,7 +950,8 @@ asmlinkage long sys_move_pages(pid_t pid
 				goto out;
 
 			pm[i].node = node;
-		}
+		} else
+			pm[i].node = 0;	/* anything to not match MAX_NUMNODES */
 	}
 	/* End marker */
 	pm[nr_pages].node = MAX_NUMNODES;


Patches currently in stable-queue which might be from sfr@canb.auug.org.au are

queue-2.6.18/fix-sys_move_pages-when-a-null-node-list-is-passed.patch
