Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWF1VVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWF1VVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWF1VVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:21:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751535AbWF1VVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:21:30 -0400
Date: Wed, 28 Jun 2006 14:24:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: grep /proc/slabinfo + rm -rf => lockup
Message-Id: <20060628142452.5842b126.akpm@osdl.org>
In-Reply-To: <20060628210523.GA7555@martell.zuzino.mipt.ru>
References: <20060628210523.GA7555@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> VT1: while true; do grep xfs /proc/slabinfo; done
> VT2: rm -rf linux-vanilla

Yup, we have a buffer overrun in /proc/slabinfo.

From: Andrew Morton <akpm@osdl.org>

The recent vsnprintf() fix introduced an off-by-one, and it's now possible to
overrun the target buffer by one byte.  Fix it so that local variable `end'
_really_ points at the last writeable byte.

[jeremy@goop.org: make the `size==0' case work properly]
Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 lib/vsprintf.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -puN lib/vsprintf.c~vsnprintf-fix lib/vsprintf.c
--- a/lib/vsprintf.c~vsnprintf-fix
+++ a/lib/vsprintf.c
@@ -259,7 +259,9 @@ int vsnprintf(char *buf, size_t size, co
 	int len;
 	unsigned long long num;
 	int i, base;
-	char *str, *end, c;
+	char *str;		/* Where we're writing to */
+	char *end;		/* The terminal '\0' (if any) */
+	char c;
 	const char *s;
 
 	int flags;		/* flags to number() */
@@ -283,7 +285,10 @@ int vsnprintf(char *buf, size_t size, co
 	}
 
 	str = buf;
-	end = buf + size;
+	if (size > 0)
+		end = buf + size - 1;
+	else
+		end = buf;
 
 	/* Make sure end is always >= buf */
 	if (end < buf) {
_

