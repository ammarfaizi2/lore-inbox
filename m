Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265788AbUEZWWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUEZWWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUEZWWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:22:44 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:11728 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S265788AbUEZWWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:22:42 -0400
Message-ID: <40B473F7.4000100@linuxmail.org>
Date: Wed, 26 May 2004 20:39:51 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] SMP support for drain local pages.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Nigel Cunningham <ncunningham@linuxmail.org>

Hi.

This patch adds SMP support for drain_local_pages, so that suspend
implementations can drain pcp structures on all CPUs and thus accurately
determine which pages are free.

Please apply.

diff -ruN 2.6.6-current-bk/mm/page_alloc.c smp-drain-local-pages/mm/page_alloc.c
--- 2.6.6-current-bk/mm/page_alloc.c    2004-05-26 19:47:15.000000000 +1000
+++ smp-drain-local-pages/mm/page_alloc.c       2004-05-26 19:56:19.000000000 +1000
@@ -459,6 +459,24 @@
         __drain_pages(smp_processor_id());
         local_irq_restore(flags);
  }
+
+#ifdef CONFIG_SMP
+static void __smp_drain_local_pages(void * data)
+{
+       drain_local_pages();
+}
+
+void smp_drain_local_pages(void)
+{
+       smp_call_function(__smp_drain_local_pages, NULL, 0, 1);
+       drain_local_pages();
+}
+#else
+void smp_drain_local_pages(void)
+{
+       drain_local_pages();
+}
+#endif
  #endif /* CONFIG_PM */

  static void zone_statistics(struct zonelist *zonelist, struct zone *z)



