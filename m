Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSKNDSF>; Wed, 13 Nov 2002 22:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSKNDSF>; Wed, 13 Nov 2002 22:18:05 -0500
Received: from dp.samba.org ([66.70.73.150]:1977 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261409AbSKNDSD>;
	Wed, 13 Nov 2002 22:18:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module parameters reimplementation 0/4
Date: Thu, 14 Nov 2002 15:23:00 +1100
Message-Id: <20021114032456.3337E2C057@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was going to feed this more slowly, to get feedback at every stage,
but I'm being mailbombed by angry developers 8(

Explanation: (Not that anyone read my previous ones, it seems)

1) MODULE_PARM() is not typesafe: it doesn't even check that the
   variable exists.  There are dozens of completely bogus uses in
   drivers.
2) Everyone who wants to implement module parameters *and* boot
   parameters had to implement MODULE_PARM() and __setup() and roll
   their own parsing.
3) MODULE_PARM() is not extensible.

This patch series introduces "PARAM(var, type, perm)".  This does
several things:
1) Checks the type of "var" matches "type".
2) If built-in, adds a boot parameter called <modulename>.var.
3) If modular, adds a module parameter called var.
4) The third arg is for exposure through sysfs once it stabilizes, 000
   means don't expose.

PARAM() is implemented in terms of PARAM_CALL(), similar to __setup()
except it (depending on the perm field) might be readable too.

Types "short", "ushort", "int", "ulong", "bool", "invbool" etc are
implemented pre-canned.  You can define your own, see linux/params.h
for how.

Finally, if you do not use your own types, PARAM() can be #defined
into a MODULE_PARM statement for 2.4 kernels (ie. backwards
compatible).  Patch 4/4 also translates old-style MODULE_PARM() into
PARAMs at load time, for existing modules.

Why now?
--------
This kind of change shows why you need an in-kernel linker: this kind
of change would break userspace with the current modutils.

Sorry for any inconvenience,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
