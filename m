Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVGYVlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVGYVlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVGYVle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:41:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46747 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261500AbVGYVl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:41:27 -0400
Message-ID: <42E55C7E.50301@us.ibm.com>
Date: Mon, 25 Jul 2005 14:41:18 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
CC: lkml <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Subject: Re: topology api confusion
References: <20050722213316.GE17865@otto>
In-Reply-To: <20050722213316.GE17865@otto>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:
> We need some clarity on how asm-generic/topology.h is intended to be
> used.  I suspect that it's supposed to be unconditionally included at
> the end of the architecture's topology.h so that any elements which
> are undefined by the arch have sensible default definitions.  Looking
> at 2.6.13-rc3, this is what ppc64, ia64, and x86_64 currently do,
> however i386 does not (i386 pulls in the generic version only when
> !CONFIG_NUMA).
> 
> The #ifndef guards around each element of the topology api
> cannot serve their apparent intended purpose when the architecture
> implements a given bit as a function instead of a macro
> (e.g. cpu_to_node in ppc64):

When I originally wrote this all up, I had planned it to be used the way
i386 does: offer a full implementation of topology if appropriate, else
include the generic "sane" default.  It has since changed to work more like
you described: implement some (or all) of the topology functions, then
include the generic one to define any you missed.


> Since ppc64 unconditionally includes asm-generic/topology.h, all uses
> of cpu_to_node are preprocessed to (0).  Similar damage occurs with
> every other topology function which happens to be a real function
> instead of a macro.  I'm surprised my ppc64 numa systems even boot ;)
> 
> If the intent is that the architecture is free to define only a subset
> of the api and include the generic header for fallback definitions,
> then we need to do the #ifndef __HAVE_ARCH_FOO thing, no?  That is,
> the code above would look like:

You are correct in noticing that things should (though apparently don't?)
go wonky when arches define their topology functions as *functions*, rather
than macros.  It hasn't really seemed to bite anyone yet, so I've left it
alone, though to be honest, it is as surprising to me that it works as it
is to you.  I've resisted creating #ifdef ARCH_HAVE_XXX all over the place,
though maybe it is finally time?


> Thought I'd ask for input first since this would involve a sweep of
> include/asm-*.

It would indeed...  I'd be more than happy to look at any patches you care
to generate.  As I said, it seems to work, though I'm certain it's all held
together by GCC black magic & voodoo, and probably a little duct-tape.  A
more obviously correct solution would not be a bad thing. :)

-Matt
