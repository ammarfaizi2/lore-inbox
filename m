Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbWJDQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWJDQkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161544AbWJDQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:40:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161250AbWJDQkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:40:36 -0400
Date: Wed, 4 Oct 2006 09:40:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: Reinette Chatre <reinette.chatre@linux.intel.com>,
       linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a
 user buffer
Message-Id: <20061004094029.cdfef098.akpm@osdl.org>
In-Reply-To: <20061004141405.GA22833@tsunami.ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
	<20061003163936.d8e26629.akpm@osdl.org>
	<20061004141405.GA22833@tsunami.ccur.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 10:14:05 -0400
Joe Korty <joe.korty@ccur.com> wrote:

> On Tue, Oct 03, 2006 at 04:39:36PM -0700, Andrew Morton wrote:
> > On Tue, 3 Oct 2006 08:16:27 -0700
> > Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> > 
> > > lib/bitmap.c:bitmap_parse() is a library function that received as
> > > input a  user buffer. This seemed to have originated from the way the
> > > write_proc function of the /proc filesystem operates.
> > > 
> > > This function will be useful for other uses as well;
> > > for example, taking input  for /sysfs instead of /proc,
> > > so it was changed to accept kernel buffers. We have this
> > > use for the Linux UWB project, as part as the upcoming
> > > bandwidth allocator code.
> > > 
> > > Only a few routines used this function and they were changed too.
> > 
> > Fair enough.  But this: [ ... ] is sending us a message ;)
> > 
> > How about adding a new bitmap_parse_user() (and cpumask_parse_user())
> > which does the above?
> 
> 
> I am slightly concerned about using a kmalloc where 'count' is specified
> by userspace.  There might be a DoS attack in here somewhere.....

spose so.  It would allow an unprivileged app to force lots of order-3
allocations, which can make page reclaim do a lot of work.  Still...

> Perhaps we can reverse Andrew's idea: rename the existing bitmap_parse
> to bitmap_parse_user, then make the kernel-buffer version, bitmap_parse,
> be a wrapper around that.
> 

I think we can do a version which omits the kmalloc altogether:


/*
 * insert suitable comment here
 */
int bitmap_parse_kernel(const char *ubuf, unsigned int ubuflen,
        unsigned long *maskp, int nmaskbits)
{
	int c, old_c, totaldigits, ndigits, nchunks, nbits;
	u32 chunk;

	bitmap_zero(maskp, nmaskbits);

	nchunks = nbits = totaldigits = c = 0;
	do {
		chunk = ndigits = 0;

		/* Get the next chunk of the bitmap */
		while (ubuflen) {
			old_c = c;
			if (__get_user(c, ubuf++))
				return -EFAULT;

(Note the s/get_user/__get_user/)

int bitmap_parse_user(const char __user *ubuf, unsigned int ubuflen,
        unsigned long *maskp, int nmaskbits)
{
	if (!access_ok(VERIFY_READ, ubuf, ubuflen))
		return -EFAULT;
	return bitmap_parse_kernel((const char *)ubuf, ubuflen,
					maskp, nmaskbits);
}

(Does typecasting a __user char * to a char * make sparse happy?)
