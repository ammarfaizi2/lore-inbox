Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUCAU0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUCAU0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:26:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:54209 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261423AbUCAU0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:26:19 -0500
Date: Mon, 1 Mar 2004 12:26:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Rik Faith <faith@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
Message-ID: <20040301122618.O22989@build.pdx.osdl.net>
References: <16451.25789.72815.763592@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16451.25789.72815.763592@neuro.alephnull.com>; from faith@redhat.com on Mon, Mar 01, 2004 at 11:28:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik Faith (faith@redhat.com) wrote:
> This note describes a patch against 2.6.4-rc1-bk2 that provides a
> low-overhead system-call auditing framework for Linux that is usable by
> LSM components (e.g., SELinux).  Comments will be appreciated.

Do you have an perf numbers for simply enabling the auditint framework?
Seems to be a lot of use of likely/unlikely.  Are these actually useful
optimizations?  Doesn't seem like CONFIG_AUDIT=n disables all the code.
Not sure if the rest of the patch lot is mainlineable or not, but here are
some simple nits/questions.

Some basic CodingStyle bits:

+static int         audit_initialized = 0;

no need to zero initialized static data.

+       if (in_irq()) BUG();
+       if (!context) BUG();

convert to BUG_ON(in_irq());
           BUG_ON(!context);

+#ifdef CONFIG_AUDIT
+/***********************************************************************/
+/** audit.c                                                           **/
+/***********************************************************************/

Noisy comments.

+                       audit_log_format(ab, " dev=%02x:%02x",
+                                        MAJOR(context->names[i].rdev),
+                                        MINOR(context->names[i].rdev));

format_dev_t() ?

+static int __init audit_enable(char *str)
+{
+       if (!strncmp(str, "on", 2) || !strncmp(str, "yes", 3))
+               audit_default = 1;
+       else if (!strncmp(str, "off", 3) || !strncmp(str, "no", 2))
+               audit_default = 0;
+       else
+               audit_default = simple_strtol(str, NULL, 0);

just pick one method, strings or int (int is so simple), and document the
method for enable/disable.

+void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)

as of now, this could be static, and not exported, no?


+               ab = kmalloc(sizeof(*ab), GFP_ATOMIC);

need atomic allocations here?  also, i wasn't clear on what makes sure the
audit_buffers can't be overflown, the bits in vformat talking about 1024 bytes?


+               audit_log_format(ab, "<toolong>");

is it useful to at least get the final d_name?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
