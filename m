Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVADQyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVADQyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVADQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:54:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53732 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261743AbVADQxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:53:47 -0500
Date: Tue, 4 Jan 2005 10:53:47 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: [RFC] [PATCH] capset returns -EPERM when pid==current->pid
Message-ID: <20050104165347.GA3880@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current kernel/capability.c:sys_capset() code, permission is
denied if CAP_SETPCAP is not held and pid is positive.  pid=0 means use
the current process, and this is allowed.  But using the current
process' pid is not allowed.  The man page for capsetp simply says that
CAP_SETPCAP is required to use this function, and does not mention the
exception for pid=0.  

The current behavior seems inconsistent.  The attached patch also
allows a process to call capset() on itself.  Does this seem reasonable?

thanks,
-serge

Index: linux-2.6.10-mm1/kernel/capability.c
===================================================================
--- linux-2.6.10-mm1.orig/kernel/capability.c	2005-01-04 11:51:21.000000000 -0600
+++ linux-2.6.10-mm1/kernel/capability.c	2005-01-04 11:52:58.000000000 -0600
@@ -147,7 +147,7 @@ asmlinkage long sys_capset(cap_user_head
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 
 
-     if (pid && !capable(CAP_SETPCAP))
+     if (pid && pid != current->pid && !capable(CAP_SETPCAP))
              return -EPERM;
 
      if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
