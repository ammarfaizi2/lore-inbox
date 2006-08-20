Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWHTOrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWHTOrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWHTOra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:47:30 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:55171 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750797AbWHTOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:47:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iDZhnjp689hcvtBD4M8nWZ2sI3p+VvVQMLnqh77+axEZ+z9gf4aH6jQ9DUPnjmVWrmrJMZ0BrgRytKQOnO6QcH95WqNQFZGlbB+Ssma+J4lFvzxR5pnNiJf7BnLzGLb6pFyAzG01sXqmhO48/VkTmLQG8CW596K0lIy/2bcyEdc=
Message-ID: <18d709710608200747k3323b23cq70eb52fdb9032554@mail.gmail.com>
Date: Sun, 20 Aug 2006 07:47:29 -0700
From: "Julio Auto" <mindvortex@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17.9 Incorrect string length checking in param_set_copystring()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As for 2.6.17.9, linux/include/linux/moduleparam.h suggests the user
of module_param_string() to set the maxlen parameter to
strlen(string), ie. '\0' excluded. However the function that actually
sets the string (param_set_copystring()), doesn't accept inputs with
maxlen-1 characters, reporting that the supplied string should fit
maxlen-1 chars.
See patch below.
Cheers,

    Julio Auto

--- linux-2.6.17.9/kernel/params.c.old  2006-08-19 20:48:30.000000000 -0700
+++ linux-2.6.17.9/kernel/params.c      2006-08-19 20:49:15.000000000 -0700
@@ -351,9 +351,9 @@ int param_set_copystring(const char *val
 {
        struct kparam_string *kps = kp->arg;

-       if (strlen(val)+1 > kps->maxlen) {
+       if (strlen(val) > kps->maxlen) {
                printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
-                      kp->name, kps->maxlen-1);
+                      kp->name, kps->maxlen);
                return -ENOSPC;
        }
        strcpy(kps->string, val);
