Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271164AbUJVBNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271164AbUJVBNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271143AbUJVBFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:05:49 -0400
Received: from ozlabs.org ([203.10.76.45]:33681 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S271158AbUJVBBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:01:41 -0400
Subject: Re: [PATCH] boot parameters: quoting of
	environmentvariablesrevisited
From: Rusty Russell <rusty@rustcorp.com.au>
To: Len Brown <len.brown@intel.com>
Cc: Werner Almesberger <werner@almesberger.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1098258821.26595.4324.camel@d845pe>
References: <1098253261.10571.129.camel@localhost.localdomain>
	 <1098256561.26603.4289.camel@d845pe>
	 <1098257731.10571.138.camel@localhost.localdomain>
	 <1098258821.26595.4324.camel@d845pe>
Content-Type: text/plain
Message-Id: <1098406899.12103.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 11:01:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 17:53, Len Brown wrote:
> On Wed, 2004-10-20 at 03:35, Rusty Russell wrote:
> > On Wed, 2004-10-20 at 17:16, Len Brown wrote:
> > > I verified that this new patch doesn't break the
> > acpi_os_string="Brand X" kernel parameter.

OK, so this is the patch then.  We strip " when we hand to __setup or
put into the environment.

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

