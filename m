Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262318AbSI1UIW>; Sat, 28 Sep 2002 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262319AbSI1UIW>; Sat, 28 Sep 2002 16:08:22 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:54276 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262318AbSI1UIV>; Sat, 28 Sep 2002 16:08:21 -0400
Date: Sat, 28 Sep 2002 21:13:08 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 kmem_cache bug
Message-ID: <20020928201308.GA59189@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kmem_cache_destroy() is falsely reporting
"kmem_cache_destroy: Can't free all objects" in 2.5.39. I have
verified my code was freeing all allocated items correctly.

Reverting this chunk :

-                       list_add(&slabp->list, &cachep->slabs_free);
+/*                     list_add(&slabp->list, &cachep->slabs_free);            */
+                       if (unlikely(list_empty(&cachep->slabs_partial)))
+                               list_add(&slabp->list, &cachep->slabs_partial);
+                       else
+                               kmem_slab_destroy(cachep, slabp);

and the problem goes away. I haven't investigated why.

This is with CONFIG_SMP, !CONFIG_PREEMPT

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
