Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270145AbUJTGao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270145AbUJTGao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUJTG1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:27:10 -0400
Received: from ozlabs.org ([203.10.76.45]:64943 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266611AbUJTGVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 02:21:11 -0400
Subject: Re: [PATCH] boot parameters: quoting of environment variables
	revisited
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041019192336.K18873@almesberger.net>
References: <20041019192336.K18873@almesberger.net>
Content-Type: text/plain
Message-Id: <1098253261.10571.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 16:21:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 08:23, Werner Almesberger wrote:
> When passing boot parameters, they can be quoted as follows:
> param="value"
> 
> Unfortunately, when passing environment variables this way, the
> quoting causes confusion: in 2.6.7 (etc.), only the variable name
> was placed in the environment, which caused it to be ignored.
> I've sent a patch that adjusted the name, but this patch was
> dropped. Instead, apparently a different fix was attempted in
> 2.6.9, but this now yields param="value in the environment (note
> the embeded double quote), which isn't much better.
> 
> I've attached a patch for 2.6.9 that fixes this. This time, I'm
> shifting the value. Maybe you like it better this way :-)

Sorry, I had a patch lying around for this which I didn't send to
Andrew.

AFAICT 2.4 didn't remove quotes, but I have no problem with removing
them now, and for __setup for that matter.  Hope noone relies on it.

This seems to work here...
Rusty.
Name: Remove quotes around environment variables
Status: Booted on 2.6-bk
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

As noticed by Joey Hess (and thanks for Christoph for forwarding it).
Also requirements from Werner Almesberger.

If someone passes 'foo="some value"' the param engine removes the
quotes and hands 'foo' and 'some value'.  The __setup() parameters
expect a single string, and so we try to regenerate it from the two
parts.  Finally, we try to place it as an environment variable.

Werner wants quotes stripped out of the environment variable.  It
makes sense to do that for __setup, too (so it sees 'foo=some value'),
since __setup functions don't usually handle quotes.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23831-linux-2.6.9-bk3/init/main.c .23831-linux-2.6.9-bk3.updated/init/main.c
--- .23831-linux-2.6.9-bk3/init/main.c	2004-10-19 14:34:23.000000000 +1000
+++ .23831-linux-2.6.9-bk3.updated/init/main.c	2004-10-20 14:48:20.000000000 +1000
@@ -287,8 +287,15 @@ static int __init unknown_bootoption(cha
 {
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
-		if (val[-1] == '"') val[-2] = '=';
-		else val[-1] = '=';
+		/* param=val or param="val"? */
+		if (val == param+strlen(param)+1)
+			val[-1] = '=';
+		else if (val == param+strlen(param)+2) {
+			val[-2] = '=';
+			memmove(val-1, val, strlen(val)+1);
+			val--;
+		} else
+			BUG();
 	}
 
 	/* Handle obsolete-style parameters */

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

