Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVIUSqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVIUSqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVIUSqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:46:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750794AbVIUSqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:46:20 -0400
Date: Wed, 21 Sep 2005 11:45:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys
Message-Id: <20050921114533.76815f03.akpm@osdl.org>
In-Reply-To: <5543.1127327394@warthog.cambridge.redhat.com>
References: <20050921101558.7ad7e7d7.akpm@osdl.org>
	<5378.1127211442@warthog.cambridge.redhat.com>
	<12434.1127314090@warthog.cambridge.redhat.com>
	<5543.1127327394@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > The above bit needs to be captured in a code comment.  Because:
> 
> Okay.
> 
> > Is hair-raising and makes people want to come after you with a stick ;)
> 
> If people get upset by this sort of thing, they shouldn't be doing kernel
> development.

hrmph.  Of course it's a reasonable trick from a performance and
convenience and resource consumption POV.  But it's a new idiom and the
threshold for new idioms is non-zero.  We use it in struct page, but struct
page is special.

It does need really obvious commenting.  Pity the poor person who spends
ten miniutes trying to find the definition of struct key_ref.

> ...
> > > +			if (PTR_ERR(key_ref) != -EAGAIN) {
> > > +				if (IS_ERR(key_ref))
> > > +					key = key_deref(key_ref);
> > > +				else
> > > +					key = ERR_PTR(PTR_ERR(key_ref));
> > > +				break;
> > > +			}
> > > +		}
> > 
> > That's getting a bit intimate with how IS_ERR and PTR_ERR are implemented
> > but I guess we're unlikely to change that.
> 
> You're referring to the ordering of the first two lines? I could, and probably
> should, reorder them.

Yup.  Logically we shouldn't use PTR_ERR unless IS_ERR is known to be true.
Yes, it works and yes, it'll surely continue to work.  But.

> It's also wrong: there should be a ! before the IS_ERR.
> 
> I've changed this to:
> 
> 			if (!IS_ERR(key_ref)) {
> 				key = key_deref(key_ref);
> 				break;
> 			}
> 
> 			if (PTR_ERR(key_ref) != -EAGAIN) {
> 				key = ERR_PTR(PTR_ERR(key_ref));
> 				break;
> 			}

OK.

> > This all seems quite inappropriate to -rc2?
> 
> Which -rc2? If it's 2.6.14-rc2 you're referring to, then yes - that's already
> released.

It doesn't fix any bugs (does it?).  Hence according to the shiny new rules
this work is 2.6.15 material.
