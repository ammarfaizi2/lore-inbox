Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270669AbUJUJ4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270669AbUJUJ4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270381AbUJUJw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:52:59 -0400
Received: from ozlabs.org ([203.10.76.45]:53978 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269399AbUJUJk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:40:26 -0400
Subject: Re: Am I paranoid or is everyone out to break my kernel builds
	(Breakage in drivers/pcmcia)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041021100903.A3089@flint.arm.linux.org.uk>
References: <20041021100903.A3089@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098351606.10571.359.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 19:40:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 19:09, Russell King wrote:
> It would appear that this change:
> 
> -module_param_array(irq_list, int, irq_list_count, 0444);
> +module_param_array(irq_list, int, &irq_list_count, 0444);
> 
> given:
> 
> static int irq_list[16];
> static int irq_list_count;
> 
> breaks PCMCIA drivers.  Why?
> 
> #define module_param_array(name, type, num, perm)               \
>         module_param_array_named(name, name, type, num, perm)
> 
> #define module_param_array_named(name, array, type, num, perm)          \
>         static struct kparam_array __param_arr_##name                   \
>         = { ARRAY_SIZE(array), &num, param_set_##type, param_get_##type,\
>             sizeof(array[0]), array };                                  \
>         module_param_call(name, param_array_set, param_array_get,       \
>                           &__param_arr_##name, perm)

I'm confused. Andrew, what happened to this part of my patch?

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22800-linux-2.6-bk/include/linux/moduleparam.h .22800-linux-2.6-bk.updated/include/linux/moduleparam.h
--- .22800-linux-2.6-bk/include/linux/moduleparam.h	2004-10-19 14:34:21.000000000 +1000
+++ .22800-linux-2.6-bk.updated/include/linux/moduleparam.h	2004-10-20 17:13:45.000000000 +1000
@@ -129,16 +129,16 @@ extern int param_set_invbool(const char 
 extern int param_get_invbool(char *buffer, struct kernel_param *kp);
 #define param_check_invbool(name, p) __param_check(name, p, int)
 
-/* Comma-separated array: num is set to number they actually specified. */
-#define module_param_array_named(name, array, type, num, perm)		\
+/* Comma-separated array: *nump is set to number they actually specified. */
+#define module_param_array_named(name, array, type, nump, perm)		\
 	static struct kparam_array __param_arr_##name			\
-	= { ARRAY_SIZE(array), &num, param_set_##type, param_get_##type,\
+	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
 			  &__param_arr_##name, perm)
 
-#define module_param_array(name, type, num, perm)		\
-	module_param_array_named(name, name, type, num, perm)
+#define module_param_array(name, type, nump, perm)		\
+	module_param_array_named(name, name, type, nump, perm)
 
 extern int param_array_set(const char *val, struct kernel_param *kp);
 extern int param_array_get(char *buffer, struct kernel_param *kp);


Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

