Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269345AbUJUF6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269345AbUJUF6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbUJUF5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:57:21 -0400
Received: from ozlabs.org ([203.10.76.45]:3285 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270259AbUJUFzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:55:48 -0400
Subject: Re: Fix for MODULE_PARM obsolete
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041020222633.7ec19a4e.akpm@osdl.org>
References: <1098336290.10571.341.camel@localhost.localdomain>
	 <20041020222633.7ec19a4e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098338148.10571.354.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 15:55:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 15:26, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > There is no __attribute_unused__: use __attribute__((__unused__)).
> 
> Will that fix this?
> 
> /usr/src/25/drivers/acpi/tables/tbxfroot.c:168: undefined reference to `MODULE_PARM_'

No, but this will.  Tested on a tree which still has MODULE_PARM in it.

Name: Fixe MODULE_PARM warning
Status: Tested on 2.6-bk
Depends: Module/MODULE_PARM-warning.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

There is no __attribute_unused__: use __attribute__((__unused__)).
Also, needs a real MODULE_PARM_ for when gcc doesn't throw it away for us.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20741-linux-2.6-bk/include/linux/module.h .20741-linux-2.6-bk.updated/include/linux/module.h
--- .20741-linux-2.6-bk/include/linux/module.h	2004-10-21 15:46:41.000000000 +1000
+++ .20741-linux-2.6-bk.updated/include/linux/module.h	2004-10-21 15:46:45.000000000 +1000
@@ -563,14 +563,14 @@ struct obsolete_modparm {
 	void *addr;
 };
 
-extern void __deprecated MODULE_PARM_(void);
+static inline void __deprecated MODULE_PARM_(void) { }
 #ifdef MODULE
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
 { __stringify(var), type, &MODULE_PARM_ };
 #else
-#define MODULE_PARM(var,type) static void __attribute_unused__ *__parm_##var = &MODULE_PARM_;
+#define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
 #endif
 
 #define __MODULE_STRING(x) __stringify(x)

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

