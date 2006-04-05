Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWDEAEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWDEAEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWDEABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:46 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:38338
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750980AbWDEABh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:37 -0400
Date: Tue, 4 Apr 2006 17:00:53 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Sergey Vlasov <vsu@altlinux.ru>, Christoph Hellwig <hch@lst.de>,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/26] Fix module refcount leak in __set_personality()
Message-ID: <20060405000053.GR27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-module-refcount-leak-in.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Vlasov <vsu@altlinux.ru>

If the change of personality does not lead to change of exec domain,
__set_personality() returned without releasing the module reference
acquired by lookup_exec_domain().

This patch was already included in Linus' tree.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/exec_domain.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.1.orig/kernel/exec_domain.c
+++ linux-2.6.16.1/kernel/exec_domain.c
@@ -140,6 +140,7 @@ __set_personality(u_long personality)
 	ep = lookup_exec_domain(personality);
 	if (ep == current_thread_info()->exec_domain) {
 		current->personality = personality;
+		module_put(ep->module);
 		return 0;
 	}
 

--
