Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135973AbRD0Eta>; Fri, 27 Apr 2001 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135974AbRD0EtU>; Fri, 27 Apr 2001 00:49:20 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:3768 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135973AbRD0EtH>; Fri, 27 Apr 2001 00:49:07 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 26 Apr 2001 21:49:05 -0700
Message-Id: <200104270449.VAA05279@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Suggestion for module .init.{text,data} sections
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	A while ago, on linux-kernel, we had a discussion about
adding support for __initdata and __init in modules.  Somebody
(whose name escapes me) had implemented it by essentially adding
a vmrealloc() facility in the kernel.  I think I've thought of a
simpler way, that would require almost no kernel changes.

	Have insmod split the module into two parts and load them
as two modules.  First, create the regular part of the module as usual
(without .data.init and .text.init), except with no initialization
routine set.  Second, create a module from the .data.init and the
.text.init sections (if any), with it's initialization routine set
to the module's init_module routine, even if that routine resides
in the first module.  Third, there will be cross references between
these two modules, so will generally be necessary to resolve the
relocations before loading either module.  Fourth, load the first
module.  This will always succeed, since there is no initialization
routine to fail.  Fifth, load the second module, the one made of .data.init
and .text.init.  It will run the actual module_init function.  If the
module initialization routine fails, both modules are unloaded and
the usual failure behavior happens.  If the module initialization
succeeds, the ".init" module (the second module) is unloaded.

	Potentially, this could save some memory footprint in
highly modularized systems and cleanup linux/include/init.h.
I guess I would imagine this as a potential 2.5 feature, or
perhaps as a default-off option intended soley for stress testing
in 2.4.

	I started looking through the modutils sources, but I was
a little disappointed to discover that it is ELF-specific rather
than written in bfd, as I am pretty unfamiliar with ELF innards but
a little more conversant in bfd.  Maybe I'll take a whack at it yet,
but I figure I should at least pass the idea along and see if I'm
overlooking anything obvious.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
