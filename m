Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbUKTOiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUKTOiF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 09:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUKTOiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 09:38:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53512 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262941AbUKTOh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 09:37:59 -0500
Date: Sat, 20 Nov 2004 14:37:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: sparse segfaults
Message-ID: <20041120143755.E13550@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Sparse appears to segfault when trying to check kernel/timer.c:

  CC      kernel/ptrace.o
  CHECK   /home/rmk/bk/linux-2.6-rmk/kernel/timer.c
make[2]: *** [kernel/timer.o] Error 139
make[1]: *** [kernel] Error 2
make: *** [_all] Error 2

It doesn't seem to matter which ARM machine I have my kernel configured
for, the result is always the same.

#0  0x08059222 in expand_conditional (expr=0xf6a88c4c) at expand.c:478
478                     *expr = *true;
(gdb) where
#0  0x08059222 in expand_conditional (expr=0xf6a88c4c) at expand.c:478
#1  0x08059956 in expand_expression (expr=0xf6a88c4c) at expand.c:859
#2  0x08059a32 in expand_symbol (sym=0x5) at expand.c:917
#3  0x08048cc0 in clean_up_symbols (list=0x9464fb0) at check.c:100
#4  0x08048eb5 in main (argc=40, argv=0xfef19dc4) at check.c:192
(gdb) print expr
$1 = (struct expression *) 0xf6a88c4c
(gdb) print true
$2 = (struct expression *) 0x0
(gdb) print *expr
$3 = {type = EXPR_CONDITIONAL, op = 63, pos = {type = 6, stream = 1,
    newline = 0, whitespace = 1, pos = 22, line = 566, noexpand = 0},
  ctype = 0x80764a0, {value = 4138241036, fvalue = <invalid float value>,
    string = 0xf6a88c0c, unop = 0xf6a88c0c, statement = 0xf6a88c0c,
    expr_list = 0xf6a88c0c}}

Unfortunately, gdb won't show me the contents of expr->cond_true nor
expr->cond_false without the following:

(gdb) print *(&expr->string)
$4 = (struct string *) 0xf6a88c0c
(gdb) print *(&expr->string+1)
$5 = (struct string *) 0x0
(gdb) print *(&expr->string+2)
$6 = (struct string *) 0xf6a88c6c

Looks like expr->cond_true is NULL.  Line 566 of kernel/timer.c is:

int tickadj = 500/HZ ? : 1;             /* microsecs */

which makes it look like sparse doesn't understand such constructions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
