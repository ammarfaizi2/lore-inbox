Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbUKQV7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbUKQV7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUKQVM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:12:27 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:41888 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262611AbUKQVKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:10:06 -0500
Message-ID: <419BCC88.D26B96AE@akamai.com>
Date: Wed, 17 Nov 2004 14:11:20 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Prasanna Meda <pmeda@akamai.com>
CC: akpm@osdl.org
Subject: Re: One more get_task_comm()
References: <419BC8CF.424232E6@akamai.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removing assumption of  command length as 16 completely

--- arch/mips/kernel/sysirix.c.saved    Wed Nov 17 13:18:50 2004
+++ arch/mips/kernel/sysirix.c  Wed Nov 17 14:09:12 2004
@@ -282,9 +282,9 @@
                int pid = (int) regs->regs[base + 5];
                char *buf = (char *) regs->regs[base + 6];
                struct task_struct *p;
-               char comm[16];
+               char tcomm[sizeof(current->comm)];

-               retval = verify_area(VERIFY_WRITE, buf, 16);
+               retval = verify_area(VERIFY_WRITE, buf, sizeof(tcomm));
                if (retval)
                        break;
                read_lock(&tasklist_lock);
@@ -294,11 +294,11 @@
                        retval = -ESRCH;
                        break;
                }
-               memcpy(comm, p->comm, 16);
+               get_task_comm(tcomm, p);
                read_unlock(&tasklist_lock);

                /* XXX Need to check sizes. */
-               copy_to_user(buf, p->comm, 16);
+               copy_to_user(buf, tcomm, sizeof(tcomm));
                retval = 0;
                break;
        }

