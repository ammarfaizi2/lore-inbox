Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264442AbRFISVS>; Sat, 9 Jun 2001 14:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbRFISU6>; Sat, 9 Jun 2001 14:20:58 -0400
Received: from ppp32-0-67.miem.edu.ru ([194.226.32.67]:2564 "EHLO yahoo.com")
	by vger.kernel.org with ESMTP id <S264442AbRFISUy>;
	Sat, 9 Jun 2001 14:20:54 -0400
From: Stas Sergeev <stas_orel@yahoo.com>
Reply-To: stas.orel@mailcity.com
To: linux-kernel@vger.kernel.org
Subject: linux fails to do proper cleanups with free_vm86_irq()
Date: Sat, 9 Jun 2001 22:20:09 +0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01060922031100.00974@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using linux-2.2.19 and I have a problem with irq handling:
if some program requests an irq and doesn't free it before exit, I have to
reboot my machine in order to make this program to work again.
I mean dosemu: if it crashes, it doesn't handle irqs any more until reboot.

I can demonstrate the problem with the following example:

----------------------------------------
#include <sys/vm86.h>
#include <stdio.h>
#include <signal.h>

#define OLD_SYS_vm86  113
#define NEW_SYS_vm86  166
static inline int vm86_plus(int function, int param)
{
	int __res;
	__asm__ __volatile__("int $0x80\n"
	:"=a" (__res):"a" ((int)NEW_SYS_vm86), "b" (function), "c" (param));
	return __res;
} 

int main() {
    printf("%s\n", vm86_plus(VM86_REQUEST_IRQ, (SIGIO << 8) | 11)>0?
	"Success":"Fail");
    return 0;
}
------------------------------------------

Running it first time (with root previleges) returns "Success", and next
starts will return "Fail".
I have looked in kernel's vm86.c and found a function handle_irq_zombies()
that must do a cleanup. It doesn't work however for some reasons.
I think the problem is that a function task_valid() compares pointers to
task_struct instead of comparing the actual structures.
Furthermore I have found out that I can make a cleanup manually just
doing VM86_FREE_IRQ within the program, started from the normal user,
not root! It just prooves that the check
if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
is not valid.
Never mind, it is just my guesses...

So can anyone help me with this problem by explaining why linux fails to do
a cleanup and how to make it to do it?

Thanks.
