Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVG1RmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVG1RmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVG1R2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:28:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVG1R0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:26:21 -0400
Date: Thu, 28 Jul 2005 10:25:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122569848.29823.248.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
 <1122569848.29823.248.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Steven Rostedt wrote:
> 
> I can change the find_first_bit to use __builtin_ffs, but how would you
> implement the ffz?

The thing is, there are basically _zero_ upsides to using the __builtin_xx 
functions on x86.

There may be more upsides on other architectures (*cough*ia64*cough*) that 
have strange scheduling issues and other complexities, but on x86 in 
particular, the __builtin_xxx() functions tend to be a lot more pain than 
they are worth. Not only do they have strange limitations (on selection of 
opcodes but also for compiler versions), but they aren't well documented, 
and semantics aren't clear.

For example, if you use the "bsfl" inline assembly instruction, you know 
what the semantics are and what the generated code is like: Intel 
documents it, and you know what code you generated. So the special cases 
like "what happens if the input is zero" are well-defined.

In contrast, the gcc builtins probably match some standard that is not 
only harder to find, but also has some _other_ definition for what happens 
for the zero case, so the builtins automatically end up having problems 
due to semantic mis-match between the CPU and the standard.

Basic rule: inline assembly is _better_ than random compiler extensions. 
It's better to have _one_ well-documented extension that is very generic 
than it is to have a thousand specialized extensions.

		Linus
