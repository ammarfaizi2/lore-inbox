Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbUJ1HYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbUJ1HYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUJ1HYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:24:23 -0400
Received: from ozlabs.org ([203.10.76.45]:28141 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262837AbUJ1HX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:23:57 -0400
Subject: Re: Per-device parameter new interface and issues to be resolved
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20041027063204.GA11887@home-tj.org>
References: <20041027063204.GA11887@home-tj.org>
Content-Type: text/plain
Date: Thu, 28 Oct 2004 16:32:27 +1000
Message-Id: <1098945148.9349.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 15:32 +0900, Tejun Heo wrote: 
>  4. sysfs directory "params" renamed to "parameters"

Probably a good idea, but I'm reluctant to endorse userspace-visible
breakage.  We've already done that once 8)

>  2. module_param_*_ranged() stuff
> 
>  I've looked at a number of places where module param is used, and
> most parameters need range checking.  Only a few parameters actually
> accept full range of the designated type.  For example, maxbatch in
> kernel/rcupdate.c is currently of type int but values smaller than 1
> doesn't make much sense.  All ports array parameter in
> net/ipv4/netfilter/*.c should be in the range of 0-65535 and most
> device driver parameters need range-checking too.  I think
> incorporating range into moduleparam can reduce duplicate codes and
> improve consistency regarding handling of out-of-range parameters.
> 
>  Yes, the number of functions in module/devparam is increased but
> they're straightforward and it's not like actual code is bloated.

Well, netfilter ports should be a u16, so it's naturally contrained
(although 0 would be very unusual).  If max_batch were unsigned, rcu
would be fixed too (although we have 0 again as the odd case).

I don't really want the churn of making them all take range args
and adding "#define PARAM_NO_RANGE 0, -1".  Perhaps doubling the number
of macros is the right approach.

>  3. In array parameters, discarding the number of set array elements
> instead of using param_array's max field to store it when nump isn't
> supplied.
> 
>  I think that it's fair and clear to require the user to supply nump
> field to param_array() when the number of set array element matters
> either to the driver or the user space reading the value off sysfs
> node.

Fortunately sprintf("%s") handles NULL, which was my main concern, so
this is OK IMHO.

I think my bigger question is: is this going in the right direction?
Should we instead be doing something like eg. "block/hda/dev=3:0", and
trying to connect the pipes so the driver's sysfs entries are
initialized by the parameter parsing code?

Should we be using module parameters to control device settings at all?

I don't know the answers here, but I share your discomfort over the
current module parameter <-> device parameter mapping.

(Hoping Greg KH will have an opinion here...)

Thanks!
Rusty.
-- 

