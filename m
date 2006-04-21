Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWDUUad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWDUUad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWDUUad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:30:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:22461 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751352AbWDUUac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:30:32 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kfree(NULL)
User-Agent: KMail/1.8.3
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com> <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr> <20060421192217.GI19754@stusta.de>
In-Reply-To: <20060421192217.GI19754@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Date: Fri, 21 Apr 2006 13:30:30 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604211330.30657.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 12:22, you wrote:
> On Fri, Apr 21, 2006 at 05:07:45PM +0200, Jan Engelhardt wrote:
> > >> Maybe kfree should really be a wrapper around __kfree which does the
> > >> real work.  Then kfree could be a inlined function or a #define that
> > >> does the NULL pointer check.
> > >
> > >NULL pointer check in kfree saves lot of small code fragments in
> > > callers. It is one of many reasons why kfree does it.
> > >Making kfree inline wrapper eliminates this save.
> >
> > How about
> >
> > slab.h:
> > #ifndef CONFIG_OPTIMIZING_FOR_SIZE
> > static inline void kfree(const void *p) {
> >     if(p != NULL)
> >         __kfree(p);
> > }
> > #else
> > extern void kfree(const void *);
> > #endif
> >
> > slab.c:
> > #ifdef CONFIG_OPTIMIZING_FOR_SIZE
> > void kfree(const void *p) {
> >     if(p != NUILL)
> >         _kfree(p);
> > }
> > #endif
> >
> > That way, you get your time saving with -O2 and your space saving with
> > -Os.
>
> What makes you confident that the static inline version gives a time
> saving?

A static inline wrapper would mean that it wouldn't have to make a function 
call just to check if the pointer is NULL.  A simple NULL check is faster 
than a function call and then a simple NULL check.  In other words, there 
would be no pushing and popping the stack.  In almost all cases, replacing an 
inline function with a non-inline function means a trade-off between speed 
and size.

--Vernon
