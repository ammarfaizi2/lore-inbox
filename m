Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVADUbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVADUbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVADU24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:28:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:43164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbVADUXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:23:55 -0500
Date: Tue, 4 Jan 2005 12:23:47 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [RFC] [PATCH] capset returns -EPERM when pid==current->pid
Message-ID: <20050104122347.U2357@build.pdx.osdl.net>
References: <20050104165347.GA3880@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104165347.GA3880@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Tue, Jan 04, 2005 at 10:53:47AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> In the current kernel/capability.c:sys_capset() code, permission is
> denied if CAP_SETPCAP is not held and pid is positive.  pid=0 means use
> the current process, and this is allowed.  But using the current
> process' pid is not allowed.  The man page for capsetp simply says that
> CAP_SETPCAP is required to use this function, and does not mention the
> exception for pid=0.  
> 
> The current behavior seems inconsistent.  The attached patch also
> allows a process to call capset() on itself.  Does this seem reasonable?

Yes.

From: Serge E. Hallyn <serue@us.ibm.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

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

