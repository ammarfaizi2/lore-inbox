Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSKTMpD>; Wed, 20 Nov 2002 07:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbSKTMpD>; Wed, 20 Nov 2002 07:45:03 -0500
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:53120
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S266038AbSKTMpB>; Wed, 20 Nov 2002 07:45:01 -0500
Date: Wed, 20 Nov 2002 13:52:11 +0100
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't allocate memory when loading a module 2.5.48-bk
Message-ID: <20021120125211.GA446@apocalipsis>
References: <20021120084303.GB22936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120084303.GB22936@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 12:43:03AM -0800, Greg KH wrote:
> With Linus's latest bk tree (plus some USB patches) I get the following
> error when trying to load the parport.o module:
> 
> # modprobe parport
> FATAL: Error inserting /lib/modules/2.5.48/kernel/parport.o: Cannot allocate memory
> 
> Any ideas?

 Try applying this patch:

--- linux-2.5.48/kernel/module.c.orig   Tue Nov 19 20:08:52 2002
+++ linux-2.5.48/kernel/module.c        Tue Nov 19 20:37:47 2002
@@ -972,13 +972,15 @@
        memset(ptr, 0, mod->core_size);
        mod->module_core = ptr;

-       ptr = module_alloc(mod->init_size);
-       if (!ptr) {
-               err = -ENOMEM;
-               goto free_core;
-       }
-       memset(ptr, 0, mod->init_size);
-       mod->module_init = ptr;
+       if (mod->init_size) {
+               ptr = module_alloc(mod->init_size);
+               if (!ptr) {
+                       err = -ENOMEM;
+                       goto free_core;
+               }
+               memset(ptr, 0, mod->init_size);
+               mod->module_init = ptr;
+       }

        /* Transfer each section which requires ALLOC, and set sh_offset
           fields to absolute addresses. */

-- 
/jm

