Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161506AbWJKVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161506AbWJKVWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJKVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:21:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:19874 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161425AbWJKVIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:06 -0400
Date: Wed, 11 Oct 2006 14:07:22 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, rientjes@cs.washington.edu, clameter@sgi.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 42/67] do not free non slab allocated per_cpu_pageset
Message-ID: <20061011210722.GQ16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="do-not-free-non-slab-allocated-per_cpu_pageset.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Rientjes <rientjes@cs.washington.edu>

Stops panic associated with attempting to free a non slab-allocated
per_cpu_pageset.

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
Acked-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 mm/page_alloc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/mm/page_alloc.c
+++ linux-2.6.18/mm/page_alloc.c
@@ -1845,8 +1845,10 @@ static inline void free_zone_pagesets(in
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
 
+		/* Free per_cpu_pageset if it is slab allocated */
+		if (pset != &boot_pageset[cpu])
+			kfree(pset);
 		zone_pcp(zone, cpu) = NULL;
-		kfree(pset);
 	}
 }
 

--
