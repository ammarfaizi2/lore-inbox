Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264381AbUDTXZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbUDTXZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbUDTXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:22:14 -0400
Received: from mta6.wss.scd.yahoo.com ([66.218.85.37]:65418 "EHLO
	mta6.wss.scd.yahoo.com") by vger.kernel.org with ESMTP
	id S263726AbUDTXVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:21:44 -0400
Message-ID: <4085B069.5070709@specifixinc.com>
Date: Tue, 20 Apr 2004 16:21:13 -0700
From: Jim Wilson <wilson@specifixinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] Add 64-bit get_user and __get_user for i386
References: <Pine.LNX.4.58.0404190747110.2808@ppc970.osdl.org> <20040420020922.GA18348@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> However that doesn't seem to be a problem.  Experiments show that an
> __asm__ which outputs to a char or short type is _always_
> sign-extended or zero-extended if needed by the compiler, on various
> i386 subtargets.  The compiler doesn't assume anything about the
> output higher bits from an __asm__.
>  
>    --> GCC experts, can you confirm the above property please?

expand_asm_operands in stmt.c checks for promoted variables, and if it 
sees one, it will generate a temporary with the unpromoted size to 
replace it in the asm, and then copy the temporary to the promoted 
variable after the asm, ensuring that the extension happens after the asm.

> (Function calls are similar: GCC won't assume anything about the
> higher bits of the result received from a function, although it always
> promotes the result before returning a value.  Odd combination).

I think this is a minor gcc bug.  We have been promoting char/short 
return values since the gcc-1.x days.  This promotion occurs regardless 
of whether the target asks for return values to be promoted.  This 
promotion happens in start_function in c-decl.c.  Perhaps this is a left 
over from the K&R C days, as I don't see anything in the C89 standard 
that requires this.  Changing this now might break ports that require 
the promotion, but were not explicitly asking for it, so changing this 
might be tricky.  I'd suggest opening a gcc bugzilla bug report if we 
really care about this.
-- 
Jim Wilson, GNU Tools Support, http://www.SpecifixInc.com

