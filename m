Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVFPWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVFPWMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFPWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:12:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261822AbVFPWMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:12:02 -0400
Message-ID: <42B1F92D.3040108@ce.jp.nec.com>
Date: Thu, 16 Jun 2005 18:11:57 -0400
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>,
       Alasdair Kergon <agk@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.12-rc6: fix __rh_alloc()/rh_update_states() race in dm-raid1.c
Content-Type: multipart/mixed;
 boundary="------------080402050208040909030801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402050208040909030801
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fixes the bug in dm-raid1.c that
the region returned by __rh_alloc() may be freed while
it's in use.

__rh_alloc() write-unlocks the hash_lock after inserting the new region.
Though it read-locks the hash-lock just after that, it's possible
that the region was reclaimed by rh_update_states() as the region
was clean at the time.

   CPU0                                  CPU1
   -----------------------------------------------------------------------
   __rh_alloc()
     write_lock(hash_lock)
     <insert new region to clean list>
     write_unlock(hash_lock)
                                         rh_update_states()
                                           write_lock(hash_lock)
                                           <move clean regions to freeable list>
                                           write_unlock(hash_lock)
                                           <free regions in the freeable list>
     read_lock(hash_lock)
     <return the region>

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>


--------------080402050208040909030801
Content-Type: text/x-patch;
 name="dm-raid1-race1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-raid1-race1.patch"

--- kernel/drivers/md/dm-raid1.c.orig	2005-06-16 07:13:50.610325768 -0400
+++ kernel/drivers/md/dm-raid1.c	2005-06-16 10:34:12.510719112 -0400
@@ -269,9 +269,12 @@ static inline struct region *__rh_find(s
 {
 	struct region *reg;
 
+retry:
 	reg = __rh_lookup(rh, region);
-	if (!reg)
+	if (!reg) {
 		reg = __rh_alloc(rh, region);
+		goto retry;
+	}
 
 	return reg;
 }

--------------080402050208040909030801--
