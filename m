Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWHOKg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWHOKg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWHOKg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:36:28 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:16878 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030197AbWHOKg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:36:27 -0400
Message-Id: <44E1BFDC.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 15 Aug 2006 12:36:44 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for review] [127/145] i386: move
	kernel_thread_helper into entry.S
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like done in the x86-64 patch that I just sent, I'd recommend
moving
the push added yesterday outside of the CFI-covered region (so that
in the unlikely event of being caught at the push there won't be an
ill
assumption that a [fake] return address is already on the stack, or
that
there is a return address at all):

ENTRY(kernel_thread_helper)
	pushl $0			# fake return address
	CFI_STARTPROC
	movl %edx,%eax
	pushl %edx
	CFI_ADJUST_CFA_OFFSET 4
	call *%ebx
	pushl %eax
	CFI_ADJUST_CFA_OFFSET 4
	call do_exit
	CFI_ENDPROC
ENDPROC(kernel_thread_helper)

Jan
