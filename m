Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752345AbWCPPqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbWCPPqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbWCPPqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:46:18 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:47374 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752048AbWCPPqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:46:17 -0500
Date: Thu, 16 Mar 2006 16:46:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jiri Benc <jbenc@suse.cz>
Cc: Bernd Petrovitsch <bernd@firmix.at>, rusty@rustcorp.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: fix buffer overflow
Message-ID: <20060316154601.GA1582@mars.ravnborg.org>
References: <20060315154436.4286d2ab@griffin.suse.cz> <1142434648.17627.5.camel@tara.firmix.at> <20060315160858.311e5c0e@griffin.suse.cz> <20060315225159.GA11095@mars.ravnborg.org> <20060316142114.74367113@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316142114.74367113@griffin.suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 02:21:14PM +0100, Jiri Benc wrote:
> On Wed, 15 Mar 2006 23:51:59 +0100, Sam Ravnborg wrote:
> > Can I ask you to make a new patch where you change buf_printf() to use
> > buf_write. And then change buf_write to allocate in chunks also.
> > This would be cleanest solution.
> 
> This probably will be the cleanest solution, but I doubt it would be
> acceptable for 2.6.16. And I think the fix should go into 2.6.16.

Like this...

	Sam

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 30f3ac8..0b92ddf 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -923,19 +923,14 @@ void __attribute__((format(printf, 2, 3)
 
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
 
 void buf_write(struct buffer *buf, const char *s, int len)
 {
 	if (buf->size - buf->pos < len) {
-		buf->size += len;
+		buf->size += len + SZ;
 		buf->p = realloc(buf->p, buf->size);
 	}
 	strncpy(buf->p + buf->pos, s, len);
