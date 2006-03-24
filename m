Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWCXWdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWCXWdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWCXWdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:33:39 -0500
Received: from mx.pathscale.com ([64.160.42.68]:63439 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751510AbWCXWdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:33:38 -0500
Subject: Re: [openib-general] Re: [PATCH 0 of 18] ipath driver - for
	inclusion in 2.6.17
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <adaveu3pml7.fsf@cisco.com>
References: <patchbomb.1143175292@eng-12.pathscale.com>
	 <ada4q1nr7pu.fsf@cisco.com>
	 <1143227515.30626.43.camel@serpentine.pathscale.com>
	 <adaveu3pml7.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 24 Mar 2006 14:33:37 -0800
Message-Id: <1143239617.30626.83.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 13:19 -0800, Roland Dreier wrote:

> Having #ifdef CONFIG_NET all over is definitely suboptimal.
> Unfortunately it looks kind of hard to untangle your skb use from the
> rest of the driver, so putting a dependency on NET might be the best bet.

I don't think it will be that bad, actually.  I'll see how it works to
just move skb-based code into a single source file and build it iff
CONFIG_NET.

> How are you building on powerpc?

I have a hack that lets me compile-test, which I used to make sure I was
getting sparse annotations and header inclusions into decent shape.

> Anyway building an ia64 cross toolchain is easy with http://kegel.com/crosstool

I'll take a look.

> I would just get rid of your atomic_clear_mask() and atomic_set_mask()
> calls.  They're bogus because you're not even operating on an
> atomic_t, and not many architectures implement them.

They're not obviously defined to operate on atomic_t objects, but what
you say makes sense.  I guess that's a peril of using macros for that
stuff.

>     Bryan> I've been building with C=1 for months.  I'll see if I can
>     Bryan> figure out why you're getting such different results.
> 
> It's probably because I use CF=-D__CHECK_ENDIAN__ too.

Ah.

> The whole duplicated SMA / ipath_verbs doesn't work without ib_mad loaded.

There is no duplicated SMA code.  There are two routines in ipathfs that
handle nodeinfo and portinfo structures, but they're for passing them to
userspace; they don't even really resemble the code in ipath_mad.c.

Regarding "ipath_verbs doesn't work without ib_mad loaded", I don't know
that there's a problem there any more.  We took out the use of
ib_register_mad_agent to create an automatic dependency that depmod
would find, and we're just recommending mangling modprobe.conf instead
for now.

>  - Andrew raised some questions about the special "pick a device for
>    me" that I'm not sure we satisfied him on.

That's possible.  Andrew, what's your opinion on that?

> It looks like ipath_copy.c is completely unused now that you're not
> including the ipath_ether driver.

That's true; sorry about that.  Do you want me to send you a patch that
drops it and pulls it out of headers and kbuild stuff?

	<b

