Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313976AbSDFEsh>; Fri, 5 Apr 2002 23:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313986AbSDFEs1>; Fri, 5 Apr 2002 23:48:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:17414 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313976AbSDFEsR>;
	Fri, 5 Apr 2002 23:48:17 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: kbuild 2.5 problems with netfilter linking
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 14:48:02 +1000
Message-ID: <15086.1018068482@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AKA - Rusty shoots himself in the foot :)

kbuild 2.5 defines

 -DKBUILD_OBJECT=module, the name of the module the object is linked
    into, without the trailing '.o' and without any paths.  If the
    object is a free standing module or is linked into vmlinux then the
    "module" name is the object itself.  Automatically generated.

This variable is aimed at standardizing boot and module parameters, so
'insmod foo option=value' and booting with 'foo.option=value' will have
exactly the same effect.  Rusty already has code to do this and is
waiting for kbuild 2.5 to go in.

Alas netfilter has objects that are linked into multiple modules,
$(ip_nf_compat-objs) is linked into both ipfwadm and ipchains so
KBUILD_OBJECT is ambiguous.  Two possible solutions -

* Change netfilter so the objects are not linked twice.  That will
  require $(ip_nf_compat-objs) to be a module in its own right with
  extra exported symbols.

* Change kbuild 2.5 to detect multi linked objects and not set
  KBUILD_OBJECT for those objects.  It follows that multi linked
  objects cannot have module or boot parameters, so change modules.h to
  barf on MODULE_PARM() and __setup() when KBUILD_OBJECT is not
  defined.

I am tending towards the second solution.

