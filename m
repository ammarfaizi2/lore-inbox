Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUIBRrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUIBRrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268030AbUIBRrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:47:51 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65215 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S267785AbUIBRrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:47:11 -0400
Date: Thu, 2 Sep 2004 10:47:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Subject: [PATCH,RFC 2.6.9-rc1 2/2] zlib_inflate: Add __BOOTER__ around zlib_inflate_trees_fixed(...)
Message-ID: <20040902174707.GC26144@smtp.west.cox.net>
References: <20040901231659.GA20624@smtp.west.cox.net> <20040902173626.GB26144@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902173626.GB26144@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 10:36:26AM -0700, Tom Rini wrote:

> On Wed, Sep 01, 2004 at 04:17:00PM -0700, Tom Rini wrote:
> 
> > The following patch switches arch/ppc/boot over from using its own
> > version of zlib to the code found under lib/zlib_inflate.  The plus side
> > to this, is one less version of zlib stuff around in the kernel.  The
> > downside is that the zlib code is ~8kB larger now, so I'm not sure if
> > this is a good idea.
> 
> So, to try and get around this growth in size, I decided to see how bad
> things would look, and how much it would take, to get the size back down
> to what it was.  After messing around, I've come up with two patches,
> which in the end shrink the overall size slightly.  The first, and I
> hope least objectionable is to move zlib_inflateSync, and related bits
> used by PPP into inflate_sync.c.  This saves us 169 bytes.

This is the second part of what I found.  zlib_inflate_trees_fixed(...)
isn't called in decompressing a kernel.  Dropping this, and the call to
it saves ~8kB.  __BOOTER__ is a flag already passed along during the
build of arch/ppc/boot/.  But, I'm going to guess doing it this way is
just too ugly.  zlib_inflate_trees_fixed(...) itself could be moved into
another file, but that leaves the problem of having to provide some sort
of stub function, and perhaps making zlib_inflate_trees_fixed return
Z_OK (real version) or Z_STREAM_ERROR (stub).

Or if anyone else has a better idea, I'd be glad to give that a shot.
Thanks.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6/lib/zlib_inflate/infblock.c
===================================================================
--- linux-2.6.orig/lib/zlib_inflate/infblock.c
+++ linux-2.6/lib/zlib_inflate/infblock.c
@@ -134,6 +134,7 @@ int zlib_inflate_blocks(
           DUMPBITS(t)
           s->mode = LENS;               /* get length of stored block */
           break;
+#ifndef __BOOTER__
         case 1:                         /* fixed */
           {
             uInt bl, bd;
@@ -150,6 +151,7 @@ int zlib_inflate_blocks(
           DUMPBITS(3)
           s->mode = CODES;
           break;
+#endif
         case 2:                         /* dynamic */
           DUMPBITS(3)
           s->mode = TABLE;
Index: linux-2.6/lib/zlib_inflate/inftrees.c
===================================================================
--- linux-2.6.orig/lib/zlib_inflate/inftrees.c
+++ linux-2.6/lib/zlib_inflate/inftrees.c
@@ -374,6 +374,7 @@ int zlib_inflate_trees_dynamic(
 }
 
 
+#ifndef __BOOTER__
 /* build fixed tables only once--keep them here */
 #include "inffixed.h"
 
@@ -392,3 +393,4 @@ int zlib_inflate_trees_fixed(
   *td = fixed_td;
   return Z_OK;
 }
+#endif

-- 
Tom Rini
http://gate.crashing.org/~trini/
