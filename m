Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUFJMdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUFJMdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 08:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUFJMdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 08:33:52 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:46541 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261184AbUFJMdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 08:33:49 -0400
Date: Thu, 10 Jun 2004 13:32:35 +0100
From: Dave Jones <davej@redhat.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, arjanv@redhat.com,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
Message-ID: <20040610123235.GA28923@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>, arjanv@redhat.com,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
	tiwai@suse.de
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi> <20040609113455.U22989@build.pdx.osdl.net> <1086812001.13026.63.camel@cherry> <1086812486.2810.21.camel@laptop.fenrus.com> <1086814663.13026.70.camel@cherry> <Pine.LNX.4.58.0406092133300.19296@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406092133300.19296@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 10:08:34PM -0700, dean gaudet wrote:

 > > +void *kcalloc(size_t n, size_t size, int flags)
 > > +{
 > > +	if (n != 0 && size > INT_MAX / n)
 > > +		return NULL;
 > 
 > division isn't very efficient :)  it's typically a 40+ cycle operation.
 >
 > there's almost certainly more efficient ways to do this with per-target
 > assembly... but you should probably just crib the code from glibc which
 > avoids division for small allocations:
 > 
 >   /* size_t is unsigned so the behavior on overflow is defined.  */
 >   bytes = n * elem_size;
 > #define HALF_INTERNAL_SIZE_T \
 >   (((INTERNAL_SIZE_T) 1) << (8 * sizeof (INTERNAL_SIZE_T) / 2))
 >   if (__builtin_expect ((n | elem_size) >= HALF_INTERNAL_SIZE_T, 0)) {
 >     if (elem_size != 0 && bytes / elem_size != n) {
 >       MALLOC_FAILURE_ACTION;
 >       return 0;
 >     }
 >   }

Considering this isn't exactly a cycle-critical piece of code,
I'd choose readability over saving 40 cycles which is probably
lost in the noise of every other operation we do in that allocation.

		Dave

