Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWCOJhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWCOJhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWCOJhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:37:24 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:49323 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751148AbWCOJhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:37:23 -0500
Message-ID: <4417E047.70907@cosmosbay.com>
Date: Wed, 15 Mar 2006 10:37:11 +0100
From: Eric Dumazet <dada1@resalehost.networksolutions.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] No need to protect current->group_info in sys_getgroups(),
  in_group_p() and in_egroup_p()
References: <20060315054416.GF3205@localhost.localdomain>	<1142403500.26706.2.camel@sli10-desk.sh.intel.com> <20060314233138.009414b4.akpm@osdl.org>
In-Reply-To: <20060314233138.009414b4.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060005040803050201070304"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 15 Mar 2006 10:37:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060005040803050201070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


While doing some benchmarks of an Apache/PHP SMP server, I noticed high 
oprofile numbers in in_group_p() and _atomic_dec_and_lock().

rank  percent
  1     4.8911 % __link_path_walk
  2     4.8503 % __d_lookup
*3     4.2911 % _atomic_dec_and_lock
  4     3.9307 % __copy_to_user_ll
  5     4.9004 % sysenter_past_esp
*6     3.3248 % in_group_p

It appears that in_group_p() does an uncessary

get_group_info(current->group_info); /* atomic_inc() */
  ... /* access current->group_info */
put_group_info(current->group_info); /* _atomic_dec_and_lock */


It is not necessary to do this, because the current task holds a reference on 
its own group_info, and this reference cannot change during the lookup.

This patch deletes the get_group_info()/put_group_info() pair from 
sys_getgroups(), in_group_p() and in_egroup_p() functions.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------060005040803050201070304
Content-Type: text/plain;
 name="kernel_sys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_sys.patch"

--- a/kernel/sys.c	2006-03-15 10:14:37.000000000 +0100
+++ b/kernel/sys.c	2006-03-15 10:15:55.000000000 +0100
@@ -1433,7 +1433,6 @@
 		return -EINVAL;
 
 	/* no need to grab task_lock here; it cannot change */
-	get_group_info(current->group_info);
 	i = current->group_info->ngroups;
 	if (gidsetsize) {
 		if (i > gidsetsize) {
@@ -1446,7 +1445,6 @@
 		}
 	}
 out:
-	put_group_info(current->group_info);
 	return i;
 }
 
@@ -1487,9 +1485,7 @@
 {
 	int retval = 1;
 	if (grp != current->fsgid) {
-		get_group_info(current->group_info);
 		retval = groups_search(current->group_info, grp);
-		put_group_info(current->group_info);
 	}
 	return retval;
 }
@@ -1500,9 +1496,7 @@
 {
 	int retval = 1;
 	if (grp != current->egid) {
-		get_group_info(current->group_info);
 		retval = groups_search(current->group_info, grp);
-		put_group_info(current->group_info);
 	}
 	return retval;
 }

--------------060005040803050201070304--
