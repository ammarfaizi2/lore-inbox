Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWCi2>; Wed, 22 Nov 2000 21:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWCiS>; Wed, 22 Nov 2000 21:38:18 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:9826 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S129514AbQKWCiG>; Wed, 22 Nov 2000 21:38:06 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank van de Pol <fvdpol@home.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 + ALSA 0.6pre1 version is OOPSing 
In-Reply-To: Your message of "Thu, 23 Nov 2000 02:49:27 BST."
             <20001123024927.B6395@idefix.fvdpol.home.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 13:07:56 +1100
Message-ID: <3322.974945276@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000 02:49:27 +0100, 
Frank van de Pol <fvdpol@home.nl> wrote:
>After upgrade to 2.4.0-test11 my copy of ALSA 0.6pre1 (cvs version) stopped
>working (causing OOPS on module load of snd-card-sbawe). I reverted back to
>2.4.0-test10 and verified that the problem does not exist in that version.
>
>Could any of the changes between 2.4.0-test10 and 2.4.0-test11 cause this
>behaviour??? 

2.4.0-test11 incorrectly handles module initialization when the
userspace struct module is smaller than the kernel struct module.

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
