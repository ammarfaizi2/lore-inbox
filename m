Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVCPViG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVCPViG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVCPVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:36:37 -0500
Received: from mailhub3.nextra.sk ([195.168.1.146]:5381 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S262813AbVCPVeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:34:04 -0500
Message-ID: <4238A65C.7020908@rainbow-software.org>
Date: Wed, 16 Mar 2005 22:34:20 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-62896-1111008841-0001-2"
To: linux-kernel@vger.kernel.org
Subject: [patch] Syscall auditing - move "name=" field to the end
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-62896-1111008841-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch moves the "name=" field to the end of audit records. The 
original placement is bad because it cannot be properly parsed. It is 
impossible to tell if the name is "/bin/true" or "/bin/true inode=469634 
dev=00:00" because the "inode=" and "dev=" fields can be omitted.

Before:
audit(1111008486.824:89346): item=0 name=/bin/true inode=469634 dev=00:00

After:
audit(1111008486.824:89346): item=0 inode=469634 dev=00:00 name=/bin/true

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

-- 
Ondrej Zary

--=_tic-62896-1111008841-0001-2
Content-Type: text/plain; name="auditsc_move_name_to_end_of_record.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="auditsc_move_name_to_end_of_record.patch"

--- linux-2.6.11/kernel/auditsc.c~	2005-03-16 22:13:22.000000000 +0100
+++ linux-2.6.11/kernel/auditsc.c	2005-03-16 22:13:22.000000000 +0100
@@ -612,9 +612,6 @@
 		if (!ab)
 			continue; /* audit_panic has been called */
 		audit_log_format(ab, "item=%d", i);
-		if (context->names[i].name)
-			audit_log_format(ab, " name=%s",
-					 context->names[i].name);
 		if (context->names[i].ino != (unsigned long)-1)
 			audit_log_format(ab, " inode=%lu",
 					 context->names[i].ino);
@@ -624,6 +621,9 @@
 			audit_log_format(ab, " dev=%02x:%02x",
 					 MAJOR(context->names[i].rdev),
 					 MINOR(context->names[i].rdev));
+		if (context->names[i].name)
+			audit_log_format(ab, " name=%s",
+					 context->names[i].name);
 		audit_log_end(ab);
 	}
 }

--=_tic-62896-1111008841-0001-2--
