Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVI0Ecc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVI0Ecc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 00:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVI0Ecc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 00:32:32 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:53265 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932327AbVI0Ecc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 00:32:32 -0400
Date: Tue, 27 Sep 2005 12:34:28 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <17208.24786.729632.221157@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0509271223440.3079@wombat.indigo.net.au>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
 <17203.7543.949262.883138@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
 <17205.48192.180623.885538@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
 <17208.24786.729632.221157@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-102.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Jeff Moyer wrote:

> ==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Sat, 24 Sep 2005, Jeff Moyer wrote:
> >> >> >> >> >> Ian, I'm not really sure how we can address this issue
> >> without VFS >> >> changes.  Any ideas?
> >> >> >> 
> >> >> 
> raven> I'm aware of this problem.  I'm not sure how to deal with it yet.
> raven> The case above is probably not that difficult to solve but if the
> raven> last component is a directory it's hard to work out it's a problem.
> >> >> Ugh.  If you're thinking what I think you're thinking, that's an ugly
> >> >> hack.
> >> 
> raven> Don't think so.
> >>
> raven> I've been seeing this for a while. I wasn't quite sure of the source
> raven> but, for some reason your report has cleared that up.
> >>
> raven> The problem is not so much the success returned on the failed mount
> raven> (revalidate). It's the return from the following lookup. This is a
> raven> lookup in a non-root directory. I replaced the non-root lookup with
> raven> the root lookup a while ago and I think this is an unexpected side
> raven> affect of that. Becuase of other changes that lead to that decision
> raven> I think that it should be now be OK to put back the null function
> raven> (always return a negative dentry) that was there before I started
> raven> working on the browable maps feature.
> >>
> raven> I'll change the module I use here and test it out for a while.  If
> raven> you have time I could make a patch for the 2.4 code and send it over
> raven> so that you could test it out a bit as well.
> >> Just send along the 2.6 patch, since I have to deal with that, too.
> >> I'll go through the trouble of backporting it.
> 
> raven> I'm in the middle of working on lazy multi-mounts atm so I'm not in
> raven> a good position to test. It's a little tricky so I don't want to
> raven> forget where I'm at by getting side tracked.
> 
> raven> But here's the patch that I will apply to my v5 tree for the initial
> raven> testing. Hopefully you will be able to give it a run in a standard
> raven> setup.
> 
> I put together a different patch, but I want to get your input on the
> approach before I post it.  It requires both user-space and kernel-space
> changes.
> 
> Basically, you identify that a given automount tree is a direct map tree.
> This information is passed along to the kernel (I did this via a mount
> option), and recorded (in the super block info).  Then, when a directory
> lookup occurs, if we are in a direct map tree, and ghosting is enabled,
> then we pass the lookup on to the real lookup code.
> 
> I'm not sold on the approach, as I haven't thought through all of the
> implications.  Care to comment?
> 

Based on your description I'm not sure that this is the simplest approach.

The fundamental problem here is, I think, an incorrect return code from 
lookup. revalidate is called from lookup and it's return code is not 
checked. Even if it was the return is often success even if there is a 
mount failure.

revalidate calls try_to_fill_dentry (I think that's the function name) 
which is responsible for the false return code. Some thought about why it 
returns these would be good to do first. This may well be historic and 
overdue to be updated. If so correcting the return codes and checking 
them in lookup my be a better solution.

I'll have a closer look at the patch and the return code issue tonight.

Thanks for your continued help.

Ian



