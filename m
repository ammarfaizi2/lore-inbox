Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUFJFIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUFJFIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 01:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUFJFIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 01:08:37 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:34524 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S266117AbUFJFIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 01:08:35 -0400
Date: Wed, 9 Jun 2004 22:08:34 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: arjanv@redhat.com, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
In-Reply-To: <1086814663.13026.70.camel@cherry>
Message-ID: <Pine.LNX.4.58.0406092133300.19296@twinlark.arctic.org>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi> 
 <20040609113455.U22989@build.pdx.osdl.net>  <1086812001.13026.63.camel@cherry>
  <1086812486.2810.21.camel@laptop.fenrus.com> <1086814663.13026.70.camel@cherry>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, Pekka Enberg wrote:

> +void *kcalloc(size_t n, size_t size, int flags)
> +{
> +	if (n != 0 && size > INT_MAX / n)
> +		return NULL;

division isn't very efficient :)  it's typically a 40+ cycle operation.

there's almost certainly more efficient ways to do this with per-target
assembly... but you should probably just crib the code from glibc which
avoids division for small allocations:

  /* size_t is unsigned so the behavior on overflow is defined.  */
  bytes = n * elem_size;
#define HALF_INTERNAL_SIZE_T \
  (((INTERNAL_SIZE_T) 1) << (8 * sizeof (INTERNAL_SIZE_T) / 2))
  if (__builtin_expect ((n | elem_size) >= HALF_INTERNAL_SIZE_T, 0)) {
    if (elem_size != 0 && bytes / elem_size != n) {
      MALLOC_FAILURE_ACTION;
      return 0;
    }
  }

-dean
