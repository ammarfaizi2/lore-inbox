Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUBHBAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUBHBAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:00:13 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:40156 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261605AbUBHBAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:00:08 -0500
Message-ID: <40258A16.5060905@jon-foster.co.uk>
Date: Sun, 08 Feb 2004 01:00:06 +0000
From: Jon Foster <jon@jon-foster.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> On Fri, 6 Feb 2004 viro wrote:
>>
>> IOW, gcc doesn't realize that we never return from BUG(). AFAICS, it
>> should. Some changes of __volatile__ semantics?
> 
> Thsrs is no way to tell gcc that an inline asm doesn't return. The only
> way to do it would be to add something like a "for (;;);" (that gcc will
> actually generate real code for) inside the BUG() macro, but I'd hate to
> do that.

Why would you hate to do that?  Because of the extra code this generates?
Or because it's a hack (we should just be able to tell GCC that the inline
assembly never returns)?

Although the loop does generate real code, GCC is currently generating real
code to handle what happens after BUG() returns.  The two pretty much cancel
each other out - they're both basically a jump (possibly with a nop for
alignment).  This is extremely non-obvious (at least to me), since the code
to handle BUG() returning is implicit, whereas the for(;;); is explicit.

I've just done some benchmarks (using a vendor 2.4 kernel) and the for(;;);
change actually reduced the kernel size.  The change was a negligible
amount, almost lost in the noise, but at least the size didn't go up.  See
my recent l-k post "Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]".

I agree with Viro that the best solution would be if there was some way
to tell GCC that the inline assembly doesn't return - probably by attaching
__attribute__((noreturn)) to it.

Kind regards,

Jon

> 
> Better to just initialize the variable to a default value and avoid the
> warning for now.
> 
> Linus



