Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbULPUJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbULPUJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbULPUJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:09:35 -0500
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:28126 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261969AbULPUJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:09:11 -0500
Message-ID: <41C1E981.1030800@umich.edu>
Date: Thu, 16 Dec 2004 15:01:05 -0500
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [RFC] Generalized prio_tree, revisited
References: <20041216053118.M1229@almesberger.net> <41C1A3F4.2090707@umich.edu> <20041216163816.X1229@almesberger.net>
In-Reply-To: <20041216163816.X1229@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> You mean to roll prio_tree_first and prio_tree_iter_init into a
> single call, so that prio_tree_first would look similar to the
> one in 2.6.7 ?

Something like this...
 
---
 
 linux-2.6.9-testuser/include/linux/prio_tree.h |    1 +
 linux-2.6.9-testuser/mm/prio_tree.c            |    3 +++
 2 files changed, 4 insertions(+)
 
diff -puN include/linux/prio_tree.h~roll_prio_tree_first include/linux/prio_tree.h
--- linux-2.6.9/include/linux/prio_tree.h~roll_prio_tree_first  2004-12-16 14:52:46.878268680 -0500
+++ linux-2.6.9-testuser/include/linux/prio_tree.h      2004-12-16 14:55:18.731183528 -0500
@@ -29,6 +29,7 @@ static inline void prio_tree_iter_init(s
        iter->root = root;
        iter->r_index = r_index;
        iter->h_index = h_index;
+       iter->cur = NULL;
 }
  
 #define INIT_PRIO_TREE_ROOT(ptr)       \
diff -puN mm/prio_tree.c~roll_prio_tree_first mm/prio_tree.c
--- linux-2.6.9/mm/prio_tree.c~roll_prio_tree_first     2004-12-16 14:55:27.695820696 -0500
+++ linux-2.6.9-testuser/mm/prio_tree.c 2004-12-16 14:56:31.889061840 -0500
@@ -457,6 +457,9 @@ static struct prio_tree_node *prio_tree_
 {
        unsigned long r_index, h_index;
  
+       if (iter->cur == NULL)
+               return prio_tree_first(iter);
+
 repeat:
        while (prio_tree_left(iter, &r_index, &h_index))
                if (overlap(iter, r_index, h_index))
_
