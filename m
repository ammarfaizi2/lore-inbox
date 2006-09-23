Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWIWNSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWIWNSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 09:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWIWNSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 09:18:36 -0400
Received: from [212.227.126.186] ([212.227.126.186]:4571 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751107AbWIWNSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 09:18:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [patch 1/8] extend make headers_check to detect more problems
Date: Sat, 23 Sep 2006 15:18:15 +0200
User-Agent: KMail/1.9.4
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060918012740.407846000@klappe.arndb.de> <20060918013216.335200000@klappe.arndb.de> <1159009461.24527.920.camel@pmac.infradead.org>
In-Reply-To: <1159009461.24527.920.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231518.16201.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 13:04, David Woodhouse wrote:
> It would be good to fix these problems, it's true -- but bear in mind
> that none of these are actually fatal problems -- they're just caveats
> of (ab)using kernel-private headers in userspace. 
> 
> On the other hand, it would be good to get people used to running
> 'make headers_check' whenever they make a change -- so introducing more
> breakage right now may be counterproductive from that point of view.
> 
> So I think I'd prefer to leave this for now, or at least limit it to
> 'make CHECKMEHARDER=1 headers_check' so that we can wean people onto
> using headers_check slowly and relatively painlessly.

yes, that sounds fair.

> > I found many problems with this, which I then fixed for
> > powerpc, s390 and i386, in subsequent patches.
> 
> Can you -include <linux/types.h> _every_ time, to reduce the number of
> places you have to add '/* @headercheck: -include linux/types.h @ */' ?

The problem with this are a few files which have code like

#ifndef __KERNEL__
#include <sys/types.h>
#include <stdint.h>
#endif

or similar. These break heavily if you include <linux/types.h> before the
the glibc provided headers, because linux/types.h provides some of the
types that are normally defined elsewhere and duplicate typedefs result
in compile errors.

To solve this, we would need to make all headers build fine with
gcc -D__STRICT_KERNEL_NAMES -include linux/types.h.
That is a valueable goal as well, since it avoids a number of problems,
but it is actually a larger change than this.

Now one option we could take would be to always pass -include linux/types.h
to gcc and put /* @headercheck: -D__STRICT_KERNEL_NAMES */ into the few
places that break otherwise.

	Arnd <><
