Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWDUAOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWDUAOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWDUAOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:14:08 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:9413 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932163AbWDUAOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:14:06 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dean Nelson <dcn@sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 6/7] Kprobes registers for notify page fault 
In-reply-to: Your message of "Thu, 20 Apr 2006 16:25:02 MST."
             <20060420233912.410449785@csdlinux-2.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Apr 2006 10:14:04 +1000
Message-ID: <18550.1145578444@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anil S Keshavamurthy (on Thu, 20 Apr 2006 16:25:02 -0700) wrote:
>---
> kernel/kprobes.c |    8 ++++++++
> 1 file changed, 8 insertions(+)
>
>Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
>===================================================================
>--- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
>+++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
>@@ -544,6 +544,11 @@ static struct notifier_block kprobe_exce
> 	.priority = 0x7fffffff /* we need to notified first */
> };
> 
>+static struct notifier_block kprobe_page_fault_nb = {
>+	.notifier_call = kprobe_exceptions_notify,
>+	.priority = 0x7fffffff /* we need to notified first */
>+};
>+
> int __kprobes register_jprobe(struct jprobe *jp)
> {
> 	/* Todo: Verify probepoint is a function entry point */
>@@ -654,6 +659,9 @@ static int __init init_kprobes(void)
> 	if (!err)
> 		err = register_die_notifier(&kprobe_exceptions_nb);
> 
>+	if (!err)
>+		err = register_page_fault_notifier(&kprobe_page_fault_nb);
>+
> 	return err;
> }
> 

The rest of the patches look OK, but this one does not.  init_kprobes()
registers the main kprobe exception handler, not the page fault
handler.

Now that there is a dedicated page fault handler, instead of being a
subcase of notify_die(), it might be better to delete DIE_PAGE_FAULT
completely.  That can be done in this patch set or in some follow on
patches.

