Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWHGXyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWHGXyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWHGXyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:54:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932371AbWHGXyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:54:52 -0400
Date: Mon, 7 Aug 2006 19:57:27 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060807235727.GM16231@redhat.com>
References: <20060710233219.GF16215@in.ibm.com> <20060711010815.GB1021@host0.dyn.jankratochvil.net> <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com> <20060804210826.GE16231@redhat.com> <m164h8p50c.fsf@ebiederm.dsl.xmission.com> <20060804234327.GF16231@redhat.com> <m1hd0rmaje.fsf@ebiederm.dsl.xmission.com> <20060807174439.GJ16231@redhat.com> <m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> >
> >> >> 
> >> >> The error is the uncompressed length does not math the stored length
> >> >> of the data before from before we compressed it.  Now what is
> >> >> fascinating is that our crc's match (as that check is performed first).
> >> >> 
> >> >> Something is very slightly off and I don't see what it is.
> >> >
> >> > I printed out orig_len -> 5910532 (which matches vmlinux.bin)
> >> >              bytes_out -> 5910531
> >> >
> >> >> 
> > It seems to be an AMD64 vs EM64T problem.  AMD chipsets work but Intel
> > chipsets don't.  
> >
> > I also blindly incremented bytes_out (as a really cheap hack), it didn't
> > work until I added some random putstr's below it (timing??).  Then the
> > kernel booted. 
> >
> > Still looking into things.  
> 
> Odd.  I wonder if I'm missing a serializing instruction somewhere,
> to ensure the effects of ``self modifying code'' aren't a problem.
> As I read Intels Documentation if you have a jump before you get
> to the code there shouldn't be a problem.
> 
> Still that doesn't really explain bytes_out.
> 

So I narrowed down the problem but it isn't obvious to me why this problem
exists.  Basically, even though bytes_out is supposed to be initialized to
0, it becomes -1 before entering decompress_kernel().  Of course, the
fallout is in flush_window() bytes_out wounds up being one less than
outcnt and hence my original problem.

Any thoughts on how to debug where this could be getting corrupted?  

Cheers,
Don

