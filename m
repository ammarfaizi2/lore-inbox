Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWEPM7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWEPM7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWEPM7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:59:18 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:40582
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751025AbWEPM7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:59:17 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2/9] Add new generic HW RNG core
Date: Tue, 16 May 2006 14:56:44 +0200
User-Agent: KMail/1.9.1
References: <20060515145243.905923000@bu3sch.de> <20060515145316.089681000@bu3sch.de> <20060515150202.0835232d.akpm@osdl.org>
In-Reply-To: <20060515150202.0835232d.akpm@osdl.org>
Cc: dsaxena@plexity.net, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, vsu@altlinux.ru
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161456.45279.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will send patches for the following stuff, on top
of your current -mm, which has my previous patches applied.

On Tuesday 16 May 2006 00:02, you wrote:
> Michael Buesch <mb@bu3sch.de> wrote:
> > +static inline
> > +int hwrng_init(struct hwrng *rng)
> > +static inline
> > +void hwrng_cleanup(struct hwrng *rng)
> > +static inline
> > +int hwrng_data_present(struct hwrng *rng)
> > +static inline
> > +int hwrng_data_read(struct hwrng *rng, u32 *data)
> 
> Lose the newlines, please.

No problem.

> What's going on with the need_resched() tricks in there?  (Unobvious, needs
> a comment).  From my reading, it'll cause a caller to this function to hang
> for arbitrary periods of time if something if causing heavy scheduling
> pressure.

Yeah, it was like this in the old RNG driver. I would also like to
drop it, as I don't see a real advantage from it. But I don't
like to drop the hwrng_data_present() polling bit of it, because...

> What's the polling of hwrng_data_present() doing in here?  (Unobvious,
> needs a comment).

Some HW RNG might require some time between data_reads to gather
new entropy. The short polling here makes sure we don't return too
early from the syscall. So it reduces syscall overhead. Imagine a
device which needs 20usecs between reads to gather new entropy.
The first read will succeed and probably only return one byte of
entropy. The next attempt to data_present in the while loop will
fail and the syscall will return with one byte read. userspace will
need to call the syscall for every byte (in this case).

We could, of course, add a variable to struct hwrng that indicates the
average needed time a device needs to gather new entropy in most cases.
So we could poll for this time instead of the rather random 200usecs. 

> > +static ssize_t hwrng_attr_current_store(struct class_device *class,
> > +					const char *buf, size_t len)
> > +{
> > +	int err;
> > +	struct hwrng *rng;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> 
> Are the sysfs permissions not adequate?

Will drop this.

> > +MODULE_AUTHOR("The Linux Kernel team");
> 
> Mutter.  Might as well remove this.

Sure. Leftover from the old driver.

> A MAINTAINERS record would be nice.

Yes, sir.

