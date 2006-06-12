Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWFLMx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWFLMx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWFLMx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:53:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:27417 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWFLMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:53:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lNjnTmYYgg3TH6ZTY3o9+MgkQ276lW6577Hcjac4tjyOvxKkw1CAQZnxyqZcOMKwIwgc9qVn8gviSwmsAyM2Lmui2+CSgI5HOge8cvZND4jJq1+Yj3n74Lrlj6iYBGpH+cQVOo5RqL5F/kCsaYsCgY8Iaoa7sUmxLpI6YPqzP4I=
Message-ID: <b0943d9e0606120553v7bcb1678p9f45fc4097b7ebe7@mail.gmail.com>
Date: Mon, 12 Jun 2006 13:53:56 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI>
	 <20060612113637.GA14136@elte.hu>
	 <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > > I found at least two unacceptable false positive classes:
> > >
> > >   - arch/i386/kernel/setup.c:
> > >     False positive because res pointer is stored in a global instance of
> > >     struct resource.
> >
> > there's no good way around this one but to annotate it in one way or
> > another.
>
> Scanning bss and data sections is too expensive, I guess.  I would prefer
> we create a separate section for gc roots but what you're suggesting is
> ok as well.

Data and BSS sections are scanned, otherwise it would report a lot of
false positives.

Looking again at this false positive, I might have been wrong in the
first place. Since the iomem_resource is scanned (being in the data
section), there should be a way to get to the "res" pointer, unless
the request_resource() doesn't return NULL (or some other sibling is
freed without calling release_resource).

> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > >   - drivers/base/platform.c and fs/ext3/dir.c:
> > >     False positive because we allocate memory for struct + some extra
> > >     stuff.
> > >
> > > At least the latter can be fixed as outlined by Catalin in another
> > > mail.
> >
> > yes.
>
> Indeed and should be fixed before inclusion.

... with a slight risk of increasing the false negatives (but reducing
the memleak_padding calls).

The reason for the current implementation - because the type
information is lost in alloc calls, there is no way to know what type
of structure it is and what container_of() macros are used on its
members. The sizeof() value provides an approximation to this but this
assumption is broken once the allocated memory is different from the
size of the allocated structure. The above idea would eliminate these
issues

-- 
Catalin
