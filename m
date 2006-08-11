Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWHKJsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWHKJsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWHKJsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:48:12 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:46572 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1750995AbWHKJsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:48:11 -0400
Message-Id: <44DC6EAA.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 11 Aug 2006 11:48:58 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for review] [127/145] i386: move
	kernel_thread_helper into entry.S
References: <20060810 935.775038000@suse.de>
 <20060810193726.C133F13B8E@wotan.suse.de>
 <44DC5CE8.76E4.0078.0@novell.com> <200608111038.17716.ak@suse.de>
In-Reply-To: <200608111038.17716.ak@suse.de>
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

I would do it this way (untested):

ENTRY(kernel_thread_helper)
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

(i.e. tracking the stack pointer movement, but not the register values
other than the return address)

Jan
