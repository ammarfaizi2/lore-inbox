Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWJ2LCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWJ2LCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 06:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWJ2LCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 06:02:30 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:6095 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S932189AbWJ2LC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 06:02:29 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 29 Oct 2006 06:00:25 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "signed" versus "__signed__" versus "__signed" in arch-specific
 "types.h" files
Message-ID: <Pine.LNX.4.64.0610290537290.6187@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.985, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_40 -0.18)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  more annoying, nitpicky pedantry as i continue my tour of the kernel
source.  what is the rationale behind using the gcc keyword alias
"__signed__" in many of the architecture-specific types.h files?

  the general form of many of those files is:

===================
#ifndef __ASSEMBLY__

/*
 * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
 * header files exported to user space
 */

typedef __signed__ char __s8;		<-- see?
typedef unsigned char __u8;

typedef __signed__ short __s16;		<-- here, too, and so on.
typedef unsigned short __u16;
...
#ifdef __KERNEL__
#ifndef __ASSEMBLY__

typedef signed char s8;			<-- but now, things change
typedef unsigned char u8;

typedef signed short s16;
typedef unsigned short u16;
...
===================

  so the keyword alias "__signed__" is used early on in nearly every
types.h file but, if __KERNEL__ is defined, the file falls back to
just using "signed".  (the use of "unsigned" is, of course, consistent
throughout.)

  so, first, what is the rationale behind the use of "__signed__" in
this context?  and is there any reason that most of that content can't
be centralized in a single arch-independent file and simply
#include'd?  for the most part, that general content looks identical
regardless of the architecture.  (in some cases, the files are
*absolutely* identical, such as for arm and arm26, and one would think
that a simple #ifdef or two could handle differing word sizes of the
architecture.)

  however, having said all that, there are some puzzling exceptions to
the above pattern.  asm-ia64/types.h typedefs the second set based on
the *earlier* typedefs:

=============================
...
typedef __signed__ int __s32;
typedef unsigned int __u32;

typedef __signed__ long __s64;
typedef unsigned long __u64;

/*
 * These aren't exported outside the kernel to avoid name space
clashes
 */
# ifdef __KERNEL__

typedef __s8 s8;	<-- like that
typedef __u8 u8;

typedef __s16 s16;
typedef __u16 u16;
...
=============================

  then there's asm-mips/sh/types.h, which *continues* to use
"__signed__" after everyone else switches to merely "signed":

=============================
...
#ifdef __KERNEL__

#define BITS_PER_LONG 32

#ifndef __ASSEMBLY__


typedef __signed__ char s8;	<-- still using that gcc keyword alias
typedef unsigned char u8;

typedef __signed__ short s16;
typedef unsigned short u16;
...
=============================

  and, finally, there's include/asm-mips/types.h, which curiously
introduces "__signed":

=============================
...
#ifdef __KERNEL__

#define BITS_PER_LONG _MIPS_SZLONG

#ifndef __ASSEMBLY__


typedef __signed char s8;	<-- ?????
typedef unsigned char u8;

typedef __signed short s16;
typedef unsigned short u16;
...
=============================

  is there any reason why a lot of this can't be standardized?  it
certainly looks like a lot of unnecessary duplication, interspersed
with puzzling anomalies just to keep life interesting.  :-)

rday
