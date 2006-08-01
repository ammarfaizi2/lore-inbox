Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWHAC2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWHAC2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHAC2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:28:11 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:36531 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751305AbWHAC2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:28:09 -0400
Date: Mon, 31 Jul 2006 22:24:47 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: + espfix-code-cleanup.patch added to -mm tree
To: "akpm@osdl.org" <akpm@osdl.org>
Cc: zach@vmware.com, rohitseth@google.com, JBeulich@novell.com, ak@muc.de,
       stsp@aknet.ru, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607312226_MC3-1-C6A9-1757@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net>

On Sat, 29 Jul 2006 17:16:34 -0700, Andrew Morton wrote:

>     espfix-code-cleanup.patch

After the fixup code does this:

       movl %esp, %eax         # pt_regs pointer
       movl %esp, %edx
       call patch_espfix_gdt
       pushl $__ESPFIX_SS
       CFI_ADJUST_CFA_OFFSET 4
       pushl %eax
       CFI_ADJUST_CFA_OFFSET 4
==>    lss (%esp), %esp
       CFI_ADJUST_CFA_OFFSET -8
       jmp restore_nocheck

we are on a ring0 32-bit stack that's not zero-based.  If an exception
occurs in that state, UNWIND_ESPFIX_STACK restores the proper kernel
SS and ESP but on return from the exception nothing restores the espfix
stack.  I guess this isn't a problem now because exceptions in kernel
mode are fatal but a kernel debugger might have problems here?

-- 
Chuck
