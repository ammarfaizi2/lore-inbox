Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUJOQh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUJOQh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUJOQg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:36:58 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:24865 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268175AbUJOQfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:35:51 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PyG/Gp8CQo+81ZMQhi9RQUcjZUgUCuG0VSr+Q4P9I/4B6cxvWI1bnDtWR+m5pf9KxsPBdBI2HCGsh1TCsKjlHiN0hl2Fa+tcxZC6id5lg9MDbtnxz+++qfF0R7zGJRZVVR2Z2mLUM1N0jPubeCr092zTPBKWkIKHlkKZZnWKJKk
Message-ID: <c461c0d10410150935408afd96@mail.gmail.com>
Date: Fri, 15 Oct 2004 17:35:50 +0100
From: Alex Kiernan <alex.kiernan@gmail.com>
Reply-To: Alex Kiernan <alex.kiernan@gmail.com>
To: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, viro@zenii.linux.org.uk
In-Reply-To: <20041013134350.GA23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <c461c0d10410130406714fafe3@mail.gmail.com>
	 <c461c0d104101305103792ad7a@mail.gmail.com>
	 <20041013134350.GA23987@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 14:43:51 +0100,
viro@parcelfarce.linux.theplanet.co.uk
<viro@parcelfarce.linux.theplanet.co.uk> wrote:
> On Wed, Oct 13, 2004 at 01:10:10PM +0100, Alex Kiernan wrote:
> 
> 
> > On Wed, 13 Oct 2004 12:06:29 +0100, Alex Kiernan <alex.kiernan@gmail.com> wrote:
> > > I've run into a bug in the UFS reading code (on Solaris x86 the
> > > major/minor numbers are in 2nd indirect offset not the first), so I've
> > > patched it & bugzilled it
> > > (http://bugzilla.kernel.org/show_bug.cgi?id=3475).
> > >
> > > But where do I go from here? There doesn't seem to be a maintainer for
> > > UFS so I can't send it there.
> > >
> >
> > After advice from Alan (thanks), here's the patch which addresses the
> > problem I'm seeing. Specifically it appears that on x86 Solaris stores
> > the major/minor device numbers in the 2nd indirect block, not the
> > first.
> 
> 1) please, move old_encode_dev()/old_decode_dev() into your helper functions.

Will do.

> 2) we could do a bit better now that we have large dev_t.  What are complete
> rules for
>         a) Solaris userland dev_t => on-disk data
>         b) major/minor => Solaris userland dev_t
> on sparc and x86 Solaris?
> 

Assuming I've followed it right...

The kernel dev_t has 14 major device bits, 18 minor device bits (with
the major as the most significant bits).

On disk there are 32 bits stored in host byte order, the device is in
the [0] indirect offset on Sparc, [1] on x86.

Looking at an individual entry, if the top 16 bits are clear or
0xffff, then the bottom 16 bits are the device number, with 7 bits of
major (most significant), 8 bits of minor (and the most significant
bit unused). If the top 16 bits are some other pattern, the on disk
mapping is the same as the kernel mapping.

-- 
Alex Kiernan
