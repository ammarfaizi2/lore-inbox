Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUIDUjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUIDUjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUIDUjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 16:39:53 -0400
Received: from dhcp160178161.columbus.rr.com ([24.160.178.161]:36113 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S266069AbUIDUjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 16:39:49 -0400
Date: Sat, 4 Sep 2004 16:37:15 -0400
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: Roland McGrath <roland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: 2.6.9-rc1-mm1 ppc build broken
Message-ID: <20040904203715.GA3049@samarkand.rivenstone.net>
Mail-Followup-To: Albert Herranz <albert_herranz@yahoo.es>,
	Roland McGrath <roland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, benh@kernel.crashing.org
References: <200408302348.i7UNmvw0006978@magilla.sf.frob.com> <20040831105118.85292.qmail@web52306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831105118.85292.qmail@web52306.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040818i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hOn Tue, Aug 31, 2004 at 12:51:18PM +0200, Albert Herranz wrote:

[[ CC'ing BenH since lists.linuxppc.org doesn't seem to resolve ]]

[ 2.6.9-rc1-mm1 ]

> > This is creating a circularity on ppc that others
> > don't have apparently.
> > 
> > >   CC      arch/ppc/kernel/asm-offsets.s
> > > In file included from include/linux/mm.h:4,
> > 
> > >                  from include/asm/io.h:7,
> > >                  from include/linux/timex.h:61,
> > 
> > This #include link here is the issue.  Vanilla
> > linux/timex.h does not have
> > the #include <asm/io.h>.  On other machines,
> > <asm/io.h> does not include
> > <linux/mm.h>, so you don't get into the problem with
> > sched.h.
> 
> Thanks.
> 
> The #include <asm/io.h> comes from bk-ia64.patch time
> interpolation logic patch from Cristoph Lameter.
> 
> I've checked that at least for the embedded port I'm
> working on the linux/mm.h is *not* a must on ppc
> asm/io.h so we can get rid of it (commented out).
> Maybe this is also true for the rest of ppc platforms.
> 
> Now 2.6.9-rc1-mm1 builds fine.

    This is still broken in -mm3.  This fix works for my powermac too,
except that arch/ppc/syslib/open_pic.c misses errno.h when it does not
get it through mm.h.  I can't speak for other platforms, but I'll
include the patch.

In case it matters:

Signed-off-by: Joseph Fannin <jhf@rivenstone.net>

--
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

diff -aurN a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c	2004-09-04 15:43:05.035636648 -0400
+++ b/arch/ppc/syslib/open_pic.c	2004-09-04 15:47:14.260748672 -0400
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
+#include <linux/errno.h>
 #include <asm/ptrace.h>
 #include <asm/signal.h>
 #include <asm/io.h>
diff -aurN a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	2004-08-22 22:48:30.000000000 -0400
+++ b/include/asm-ppc/io.h	2004-09-04 15:45:19.641173496 -0400
@@ -4,7 +4,6 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/mm.h>
 
 #include <asm/page.h>
 #include <asm/byteorder.h>
