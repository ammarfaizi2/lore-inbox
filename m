Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290060AbSAQQ6o>; Thu, 17 Jan 2002 11:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290051AbSAQQ62>; Thu, 17 Jan 2002 11:58:28 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:12456 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S290054AbSAQQ6N>; Thu, 17 Jan 2002 11:58:13 -0500
Message-Id: <200201171609.JAA25941@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: davem@redhat.com
Subject: 2.5.3-pre1 build error and possible fix for net/ipv4/netfilter/ip_fw_compat_redir.c
Date: Thu, 17 Jan 2002 09:58:15 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error building 2.5.3-pre1.

ip_fw_compat_redir.c: In function `check_for_redirect':
ip_fw_compat_redir.c:274: too many arguments to function `add_timer'
ip_fw_compat_redir.c: In function `check_for_unredirect':
ip_fw_compat_redir.c:300: too many arguments to function `add_timer'
make[3]: *** [ip_fw_compat_redir.o] Error 1

Here is a proposed fix.  I looked at how add_timer was used earlier in the file.

Steven

--- linux/net/ipv4/netfilter/ip_fw_compat_redir.c.original	Tue Jan 15 14:35:45 2002
+++ linux/net/ipv4/netfilter/ip_fw_compat_redir.c	Thu Jan 17 09:40:58 2002
@@ -270,8 +270,10 @@
 	if (redir) {
 		DEBUGP("Doing tcp redirect again.\n");
 		do_tcp_redir(skb, redir);
-		if (del_timer(&redir->destroyme))
-			add_timer(&redir->destroyme, jiffies + REDIR_TIMEOUT);
+		if (del_timer(&redir->destroyme)) {
+			redir->destroyme.expires = jiffies + REDIR_TIMEOUT;
+			add_timer(&redir->destroyme);
+			}
 	}
 	UNLOCK_BH(&redir_lock);
 }
@@ -296,8 +298,10 @@
 	if (redir) {
 		DEBUGP("Doing tcp unredirect.\n");
 		do_tcp_unredir(skb, redir);
-		if (del_timer(&redir->destroyme))
-			add_timer(&redir->destroyme, jiffies + REDIR_TIMEOUT);
+		if (del_timer(&redir->destroyme)) {
+			redir->destroyme.expires = jiffies + REDIR_TIMEOUT;
+			add_timer(&redir->destroyme);
+			}
 	}
 	UNLOCK_BH(&redir_lock);
 }
