Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTBGSdr>; Fri, 7 Feb 2003 13:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTBGSdq>; Fri, 7 Feb 2003 13:33:46 -0500
Received: from fmr03.intel.com ([143.183.121.5]:4818 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id <S266292AbTBGSdq> convert rfc822-to-8bit;
	Fri, 7 Feb 2003 13:33:46 -0500
content-class: urn:content-classes:message
Subject: Re: [PATCH] Restore module support.
Date: Fri, 7 Feb 2003 10:43:19 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <DD755978BA8283409FB0087C39132BD1A07C9E@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH] Restore module support.
Thread-Index: AcLO2NAuGrvFE3wlTHm6j3KoHz8xwQ==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2003 18:43:19.0761 (UTC) FILETIME=[C8D75C10:01C2CED8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (2) has the disadvantage that its touching non-architecture specific
> code, but this is the option I'd prefer due to the obvious performance
> advantage.  However, I'm afraid that it isn't worth the effort to fix
> up vmalloc and /proc/kcore.  vmalloc fix appears simple, but /proc/kcore
> has issues (anyone know what KCORE_BASE is all about?)

KCORE_BASE is my fault ... it was an attempt to fix the "modules
below PAGE_OFFSET" problem for the ia64 port.  For a few nanoseconds
the code just here looked like this:

#if VMALLOC_START < PAGE_OFFSET
#define	KCORE_BASE	VMALLOC_START
#else
#define	KCORE_BASE	PAGE_OFFSET
#endif

Which worked great for ia64, but failed to even compile on i386
(because on i386 VMALLOC_START isn't a simple constant that cpp
can compare against).

Linus kept the bulk of my patch and just replaced the above code with
the "#define	KCORE_BASE	PAGE_OFFSET" that is there today, maybe
in the hope that I'd come back with a workable #ifdef ... but the only
one I've come up with so far is "#ifdef CONFIG_IA64" which can't be
right as ia64 isn't the only architecture with this issue.

There was some discussion on a better way to do this, by adding the
kernel itself to the vmlist, and eliminating all the special case code.
I took a brief look at this, but realised that there were all sorts
of ugly race conditions with /proc/kcore if a module is loaded/unloaded
after some process has read the Elf header.

-Tony Luck

