Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUEONKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUEONKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 09:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUEONKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 09:10:38 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:23528 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262451AbUEONKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 09:10:35 -0400
From: tglx@linutronix.de (Thomas Gleixner)
Reply-To: tglx@linutronix.de
Organization: linutronix
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.26] drivers/char/vt.c fix compiler warnings
Date: Sat, 15 May 2004 15:05:23 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151505.23250.tglx@linutronix.de>
X-Seen: false
X-ID: STDGcMZAYelWpWO3IoMipmpEqPZNFi+1HtwU7-G3o19-zSgbiCsEg7@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch fixes the following warnings, produced by gcc3.3.3:

vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of data 
type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of data 
type

s is a unsigned char, which can never be >= MAX_NR_KEYMAPS, as MAX_NR_KEYMAPS 
= 256

tmp.kb_func is an unsigned char, which can never be > MAX_NR_FUNC, which is = 
256

Maybe it is neccecary to change the types from unsigned char to uint8_t ?

-- 
Thomas
________________________________________________________________________
"Free software" is a matter of liberty, not price. To understand the concept,
you should think of "free" as in "free speech,'' not as in "free beer".
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

--- linux-2.4.26.org/drivers/char/vt.c	2002-11-29 00:53:12.000000000 +0100
+++ linux-2.4.26/drivers/char/vt.c	2004-05-15 15:02:05.000000000 +0200
@@ -163,7 +163,7 @@
 
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
-	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
+	if (i >= NR_KEYS)
 		return -EINVAL;	
 
 	switch (cmd) {
@@ -280,8 +280,6 @@
 	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
 		return -EFAULT;
 	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
-	if (tmp.kb_func >= MAX_NR_FUNC)
-		return -EINVAL;
 	i = tmp.kb_func;
 
 	switch (cmd) {

