Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWHKIcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWHKIcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWHKIcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:32:25 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:55221 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1750753AbWHKIcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:32:24 -0400
Message-Id: <44DC5CE8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 11 Aug 2006 10:33:12 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for review] [127/145] i386: move
	kernel_thread_helper into entry.S
References: <20060810 935.775038000@suse.de>
 <20060810193726.C133F13B8E@wotan.suse.de>
In-Reply-To: <20060810193726.C133F13B8E@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And add proper CFI annotation to it which was previously
>impossible. This prevents "stuck" messages by the dwarf2 unwinder
>when reaching the top of a kernel stack.

>+ENTRY(kernel_thread_helper)
>+	CFI_STARTPROC
>+	movl %edx,%eax
>+	CFI_REGISTER edx,eax

This is pointless, as %eax will be clobbered by the callee of the
subsequent call.

>+	push %edx
>+	CFI_ADJUST_CFA_OFFSET 4
>+	CFI_REL_OFFSET edx,0

This likewise is pointless, as the argument is owned by the callee.

>+	call *%ebx
>+	push %eax
>+	CFI_ADJUST_CFA_OFFSET 4
>+	CFI_REL_OFFSET eax,0

And this too - the value now in %eax has no relation with the
value known by the caller of this routine (which doesn't expect
any return from here anyway).

>+	call do_exit
>+	CFI_ENDPROC
>+ENDPROC(kernel_thread_helper)

Jan
