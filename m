Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRHCNcT>; Fri, 3 Aug 2001 09:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269058AbRHCNcJ>; Fri, 3 Aug 2001 09:32:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59008 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269041AbRHCNb6>; Fri, 3 Aug 2001 09:31:58 -0400
Date: Fri, 3 Aug 2001 09:31:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jlnance@intrex.net
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <20010803090703.B1248@bessie.localdomain>
Message-ID: <Pine.LNX.3.95.1010803093017.17341A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001 jlnance@intrex.net wrote:

> On Thu, Aug 02, 2001 at 07:27:42PM -0300, Rik van Riel wrote:
> > On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
> > 
> > > I'm telling you that's not what happens.  When memory pressure
> > > gets really high, the kernel takes all the CPU time and the box
> > > is completely useless. Maybe the VM sorts itself out but after
> > > five minutes of barely responding, I usually just power cycle
> > > the damn thing.  As I said, this isn't a classic thrash because
> > > the swap disks only blip perhaps once every ten seconds!
> > 
> > What kind of workload are you running ?
> > 
> > We could be dealing with some weird artifact of
> > virtual page scanning here, or with a strange
> > side effect of recent VM changes ...
> 
> Rik,
>     FWIW, I am seeing this sort of thing too, though I am running a 2.4.5
> kernel so I am a little out of date.  Its a large machine with 2G of ram,
> 4G of swap, and 2 CPUs.  You dont have to actually use all the memory either.
> When my process gets to about 1.5G and starts doing lots of file I/O, the
> machine can just disappear for several minutes.  I will be sshed in and
> I can not even get my shell to give me a new prompt when I hit return.  It
> will eventually sort it self out, but it might take 15 minutes.  I will try
> and get a more recent kernel installed, but the machine is not under my
> control, so I dont get to decide when that happens.
> 
> Thanks,
> 
> Jim


If users are going to fail to administer their machines
then we need some kind of dynamic quotas, i.e., based
upon some percent of available resources, not absolute
values of resources that exist at boot.

For this to work, the kernel also needs resource quotas.
Right now, the kernel will use any "spare" memory it finds
for buffers. This means that there are never any resources
visibly available when they are needed. Instead, the lack
of resources becomes known only when it runs out, i.e., swap
fails.

For instance, the kernel needs to free a few pages for a
user-mode task so a driver attempts to allocate a page for
disk I/O so data can be swapped. The driver allocation fails.

Yes, there is such deadlock detection, however, with no pages
to free because they can't be written, there will be no pages
available for the write.

I think we just need to keep track of who forced pages to be
swapped. The kernel gets to use the whole swap-file, users
are under some page-file quota (like VAX/VMS). Unlike VAX/VMS
we don't keep a task in RWAST state until resources are available,
instead we cause the next "set break address" call to fail,
thereby forcing malloc() to return NULL.

Currently this, and other, memory limiting schemes will fail
because no allocation actually occurs when the break address
is set. As I see it, all we have to do before returning such
a break address is to check the caller's page-file quota. If
the allocation (when it actually occurs) will not exceed that
quota, the operation returns successfully.

The page-file quota is not the amount of file-space that contains
the user's virtual-RAM data, instead, it is the amount of file-space
that a particular user forced to be swapped out. Such file-data
usually contains other processes' data. One of the VAXen's failings
was that this wasn't considered. It's actually easier to do it
the "right" way because less information has to be known.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


