Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSKTRZA>; Wed, 20 Nov 2002 12:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKTRZA>; Wed, 20 Nov 2002 12:25:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33111 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261573AbSKTRY6>; Wed, 20 Nov 2002 12:24:58 -0500
To: suparna@in.ibm.com
Cc: Werner Almesberger <wa@almesberger.net>, Andy Pfiffer <andyp@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@provisioning.fibertel.com.ar>,
       torvalds@transmeta.com
Subject: Re: Kexec for v2.5.47-bk2
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1adkda9dm.fsf_-_@frodo.biederman.org>
	<20021115145454.B2503@in.ibm.com>
	<20021115113707.A3749@almesberger.net>
	<20021120151456.A2556@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2002 10:28:31 -0700
In-Reply-To: <20021120151456.A2556@in.ibm.com>
Message-ID: <m1fztwywu8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> Yes indeed. At the moment however I was just looking at something 
> as simple as a single (or more) parameter to pass from an old 
> kernel to the new one. 

Currently we pass all kinds of parameters, the e820 memory map being
one of the significant ones.  Though the arch specific locations are
not generally the best ones to use.

> That parameter could be a scalar value/
> variable or denote the address of a control block, or something 
> requiring more complicated interpretation like you mention.
> If the parameter is a pointer to an address block right now the
> code to put it in a place that doesn't get overwritten when the
> new kernel loads is left as the responsibility of the caller.
> Designing a generic and clean interface for that would require
> more thought and is best delayed a bit till we understand all the
> needs better. Mcore for example (as you probably know already)
> passes a map of affected pages to the new kernel and during early 
> bootmem initialization those pages (from the previous boot) are 
> marked as reserved, instead of moving them to a contiguous memory 
> area. Its just the start of the map (crash header) that's still 
> passed in as a fixed location (rather its relative to the end of
> the current image) and I was looking at a nice way to avoid that.

When you can do it passing tables, at a fixed or a relatively fixed
address is a powerful way to do things..  At least when they are
supposed to have a long lifetime.  I'm not quite certain about
a temporary solution.

> One way of course is to add a kernel parameter(s) and set this 
> through user-space (after extracting it from the
> kernel .. possibly via kmem) when loading the image (kexec tools
> does all the work of filling up the parameter block). Probably
> that's what was intended.
>
 
> Eric, Is that correct ? 

Yes.  Getting the information down to user space and then putting
it in the kernel is a reasonable thing to do.

> BTW, did you have an option (or plan 
> to add one) in kexec tools to use the current kernel's parameters 
> and append additional options to it ?

For command line arguments that is trivial 
--command-line="`cat /proc/cmdline` extra arguments".  

For the rest it would require a little more work, as all of the
kernels current parameters are not currently preserved.  But my basic
take is that I would rather derive/create the parameters to the new
kernel than just copy them from some fixed location.  Then passing
the current values just becomes a matter of policy, which the user can
control. 

For me it is important to be able to boot new kernels, and things
other than linux.  And especially in those cases the policy needs to
be driven from user space, as there is no real standardization of
parameters or what can be passed.  Nor is there much desire among
the various kernel authors, and bootloader authors to come up with a
standard format they all can use.  A good proposal with an unchanging
story and years of history behind it may eventually change some
minds, but I'm not holding my breath.

So beyond what functionality is currently there, I am not real
enthusiastic about optimizing the case of do what I just did.  For me
that is not an especially interesting case.

Eric
