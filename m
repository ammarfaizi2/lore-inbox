Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTJNSnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJNSmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:42:36 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:42905 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262907AbTJNSm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:42:28 -0400
Date: Tue, 14 Oct 2003 20:42:21 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Chris Lattner <sabre@nondot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
Message-ID: <20031014184221.GF21740@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org> <Pine.LNX.4.44.0310141347530.4033-100000@nondot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310141347530.4033-100000@nondot.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 01:49:04PM -0500, Chris Lattner wrote:
> On Tue, 14 Oct 2003, Chris Lattner wrote:
> > Generated code:
> >         .intel_syntax
> > ...
> > main:
> >         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
> >         mov %EBP, %ESP                        # Set up EBP
> >         sub %ESP, 16004                       # Finally adjust ESP
> >         lea %EAX, DWORD PTR [%EBP - 16000]    # Get the address of the array
> > ...
> >         mov %EAX, 0                           # Setup return value
> >         mov %ESP, %EBP                        # restore ESP
> >         mov %EBP, DWORD PTR [%ESP - 16004]    # Restore EBP from stack
> >         ret
> 
> Ok, I found my own "answer": arch/i386/mm/fault.c:
> 
>                 /*
>                  * accessing the stack below %esp is always a bug.
>                  * The "+ 32" is there due to some instructions (like
>                  * pusha) doing post-decrement on the stack and that
>                  * doesn't show up until later..
>                  */
>                 if (address + 32 < regs->esp)
>                         goto bad_area;
> 
> Why exactly is accessing the stack below %esp always a bug?

Any signal can overwrite any value stored below %esp. In kernel
any interrupt/exception can overwrite any value stored below %esp.
Your compiler is broken....
							Petr Vandrovec

