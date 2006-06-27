Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWF0MqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWF0MqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWF0MqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:46:13 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:59602 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S932216AbWF0MqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:46:12 -0400
Date: Tue, 27 Jun 2006 08:46:09 -0400
From: Sonny Rao <sonny@burdell.org>
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH] powerpc: fix idr locking in init_new_context
Message-ID: <20060627124609.GA2497@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We always need to serialize accesses to mmu_context_idr.

I hit this bug when testing with a small number of mmu contexts.


Signed-off-by: Sonny Rao <sonny@burdell.org>

--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -44,7 +44,9 @@ again:
                return err;
 
        if (index > MAX_CONTEXT) {
+               spin_lock(&mmu_context_lock);
                idr_remove(&mmu_context_idr, index);
+               spin_unlock(&mmu_context_lock);
                return -ENOMEM;
        }

