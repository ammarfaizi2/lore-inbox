Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTATNcB>; Mon, 20 Jan 2003 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbTATNcB>; Mon, 20 Jan 2003 08:32:01 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:57763 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265816AbTATNcA>;
	Mon, 20 Jan 2003 08:32:00 -0500
Date: Mon, 20 Jan 2003 14:41:03 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301201341.OAA23795@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: kernel param and KBUILD_MODNAME name-munging mess
Cc: rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting kernel 2.5.59 with the "-s" kernel boot parameter
doesn't get you into single-user mode like it should.

One part of the problem is Rusty's new module option and
kernel boot parameter parsing code, which changes '-' to
'_' in every string. This change is not reverted when the
string is found NOT to be a kernel option, with the result
that "_s" is passed to init instead of "-s".

Why is this s/-/_/ stuff done at all?
I suppose it's because the string is compared with
MODULE_PARAM_PREFIX, which is __stringify(KBUILD_MODNAME) ".",
and KBUILD_MODNAME is the module name after s/-/_/.

And why does KBUILD_MODNAME change the name like this?
A grep for KBUILD_MODNAME shows that it's only used in #ifdef
and __stringify(). __stringify() macro-expands its argument
before turning it to a string literal. If this is intensional,
then its a bug, since it breaks module parameters to any module
whose (munged) name also is a #define. (I was bitten by that
myself recently when adding a module param to ide-scsi.c.)

Would anything break if we made scripts/Makefile.lib set
KBUILD_MODNAME to the original module name in "", drop the
__stringify() around uses of KBUILD_MODNAME, and remove the
s/-/_/ from kernel/param.c ?

/Mikael
