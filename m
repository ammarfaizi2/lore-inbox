Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbUKQU6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUKQU6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUKQU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:58:23 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:18591 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262531AbUKQUyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:54:11 -0500
Message-ID: <419BC8CF.424232E6@akamai.com>
Date: Wed, 17 Nov 2004 13:55:27 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: One more get_task_comm()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at  get_task_comm patch:
http://linus.bkbits.net:8080/linux-2.5/patch@1.1803.144.3

There is one other place where task->comm is accessed
outside current.  There are two issues.  The code is
trying to copy to temp space without task_lock. It is not
using temp space for actual user copy.

--- arch/mips/kernel/sysirix.c.saved    Wed Nov 17 13:18:50 2004
+++ arch/mips/kernel/sysirix.c  Wed Nov 17 13:29:11 2004
@@ -282,7 +282,7 @@
                int pid = (int) regs->regs[base + 5];
                char *buf = (char *) regs->regs[base + 6];
                struct task_struct *p;
-               char comm[16];
+               char  comm[sizeof(current->comm)];

                retval = verify_area(VERIFY_WRITE, buf, 16);
                if (retval)
@@ -294,11 +294,11 @@
                        retval = -ESRCH;
                        break;
                }
-               memcpy(comm, p->comm, 16);
+               get_task_comm(comm, p);
                read_unlock(&tasklist_lock);

                /* XXX Need to check sizes. */
-               copy_to_user(buf, p->comm, 16);
+               copy_to_user(buf, comm, 16);
                retval = 0;
                break;
        }

Related questions:

