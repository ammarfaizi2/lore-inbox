Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVIGRyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVIGRyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVIGRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:54:22 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:8873 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbVIGRyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:54:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8L8NvMPPvx5Jzmzmq0pElW9i/waAQEINglI/BNQHEdk/fBz85/q9mIfPFFWOCdLsL1kyxTfcfPnf7tDqF8RCcKbR5NMjQkMu2MVxMoiilJD9vSA2+T9sshbhtSPS7WC+HCc6aQLRW+7KFl2T4bn/Eesk6Bg4QkqoJmHOI0nF/Q=
Message-ID: <58d0dbf10509071054175e82ff@mail.gmail.com>
Date: Wed, 7 Sep 2005 19:54:19 +0200
From: Jan Kiszka <jan.kiszka@googlemail.com>
Reply-To: jan.kiszka@googlemail.com
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431F2760.5060904@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <1125854398.23858.51.camel@localhost.localdomain>
	 <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org>
	 <58d0dbf10509061005358dce91@mail.gmail.com>
	 <dfkjav$lmd$1@sea.gmane.org>
	 <58d0dbf105090612421dcd9d8d@mail.gmail.com> <431F2760.5060904@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/7, Bill Davidsen <davidsen@tmr.com>:
> Jan Kiszka wrote:
> > 2005/9/6, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>:
> >
> >>Jan Kiszka wrote:
> >>
> >>
> >>>The only way I see is to switch stacks back on ndiswrapper API entry.
> >>>But managing all those stacks correctly is challenging, as you will
> >>>likely not want to create a new stack on each switching point. Rather,
> >>
> >>This is what I had in mind before I saw this thread here. I, in fact, did
> >>some work along those lines, but it is even more complicated than you
> >>mentioned here: Windows uses different calling conventions (STDCALL,
> >>FASTCALL, CDECL) so switching stacks by copying arguments/results gets
> >>complicated. So I gave up on that approach. For X86-64 drivers we use
> >>similar approach, but for that there is only one calling convention and we
> >>don't need to switch stacks, but reshuffle arguments on stack / in
> >>registers.
> >>
> >>I am still hoping that Andi's approach is possible (I don't understand how
> >>we can make kernel see current info from private stack).
> >>
> >
> >
> > The more I think about this the more it becomes clear that this path
> > will be too winding, especially when compared to the effort needed to
> > patch 8K (or more) back into the kernel as an intermediate workaround.
> 
> Is there a technical reason ("hard to implement" is a practical reason)
> why all stacks need to be the same size?
> 

Because of

static inline struct thread_info *current_thread_info(void)
{
        struct thread_info *ti;
        __asm__("andl %%esp,%0; ":"=r" (ti) : "" (~(THREAD_SIZE - 1)));
        return ti;
}
[include/asm-i386/thread_info.h]

which assumes that it can "round down" the stack pointer and then will
find the thread_info of the current context there. Only works for
identically sized stacks. Note that this function is heavily used in
the kernel, either directly or indirectly. You cannot avoid it.

My current assessment regarding differently sized threads for
ndiswrapper: not feasible with vanilla kernels.

Jan
