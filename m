Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVKDOAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVKDOAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 09:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVKDOAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 09:00:42 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:19579 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750862AbVKDOAm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 09:00:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=inKgOtCdnJXsRletcVzYR6Rxp4Nnk6O59S5g4PLDObkjkhbedhSjQ/C6092QEL70nwkHnlkIwRDUxsVLx+n773z6ec8k2hopU7CsCZdXKQA0RLlKp16LeeS+uFKqTjJJjmPON9wzmhGSD1lro1pOq/CUEij59YmUhIyEyRtukJA=
Message-ID: <121a28810511040600k2aa362ecy@mail.gmail.com>
Date: Fri, 4 Nov 2005 15:00:40 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>, vserver@list.linux-vserver.org
Subject: Re: [Vserver] sendfile crash? (2.6.13.4 with vserver 2.1.0-rc4)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051104010715.GC22020@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511030838s118be14fv@mail.gmail.com>
	 <20051103181930.GD18015@MAIL.13thfloor.at>
	 <121a28810511031201q612cdf6dx@mail.gmail.com>
	 <20051104010715.GC22020@MAIL.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

2005/11/4, Herbert Poetzl <herbert@13thfloor.at>:
> On Thu, Nov 03, 2005 at 09:01:14PM +0100, Grzegorz Nosek wrote:
> > 2005/11/3, Herbert Poetzl <herbert@13thfloor.at>:
> > > On Thu, Nov 03, 2005 at 05:38:43PM +0100, Grzegorz Nosek wrote:
> > > > Hello all
> > > >
> > > > I needed to apply the patch below in order to keep the kernel from
> > > > oopsing (in some older revisions) or freezing solid (in the newest,
> > > > listed in the subject.
> > >
> > > as follow up, please try the following patch instead:
> > >
> > > http://lkml.org/lkml/diff/2005/11/3/161/1
> > >
> > > rationale: http://lkml.org/lkml/2005/11/3/161
> > >
> > > HTH,
> > > Herbert
> > >
> > >
> >
> > Hello,
> >
> > I think I disagree that my proposed patch is hiding the real bug
> > because the ppos and max variables aren't ever used in do_sendfile.
> > They're blindly passed to vfs_sendfile, which does the checks and
> > returns -EOVERFLOW if needed.
>
> hmm, good that you disagree ...
>
> > IMHO my patch is more of The Right Way (tm) because it doesn't involve
> > modifications in another function (only do_sendfile is affected, which
> > is modified heavily anyway).
>
> hmm, well, maybe a mix of both approaches is what we
> really want because the following looks 'suspicious'
> to me:
>
> asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd,
>                                 off_t __user *offset, size_t count)
> {
>         ...
>         if (offset) {
>                 ...
>                 pos = off;
>                 ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
>                 ...
>                 return ret;
>         }
>         return do_sendfile(out_fd, in_fd, NULL, count, 0);
> }
>
> because in the case we _have_ an offset specified, we
> pass a pos and limit (MAX_NON_LFS) and if not, we just
> set it to zero?

IMHO the zero here is a bug because we do want the limit to be
MAX_NON_LFS. A null pointer should be acceptable as a parameter but as
we're already passing semi-arbitrary max values, why not make them
consistent.

>
> well, I agree with you that the check in do_sendfile()
> is superfluous ... and that the checks in vfs_sendfile()
> should be sufficient ... haven't checked all cases here

I tried to replicate that check from vfs_sendfile() but it turned out
that while comparing *ppos and max both these values are unknown and
must be checked and computed, which is done in vfs_sendfile so there's
no need to do it again. Also if we caught an error in that check, we'd
screw something up (didn't trace it so I don't know what exactly but
something for sure) by not calling fput_light() near the exit point of
do_sendfile.

On a more optimistic note, this kernel with the sendfile fix survived
the night at load 40 (two vservers running bonnie++, another one with
a looped make -j8 of the kernel and about a dozen of mostly idle
ones). We had to stop the tests in the morning as the machine was
almost impossible to do any work on, but no signs of crashes. As I'm
facing another kernel build soon, are there any known issues with ACPI
on SMP with vservers? (AFAIK ACPI is needed to use HT on Intel CPUs
and I haven't compiled it in yet since I'm not currently using HT
CPUs)

Best regards,
 Grzegorz Nosek

>
> best,
> Herbert
>
> PS: please follow up on lkml, if not done so already ...
>

OK, cc'ed
