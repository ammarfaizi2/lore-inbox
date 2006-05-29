Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWE2V1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWE2V1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWE2V1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4066 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751380AbWE2V1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:12 -0400
Date: Mon, 29 May 2006 23:27:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 55/61] lock validator: special locking: sb->s_umount
Message-ID: <20060529212732.GC3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

workaround for special sb->s_umount locking rule.

s_umount gets held across a series of lock dropping and releasing
in prune_one_dentry(), so i changed the order, at the risk of
introducing a umount race. FIXME.

i think a better fix would be to do the unlocks as _non_nested in
prune_one_dentry(), and to do the up_read() here as
an up_read_non_nested() as well?

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 fs/dcache.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux/fs/dcache.c
===================================================================
--- linux.orig/fs/dcache.c
+++ linux/fs/dcache.c
@@ -470,8 +470,9 @@ static void prune_dcache(int count, stru
 		s_umount = &dentry->d_sb->s_umount;
 		if (down_read_trylock(s_umount)) {
 			if (dentry->d_sb->s_root != NULL) {
-				prune_one_dentry(dentry);
+// lockdep hack: do this better!
 				up_read(s_umount);
+				prune_one_dentry(dentry);
 				continue;
 			}
 			up_read(s_umount);
