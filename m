Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTKQUAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTKQUAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:00:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41884 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261276AbTKQUAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:00:39 -0500
Date: Mon, 17 Nov 2003 15:00:30 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Alexander Viro <aviro@redhat.com>,
       <linux-kernel@vger.kernel.org>, Russell Coker <russell@coker.com.au>
Subject: [PATCH][RFC] Remove CLONE_FILES from init kernel thread creation
Message-ID: <Xine.LNX.4.44.0311171439590.2731-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the CLONE_FILES flag from the kernel_thread() call
which starts init.

This is to prevent other kernel threads from sharing file descriptors 
opened by init (try 'lsof /dev/initctl' on a 2.6 system :-).

The reason this patch is being proposed is so that usermode helper apps
launched via kernel threads (e.g. modprobe, hotplug) do not then inherit
any such file descriptors.  This is not a problem in itself so far (other
than being messy), but it is a problem for SELinux, which will otherwise
need to grant access to /dev/initctl by modprobe and hotplug, a somewhat
undesirable scenario.

As far as I can tell, there is no reason why init needs to be spawned with
CLONE_FILES.  Please let me know if there are any objections to the
change, which I would like to propose for 2.6.0+ as a cleanup.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.0-test9-mm3.orig/init/main.c linux-2.6.0-test9-mm3.w1/init/main.c
--- linux-2.6.0-test9-mm3.orig/init/main.c	2003-11-17 10:30:41.000000000 -0500
+++ linux-2.6.0-test9-mm3.w1/init/main.c	2003-11-17 14:27:07.000000000 -0500
@@ -375,7 +375,7 @@
 
 static void rest_init(void)
 {
-	kernel_thread(init, NULL, CLONE_KERNEL);
+	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	unlock_kernel();
  	cpu_idle();
 } 

