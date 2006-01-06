Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWAFAnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWAFAnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWAFAnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:43:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31107 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932349AbWAFAnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:43:49 -0500
Date: Thu, 5 Jan 2006 16:45:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Linus Torvalds <torvalds@g5.osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/6] sysctl: dont overflow the user-supplied buffer with 0
Message-ID: <20060106004555.GD25207@sorel.sous-sol.org>
References: <20060105235845.967478000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysctl-don-t-overflow-the-user-supplied-buffer-with-0.patch"
In-Reply-To: <20060105235947.100933000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

If the string was too long to fit in the user-supplied buffer,
the sysctl layer would zero-terminate it by writing past the
end of the buffer. Don't do that.

Noticed by Yi Yang <yang.y.yi@gmail.com>

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/sysctl.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.14.5.orig/kernel/sysctl.c
+++ linux-2.6.14.5/kernel/sysctl.c
@@ -2200,14 +2200,12 @@ int sysctl_string(ctl_table *table, int 
 		if (get_user(len, oldlenp))
 			return -EFAULT;
 		if (len) {
-			l = strlen(table->data);
+			l = strlen(table->data)+1;
 			if (len > l) len = l;
 			if (len >= table->maxlen)
 				len = table->maxlen;
 			if(copy_to_user(oldval, table->data, len))
 				return -EFAULT;
-			if(put_user(0, ((char __user *) oldval) + len))
-				return -EFAULT;
 			if(put_user(len, oldlenp))
 				return -EFAULT;
 		}

--
