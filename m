Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWF0WNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWF0WNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWF0WNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:13:42 -0400
Received: from canuck.infradead.org ([205.233.218.70]:57806 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422643AbWF0WNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:13:41 -0400
Subject: [GIT *] make headers_install
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: sam@savnborg.org, arnd@arndb.de, jbailey@ubuntu.com,
       Tim Yamin <plasmaroo@gentoo.org>,
       Bernhard Rosenkraenzer <bero@arklinux.org>, alan@lxorguk.ukuu.org.uk,
       Thorsten Kukuk <kukuk@suse.de>, Clint Adams <schizo@debian.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 27 Jun 2006 23:12:52 +0100
Message-Id: <1151446372.6394.295.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from git://git.infradead.org/hdrinstall-2.6.git

This contains an implementation of a 'make headers_install' target for
the kernel -- based on original work by Arnd Bergmann, modifed my myself
and then cleaned up by Sam. This copies _selected_ kernel headers out to
a separate directory, passing them through sed and BSD's 'unifdef' tool
to remove parts which userspace should not see.

(The BSD 'unifdef' tool is available at least in Fedora and Debian
through their standard package management tools. I believe that Sam
intends to follow up with a patch to add our own copy of unifdef into
the kernel scripts/ directory, as soon as he's fixed the dependency
issues with that.)

This isn't a departure from our current policy that random userspace
must not poke at kernel private headers. It's just an attempt to impose
some control over those places where we have to accept that people _do_
use the kernel's headers -- when building system libraries and tools,
and when building compilers.

Currently, the compiler-build scripts just use 'cp -a', while the
distributions tend to do their own thing to make it _slightly_ saner
than that, although it's a lot of work to do so. The result is wildly
inconsistent and often exposes things which we really don't want
userspace to have copies of.

By adding a 'make headers_install' target to the kernel, we regulate
those people who really do have to use kernel headers, and we can ensure
that we have a _consistent_ set of headers across all distributions,
which contains only what we _need_ to expose; ioctl definitions, etc.

An additional benefit is that comparing the results of 'make
headers_install' from one kernel release to the next allows us to spot
kernel<->user ABI changes in isolation and give them the extra review
that they deserve. I've already caught and fixed one potential problem
with 32-bit userspace on a 64-bit kernel this way.

The result of this export is already being used in the Fedora Core 6
test releases, and other distributions are either looking at switching
over to it or have done so already.

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

Jean Delvare:
      Remove <linux/i2c-id.h> and <linux/i2c-algo-ite.h> from userspace export

-- 
dwmw2

