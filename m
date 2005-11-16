Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVKPUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVKPUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbVKPUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:31:58 -0500
Received: from out002.iad.hostedmail.net ([209.225.56.24]:51721 "EHLO
	out002a.iad.hostedmail.net") by vger.kernel.org with ESMTP
	id S1030485AbVKPUb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:31:56 -0500
Message-ID: <437B97D0.2040803@qlusters.com>
Date: Wed, 16 Nov 2005 22:34:24 +0200
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gcc optimizer miscompiles code with sigaddset on i386 ?
Content-Type: multipart/mixed;
 boundary="------------090501070008040601090508"
X-OriginalArrivalTime: 16 Nov 2005 20:31:44.0554 (UTC) FILETIME=[C274C0A0:01C5EAEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501070008040601090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello:

I have run into problem using sigaddset() in kernel code. The problem is 
reproducible in user space with kernel sigaddset definition.

I have a problem where a code like the following gets miscompiled:

sigset_t a;
sigset_t b;
sigset_t c;

...........
sigaddset(&a, const1);
sigaddset(&a,  const2);
................................
b =a;    /* this line causes incorrect code; any 64-bit assignment seems 
to cause a problem! */
sigaddset(&c, const2);
sigaddset(&c,  const3);
/* more sigaddset to c */

At some iteration of sigaddset to c, c gets the value of a!

Again, the problem is reproducible in user space. Both gcc 2.96 and gcc 
3.2.3 are affected. So, the problem should be relevant for both 2.4 and 
2.6 kernels.
Attached please find a C code that that demonstrates the problem. It can 
be compiled to user space and kernel module . When compiled without 
optimization or with "-O", the problem goes away. When replacing 
sigaddset with set_bit, the problem goes away as well. Trying to run the 
problematic code in the debugger shows totally wild behavior. I have not 
analyzed the disassembly yet, so I cannot say what goes wrong. It seems 
a workaround to this problem is required in kernel source as it 
potentially breaks signal code. Is sigaddset misses some registers in 
clobbered list? Anybody is willing to crack a workaround?

THX.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


--------------090501070008040601090508
Content-Type: text/plain;
 name="sigset_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigset_test.c"

/***************************************************************************
                          sigset_test.c  -  description
                             -------------------
    begin                : Wed Nov 16 2005
    copyright            : (C) 2005 by Qlusters Ltd
    email                : linux@qlusters.com
 ***************************************************************************/
#ifdef  DEF_KERNEL
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/mm.h>
#include <linux/signal.h>

static int sigset_test_init(void);
static void sigset_test_exit(void);

module_init(sigset_test_init);
module_exit(sigset_test_exit);
#define SIGADDSET sigaddset
#define SIGISMEMBER sigismember
//#define  SIGADDSET(x, y) set_bit(y, (long *)x)

#else
extern int printf(const char *format, ...);
#define printk printf
#define KERN_INFO
typedef struct {
	unsigned long sig[2];
} sigset_t;
#include <asm/signal.h>
#define _NSIG (64)
#define _NSIG_BPW (32)

static __inline__ void SIGADDSET(sigset_t *set, int _sig)
{
	__asm__("btsl %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
}

static __inline__ int __const_sigismember(sigset_t *set, int _sig)
{
	unsigned long sig = _sig - 1;
	return 1 & (set->sig[sig / _NSIG_BPW] >> (sig % _NSIG_BPW));
}
static __inline__ int __gen_sigismember(sigset_t *set, int _sig)
{
	int ret;
	__asm__("btl %2,%1\n\tsbbl %0,%0"
		: "=r"(ret) : "m"(*set), "Ir"(_sig-1) : "cc");
	return ret;
}

#define SIGISMEMBER(set,sig)               \
	(__builtin_constant_p(sig) ?           \
	__const_sigismember((set),(sig)) :     \
	__gen_sigismember((set),(sig)))

#endif



sigset_t ssi_fatal_sigset;
static sigset_t ssi_stop_set;
static void print_pending_signals(sigset_t *pending, sigset_t *blocked);

void sigset_test_exit(void)
{
	return;
}

#ifdef  DEF_KERNEL
static int sigset_test_init()
#else
int main()
#endif
{
	sigset_t cleaned;

	cleaned = (sigset_t) { {0,  0} };
	/* these are non-fatal signals.  Other signals are if their action is SIG_DFL */
	SIGADDSET(&cleaned, SIGCONT);
	SIGADDSET(&cleaned, SIGCHLD);
	SIGADDSET(&cleaned, SIGWINCH);
	SIGADDSET(&cleaned, SIGURG);
	SIGADDSET(&cleaned, SIGTSTP);
	SIGADDSET(&cleaned, SIGTTIN);
	SIGADDSET(&cleaned, SIGTTOU);
	SIGADDSET(&cleaned, SIGSTOP);
	ssi_fatal_sigset =  (sigset_t) { {-1,  -1} };

	//uncomenting this line fixes the problem
	//printk(KERN_INFO "sigset_test: fatal %p, stop %p\n", &ssi_fatal_sigset, &ssi_stop_set);

	/* ssi_fatal_sigset is a mask of all signals that are fatal */
	//commenting the line below fixes the problem
	ssi_fatal_sigset = cleaned;

	ssi_stop_set = (sigset_t) { {0,  0} };
	printk(KERN_INFO "sigset_test after zeroing\n");
	print_pending_signals(&ssi_stop_set, NULL);

	SIGADDSET(&ssi_stop_set, SIGTSTP);
	printk(KERN_INFO "sigset_test after %d\n", SIGTSTP);
	print_pending_signals(&ssi_stop_set, NULL);

	SIGADDSET(&ssi_stop_set, SIGTTIN);
	printk(KERN_INFO "sigset_test after %d\n", SIGTTIN);
	print_pending_signals(&ssi_stop_set, NULL);

	SIGADDSET(&ssi_stop_set, SIGTTOU);
	printk(KERN_INFO "sigset_test after %d\n", SIGTTOU);
	print_pending_signals(&ssi_stop_set, NULL);

	SIGADDSET(&ssi_stop_set, SIGSTOP);
	printk(KERN_INFO "sigset_test after %d\n", SIGSTOP);
	print_pending_signals(&ssi_stop_set, NULL);
	return 1;
}

static void print_pending_signals(sigset_t *pending, sigset_t *blocked)
{
	int i;

	if(pending->sig[0] == 0 && pending->sig[1] == 0) {
		printk(KERN_INFO "sigset_t: no set signals\n");
		return;
	}
	if(blocked) {
		for(i = 0; i < _NSIG; i++) {
			if(SIGISMEMBER(pending, i+1)) {
				printk(KERN_INFO "sigset_test: set signal %d is%sblocked\n", i+1,  SIGISMEMBER(blocked, i+1) ? " " : " not ");
			}
		}
	} else {
		 for(i = 0; i < _NSIG; i++) {
			if(SIGISMEMBER(pending, i+1)) {
				printk(KERN_INFO "sigset_test: set signal %d\n", i+1);
			}
		}
	}
}

--------------090501070008040601090508--
