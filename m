Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWCOOol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWCOOol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCOOol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:44:41 -0500
Received: from styx.suse.cz ([82.119.242.94]:41618 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932509AbWCOOok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:44:40 -0500
Date: Wed, 15 Mar 2006 15:44:36 +0100
From: Jiri Benc <jbenc@suse.cz>
To: rusty@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] modpost: fix buffer overflow
Message-ID: <20060315154436.4286d2ab@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got SIGABRT in modpost when building a module really deeply nested in
a filesystem (path > 100 chars):

>   Building modules, stage 2.
>   MODPOST
> *** glibc detected *** scripts/mod/modpost: realloc(): invalid next size: 0x0809f588 ***
> [...]

This patch fixes that problem.

Signed-off-by: Jiri Benc <jbenc@suse.cz>

--- linux-2.6.16-rc6.orig/scripts/mod/modpost.c
+++ linux-2.6.16-rc6/scripts/mod/modpost.c
@@ -552,7 +552,7 @@ void __attribute__((format(printf, 2, 3)
 	
 	va_start(ap, fmt);
 	len = vsnprintf(tmp, SZ, fmt, ap);
-	if (buf->size - buf->pos < len + 1) {
+	while (buf->size - buf->pos < len + 1) {
 		buf->size += 128;
 		buf->p = realloc(buf->p, buf->size);
 	}


-- 
Jiri Benc
SUSE Labs
