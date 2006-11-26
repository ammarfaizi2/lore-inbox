Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935538AbWKZTJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935538AbWKZTJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935544AbWKZTJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:09:33 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:64027 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S935538AbWKZTJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:09:32 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
	<adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 26 Nov 2006 11:09:30 -0800
In-Reply-To: <20061125164118.de53d1cf.akpm@osdl.org> (Andrew Morton's message of "Sat, 25 Nov 2006 16:41:18 -0800")
Message-ID: <adaac2e3tzp.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Nov 2006 19:09:31.0251 (UTC) FILETIME=[66E2B430:01C7118E]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Changes this late in the piece rather hurt.

Fair enough.  This was a really close call to me but let's leave it
for 2.6.19.  I'll ask Linus to merge the patch below to fix amso1100.
I'm a little worried that other such uses might be lurking in the
tree but I guess no one has complained...

 > Your proposed change is still wrong for long longs, isn't it?

Yes, it would fail for aligning long long with an unsigned long
alignment on 32-bits.  But that's broken in the current tree too.
I'll post a patch that should work for everything -- how about if you
queue that for 2.6.20-early?

 - R.

diff --git a/drivers/infiniband/hw/amso1100/c2_provider.c b/drivers/infiniband/hw/amso1100/c2_provider.c
index fef9727..d54b284 100644
--- a/drivers/infiniband/hw/amso1100/c2_provider.c
+++ b/drivers/infiniband/hw/amso1100/c2_provider.c
@@ -368,7 +368,7 @@ static struct ib_mr *c2_reg_phys_mr(stru
 
 		total_len += buffer_list[i].size;
 		pbl_depth += ALIGN(buffer_list[i].size,
-				   (1 << page_shift)) >> page_shift;
+				   (1ull << page_shift)) >> page_shift;
 	}
 
 	page_list = vmalloc(sizeof(u64) * pbl_depth);
@@ -383,7 +383,7 @@ static struct ib_mr *c2_reg_phys_mr(stru
 		int naddrs;
 
  		naddrs = ALIGN(buffer_list[i].size,
-			       (1 << page_shift)) >> page_shift;
+			       (1ull << page_shift)) >> page_shift;
 		for (k = 0; k < naddrs; k++)
 			page_list[j++] = (buffer_list[i].addr +
 						     (k << page_shift));
