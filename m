Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWABMcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWABMcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWABMcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:32:07 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:59635 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750703AbWABMcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:32:06 -0500
Date: Mon, 2 Jan 2006 07:31:24 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Eric Dumazet <dada1@cosmosbay.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Andreas Kleen <ak@suse.de>, Matt Mackall <mpm@selenic.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on
 x86_64 machines ?
In-Reply-To: <84144f020601020046t3176cde2k7d9ec900cafd6d2f@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0601020724120.9621@gandalf.stny.rr.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>  <43A91C57.20102@cosmosbay.com>
 <200512281032.15460.vda@ilport.com.ua>  <200512281054.26703.vda@ilport.com.ua>
  <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> 
 <20051228210124.GB1639@waste.org> <20051229012616.GA3286@redhat.com> 
 <1135915609.6039.39.camel@localhost.localdomain>
 <84144f020601020046t3176cde2k7d9ec900cafd6d2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006, Pekka Enberg wrote:

> Hi,
>
> On 12/30/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Attached is a variant that was refreshed against 2.6.15-rc7 and fixes
> > the logical bug that your compile error fix made ;)
> >
> > It should be cachep->objsize not csizep->cs_size.
>
> Isn't there any other way to do this patch other than making kzalloc()
> and kstrdup() inline? I would like to see something like this in the
> mainline but making them inline is not acceptable because they
> increase kernel text a lot.

Actually, yes. I was adding to this patch something to be more specific,
and to either pass the EIP through the parameter or a __FILE__, __LINE__.

Using the following:

#ifdef CONFIG_KMALLOC_ACCOUNTING
# define __EIP__ , __builtin_return_address(0)
# define __DECLARE_EIP__ , void *eip
#else
# define __EIP__
# define __DECLARE_EIP__
#endif

#define kstrdup(s,g) __kstrdup(s, g __EIP__)
extern char *__kstrdup(const char *s, gfp_t g __DECLARE_EIP__);


Or a file line can be used:

# define __EIP__ , __FILE__, __LINE__
# define __DECLARE_EIP__ , char *file, int line



-- Steve


