Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVAXShM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVAXShM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVAXShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:37:12 -0500
Received: from fmr17.intel.com ([134.134.136.16]:16512 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261560AbVAXShB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:37:01 -0500
Date: Mon, 24 Jan 2005 10:37:00 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: Greg KH <greg@kroah.com>
cc: "Williams, Mitch A" <mitch.a.williams@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer writes to sysfs
In-Reply-To: <20050122080930.GB6999@kroah.com>
Message-ID: <Pine.CYG.4.58.0501241016430.3748@mawilli1-desk2.amr.corp.intel.com>
References: <Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com>
 <20050122080930.GB6999@kroah.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Jan 2005, Greg KH wrote:

>
> On Fri, Jan 21, 2005 at 02:52:29PM -0800, Mitch Williams wrote:
> > This patch buffers writes to sysfs files and flushes them to the
> kobject
> > owner when the file is closed.
>
> Why?  This breaks the way things work today, right?
>
> What is this patch trying to fix?
>

To be honest, I'm a bit ambivalent about this patch.  I wrote this code in
response to a bug filed by our test lab.  If you write a bunch (e.g. > 1K)
of data to a sysfs file, the c library splits it up into multiple writes
of 1K or less.  Because the kobject store method doesn't support offsets,
and because the call to copy_from_user doesn't honor offsets, you end up
with multiple calls to the store method, with incorrect results and no
error code.

Thus, this patch, which coalesces all writes to the file (up to PAGE_SIZE)
into one write.

To the typical user, there's really no difference in behavior, unless you
are writing a ton of data into the file.  Of course, there's the obvious
question of why you'd want to do so...

If you don't like this patch, I would say that there are a couple of
alternatives:

First, we could fix the call to copy_from_user to honor offsets and allow
multiple writes of the same data to sysfs.  In other words, writing a long
block of data to a sysfs file would result in multiple calls to the store
method, each one containing more data in the buffer.  Thus, the first 1K
of data may be processed up to 4 times if the data fills the buffer.

Second, we could just have sysfs_write_file return an error anytime *ppos
is nonzero.  It's quick and dirty but at least the caller would get some
sort of error.

The patch as presented has the disadvantage of hiding possible error codes
from the store method util the file is closed, but has the advantage of
allowing > 1K writes with only a single call to the store method.  Would
it make a difference in the real world?  I don't know, but I know it'll
make our test lab guys happy.



> > +      * Otherwise, return success.
> > +      */
> > +     return (ret < 0 ? ret : 0);
>
> I think this comment is not needed.  Actually, what's wrong with just:
>         return ret;
In this case, ret could contain a positive result.  Since a lot of
user-space apps just look for a nonzero result from close(), it seemed
safer to suppres positive return codes in the case of success.

Thanks for your patience with this set of patches.

-Mitch
