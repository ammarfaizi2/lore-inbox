Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752070AbWCOPJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWCOPJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCOPJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:09:03 -0500
Received: from styx.suse.cz ([82.119.242.94]:31380 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1752070AbWCOPJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:09:01 -0500
Date: Wed, 15 Mar 2006 16:08:58 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: fix buffer overflow
Message-ID: <20060315160858.311e5c0e@griffin.suse.cz>
In-Reply-To: <1142434648.17627.5.camel@tara.firmix.at>
References: <20060315154436.4286d2ab@griffin.suse.cz>
	<1142434648.17627.5.camel@tara.firmix.at>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006 15:57:28 +0100, Bernd Petrovitsch wrote:
> Silly me. To make it more obvious whatz I really meant was:
> ----  snip  ----
> 	if (buf->size - buf->pos < len + 1) {
> 		while (buf->size - buf->pos < len + 1)
> 			buf->size += 128;
> 		buf->p = realloc(buf->p, buf->size);
> 	}
> ----  snip  ----

Yes, this is probably better. New version of the patch follows.

---->8----

I got SIGABRT in modpost when compiling a module really deeply nested in
a filesystem (path > 100 chars):

>   Building modules, stage 2.
>   MODPOST
> *** glibc detected *** scripts/mod/modpost: realloc(): invalid next size: 0x0809f588 ***
> [...]

This patch fixes that problem.

Signed-off-by: Jiri Benc <jbenc@suse.cz>

--- linux-2.6.16-rc6.orig/scripts/mod/modpost.c
+++ linux-2.6.16-rc6/scripts/mod/modpost.c
@@ -553,7 +553,8 @@ void __attribute__((format(printf, 2, 3)
 	va_start(ap, fmt);
 	len = vsnprintf(tmp, SZ, fmt, ap);
 	if (buf->size - buf->pos < len + 1) {
-		buf->size += 128;
+		while (buf->size - buf->pos < len + 1)
+			buf->size += 128;
 		buf->p = realloc(buf->p, buf->size);
 	}
 	strncpy(buf->p + buf->pos, tmp, len + 1);


-- 
Jiri Benc
SUSE Labs
