Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVAHCiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVAHCiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 21:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAHCiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 21:38:10 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:19910 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261595AbVAHChy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:37:54 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] kernel/printk.c lockless access 
In-reply-to: Your message of "Thu, 06 Jan 2005 13:58:12 MDT."
             <20050106195812.GL22274@austin.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Jan 2005 13:37:44 +1100
Message-ID: <7552.1105151864@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 13:58:12 -0600, 
Linas Vepstas <linas@austin.ibm.com> wrote:
>===== kernel/printk.c 1.47 vs edited =====
>--- 1.47/kernel/printk.c	2004-11-19 01:03:10 -06:00
>+++ edited/kernel/printk.c	2005-01-06 13:44:36 -06:00
>@@ -380,6 +380,23 @@ asmlinkage long sys_syslog(int type, cha
> 	return do_syslog(type, buf, len);
> }
> 
>+#ifdef   CONFIG_DEBUG_KERNEL
>+/**
>+ * Its very handy to be able to view the syslog buffer during debug.
>+ * But do_syslog() uses locks and so it will deadlock if called during 
>+ * a debugging session. The routine provides the start and end of the 
>+ * physical and logical logs, and is equivalent to do_syslog(3).
>+ */
>+
>+void debugger_syslog_data(char *syslog_data[4])
>+{
>+	syslog_data[0] = log_buf;
>+	syslog_data[1] = log_buf + __LOG_BUF_LEN;
>+	syslog_data[2] = log_buf + log_end - (logged_chars < __LOG_BUF_LEN ? logged_chars : __LOG_BUF_LEN);
>+	syslog_data[3] = log_buf + log_end;
>+}
>+#endif   /* CONFIG_DEBUG_KERNEL */
>+

Replace __LOG_BUF_LEN with log_buf_len.  __LOG_BUF_LEN is the default
size, log_buf_len is the actual size used, including boot time
overrides with log_buf_len=.

On Thu, 06 Jan 2005 21:50:17 +0100,
Andi Kleen <ak@muc.de> wrote:

AK>Better&simpler fix would be to just unstatic __log_buf

The debug caller needs to know where the ring pointers are as well.
Also __log_buf is not necessarily the current log buffer, boot with
log_buf_len= and you get a different buffer.  The caller needs the 

On Thu, 6 Jan 2005 16:12:41 -0800,
Andrew Morton <akpm@osdl.org> wrote:

AKPM>We faced the same problem in the Digeo kernel.  When the kernel oopses we
AKPM>want to grab the last kilobyte or so of the printk buffer and stash it into
AKPM>nvram.  We did this via a function which copies the data rather than
AKPM>exporting all those variables, which I think is a nicer and more
AKPM>maintainable approach:

That assumes that you have enough free space to copy the log buffer to.
In the general debugging case that is not true, especially if you want
the entire print buffer to be printed.  The only safe way to access the
complete print buffer is in situ.  Which is what the patch above does.

