Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264817AbUDWOC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264817AbUDWOC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264814AbUDWOC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:02:56 -0400
Received: from ibague.terra.com.br ([200.154.55.225]:50620 "EHLO
	ibague.terra.com.br") by vger.kernel.org with ESMTP id S264817AbUDWOCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:02:51 -0400
Message-ID: <4089227C.9060101@terra.com.br>
Date: Fri, 23 Apr 2004 11:04:44 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: sisopiii-l@cscience.org
Subject: [PATCH] 32-bit process accounting
Content-Type: multipart/mixed;
 boundary="------------090609000401080105050608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609000401080105050608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	According to Andrew's must-fix list:

"32bit uid support is *still* broken for process accounting."

	Ok, so I went and tried to see why we can't just use uid_t/gid_t for 
the uid, gid fields on struct acct.

	I saw the GNU acct source, and it uses unsigned int fields on the hash 
tabels and doesn't assume any 16-bit only fields on the acct structure.

	So, it seems to me that the only reason we still have broken 32-bit 
process accounting is so that old tools can behave nicely. Please tell 
me other reasons as I couldn't find them.

	There are 2 patches attached.

	The first, does the obvious uid_t/gid_t replacement..since it defines 
16/32-bits for UIDs on a per-architecture basis.

	The second, uses CONFIG_UID16 as a basis for forcing 16-bit UIDs.

	I'd like to request review of these patches and pointers on what I'm 
missing to get this problem fixed.

	Thanks,

Felipe

--------------090609000401080105050608
Content-Type: text/plain;
 name="acct-32bit-config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct-32bit-config.patch"

--- linux-2.6.6-rc2/include/linux/acct.h.orig	Fri Apr 23 09:30:16 2004
+++ linux-2.6.6-rc2/include/linux/acct.h	Fri Apr 23 10:53:29 2004
@@ -41,8 +41,13 @@
  *	No binary format break with 2.0 - but when we hit 32bit uid we'll
  *	have to bite one
  */
+#ifdef CONFIG_UID16
 	__u16		ac_uid;			/* Accounting Real User ID */
 	__u16		ac_gid;			/* Accounting Real Group ID */
+#else
+	uid_t		ac_uid;			/* Accounting Real User ID */
+	gid_t		ac_gid;			/* Accounting Real Group ID */
+#endif
 	__u16		ac_tty;			/* Accounting Control Terminal */
 	__u32		ac_btime;		/* Accounting Process Creation Time */
 	comp_t		ac_utime;		/* Accounting User Time */

--------------090609000401080105050608
Content-Type: text/plain;
 name="acct-32bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct-32bit.patch"

--- linux-2.6.6-rc2/include/linux/acct.h.orig	Fri Apr 23 09:30:16 2004
+++ linux-2.6.6-rc2/include/linux/acct.h	Fri Apr 23 09:31:16 2004
@@ -41,8 +41,8 @@
  *	No binary format break with 2.0 - but when we hit 32bit uid we'll
  *	have to bite one
  */
-	__u16		ac_uid;			/* Accounting Real User ID */
-	__u16		ac_gid;			/* Accounting Real Group ID */
+	uid_t		ac_uid;			/* Accounting Real User ID */
+	gid_t		ac_gid;			/* Accounting Real Group ID */
 	__u16		ac_tty;			/* Accounting Control Terminal */
 	__u32		ac_btime;		/* Accounting Process Creation Time */
 	comp_t		ac_utime;		/* Accounting User Time */

--------------090609000401080105050608--
