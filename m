Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbUKRDsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbUKRDsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKRDsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:48:47 -0500
Received: from ozlabs.org ([203.10.76.45]:8864 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261737AbUKRDso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:48:44 -0500
Subject: Re: modprobe + request_module() deadlock
From: Rusty Russell <rusty@rustcorp.com.au>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <20041117222949.GA9006@linuxtv.org>
References: <20041117222949.GA9006@linuxtv.org>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 14:48:22 +1100
Message-Id: <1100749702.5865.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 23:29 +0100, Johannes Stezenbach wrote:
> Hi,
> 
> it seems that modprobe in newer versions of module-init-tools
> (here: 3.1-pre6) gets an exclusive lock on the module's .ko file:
> 
>                 struct flock lock;
>                 lock.l_type = F_WRLCK;
>                 lock.l_whence = SEEK_SET;
>                 lock.l_start = 0;
>                 lock.l_len = 1;
>                 fcntl(fd, F_SETLKW, &lock);
> 
> This leads to a deadlock when the loaded module calls
> request_module() in its module_init() function, to load
> a module which in turn depends on the first module.

My bug, I think.  Does this help?

Rusty.

--- modprobe.c.~70~	2004-09-30 20:16:19.000000000 +1000
+++ modprobe.c	2004-11-18 14:44:57.000000000 +1100
@@ -735,6 +735,11 @@
 		       strip_vermagic, strip_modversion);
 	}
 
+	/* Don't do ANYTHING if already in kernel. */
+	if (!ignore_proc
+	    && module_in_kernel(newname ?: mod->modname, NULL) == 1)
+		goto exists_error;
+
 	fd = lock_file(mod->filename);
 	if (fd < 0) {
 		error("Could not open '%s': %s\n",
@@ -742,11 +747,6 @@
 		goto out_optstring;
 	}
 
-	/* Don't do ANYTHING if already in kernel. */
-	if (!ignore_proc
-	    && module_in_kernel(newname ?: mod->modname, NULL) == 1)
-		goto exists_error;
-
 	command = find_command(mod->modname, commands);
 	if (command && !ignore_commands) {
 		/* It might recurse: unlock. */
@@ -799,7 +799,7 @@
 	if (first_time)
 		error("Module %s already in kernel.\n",
 		      newname ?: mod->modname);
-	goto out_unlock;
+	goto out_optstring;
 }
 
 /* Do recursive removal. */

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

