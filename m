Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752284AbWAFDih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbWAFDih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbWAFDig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:38:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17793 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1752227AbWAFDif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:38:35 -0500
Date: Thu, 5 Jan 2006 19:40:11 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, git-commits-head@vger.kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 4/6] sysctl: dont overflow the user-supplied buffer with 0
Message-ID: <20060106034011.GS3335@sorel.sous-sol.org>
References: <20060105235845.967478000@sorel.sous-sol.org> <20060106004555.GD25207@sorel.sous-sol.org> <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> Don't use this one. It doesn't zero-pad the string if the result buffer is 
> too small (which _could_ cause problems) and it actually returns the wrong 
> length too. 
> 
> There's a better one in the final 2.6.15.

Thanks, adding this (it's got both rolled together so it's the same as
upstream).

thanks,
-chris
--

Subject: sysctl: make sure to terminate strings with a NUL

From: Linus Torvalds <torvalds@osdl.org>

This is a slightly more complete fix for the previous minimal sysctl
string fix.  It always terminates the returned string with a NUL, even
if the full result wouldn't fit in the user-supplied buffer.

The returned length is the full untruncated length, so that you can
tell when truncation has occurred.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
[chrisw: inclusive of minimal fix so it's same as upstream]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 kernel/sysctl.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- linux-2.6.14.5.orig/kernel/sysctl.c
+++ linux-2.6.14.5/kernel/sysctl.c
@@ -2191,29 +2191,32 @@ int sysctl_string(ctl_table *table, int 
 		  void __user *oldval, size_t __user *oldlenp,
 		  void __user *newval, size_t newlen, void **context)
 {
-	size_t l, len;
-	
 	if (!table->data || !table->maxlen) 
 		return -ENOTDIR;
 	
 	if (oldval && oldlenp) {
-		if (get_user(len, oldlenp))
+		size_t bufsize;
+		if (get_user(bufsize, oldlenp))
 			return -EFAULT;
-		if (len) {
-			l = strlen(table->data);
-			if (len > l) len = l;
-			if (len >= table->maxlen)
+		if (bufsize) {
+			size_t len = strlen(table->data), copied;
+
+			/* This shouldn't trigger for a well-formed sysctl */
+			if (len > table->maxlen)
 				len = table->maxlen;
-			if(copy_to_user(oldval, table->data, len))
-				return -EFAULT;
-			if(put_user(0, ((char __user *) oldval) + len))
+
+			/* Copy up to a max of bufsize-1 bytes of the string */
+			copied = (len >= bufsize) ? bufsize - 1 : len;
+
+			if (copy_to_user(oldval, table->data, copied) ||
+			    put_user(0, (char __user *)(oldval + copied)))
 				return -EFAULT;
-			if(put_user(len, oldlenp))
+			if (put_user(len, oldlenp))
 				return -EFAULT;
 		}
 	}
 	if (newval && newlen) {
-		len = newlen;
+		size_t len = newlen;
 		if (len > table->maxlen)
 			len = table->maxlen;
 		if(copy_from_user(table->data, newval, len))
@@ -2222,7 +2225,7 @@ int sysctl_string(ctl_table *table, int 
 			len--;
 		((char *) table->data)[len] = 0;
 	}
-	return 0;
+	return 1;
 }
 
 /*
