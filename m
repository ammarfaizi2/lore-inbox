Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUABNU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265561AbUABNU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:20:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:4045 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265560AbUABNUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:20:22 -0500
Date: Fri, 2 Jan 2004 18:55:09 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: rusty@au1.ibm.com
Cc: lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Module Observations
Message-ID: <20040102185509.A18154@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I was going thr' module code and made some observations:

1. sys_init_module drops the module_mutex semaphore
   before calling mod->init() function and later
   reacquires it. After reacquiring, it marks
   the module state as MODULE_STATE_LIVE.

   In the window when mod->init() function is running,
   isn't it possible that sys_delete_module (running
   on some other CPU and trying to remove the _same_ module)
   acquires the module_mutex sem and marks the module
   state as MODULE_STATE_GOING?

   Shouldn't sys_init_module check for
   that possibility when it reacquires the semaphore after
   calling mod->init function?

--- module.c.org        Fri Jan  2 18:37:54 2004
+++ module.c    Fri Jan  2 18:38:57 2004
@@ -1750,7 +1750,8 @@

        /* Now it's a first class citizen! */
        down(&module_mutex);
-       mod->state = MODULE_STATE_LIVE;
+       if (likely(mod->state != MODULE_STATE_GOING))
+               mod->state = MODULE_STATE_LIVE;
        /* Drop initial reference. */
        module_put(mod);
        module_free(mod, mod->module_init);


  This off-course means that you are trying to insmod and rmmod 
  the same module simultaneously from different CPUs and hence
  may not be practical.

2. try_module_get() and module_put()

	try_module_get increments the local cpu's ref count for the module 
   and module_put decrements it.

   Is it required that the caller call both these functions from the same CPU?
   Otherwise, the total refcount for the module will be non-zero!



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
