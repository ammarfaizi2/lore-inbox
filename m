Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVLFKLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLFKLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVLFKLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:11:03 -0500
Received: from mail1.ispwest.com ([216.52.245.18]:28934 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S932122AbVLFKLC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:11:02 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <e16bc6209efd4b6e840f78f35de61b2f.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org
Subject: [PATCH] Socket filter instruction limit validation
Date: Tue, 6 Dec 2005 02:10:49 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks to make sure that the number of instructions doesn't surpass
BPF_MAXINSNS in sk_chk_filter().

Signed-off-by: Kris Katterjohn <kjak@users.sourceforge.net>

---

This is a diff from 2.6.15-rc5. And I am not subscribed, so please CC me on any
replies.

The previous check in sk_chk_filter() doesn't seem very logical to me because it
should either be limited to BPF_MAXINSNS or only limited by the max value of an
`int' (not really limited). sk_attach_filter() and get_filter() in
drivers/net/ppp_generic.c limit it to BPF_MAXINSNS, but get_filter() in
drivers/isdn/i4l/isdn_ppp.c and anything else that will use it only get this
seemingly "random" limit.

This way it is checked for in only one place, and has a single constant limit.

Thanks!

--- x/net/core/filter.c	2005-12-06 04:01:50.000000000 -0600
+++ y/net/core/filter.c	2005-12-06 04:04:23.000000000 -0600
@@ -293,7 +293,8 @@ int sk_chk_filter(struct sock_filter *fi
 	struct sock_filter *ftest;
 	int pc;
 
-	if (((unsigned int)flen >= (~0U / sizeof(struct sock_filter))) || flen == 0)
+	/* check for valid number of instructions -Kris Katterjohn 2005-12-06 */
+	if (flen == 0 || flen > BPF_MAXINSNS)
 		return -EINVAL;
 
 	/* check the filter code now */
@@ -359,9 +360,9 @@ int sk_attach_filter(struct sock_fprog *
 	unsigned int fsize = sizeof(struct sock_filter) * fprog->len;
 	int err;
 
-	/* Make sure new filter is there and in the right amounts. */
-        if (fprog->filter == NULL || fprog->len > BPF_MAXINSNS)
-                return -EINVAL;
+	/* Make sure new filter is there */
+	if (fprog->filter == NULL)
+		return -EINVAL;
 
 	fp = sock_kmalloc(sk, fsize+sizeof(*fp), GFP_KERNEL);
 	if (!fp)


