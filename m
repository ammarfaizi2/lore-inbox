Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVAEVn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVAEVn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAEVnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:43:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20472 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262607AbVAEVmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:42:04 -0500
Message-ID: <41DC5F08.4020402@mvista.com>
Date: Wed, 05 Jan 2005 14:41:28 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.4.28: 32 bit ltrace oops when tracing 64 bit executable
 [X86_64]
Content-Type: multipart/mixed;
 boundary="------------060507050001050504060509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------060507050001050504060509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Didn't see  a fix for this so here it is. Tried using "ltrace -i" on a 
64 bit executable when ltrace was a 32 bit executable. The kernel threw 
an oops.

The find_target routine (arch/x86/ia32/ptrace32.c) doesn't deal with a 
NULL return from  find_task_by_pid properly - if NULL is returned 
put_task_struct() is still called.

mark




--------------060507050001050504060509
Content-Type: text/plain;
 name="ltrace-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ltrace-patch"

Index: arch/x86_64/ia32/ptrace32.c
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/arch/x86_64/ia32/ptrace32.c,v
retrieving revision 1.1.36.1.8.3
diff -a -u -r1.1.36.1.8.3 ptrace32.c
--- arch/x86_64/ia32/ptrace32.c	19 Nov 2004 04:41:58 -0000	1.1.36.1.8.3
+++ arch/x86_64/ia32/ptrace32.c	5 Jan 2005 19:26:43 -0000
@@ -182,14 +182,14 @@
 			goto out;
 		*err = ptrace_check_attach(child, request == PTRACE_KILL); 
 		if (*err < 0) 
-				goto out;
+			goto out;
 		return child; 
-	} 
 
  out:
-	put_task_struct(child);
+		put_task_struct(child);
+	} 
+
 	return NULL; 
-	
 } 
 
 extern asmlinkage long sys_ptrace(long request, long pid, unsigned long addr, unsigned long data);

--------------060507050001050504060509--
