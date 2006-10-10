Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWJJMNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWJJMNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWJJMNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:13:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:34754 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965135AbWJJMNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:13:08 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Tue, 10 Oct 2006 14:12:57 +0200
User-Agent: KMail/1.9.4
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <200610091847.05441.arnd.bergmann@de.ibm.com> <1160466933.7920.25.camel@pmac.infradead.org>
In-Reply-To: <1160466933.7920.25.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101413.00952.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 09:55, David Woodhouse wrote:
> On Mon, 2006-10-09 at 18:47 +0200, Arnd Bergmann wrote:
> > That has the potential of breaking other source files that don't expect
> > linux/types.h to bring in the whole stdint.h file.
> 
> I don't think we need to care about those. Userspace in _general_
> shouldn't be including our header files -- this is only for low-level
> system stuff, and that can be expected to deal with the fact that we
> define and use some standard C types from last century.

Some of our headers are traditionally included by libc headers.
E.g. sys/stat.h might include asm/stat.h, but must not include
stdint.h.

It's somewhat different for file that are completely outside
of the scope of posix, e.g. <mtd/*.h>, that don't give any
guarantees about what they include.

> > Also, it may break some other linux header files that include <linux/types.h>
> > and expect to get stuff like uid_t, which you don't get if a glibc header is
> > included first, because of __KERNEL_STRICT_NAMES.
> 
> We have that problem already, don't we?

It would get worse.

An application can now do

#include <linux/types.h>
#include <linux/signal.h>
#include <stdint.h>

but not

#include <stdint.h>
#include <linux/types.h>
#include <linux/signal.h>

If <linux/types.h> includes <stdint.h> itself, the first examples breaks
as well.

I'd prefer to clean up all of our headers so they work with
__KERNEL_STRICT_NAMES and in any order, but that's a lot of work and in
the meantime we should make sure we don't make matters worse.

	Arnd <><
