Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272856AbRIWGmy>; Sun, 23 Sep 2001 02:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273240AbRIWGmp>; Sun, 23 Sep 2001 02:42:45 -0400
Received: from CPE-61-9-148-170.vic.bigpond.net.au ([61.9.148.170]:2432 "EHLO
	wagner") by vger.kernel.org with ESMTP id <S272856AbRIWGmi>;
	Sun, 23 Sep 2001 02:42:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PART1: Proposed init & module changes for 2.5
Date: Sun, 23 Sep 2001 16:37:43 +1000
Message-Id: <E15l2tb-0004KK-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Highlights:
	o Unified boot/module parameters, with type checking.
		Using PARAM(xxx, type, perms) and family.

	o Simpler in-kernel module loading
		insmod can now be written in ~20 lines.

	o Nicer internal module interface
		request_module("%s", foo)
		request_module_start/stop wrappers
		module_get()/module_put(), symbol_get()/symbol_put()

	o Warm fuzzy bleeding edge feel

Todo:
	(1) Incorporate non-ppc architectures (x86, sparc, sparc64,
	    ppc64 already written, not in patch).

	(2) Convert parts of the kernel *I* don't use.

	(3) Use kbuild 2.5, so in-kernel params don't all get called
	    "unknown.xxx".

	(4) Update documentation.

	(5) CONFIG_MODVERSIONS replacement and check for kernel version.

	(6) Patch in proc/sys, so param entries can appear there
	    (this is what the final arg to PARAM is for).

	(7) Write more sophisticated modprobe:
		o /etc/modules.conf
		o Fallback to old modutils if old system.
		o --force to override MODVERSIONS and kernel version.
		o Save parameters from /proc on unloading.

	(8) rmmod should not remove if busy (unless rmmod -f).

	(9) Convert everyone to new safe module insert usage.

Get it from:
	http://netfilter.samba.org/diary/module-init-patch-001.bz2
	http://netfilter.filewatcher.org/diary/module-init-patch-001.bz2
	http://netfilter.gnumonks.org/diary/module-init-patch-001.bz2
(46885 bytes)

And v. v. simple insmod/rmmod/modprobe from:
	http://netfilter.samba.org/diary/module-init-tools-001.bz2
	http://netfilter.filewatcher.org/diary/module-init-tools-001.bz2
	http://netfilter.gnumonks.org/diary/module-init-tools-001.bz2
(33181 bytes)

HACKERS QUICKREF:

OLD:	int parse_foo(char *s) { ... return 1; }
	__setup("foo=", parse_foo);
NEW:	int parse_foo(char *s, struct kernel_param *kp) { ... return 0; }
	PARAM_CALL(foo, parse_foo, NULL);
COMMENTS:
	This will match "foo=" only.  kb->name == "foo", kp->arg ==
	third arg of PARAM_CALL.

OLD:	MODULE_PARM("foo", &foo, "i")
NEW:	PARAM(foo, int, S_IRUGO);
COMMENTS:
	foo must be in scope (and in this case, of type int) or the
	compiler will catch it.
	S_IRUGO means that it will be accessible through proc (use 000
	if this is not useful, or maybe S_IWUSR if root can change it
	at any time).
	Use PARAM_NAMED to give a different name, PARAM_ARRAY for array.

OLD:	inter_module_*
NEW:	EXPORT_SYMBOL, symbol_get(foo) & symbol_put(foo)
COMMENTS:
	These are now typesafe, so foo declaration must be in scope.

OLD:	if (foo->owner) __MOD_INC_USE_COUNT(foo->owner);
NEW:	module_get(foo->owner);

OLD:	module_init(initfn)
NEW:	init_and_startcall(initfn, startfn);
COMMENTS:
	Please use a semicolon at the end.  Modulable code should
	transition to a two-stage init (initfn sets everything up
	and may fail, and startfn which exposes the module to the rest
	of the kernel and can't fail).  Some modules only need
	initfn or startfn, in which case use initcall() or startcall().

OLD:	if (try_inc_mod_count(foo->owner))
NEW:	module_get(foo->owner)

OLD:	int initfn(void) { ...; return 0; }
	module_init(initfn)
NEW:	void initfn(void) { ...; }
	bootcall(initfn);
COMMENTS:
	This is for code which can never be a module: we ignore the
	return value anyway, so why have one (panic() if you must).

OLD:	void exitfn(void) { ...; }
	module_exit(void)
NEW:	int stopfn(void) { ...; return 0; }
	void exitfn(void) { ...; }
	stopcall(stopfn);
	exitcall(exitfn);
COMMENTS:
	If there are neither, then module is not unloadable.  This is
	perfectly OK.  If stopfn returns 0 (otherwise it should be
	-errno) it must have deregistered itself from the rest of the
	kernel (ie. module count can never increase again), but still
	be usable to anyone using it currently.  Once exitfn is
	called, it is guaranteed to be unused.

Enjoy!
Rusty.
--
Premature optmztion is rt of all evl. --DK
