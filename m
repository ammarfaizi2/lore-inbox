Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264452AbUEMTd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUEMTd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUEMTd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:33:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:40639 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264452AbUEMTSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:18:52 -0400
Date: Thu, 13 May 2004 12:18:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513121850.B22989@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040513035134.2e9013ea.akpm@osdl.org>; from akpm@osdl.org on Thu, May 13, 2004 at 03:51:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +hugetlb_shm_group-sysctl-gid-0-fix.patch
> > > 
> > >  Don't make gid 0 special for hugetlb shm.
> > 
> > As Oracle has agreed on fixing their DB to use hugetlbfs could we
> > please stop doctoring around on this broken patch and revert it.
> 
> Once I'm convinced that kernel.org kernels will be able to run applications
> which vendor kernels will run, sure.

What about something that's just simple and generic?  This is similar to
Andrea's disable_cap_mlock patch and the disabling capabilities patch
that wli produced back in that thread.  It would remove the hack, and
buy us some time to find better solutions.  Downside of course (as all
of these have) is reduced security value.

Against -mm2, thoughts?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


--- linux-2.6.6-mm2/security/capability.c	2004-05-13 11:19:44.000000000 -0700
+++ linux-2.6.6-mm2-cap_mask_disable/security/capability.c	2004-05-13 12:01:04.167511552 -0700
@@ -24,12 +24,24 @@
 #include <linux/ptrace.h>
 #include <linux/moduleparam.h>
 
+static int capability_mask;
+module_param_named(mask, capability_mask, int, 0);
+MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
+
+static int capability_capable(struct task_struct *task, int cap)
+{
+	if (CAP_TO_MASK(cap) & capability_mask)
+		return 0;
+	else
+		return cap_capable(task, cap);
+}
+
 static struct security_operations capability_ops = {
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
 	.capset_check =			cap_capset_check,
 	.capset_set =			cap_capset_set,
-	.capable =			cap_capable,
+	.capable =			capability_capable,
 	.netlink_send =			cap_netlink_send,
 	.netlink_recv =			cap_netlink_recv,
 
