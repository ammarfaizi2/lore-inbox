Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVJSTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVJSTvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVJSTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:51:05 -0400
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:45444 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751259AbVJSTvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:51:02 -0400
Date: Wed, 19 Oct 2005 20:50:55 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - create common header for init/main.c called init functions
Message-ID: <20051019195055.GC32720@home.fluff.org>
References: <20051014004210.GA3095@home.fluff.org> <20051018231109.GA15443@krypton>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20051018231109.GA15443@krypton>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 18, 2005 at 07:11:09PM -0400, Arthur Othieno wrote:
> On Fri, Oct 14, 2005 at 01:42:10AM +0100, Ben Dooks wrote:
> > init/main.c calls a number of functions externally
> > but declaring them locally. This patch creates a
> > new header (linux/kernel_init.h) and moves all
> > the declarations into it.
> 
> These functions are only referenced in init/main.c, and rightfully so.
> In the end, this doesn't change anything much, other than maintainance
> overhead for the new include/linux/kernel_init.h
> 
> But, comments within..
> 
> > Also removes any old init functions now done by
> > an initcall()
> 
> (mca|sbus|tc)_init() removal look good.
> 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> > diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3b/drivers/acpi/bus.c linux-2.6.14-rc4-bjd3c/drivers/acpi/bus.c
> > --- linux-2.6.14-rc4-bjd3b/drivers/acpi/bus.c	2005-10-11 10:56:31.000000000 +0100
> > +++ linux-2.6.14-rc4-bjd3c/drivers/acpi/bus.c	2005-10-14 01:32:27.000000000 +0100
> > @@ -30,6 +30,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/device.h>
> >  #include <linux/proc_fs.h>
> > +#include <linux/kernel_init.h>

I've attached a pair of patches, the first removes
the unused functions, and the second moves the init
function declarations into include/linux/init.h
(and adds the init to include/linux/prio_tree.h)

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="init-remove-unused.patch"

diff -urp -X linux-2.6.14-rc4-git7-bjd1/Documentation/dontdiff linux-2.6.14-rc4-git7/init/main.c linux-2.6.14-rc4-git7-bjd1/init/main.c
--- linux-2.6.14-rc4-git7/init/main.c	2005-10-19 12:44:36.000000000 +0100
+++ linux-2.6.14-rc4-git7-bjd1/init/main.c	2005-10-19 12:51:19.000000000 +0100
@@ -82,8 +82,6 @@ static int init(void *);
 
 extern void init_IRQ(void);
 extern void fork_init(unsigned long);
-extern void mca_init(void);
-extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern void buffer_init(void);
@@ -101,10 +99,6 @@ extern void acpi_early_init(void);
 static inline void acpi_early_init(void) { }
 #endif
 
-#ifdef CONFIG_TC
-extern void tc_init(void);
-#endif
-
 enum system_states system_state;
 EXPORT_SYMBOL(system_state);
 

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="init-move-delarations.patch"

diff -urp -X linux-2.6.14-rc4-git7-bjd1/Documentation/dontdiff linux-2.6.14-rc4-git7-bjd1/include/linux/init.h linux-2.6.14-rc4-git7-bjd2/include/linux/init.h
--- linux-2.6.14-rc4-git7-bjd1/include/linux/init.h	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.14-rc4-git7-bjd2/include/linux/init.h	2005-10-19 14:15:20.000000000 +0100
@@ -143,6 +143,25 @@ struct obs_kernel_param {
 
 /* Relies on saved_command_line being set */
 void __init parse_early_param(void);
+
+/* items used by init/main.c */
+
+extern void __init init_IRQ(void);
+extern void __init fork_init(unsigned long);
+extern void __init sysctl_init(void);
+extern void __init signals_init(void);
+extern void __init buffer_init(void);
+extern void __init pidhash_init(void);
+extern void __init pidmap_init(void);
+extern void __init free_initmem(void);
+extern void __init populate_rootfs(void);
+extern void __init driver_init(void);
+extern void __init prepare_namespace(void);
+
+#ifdef CONFIG_ACPI
+extern void __init acpi_early_init(void);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 /**
diff -urp -X linux-2.6.14-rc4-git7-bjd1/Documentation/dontdiff linux-2.6.14-rc4-git7-bjd1/include/linux/prio_tree.h linux-2.6.14-rc4-git7-bjd2/include/linux/prio_tree.h
--- linux-2.6.14-rc4-git7-bjd1/include/linux/prio_tree.h	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.14-rc4-git7-bjd2/include/linux/prio_tree.h	2005-10-19 13:31:41.000000000 +0100
@@ -117,4 +117,6 @@ struct prio_tree_node *prio_tree_next(st
 #define raw_prio_tree_remove(root, node) \
 	prio_tree_remove(root, (struct prio_tree_node *) (node))
 
+extern void __init prio_tree_init(void);
+
 #endif /* _LINUX_PRIO_TREE_H */
diff -urp -X linux-2.6.14-rc4-git7-bjd1/Documentation/dontdiff linux-2.6.14-rc4-git7-bjd1/init/main.c linux-2.6.14-rc4-git7-bjd2/init/main.c
--- linux-2.6.14-rc4-git7-bjd1/init/main.c	2005-10-19 12:51:19.000000000 +0100
+++ linux-2.6.14-rc4-git7-bjd2/init/main.c	2005-10-19 14:15:26.000000000 +0100
@@ -47,6 +47,8 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/prio_tree.h>
+#include <linux/radix-tree.h>
 #include <net/sock.h>
 
 #include <asm/io.h>
@@ -80,22 +82,7 @@
 
 static int init(void *);
 
-extern void init_IRQ(void);
-extern void fork_init(unsigned long);
-extern void sysctl_init(void);
-extern void signals_init(void);
-extern void buffer_init(void);
-extern void pidhash_init(void);
-extern void pidmap_init(void);
-extern void prio_tree_init(void);
-extern void radix_tree_init(void);
-extern void free_initmem(void);
-extern void populate_rootfs(void);
-extern void driver_init(void);
-extern void prepare_namespace(void);
-#ifdef	CONFIG_ACPI
-extern void acpi_early_init(void);
-#else
+#ifndef	CONFIG_ACPI
 static inline void acpi_early_init(void) { }
 #endif
 

--TB36FDmn/VVEgNH/--
