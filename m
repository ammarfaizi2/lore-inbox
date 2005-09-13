Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbVIMOuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVIMOuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVIMOuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:50:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60172 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932651AbVIMOuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:50:20 -0400
Date: Tue, 13 Sep 2005 15:50:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was: Missing #include <config.h>)
Message-ID: <20050913155012.C23643@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050913150825.A23643@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Sep 13, 2005 at 03:08:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 03:08:26PM +0100, Russell King wrote:
> On Tue, Sep 13, 2005 at 02:56:23PM +0100, Jörn Engel wrote:
> > After spending some hours last night and this morning hunting a bug,
> > I've found that a different include order made a difference.  Some
> > files don't work correctly, unless config.h is included before.
> 
> I'm still of the opinion that we should add
> 
> 	-imacros include/linux/config.h
> 
> to the gcc command line and stop bothering with trying to get
> linux/config.h included into the right files and not in others.
> (which then means we can eliminate linux/config.h from all files.)
> 
> From what you can see below, missing includes of it can remain
> for months, and it can cause bugs which are rather non-obvious.

Well, fixing all the ARM related config.h include mess, the patch
comes out at 53K with this diffstat summary:

 150 files changed, 142 insertions(+), 91 deletions(-)

I really think we should stop being crazy and apply something like
the patch below instead.  Afterwards, we may optionally want to re-
educate people to not include linux/config.h after all.

======
Subject: [KBUILD] Permanently fix kernel configuration include mess.

Include autoconf.h into every kernel compilation via the gcc
command line using -imacros.  This ensures that we have the
kernel configuration included from the start, rather than
relying on each file having #include <linux/config.h> as
appropriate.  History has shown that this is something which
is difficult to get right.

Since we now include the kernel configuration automatically,
make configcheck becomes meaningless, so remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -346,7 +346,8 @@ AFLAGS_KERNEL	=
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
-                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
+                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
+		   -imacros include/linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
@@ -1247,11 +1248,6 @@ tags: FORCE
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
-configcheck:
-	find * $(RCS_FIND_IGNORE) \
-		-name '*.[hcS]' -type f -print | sort \
-		| xargs $(PERL) -w scripts/checkconfig.pl
-
 includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
