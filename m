Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbVKQHRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbVKQHRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbVKQHRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:17:05 -0500
Received: from out002.iad.hostedmail.net ([209.225.56.24]:33749 "EHLO
	out002a.iad.hostedmail.net") by vger.kernel.org with ESMTP
	id S1161157AbVKQHRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:17:03 -0500
Message-ID: <437C2F08.50801@qlusters.com>
Date: Thu, 17 Nov 2005 09:19:36 +0200
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Constantine Gavrilov <constg@qlusters.com>
Subject: gcc optimizer miscompiles code with sigaddset on i386 if sig arg
 is const  -- PATCH proposed
References: <437B97D0.2040803@qlusters.com>
In-Reply-To: <437B97D0.2040803@qlusters.com>
Content-Type: multipart/mixed;
 boundary="------------050105030509030004090201"
X-OriginalArrivalTime: 17 Nov 2005 07:16:56.0341 (UTC) FILETIME=[E47AAC50:01C5EB46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105030509030004090201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have run into problem using sigaddset() with constant signal argument 
in kernel code.

A code like the following gets miscompiled:

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

All versions of compilers and all kernel versions are affected. The 
problem is also reproducible in user space (with kernel sigaddset 
definition). Looking at the dissassembly (or running in the debugger) 
clearly shows that gcc miscompiled the code.

Attached please find a C code (can be compiled into module or 
executable) that demonstrates the problem. Attached is also a patch that 
fixes the problem (the patch was prepared against 2.6 tree).

I defined sigaddset a macro (similar to sigismember) that calls one 
function for constant argument and another for variable. In addition to 
fixing the problem, it also makes sigaddset() faster for constant arguments.

To be on the safe side, I changed sigdelset() in the same way (I think 
the same gcc bug may apply).


-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


--------------050105030509030004090201
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

#define SIGADDSET1(set,sig)                \
	(__builtin_constant_p(sig) ?           \
	__const_sigaddset((set),(sig)) :       \
	__gen_sigaddset((set),(sig)))

static __inline__ void __gen_sigaddset(sigset_t *set, int _sig)
{
	__asm__("btsl %1,%0" : "=m"(*set) : "Ir"(_sig-1) : "cc");
}

static __inline__ void __const_sigaddset(sigset_t *set, int _sig)
{
	unsigned long sig = _sig - 1;
	set->sig[sig / _NSIG_BPW] |= 1 << (sig % _NSIG_BPW);
}

#define SIGADDSET  __gen_sigaddset
//#define SIGADDSET  SIGADDSET1 /* fixes the problem */


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
	SIGADDSET(&cleaned, SIGTTOU);
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

--------------050105030509030004090201
Content-Type: text/plain;
 name="sigset_ops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigset_ops.patch"

--- signal.h.orig	Thu Nov 17 08:47:14 2005
+++ signal.h	Thu Nov 17 08:54:12 2005
@@ -186,16 +186,39 @@
 
 #define __HAVE_ARCH_SIG_BITOPS
 
-static __inline__ void sigaddset(sigset_t *set, int _sig)
+#define sigaddset(set,sig)                 \
+	(__builtin_constant_p(sig) ?       \
+	__const_sigaddset((set),(sig)) :   \
+	__gen_sigaddset((set),(sig)))
+
+static __inline__ void __gen_sigaddset(sigset_t *set, int _sig)
 {
 	__asm__("btsl %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
 }
 
-static __inline__ void sigdelset(sigset_t *set, int _sig)
+static __inline__ void __const_sigaddset(sigset_t *set, int _sig)
+{
+	unsigned long sig = _sig - 1;
+	set->sig[sig / _NSIG_BPW] |= 1 << (sig % _NSIG_BPW);
+}
+
+#define sigdelset(set,sig)                 \
+	(__builtin_constant_p(sig) ?       \
+	__const_sigdelset((set),(sig)) :   \
+	__gen_sigdelset((set),(sig)))
+
+
+static __inline__ void __gen_sigdelset(sigset_t *set, int _sig)
 {
 	__asm__("btrl %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
 }
 
+static __inline__ void __const_sigaddset(sigset_t *set, int _sig)
+{
+	unsigned long sig = _sig - 1;
+	set->sig[sig / _NSIG_BPW] &= ~(1 << (sig % _NSIG_BPW));
+}
+
 static __inline__ int __const_sigismember(sigset_t *set, int _sig)
 {
 	unsigned long sig = _sig - 1;

--------------050105030509030004090201--
