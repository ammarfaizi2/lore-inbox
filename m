Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbUJYHUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUJYHUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUJYHUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:20:01 -0400
Received: from [211.58.254.17] ([211.58.254.17]:35978 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261671AbUJYHTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:19:05 -0400
Date: Mon, 25 Oct 2004 16:18:59 +0900
From: Tejun Heo <tj@home-tj.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Per-device parameter support (2/16)
Message-ID: <20041025071859.GA20995@home-tj.org>
References: <20041023042421.GC3456@home-tj.org> <1098678539.8098.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098678539.8098.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Rusty.

On Mon, Oct 25, 2004 at 02:28:59PM +1000, Rusty Russell wrote:
> On Sat, 2004-10-23 at 13:24 +0900, Tejun Heo wrote:
> >  dp_02_param_array_bug.diff
> > 
> >  This is the 2nd patch of 16 patches for devparam.
> > 
> >  This patches fixes param_array_set() to not use arr->max as nump
> > argument of param_array.  If arr->max is used as nump and the
> > configuration variable is exported writeable in the syfs, the size of
> > the array will be limited by the smallest number of elements
> > specified.  One side effect is that as the actual number of elements
> > is not recorded anymore when nump is NULL, all elements should be
> > printed when referencing the corresponding sysfs node.  I don't think
> > that will cause any problem.
> 
> I thought of this, but I prefer to see this fixed by another element in
> the struct kernel_param which is used as "num" if nump is NULL.
> Although this creates some bloat, it doesn't truncate as mine does, or
> allow overflows and printing unset values as yours does.

 The problem is that, in devparam, a devparam_def and accordingly any
wrapping argument structure is shared by more than one users (e.g. a
dev paramset_def is used by all devices attached to the particular
driver).  And, making matters complicated, bus and class
paramset_def's can even be accessed concurrently.

 As we need to adjust pointers in wrapping structures to point to
specific fields in each allocated paramsets, wrapping arguments are
copied and fixed up everytime it's used (so the arg_copy_size and
arg_fixups fields in struct device_paramset_def).  i.e. wrapping
arguments are transient.  They can contain extra read-only information
to describe the parameter to the driver-model but cannot contain any
information the other way around.  Consequently, adding num field to
struct param_array wouldn't work for devparam.

> (Printing unset values is usually OK, since before the new parameter
> stuff, there was no way of telling how many elements had been set.  This
> lead authors to use a magic value for "unset".  They no longer need to
> do this, so we might see them start to rely on that).

 I think, for a user who's willing to make use of the number of set
elements, requiring to supply the number field is okay.

-- 
tejun

