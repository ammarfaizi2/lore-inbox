Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSKYEat>; Sun, 24 Nov 2002 23:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSKYEat>; Sun, 24 Nov 2002 23:30:49 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:59405 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S262414AbSKYEas>; Sun, 24 Nov 2002 23:30:48 -0500
Message-ID: <3DE1A91F.8871C2D4@compuserve.com>
Date: Sun, 24 Nov 2002 23:37:51 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.49+ and sysrq (may lock with modules loaded)?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to use sysrq tonight and had a couple problems.  While the
Doc/sysrq.txt file says it is enabled by default, it does not appear to
be any longer.  After enabling sysrq with an echo "1" to the sysrq /proc
entry, I tried an alt-sysrq-t, and promptly had a kernel oops in the
print routine, for a failed kernel paging request.  The machine is hard
locked at this point and must be reset (sysrq no longer responds.)

I tried to repeat this, to write down some of the oops, but on reboot
(prior to loading any modules) I could not get any printout from sysrq
other than the HELP message.  In response to alt-sysrq-t I only see the
first "SysRq : " printout with no task info.

The first run had some modules I had manually loaded, so I went ahead
and insmod'd sound.o and usbcore.o.  After that, alt-sysrq-t causes an
oops.  Here's a snippet (by hand):

Oops
 EIP 0060:c0134c48
  __print_symbol+0x48/0x120
 process swapper
Call Trace
  e094ae89 Unable to handle kernel paging request

An EIP lookup on my vmlinux yields:
(gdb) l *0xc0134c48
Line 190 of "include/asm/string.h" starts at address 0xc0134c3f
<__print_symbol+63> and ends at 0xc0134c5c <__print_symbol+92>.
/usr/src/linux-bk/include/asm-i386/string.h:190:4260:beg:0xc0134c3f

I'm using a recent bk tree (a day or two old), so the relevant portion
from string.h appears to be:

#define __HAVE_ARCH_STRLEN
static inline size_t strlen(const char * s)
{
int d0;
register int __res;
__asm__ __volatile__(
    	"repne\n\t"
    	"scasb\n\t"
    	"notl %0\n\t"
    	"decl %0"
    	:"=c" (__res), "=&D" (d0) :"1" (s),"a" (0), "0" (0xffffffff));
return __res;
}

with the 
__asm__ __volatile__(
line being pointed out by my debugger.


-- 
Kevin
