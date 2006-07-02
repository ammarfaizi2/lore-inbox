Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932828AbWGBJ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbWGBJ6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 05:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbWGBJ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 05:58:23 -0400
Received: from canuck.infradead.org ([205.233.218.70]:60375 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932828AbWGBJ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 05:58:22 -0400
Subject: [GIT *] make headers_install
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, sam@ravnborg.org, arnd@arndb.de, jbailey@ubuntu.com,
       Tim Yamin <plasmaroo@gentoo.org>,
       Bernhard Rosenkraenzer <bero@arklinux.org>, alan@lxorguk.ukuu.org.uk,
       Thorsten Kukuk <kukuk@suse.de>, Clint Adams <schizo@debian.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 02 Jul 2006 10:57:42 +0100
Message-Id: <1151834262.3000.19.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from git://git.infradead.org/hdrinstall-2.6.git 

This implements a 'headers_install' make target, which takes a selected
subset of kernel headers and exports them in a form which is usable by
system libraries and tools, also removing all #ifdef __KERNEL__ from
them.

This provides a number of benefits to all concerned.

 - it makes life a _lot_ easier for those who have to maintain such a
   set of headers for distributions, or for building toolchains.
   Previously, these were often maintained manually, adding new
   structures and ioctls to a set of header files which were originally
   copied from an older kernel and cleaned up. Now, they can be obtained
   directly in a form which is useful. It was the fact that I own the
   'glibc-kernheaders' package in Fedora which finally prompted me to
   follow up on this.

 - it makes life easier for those whose libraries or tools must _use_
   such headers, because it means that the set of available headers can
   be _consistent_ across all distributions and toolchains rather than
   having random differences.

 - that consistency also allows us to reduce the abuse of kernel headers
   by random userspace, by removing files which userspace has no
   business with. For example, we can simply drop asm/atomic.h from the
   export to stop people from abusing it in userspace -- when we did
   that kind of thing in Fedora alone, we got lots of complaints that
   "it works in $OTHERDISTRO". (I haven't done that yet except in the
   Fedora version; I was concentrating on the mechanism before we start
   to enforce such policy).

 - we can take diffs between the exported headers from one version to
   the next, and see any ABI-affecting changes clearly. This should help
   us to keep tabs on ABI changes. I've already kicked the GFS2 guys and
   had them fix a problem with 32-bit userspace on 64-bit kernel,
   because after 'make headers_install' I was able to see their ABI
   change in isolation instead of hidden amongst the rest of their
   patches.

 - The additional 'make headers_check' target also allows us to run some
   basic sanity checks on the exported headers. Currently, I've only
   checked that they don't attempt to include headers which aren't
   marked for export -- but Arjan van de Ven has offered patches which
   go a little further than that. We could check for bogus types like
   'u32' being used instead of '__u32', etc. And perhaps we could even 
   check that headers are _compilable_ in their standalone form,
   although that isn't usually assumed to be the case since they don't
   all include all their dependencies. Still, the mechanism is there for
   us to do with it as we see fit.

It's based on an original implementation by Arnd Bergmann, hacked around
a bit by myself, and reviewed and cleaned up by Sam Ravnborg. It
includes some additional processing provided by Tim Yamin who handles
kernel headers for the Gentoo distribution.

It uses the BSD 'unifdef' tool, which is available by 'yum install
unifdef' on Fedora systems, and I believe is also available by similar
means in Debian. Sam's actually expressed a desire to stick a copy of
unifdef.c into the kernel's scripts/ directory, and Tony Finch (the BSD
author/maintainer) has agreed to that -- Sam will probably follow up
with an appropriate patch shortly, once he's sorted out the dependency
issues with that and cross-building.

The result of this export is already shipping in the 'glibc-kernheaders'
package in Fedora Core 6 test 1. I've also been working with those who own
equivalent packages in other distributions, and there is a _lot_ of
interest in switching over to this method.

Ignoring the new Kbuild files which just list the files to be exported
from each directory under include/, the diffstat is as follows:

 Makefile                              |   17 ++++
 scripts/Makefile.headersinst          |  158 +++++++++++++++++++++++++++++++++
 scripts/hdrcheck.sh                   |    8 ++
 49 files changed, 399 insertions(+), 0 deletions(-)

David S. Miller:
      Restrict headers exported to userspace for SPARC and SPARC64

David Woodhouse:
      Basic implementation of 'make headers_install'
      Basic implementation of 'make headers_check'
      Add generic Kbuild files for 'make headers_install'
      Add Kbuild file for PowerPC 'make headers_install'
      Add Kbuild file for x86_64 'make headers_install'
      Add Kbuild file for i386 'make headers_install'
      Add Kbuild file for S390 'make headers_install'
      Add Kbuild file for IA64 'make headers_install'
      Add Kbuild file for SPARC 'make headers_install'
      Add Kbuild file for Alpha 'make headers_install'
      Add empty Kbuild files for 'make headers_install' in remaining arches.
      Remove export of include/linux/isdn/tpam.h

Jean Delvare:
      Remove <linux/i2c-id.h> and <linux/i2c-algo-ite.h> from userspace export

-- 
dwmw2

