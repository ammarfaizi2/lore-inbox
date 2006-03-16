Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWCPTAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWCPTAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWCPTAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:00:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:17676 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964848AbWCPTAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:00:15 -0500
Date: Thu, 16 Mar 2006 19:59:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jiri Benc <jbenc@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>, rusty@rustcorp.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: fix buffer overflow in modpost
Message-ID: <20060316185951.GA21681@mars.ravnborg.org>
References: <20060315154436.4286d2ab@griffin.suse.cz> <1142434648.17627.5.camel@tara.firmix.at> <20060315160858.311e5c0e@griffin.suse.cz> <20060315225159.GA11095@mars.ravnborg.org> <20060316142114.74367113@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316142114.74367113@griffin.suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus - please apply to 2.6.16-rc

Jiri Benc <jbenc@suse.cz> reported that modpost would stop with SIGABRT if
used with long filepaths.
The error looked like:
>   Building modules, stage 2.
>   MODPOST
> *** glibc detected *** scripts/mod/modpost: realloc(): invalid next size:
+0x0809f588 ***
> [...]

Following patch fixes this by allocating at least the required
memory + SZ bytes each time. Before we sometimes ended up allocating
too little memory resuting in the glibc detected bug above.
Based on patch originally submitted by: Jiri Benc <jbenc@suse.cz>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f70ff13..b8b2a56 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -508,12 +508,7 @@ buf_printf(struct buffer *buf, const cha
 	
 	va_start(ap, fmt);
 	len = vsnprintf(tmp, SZ, fmt, ap);
-	if (buf->size - buf->pos < len + 1) {
-		buf->size += 128;
-		buf->p = realloc(buf->p, buf->size);
-	}
-	strncpy(buf->p + buf->pos, tmp, len + 1);
-	buf->pos += len;
+	buf_write(buf, tmp, len);
 	va_end(ap);
 }
 
@@ -521,7 +516,7 @@ void
 buf_write(struct buffer *buf, const char *s, int len)
 {
 	if (buf->size - buf->pos < len) {
-		buf->size += len;
+		buf->size += len + SZ;
 		buf->p = realloc(buf->p, buf->size);
 	}
 	strncpy(buf->p + buf->pos, s, len);
