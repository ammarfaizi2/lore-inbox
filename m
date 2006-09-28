Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWI1TUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWI1TUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWI1TUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:20:23 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:55626 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751435AbWI1TUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:20:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RzCs6T24WGX33Zz2Aw1guUlCAYvA5eIgtWC+v6NdXm9U0KmeElwTTWCtEGfQApMKtWuP7RgdiWcy2sn0Tw3GKDETsXEikTBzg+qTYert2isPzQyOa657p4MG2j4baehyB09QuVUF/Y2DesE9qHZvpElVPIbiQZ1OgWtKoNaRYQ8=
Message-ID: <653402b90609281220s449ed538k41043348f4b11e77@mail.gmail.com>
Date: Thu, 28 Sep 2006 21:20:22 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2.6.18 real-V5] drivers: add lcd display support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060927154208.149069e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060922220346.69f63338.maxextreme@gmail.com>
	 <20060926120821.e11f3254.akpm@osdl.org>
	 <653402b90609271358m58950e96k99b2314f9732b5ef@mail.gmail.com>
	 <20060927154208.149069e3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 27 Sep 2006 20:58:24 +0000
> "Miguel Ojeda" <maxextreme@gmail.com> wrote:
>
> > On 9/26/06, Andrew Morton <akpm@osdl.org> wrote:
> > > It's also probably-incorrect on big-endian CPUs.
> > > Perhaps you should not
> > > use bitops at all for this driver, use open-coded |
> > > and &/~ instead?
> >
> > Uhm, someone told me that they shouldn't be used because the kernel
> > has generic functions for that.
>
> You can't believe everything you read on the internet ;)
>
> set_bit() and friends are a) atomic wrt other CPUs on SMP and b) only to be
> performed on unsigned longs.
>
> > I researched the kernel sources, and looking at bitops.h I found
> > setbit(), so I tried to use it in the driver, althought I prefer
> > standard |= and &=.
>
> Those are the appropriate operations to use in this driver.
>
>

Ok, I have fixed all the mistakes you found. However, I have a
question about locking.

I have used 1 global mutex for all the fops: seek, write and ioctl.
They call down_interruptable() at the very beggining and up() just
before returning. I think that it's right.

However, what about the exported symbols? I have exported functions at
the ks0108 driver like EXPORT_SYMBOL_GPL(ks0108_writedata); The
cfag12864b drivers exports more symbols also, like:
EXPORT_SYMBOL_GPL(cfag12864b_write);

Should use the mutex all this functions too?

For example: Another driver can have a fops which isn't perform any
kind of locking. Such function is being executed twice at the same
time. And it calls some of my exported symbols. Then, I will have a
race condition in my driver.

(I couldn't find anything specific about that at LDD3, just for fops).

Thanks,
     Miguel Ojeda
