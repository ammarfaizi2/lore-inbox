Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWKBRkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWKBRkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWKBRkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:40:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:3069 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751059AbWKBRkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:40:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NslwUNUi0SNR2XLgdrqCxemPFITYUp9xUq9Fm8K8zbNKQiH+o0x+FmxaXNUO1v5UcYpX7+oG6PWCOp5PeSU9Ifk0yAMylhToIYQG3e8SjU3Qgg4UX3DtsHqfUDTya6H/+ZjWn5upVlM3PqqYIikhPYbzFKSyFzALQrO0csERsFQ=
Message-ID: <aec7e5c30611020940g73ff373cjbca4c684c5ed8cc6@mail.gmail.com>
Date: Fri, 3 Nov 2006 02:40:26 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Mel Gorman" <mel@csn.ul.ie>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org
In-Reply-To: <20061102142812.GB8074@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102131934.24684.93195.sendpatchset@localhost>
	 <20061102142812.GB8074@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Thu, Nov 02, 2006 at 10:19:34PM +0900, Magnus Damm wrote:
> > x86_64: setup saved_max_pfn correctly
> >
> > 2.6.19-rc4 has broken CONFIG_CRASH_DUMP support on x86_64. It is impossible
> > to read out the kernel contents from /proc/vmcore because saved_max_pfn is set
> > to zero instead of the max_pfn value before the user map is setup.
> >
> > This happens because saved_max_pfn is initialized at parse_early_param() time,
> > and at this time no active regions have been registered. save_max_pfn is setup
> > from e820_end_of_ram(), more exact find_max_pfn_with_active_regions() which
> > returns 0 because no regions exist.
> >
> > This patch fixes this by registering before and removing after the call
> > to e820_end_of_ram().
> >
> > Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
> > ---
> >
> >  Applies to 2.6.19-rc4.
> >
> >  arch/x86_64/kernel/e820.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > --- 0002/arch/x86_64/kernel/e820.c
> > +++ work/arch/x86_64/kernel/e820.c    2006-11-02 21:37:19.000000000 +0900
> > @@ -594,7 +594,9 @@ static int __init parse_memmap_opt(char
> >                * size before original memory map is
> >                * reset.
> >                */
> > +             e820_register_active_regions(0, 0, -1UL);
> >               saved_max_pfn = e820_end_of_ram();
> > +             remove_all_active_ranges();
> >  #endif
> >               end_pfn_map = 0;
> >               e820.nr_map = 0;
>
> This looks fine to me for the time being.

Great, thanks.

> Down the line I am thinking that how about passing saved_max_pfn as
> command line parameter. I think that way we don't have to pass all the
> memmap= options to second kernel and kexec-tools can pass the memory map
> through parameter segment. This memory map can be modified to represent
> only the memory which can be used by second kernel and not the whole of
> the memory.

Hm, I'm not sure how that will improve things. Isn't memmap= just used
to inform the secondary kernel which space it can use? You need to
tell it somehow regardless - I think the current implementation seems
to work pretty well. But I guess you mean that we should pass an
modified e820 map that only includes valid areas for the second
kernel. That may simplify things. But changing the interface is
painful.

Right now I feel that so many things are happening in the kdump world
that it's difficult just to keep the current code working as is.

> I think this will simplify the logic and also save us precious comand
> line in second kernel for kdump purposes.

I remember seeing some email regarding extending the amount of command
line space, that's an alternative approach if we are running out of
space.

Thanks!

/ magnus
