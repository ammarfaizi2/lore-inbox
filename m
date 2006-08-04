Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWHDBqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWHDBqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWHDBqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:46:53 -0400
Received: from mga05.intel.com ([192.55.52.89]:60809 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932083AbWHDBqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:46:52 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="110477027:sNHT7421336202"
Date: Thu, 3 Aug 2006 18:35:45 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [Patch] fix potential stack overflow in net/core/utils.c
Message-ID: <20060803183545.B27141@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On High end systems (1024 or so cpus) this can potentially cause stack
overflow. Fix the stack usage.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.18-rc3/net/core/utils.c~	2006-08-03 14:50:28.341080424 -0700
+++ linux-2.6.18-rc3/net/core/utils.c	2006-08-03 14:50:51.222601904 -0700
@@ -130,12 +130,13 @@ void __init net_random_init(void)
 static int net_random_reseed(void)
 {
 	int i;
-	unsigned long seed[NR_CPUS];
+	unsigned long seed;
 
-	get_random_bytes(seed, sizeof(seed));
 	for_each_possible_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
-		__net_srandom(state, seed[i]);
+
+		get_random_bytes(&seed, sizeof(seed));
+		__net_srandom(state, seed);
 	}
 	return 0;
 }
