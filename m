Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWHNMgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWHNMgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWHNMgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:36:32 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:30367 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1752033AbWHNMgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:36:31 -0400
Message-Id: <44E08A76.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 14 Aug 2006 14:36:38 +0200
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

>> And this too - the value now in %eax has no relation with the
>> value known by the caller of this routine (which doesn't expect
>> any return from here anyway).
>
>Ok, but somehow it needs to be annotiated so that the unwinder stops
>and doesn't fall back. Can you please send a replacement patch that 
>does this correctly? 

Actually, with the previous attempt we still didn't achieve the
original
goal of terminating the frame chain at kernel_thread_helper. Thus
another try (the seemingly odd extra push can be avoided once we
start using CFI expressions, which the unwinder currently doesn't
support):

ENTRY(kernel_thread_helper)
	CFI_STARTPROC
	pushl $0			# fake return address
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
