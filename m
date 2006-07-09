Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWGIDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWGIDnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWGIDnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:43:42 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:7468 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1161078AbWGIDnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:43:41 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile' 
In-reply-to: Your message of "Sat, 08 Jul 2006 20:29:12 MST."
             <Pine.LNX.4.64.0607082019180.5623@g5.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jul 2006 13:43:27 +1000
Message-ID: <4234.1152416607@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (on Sat, 8 Jul 2006 20:29:12 -0700 (PDT)) wrote:
>
>
>On Sun, 9 Jul 2006, Keith Owens wrote:
>> 
>> This disagrees with the gcc (4.1.0) docs.  info --index-search='Extended Asm' gcc
>> 
>>   The ordinary output operands must be write-only; GCC will assume
>>   that the values in these operands before the instruction are dead and
>>   need not be generated.  Extended asm supports input-output or
>>   read-write operands.  Use the constraint character `+' to indicate
>>   such an operand and list it with the output operands.  You should
>>   only use read-write operands when the constraints for the operand (or
>>   the operand in which only some of the bits are to be changed) allow a
>>   register.
>
>I'm fairly sure the docs are outdated (but may well be correct for older 
>gcc versions - as I already discussed elsewhere, that "+" thing was not 
>historically useful).
>
>We've been using "+m" for some time in the kernel on several 
>architectures.
>
>git aficionados can do
>
>	git grep -1 '"+m"' v2.6.17
>
>to see the pre-existing usage of this (most of them go back a lot further, 
>although some of them are newer - the <asm-i386/bitops.h> ones were added 
>in January.
>
>So if "+m" didn't work, we've been in trouble for at least the last year.

The oldest gcc I can access quickly is 3.2.3 (May 2005) which has
significantly different wording.

  The ordinary output operands must be write-only; GCC will assume that
  the values in these operands before the instruction are dead and need
  not be generated.  Extended asm supports input-output or read-write
  operands.  Use the constraint character `+' to indicate such an
  operand and list it with the output operands.

  When the constraints for the read-write operand (or the operand in
  which only some of the bits are to be changed) allows a register, you
  may, as an alternative, logically split its function into two
  separate operands, one input operand and one write-only output
  operand.  The connection between them is expressed by constraints
  which say they need to be in the same location when the instruction
  executes.

In 3.2.3, the '+' form allows any constraint, only the split notation
requires that the operand be in a register.  In 4.1.0, the docs now say
that the '+' form requires a register.  I suspect that you are right
and the gcc docs are incorrect, but it does not hurt to check.  Would
anybody from the gcc team like to pipe up and give an opinion?

