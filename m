Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVXzY>; Wed, 22 Nov 2000 18:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKVXzO>; Wed, 22 Nov 2000 18:55:14 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:22027 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129385AbQKVXzB>;
        Wed, 22 Nov 2000 18:55:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.3.14 / Kernel 2.4.0-test11 incompatibility 
In-Reply-To: Your message of "Wed, 22 Nov 2000 23:12:25 -0000."
             <200011222312.eAMNCQ613184@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 10:24:47 +1100
Message-ID: <4589.974935487@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 23:12:25 +0000 (GMT), 
Russell King <rmk@arm.linux.org.uk> wrote:
>        if (copy_from_user(mod+1, mod_user+1, mod->size-sizeof(*mod))) {

Using sizeof(struct module) is a nono in sys_init_module(), the code
has to use the user space size.  Does this untested patch fix the
problem?  Against 2.4.0-test11-pre6 but should fit test11.


Index: 0-test11-pre6.1/kernel/module.c
--- 0-test11-pre6.1/kernel/module.c Wed, 08 Nov 2000 11:52:15 +1100 kaos (linux-2.4/j/28_module.c 1.1.2.1.1.1.7.1.1.1 644)
+++ 0-test11-pre6.1(w)/kernel/module.c Thu, 23 Nov 2000 10:22:26 +1100 kaos (linux-2.4/j/28_module.c 1.1.2.1.1.1.7.1.1.1 644)
@@ -480,7 +480,9 @@ sys_init_module(const char *name_user, s
 
 	/* Ok, that's about all the sanity we can stomach; copy the rest.  */
 
-	if (copy_from_user(mod+1, mod_user+1, mod->size-sizeof(*mod))) {
+	if (copy_from_user((char *)mod+mod_user_size,
+			   (char *)mod_user+mod_user_size,
+			   mod->size-mod_user_size)) {
 		error = -EFAULT;
 		goto err3;
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
