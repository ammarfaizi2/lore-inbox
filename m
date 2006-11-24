Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757540AbWKXBI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540AbWKXBI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 20:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757544AbWKXBI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 20:08:56 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:42434 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757542AbWKXBIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 20:08:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lBAo/vqmMcPhAtL5Ku46pB06SPc+5RMKsdw8v5seOAGVfBhjbDAG79qS4jC+mvAJhzOFfZuWmkrL7kMVeTjQJ6OHCDgApGfrrzF80h63svoYTGcTxFI/7S06Rqj1+eIOzDDMd9U2YBUwf48qqn4BgNjXYoaIaKpQ7Tz5+F7XTCA=
Message-ID: <9a8748490611231708w3abf295bw3c007acf5cdcf336@mail.gmail.com>
Date: Fri, 24 Nov 2006 02:08:53 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Ingo Oeser" <netdev@axxeo.de>,
       "David Miller" <davem@davemloft.net>, chatz@melbourne.sgi.com,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20061124005528.GF11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com>
	 <20061122.201013.112290046.davem@davemloft.net>
	 <20061123070837.GV11034@melbourne.sgi.com>
	 <200611231416.03387.netdev@axxeo.de>
	 <1164307020.3147.3.camel@laptopd505.fenrus.org>
	 <20061124005528.GF11034@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/06, David Chinner <dgc@sgi.com> wrote:
> On Thu, Nov 23, 2006 at 07:37:00PM +0100, Arjan van de Ven wrote:
> > On Thu, 2006-11-23 at 14:16 +0100, Ingo Oeser wrote:
> > > Hi there,
> > >
> > > David Chinner schrieb:
> > > > If the softirqs were run on a different stack, then a lot of these
> >
> > softirqs DO run on their own stack!
>
> So they run on a separate stack for 4k stacks on x86?
>

Yes, with 4K stacks there's sepperate IRQ stack.

>From the help text for CONFIG_4KSTACKS :

"If you say Y here the kernel will use a 4Kb stacksize for the
 kernel stack attached to each process/thread. This facilitates
 running more threads on a system and also reduces the pressure
 on the VM subsystem for higher order allocations. This option
 will also use IRQ stacks to compensate for the reduced stackspace."


> They don't run on a separate stack for 8k stacks on x86 -
> Jesper's traces show that - so this may indicate an issue
> with the methodology used to generate the stack overflow
> traces inteh first place. i.e. if 4k stacks use a separate
> stack, then most of the reported overflows are spurious
> and would not normally occur on 4k stack systems..
>

Well, some of the traces show that we were down to ~3K stack free with
8K stacks, so ~5K used. Even with 4K stacks and sepperate stack for
IRQs we will still be uncomfortably close to the edge in those cases.
Also, I did manage to capture a single line via netconsole while
running with 4K stacks :
    do_IRQ: stack overflow: 492
Unfortunately that was the only line that made it to the remote log
server, so I don't have the actual trace for that one. But it does
show that there really is an issue when running with 4K stacks, IRQ
stacks or no.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
