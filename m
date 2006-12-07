Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031684AbWLGGUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031684AbWLGGUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 01:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031686AbWLGGUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 01:20:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:31179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031679AbWLGGUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 01:20:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OlQGDarE8W/GZ2Ggjb4AhaB+mgzOB2EMkPxU4ugmHOgGcPhjxM2GxNHBdb4hubm0ExeLWAK7VWL+vUuW0EiaRqkSTuBdcUnMW3HwyQcj3a6g3OSfeXOtOz2mz5f5yMcz92jy7D4lBO9sVVl8iwPyp38VL8pxXg/7fKvgCJdva18=
Message-ID: <f383264b0612062220j283f0ad6u5be9db6ac79dbbe9@mail.gmail.com>
Date: Wed, 6 Dec 2006 22:20:22 -0800
From: "Matt Reimer" <mattjreimer@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061206.164616.74731030.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
	 <20061205.165948.98864221.davem@davemloft.net>
	 <f383264b0612061319k16809e35tb04d04fa16f976b1@mail.gmail.com>
	 <20061206.164616.74731030.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, David Miller <davem@davemloft.net> wrote:
> From: "Matt Reimer" <mattjreimer@gmail.com>
> Date: Wed, 6 Dec 2006 13:19:41 -0800
>
> > On 12/5/06, David Miller <davem@davemloft.net> wrote:
> > > From: "Matt Reimer" <mattjreimer@gmail.com>
> > > Date: Tue, 5 Dec 2006 16:57:12 -0800
> > >
> > > > Right, but isn't he declaring that each architecture needs to take
> > > > care of this? So, say, on ARM we'd need to make kunmap() not a NOP and
> > > > call flush_dcache_page() ?
> > >
> > > No.  He is only solving a problem that occurs on HIGHMEM
> > > configurations on systems which can have D-cache aliasing
> > > issues.
> >
> > Are you sure? James specifically mentions "non-highmem architectures,"
> > and "all architectures with coherence issues," which would seem to
> > include ARM (which is my concern).
> >
> > For your convenience I quote the whole commit message below.
>
> Ok, I see.
>
> He's providing it an alternative way to solve the coherency
> issues.
>
> You can still solve it the traditional way via cache flushing
> in flush_dcache_page() and {copy,clear}_user_page().

Ok, good to know, since that's what we're doing with ARM drivers
presently. What's the preferred method going forward?

If architectures with coherency problems have to take care of this in
their kmap() implementations, wouldn't commits like [1] below result
in a pessmization for these architectures, since effectively the flush
would happen twice (once by architecture-specific kunmap, and once by
the flush_dcache_page() being added in this commit)?

Matt

[1] http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c4ec7b0de4bc18ccb4380de638550984d9a65c25
