Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVAYXmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVAYXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVAYXlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:41:35 -0500
Received: from fmr19.intel.com ([134.134.136.18]:58803 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262182AbVAYXjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:39:02 -0500
Date: Tue, 25 Jan 2005 15:39:00 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: Greg KH <greg@kroah.com>
cc: "Williams, Mitch A" <mitch.a.williams@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer writes to sysfs
In-Reply-To: <20050124213906.GE18933@kroah.com>
Message-ID: <Pine.CYG.4.58.0501251519390.2388@mawilli1-desk2.amr.corp.intel.com>
References: <Pine.CYG.4.58.0501211449410.3364@mawilli1-desk2.amr.corp.intel.com>
 <20050122080930.GB6999@kroah.com> <Pine.CYG.4.58.0501241016430.3748@mawilli1-desk2.amr.corp.intel.com>
 <20050124213906.GE18933@kroah.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jan 2005, Greg KH wrote:
>
> Who is trying to send > 1K to a sysfs file?  Remember, sysfs files are
> for 1 value only.  If you consider > 1K a "single value" please point me
> to that part of the kernel that does that.
>
> > To the typical user, there's really no difference in behavior, unless
> you
> > are writing a ton of data into the file.  Of course, there's the
> obvious
> > question of why you'd want to do so...
>
> Exactly, you should not be doing that anyway.  So, because of that, I
> really don't want/like this patch.


OK, I've had a day to think about this, and I think I have a good answer
now.

Leaving aside the issue of how big a 'single object' is, we still have to
consider the possibility that a user _will_ indeed someday try to write 4K
(or more) to a sysfs file.  It's just going to happen.  And right now, the
kernel's behavior in that event is unpredictable, because we don't know
how the c library is going to buffer this write.

Right now, on my FC3 box, writing a large amount of data to a sysfs file
results in multiple writes of 1K to the file.  What my store method sees
then is multiple calls, each with 1K of data.  Each time, I have to assume
what I see is the complete contents of the write, and I have to process it
as such.

So if my sysfs file contains FOO, and the user writes BAR followed by 3k
of garbage, I'm not going to end up with FOO, or even BAR, but I'll end up
with whatever garbage I see at the beginning of the third 1K write.

The real problem is not that I get wrong values -- my store method should
handle this -- but that there are no errors returned from this operation.
The only way the user can tell that something is wrong is if a) I write a
message to the log telling what I did in my store method, and b) the user
checks the log.

My original write buffering patch fixes this problem, and allows up to 4K
to be consolidated into a single call to the store method.  It doesn't
seem to affect normal operation of my test system (nor those in our test
lab), but does hide error code returns from store methods.  And I can see
why you would be disinclined to accept such a patch.

While we may want to consider the possibility that a 'single object' may
someday grow large (crypto key maybe?), I can live without write buffering
right now.

But at the very least, we still need to handle this failure case.   I've
tested the following patch and it does resolve the issue.  However, it now
limits the size of sysfs writes to the size of the c library's buffer.

--------------------

This patch returns an error code if the user trys to write data to a sysfs
file at any offset other than 0.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>

diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-25 10:47:15.000000000 -0800
@@ -232,6 +232,8 @@ sysfs_write_file(struct file *file, cons
 {
 	struct sysfs_buffer * buffer = file->private_data;

+        if (*ppos > 0)
+            return -EIO;
 	down(&buffer->sem);
 	count = fill_write_buffer(buffer,buf,count);
 	if (count > 0)
