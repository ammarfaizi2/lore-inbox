Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFFRCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTFFRCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:02:18 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:23206 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262095AbTFFRCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:02:14 -0400
Message-ID: <3EE0CF07.2070908@techsource.com>
Date: Fri, 06 Jun 2003 13:27:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel printk format string compression: C syntax problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of you may recall that I've been working on a way to compress 
kernel printk format strings so as to shrink the kernel memory image a 
bit.  My results so far are that given the amount of space required for 
all kernel strings, I can compress them to half their original size. 
Given something the size of an allyesconfig kernel, that's not much 
compression over-all, but it's still interesting.  Additionally, the 
means to compress the kernel messages are a compile-time issue and 
completely transparent to the coder.

I am, however, encountering a problem, and I was hoping some people who 
know C syntax better than both myself and the C syntax spec I found at 
"http://eic.sourceforge.net/iso_c.html" could help me solve it.

Here's an example of the problem:

This line from process.c starts out as:

printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, 
(current_thread_info()->cpu));

And is replaced by:

printk( "EIP\200\3164x:[<\3168lx>] CPU\200%d\n" ,0xffff & 
regs->xcs,regs->eip, (current_thread_info()->cpu));

GCC 3.0.4 makes the following complaint:

arch/i386/kernel/process.c:173: warning: too many arguments for format

What I believe is happening is that where I have the escape code "\316" 
concatenated with the literal "8", the compiler is seeing it as "\3168" 
and doesn't want to take it.  Now, it's just a warning, and it MAY be 
doing the right thing, but what I want to know is the PROPER UNAMBIGUOUS 
way to specify at 3-digit octal escape code which is followed 
immediately by a literal digit.

Any suggestions?

Thank you.

