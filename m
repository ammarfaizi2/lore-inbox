Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269933AbUJSWau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269933AbUJSWau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269897AbUJSWY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:24:57 -0400
Received: from almesberger.net ([63.105.73.238]:11788 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S269289AbUJSWXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:23:49 -0400
Date: Tue, 19 Oct 2004 19:23:36 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] boot parameters: quoting of environment variables revisited
Message-ID: <20041019192336.K18873@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When passing boot parameters, they can be quoted as follows:
param="value"

Unfortunately, when passing environment variables this way, the
quoting causes confusion: in 2.6.7 (etc.), only the variable name
was placed in the environment, which caused it to be ignored.
I've sent a patch that adjusted the name, but this patch was
dropped. Instead, apparently a different fix was attempted in
2.6.9, but this now yields param="value in the environment (note
the embeded double quote), which isn't much better.

I've attached a patch for 2.6.9 that fixes this. This time, I'm
shifting the value. Maybe you like it better this way :-)

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.9/init/main.c.orig	Tue Oct 19 19:07:45 2004
+++ linux-2.6.9/init/main.c	Tue Oct 19 19:11:05 2004
@@ -310,6 +310,13 @@
 	if (val) {
 		/* Environment option */
 		unsigned int i;
+
+		/* If the value was quoted, shift it. */
+		if (val[-1] == '"') {
+			memmove(val-1,val,strlen(val)+1);
+			val--;
+		}
+
 		for (i = 0; envp_init[i]; i++) {
 			if (i == MAX_INIT_ENVS) {
 				panic_later = "Too many boot env vars at `%s'";

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
