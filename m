Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbSJISUJ>; Wed, 9 Oct 2002 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbSJISUJ>; Wed, 9 Oct 2002 14:20:09 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:22687
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261935AbSJISTH>; Wed, 9 Oct 2002 14:19:07 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210091824.g99IOkI18617@www.hockin.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 9 Oct 2002 11:24:46 -0700 (PDT)
Cc: thockin@hockin.org (Tim Hockin),
       schwidefsky@de.ibm.com (Martin Schwidefsky),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210091046170.7355-100000@home.transmeta.com> from "Linus Torvalds" at Oct 09, 2002 10:47:36 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 9 Oct 2002, Tim Hockin wrote:
> > Linus, This is actually something I sent to Martin (and DaveM).  The __UID16
> > crap is because s390x and Sparc64 (and others?) do not want the highuid
> > stuff except in very specific places - namely compat code.  Just using
> > CONFIG_UID16_SYSCALLS has the same bad side-effect as CONFIG_UID16 - all or
> > nothing.  In short, we want to build uid16.o with highuid translations, and
> > a few other compat objects, but not everything.  Ugly.
> 
> So why don't we just split it up into all the sub-options? So that you 
> have a smørgåsbord of real options to select from..
> 
> In other words, that __UID16 thing should be a real CONFIG_XXX option.

Because Sparc64/s390x/? still need to tell highuid.h to do macro magic for
NEW_TO_OLD_UID() and friends in some places and not others.  A CONFIG_XXX
applies all the time to all files.

We can make the few sparc64/s390x sections just redefine the macros they
want in the files in question, if you prefer, but uid16.c is still a user of
highuid.h and needs to define __UID16.  If you prefer, __UID16 can be called
DO_HIGHUID_CONVERSIONS.

#define DO_HIGHUID_CONVERSIONS
#include <linux/uid16.h>

Or have a new uid16.h that unconditionally defines the macros.  Then
highuid.h can include uid16.h IFF CONFIG_UID16, and uid16.c can include
uid16.h.  I see this as MORE problematic, because someone, somewhere will
include uid16.h when they meant highuid.h.  Forcing a non CONFIG_UID16 arch
to explicity call out "I want uid16 macro conversion for THIS FILE" seems
safe.  Ugly, but safe.

