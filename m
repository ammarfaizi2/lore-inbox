Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUJZE0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUJZE0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUJZBjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:39:10 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47576 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262091AbUJZBXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:51 -0400
Message-ID: <417D7799.8080307@free.fr>
Date: Tue, 26 Oct 2004 00:00:57 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1-V0.2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

Patch needed, when CONFIG_HOTPLUG_CPU is enabled, in order to fix a 
compile error.

--- mm/swap.c.orig      2004-10-22 22:31:58.000000000 +0200
+++ mm/swap.c   2004-10-22 23:10:44.202728352 +0200
@@ -423,12 +423,12 @@
#ifdef CONFIG_HOTPLUG_CPU
static void lru_drain_cache(unsigned int cpu)
{
-       struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
+       struct pagevec *pvec = &per_cpu_var_locked(lru_add_pvecs, cpu);

       /* CPU is dead, so no locking needed. */
       if (pagevec_count(pvec))
               __pagevec_lru_add(pvec);
-       pvec = &per_cpu(lru_add_active_pvecs, cpu);
+       pvec = &per_cpu_var_locked(lru_add_active_pvecs, cpu);
       if (pagevec_count(pvec))
               __pagevec_lru_add_active(pvec);
}

Otherwise, I get :

  CC      mm/swap.o
mm/swap.c: In function `lru_drain_cache':
mm/swap.c:426: `per_cpu__lru_add_pvecs' undeclared (first use in this 
function)
mm/swap.c:426: (Each undeclared identifier is reported only once
mm/swap.c:426: for each function it appears in.)
mm/swap.c:426: warning: type defaults to `int' in declaration of `type name'
mm/swap.c:426: invalid type argument of `unary *'
mm/swap.c:431: `per_cpu__lru_add_active_pvecs' undeclared (first use in 
this function)
mm/swap.c:431: warning: type defaults to `int' in declaration of `type name'
mm/swap.c:431: invalid type argument of `unary *'
make[1]: *** [mm/swap.o] Error 1
make: *** [mm] Error 2

Hope this help,
Remi
