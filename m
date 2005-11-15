Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVKOMSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVKOMSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVKOMSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:18:37 -0500
Received: from sophia.inria.fr ([138.96.64.20]:31900 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S932393AbVKOMSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:18:37 -0500
Message-ID: <4379D1F7.1000701@yahoo.fr>
Date: Tue, 15 Nov 2005 13:17:59 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, tim.bird@am.sony.com
Subject: [-mm PATCH 1/2] printk return value: fix it
References: <42F08FE6.8000601@yahoo.fr> <430CA2CE.4070403@am.sony.com>
In-Reply-To: <430CA2CE.4070403@am.sony.com>
Content-Type: multipart/mixed;
 boundary="------------020201050408030807070005"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (sophia.inria.fr [138.96.64.20]); Tue, 15 Nov 2005 13:18:02 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020201050408030807070005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

What's the true meaning of the printk return value?
Should it include the priority prefix length of 3? and what about the timing
information? In both cases it was broken:

strace -e write echo 1 > /dev/kmsg
=> write(1, "1\n", 2)                      = 5
strace -e write echo "<1>1" > /dev/kmsg
=> write(1, "<1>1\n", 5)                   = 8

The returned length was "length of input string + 3", I made it "length
of string output to the log buffer".

Note that I couldn't find any printk caller in the kernel interested by its 
return value besides kmsg_write.

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
Acked-By: Tim Bird <tim.bird@am.sony.com>

---
  printk.c |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)



-- 
Guillaume



--------------020201050408030807070005
Content-Type: text/x-patch;
 name="printk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printk.diff"

diff -r d18e06f9c571 kernel/printk.c
--- a/kernel/printk.c	Mon Nov 14 10:22:49 2005 +0800
+++ b/kernel/printk.c	Mon Nov 14 15:02:56 2005 +0100
@@ -569,7 +569,7 @@
 				   p[1] <= '7' && p[2] == '>') {
 					loglev_char = p[1];
 					p += 3;
-					printed_len += 3;
+					printed_len -= 3;
 				} else {
 					loglev_char = default_message_loglevel
 						+ '0';
@@ -584,7 +584,7 @@
 
 				for (tp = tbuf; tp < tbuf + tlen; tp++)
 					emit_log_char(*tp);
-				printed_len += tlen - 3;
+				printed_len += tlen;
 			} else {
 				if (p[0] != '<' || p[1] < '0' ||
 				   p[1] > '7' || p[2] != '>') {
@@ -592,8 +592,8 @@
 					emit_log_char(default_message_loglevel
 						+ '0');
 					emit_log_char('>');
+					printed_len += 3;
 				}
-				printed_len += 3;
 			}
 			log_level_unknown = 0;
 			if (!*p)


--------------020201050408030807070005--
