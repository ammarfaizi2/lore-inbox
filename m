Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbREWHid>; Wed, 23 May 2001 03:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263002AbREWHiY>; Wed, 23 May 2001 03:38:24 -0400
Received: from t2.redhat.com ([199.183.24.243]:52471 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262999AbREWHiL>; Wed, 23 May 2001 03:38:11 -0400
To: Blesson Paul <blessonpaul@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __asm__ 
In-Reply-To: Your message of "23 May 2001 00:54:12 MDT."
             <20010523065412.6796.qmail@nwcst320.netaddress.usa.net> 
Date: Wed, 23 May 2001 08:38:09 +0100
Message-ID: <18216.990603489@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> __asm__("and	1 %%esp.%0; ":"=r" (current) : "0" (~8191UL));

This doesn't look right... Where did you get this from.

Taking the one in include/asm-i386/current.h as an example:

| __asm__(

This signifies a piece of inline assembly that the compiler must insert into
it's output code. The __asm__ is the same as asm, but can't be disabled by
command line flags.

| "andl %%esp,%0

"%%" is a macro that expands to a "%".
"%0" is a macro that expands to the first input/output specification.

So in this case, it takes the stack pointer (register %esp) and ANDs it
into a register that contains 0xFFFFE000, leaving the result in that register.

Basically, the a task's task_struct and a task's kernel stack occupy an 8KB
block that is 8KB aligned, with the task_struct at the beginning and the stack
growing from the end downwards. So you can find the task_struct by clearing
the bottom 13 bits of the stack pointer value.

| ; "

The semicolon can be used to separate assembly statements, as can the newline
character escape sequence ("\n").

| :"=r" (current)

This specifies an output constraint (all of which occur after the first colon,
but before the second). The '=' also specifies that this is an output. The 'r'
indicates that a general purpose register should be allocated such that the
instruction can place the output value into it. The bit inside the brackets -
'current' - is the intended destination of the output value (normally a local
variable) once the C part is returned to.

| : "0" (~8191UL));

This specifies an input constraint (all of which occur after the second colon,
but before the third). The '0' references another constraint (in this case,
the first output constraint), saying that the same register or memory location
should be used for both. The '~8191UL' inside the brackets is a constant that
should be loaded into the register allocated for the output value before using
the instructions inside the asm block.

See also the gcc info pages, Topic "C Extensions", subtopic "Extended Asm".

David
