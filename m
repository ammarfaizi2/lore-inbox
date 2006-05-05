Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWEEOEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWEEOEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWEEOEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:04:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16360 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751124AbWEEOEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:04:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1146834740.10109.9.camel@kleikamp.austin.ibm.com> 
References: <1146834740.10109.9.camel@kleikamp.austin.ibm.com>  <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com> <20060504031755.GA28257@hellewell.homeip.net> <20060504033829.GE28613@hellewell.homeip.net> <23457.1146778849@warthog.cambridge.redhat.com> 
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 05 May 2006 15:03:49 +0100
Message-ID: <3439.1146837829@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> > But it may use more stack, which is a much more limited resource, so what
> > you suggest is not necessarily the best thing to do.
> 
> I think either way it's coded, the compiler will probably store the
> result in a register.

There's an apparent function call between the two usages of the value.  So
even if the value is placed in a register, that register must either be saved
on the stack around the function call (if it's callee-clobbered), or the
register must be saved on the stack before the value is placed in it (if it's
callee-saved).

Either way, it will use more stack; the mere fact that whilst it's using the
value, the compiler may stash it in a register is irrelevant.

> I would recommend the most readable approach (which I believe would be using
> a local variable) and leave the optimization to the compiler.

Whilst it may be more readable, it doesn't mean it's more optimal.  You're
just trading stack usage for code size.  The function call in the middle
limits the optimisation the compiler can do.

Of course, if the thing in the middle is not actually a function call, or if
it can be inlined, then this _might_ not apply.  It may even be possible that
the compiler will discard the variable and fetch it again from memory if it
considers the value in memory to be unchanging for the duration.

David
