Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVHCVqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVHCVqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVHCVqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:46:11 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:41947 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261523AbVHCVqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:46:08 -0400
Date: Wed, 3 Aug 2005 23:46:01 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       Bodo Eggert <7eggert@gmx.de>, Gene Heskett <gene.heskett@verizon.net>,
       "H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
       Puneet Vyas <vyas.puneet@gmail.com>,
       Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
Subject: Re: Documentation - how to apply patches for various trees
In-Reply-To: <200508032251.07996.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.58.0508032257080.3158@be1.lrz>
References: <200508022332.21380.jesper.juhl@gmail.com>
 <200508030840.39852@bilbo.math.uni-mannheim.de>
 <Pine.LNX.4.50.0508030742350.489-100000@shark.he.net>
 <200508032251.07996.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Jesper Juhl wrote:

> +What is a patch?

> +To correctly apply a patch you need to know what base it was generated from
> +and what new version the patch will change the source tree into. These
> +should both be present in the patch file metadata.

This is usurally not true for kernel patches, the directories are mostly
named a and b. You can however deduce the to-bepatched version and the
patched version from the filename.

> +How do I apply a patch?
> +---
> + You apply a patch with the `patch' program. The patch program reads a diff
> +(or patch) file and makes the changes to the source tree described in it.
> +Patches for the Linux kernel are generated relative to the parent directory
> +holding the kernel source dir. This means that paths to files inside the
> +patch file contain the name of the kernel source directories it was
> +generated against - since this is unlikely to match the name of the kernel
> +source dir on your local machine (but is often useful info to see what
> +version an otherwise unlabeled patch was generated against)

Same issue.

> you should
> +change into your kernel source directory and then strip the first element of
> +the path from filenames in the patch file when applying it (the -p1 argument
> +to `patch' does this). To revert a previously applied patch, use the -R
> +argument to patch.

> +How do I feed a patch/diff file to `patch'?
[...]

Or: bzcat patch1 patch2 patch3 | (cd linux-oldversion && patch -p1)


Finding out if a patch applied correctly
---
A quick check is to search for .rej files. Unfortunately some errors 


How do I undo a patch?
---
You can undo a patch by supplying the -R switch to patch. If you patched 
using zcat ../patch.gz | patch -p1, zcat ../patch.gz | patch -Rp1 will 
undo the changes as long as the patch applied correctly.


Common errors while patching
---
"File to patch:"

  Patch could not find a file to be patched. Most probably you forgot to
  use -p1 or you're in the wrong directory. Less often, you'll find
  patches that need to be applied with -p0 instead (you can't just omit
  -p0!).                                            ^^^^^^^^^^^^^^^^^^^
  ^^^^^ [IIRC]

  Sometimes this is the result of an incomplete tarball, a out-of-space 
  error while unpacking or a fsck.

"Hunk #2 succeeded at 1887 with fuzz 2 (offset 7 lines)."

  The patch was applied, but it might be applied to the wrong place
  because you patched the "wrong" source. The result might not work
  correctly.

"Hunk #3 FAILED at 2387."

  The patch could not be applied correctly. This is usurally fatal, except 
  if you apply external patches to the stable series (e.g. to 2.6.23.42
  instead of 2.6.23) and the reject is in the toplevel Makefile.
  (You'll have to manually edit the Makefile and change the version string 
   as recorded in Makefile.rej)

  If you apply more than one external patch, the same thing will happen, 
  but there is no guarantee for a working kernel (the changes may bite 
  each other).

  You can most likely recover the source tree by undoing the patch and 
  removing the .rej and .orig files. YMMV.

"Reversed (or previously applied) patch detected!  Assume -R? [n]"

  Either you really applied the patch before, or the patch is for some
  other source. If this is not the very first message, the source is
  most likely unusable by now.

"patch: **** unexpected end of file in patch"
  Your download is broken. Re-get the file.

-- 
To steal information from a person is called plagiarism. To steal
information from the enemy is called gathering intelligence.
