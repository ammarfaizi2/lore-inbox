Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUJYIVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUJYIVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUJYITx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:19:53 -0400
Received: from [211.58.254.17] ([211.58.254.17]:39824 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261726AbUJYHsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:48:31 -0400
Date: Mon, 25 Oct 2004 16:48:27 +0900
From: Tejun Heo <tj@home-tj.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Per-device parameter support (4/16)
Message-ID: <20041025074827.GB20995@home-tj.org>
References: <20041023042550.GE3456@home-tj.org> <1098679520.8098.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098679520.8098.20.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:45:20PM +1000, Rusty Russell wrote:
> On Sat, 2004-10-23 at 13:25 +0900, Tejun Heo wrote:
> >  dp_04_module_param_ranged.diff
> > 
> >  This is the 4th patch of 16 patches for devparam.
> > 
> >  This patch implements module_param_flag() and module_param_invflag().
> > They appear as boolean parameter to the outside, and bitwise OR the
> > specified flag to flags when the specified boolean value is 1 and 0
> > respectively.
> 
> Comment is wrong, of course:

 Yeah, definitely.  Sorry. :-P

> this patch adds range to the kernel_param
> structure.  But I'm not convinced that it's a great idea.  It could be
> added using the same method (kp->arg) used to extend the others instead.
> 
> (Same logic applied to spinlocking param variants).
> 
> It comes down to usage: currently there are few range-needing users, but
> maybe that's because MODULE_PARM didn't support it.  So I would drop
> this or implement it as a wrapper, and later we can add it when it takes
> over the world.  Although I'd probably just add args to
> module_param_call: I like having it as the "base".

 And yes again.  I also thought it would look cleaner to implement
range checking using a wrapping argument.  But my rationales to include
them directly were

 1. Most driver parameters need range-checking.  I haven't seen many
    driver parameters which don't require range-checking.  The range
    values are also useful for non-integer parameters including strings
    and arrays.

 2. If we use separate range structure.  We would either
    - have two different sets (vanilla and ranged) of standard parameter
      set/get functions
    - or, end up using the wrapped version for both. (turning off range
      checking with some special value.)
    And both didn't look very attractive to me.  #1 is just not good
    and #2 seems a bit pointless as we'll always be using the wrapping
    argument for all types of paramters (integer, charp, string, array...).

 So, I folded range into the kernel_param structure.

> The other thing is the min=1 max=0 case: I'd prefer INT_MAX, INT_MIN
> etc. instead I think so there's no special cases.

 The thing is that the min, max values are used for all types
including signed and unsigned types.  min=MIN_MAX, max=INT_MIN will be
interpreted as a valid [INT_MAX, (unsigned)INT_MAX + 1] range for
unsigned int parameters.  So, I had to choose some value which,
regardless of type, maintains their relative relation, so the 1 and 0.
However, I do agree that plain 1, 0 doesn't look very clear.  How
about using something like the following?

#define PARAM_UNRANGED_MIN	1
#define PARAM_UNRANGED_MAX	0

or

#define PARAM_UNRANGED		1, 0

 I think it's better to be a bit feature-rich in module/device
paramter handling because by doing so we can avoid duplicated codes in
many places.

-- 
tejun

