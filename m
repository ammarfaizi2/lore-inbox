Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265680AbUGDM7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUGDM7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUGDM7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:59:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:42143 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265680AbUGDM7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:59:12 -0400
Date: Sun, 4 Jul 2004 14:59:04 +0200 (MEST)
Message-Id: <200407041259.i64Cx4SX012978@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: updated gcc-3.4.0 fixes patch for 2.4.27-rc3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's now an updated gcc-3.4.0 fixes patch for 2.4.27-rc3 at
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-rc3>.

This update includes two cleanups:

1. The fix for the __attribute__((packed)) problem in ftape-bsm.h
   has been corrected. The problem is that

   typedef struct { char c[3]; } Name __attribute__((packed));

   generates gcc warnings about the 'packed' attribute being
   ignored. I assumed this was because packed is meaningless
   on a struct containing only char values, so the previous
   patches simply removed the attribute. However, the problem
   turns out to be syntactic: __attribute__((packed)) is only
   allowed in struct/union declarations, not in typedef:s.
   The revised patch moves the attribute into the struct part:

   typedef struct { char c[3]; } __attribute__((packed)) Name;

2. The patches that removed 'inline' from function declarations
   have been removed. The problem is that include/linux/compiler.h
   defines inline as follows:

   #if __GNUC__ == 3
   #if __GNUC_MINOR__ >= 1
   # define inline         __inline__ __attribute__((always_inline))

   A number of functions are marked inline and then called in
   contexts where their function bodies aren't visible. gcc-3.4.0
   takes the always_inline attribute literally, and terminates
   with an error in these cases.

   The previous patches removed the problematic inline annotations.
   The proper fix is to eliminate the always_inline attribute:

   #if __GNUC__ == 3
   #if __GNUC_MINOR__ >= 1 && __GNUC_MINOR__ < 4
   # define inline         __inline__ __attribute__((always_inline))

   This is what the 2.6 kernels do, and my patch set already included
   this change. So the inline removals were unnecessary and have been
   eliminated.

Both cleanups are due to Marcelo questioning me about the validity
of the previous versions of these fixes.

/Mikael
