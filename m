Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315130AbSEHUib>; Wed, 8 May 2002 16:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315133AbSEHUia>; Wed, 8 May 2002 16:38:30 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29198
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315130AbSEHUi2>; Wed, 8 May 2002 16:38:28 -0400
Date: Wed, 8 May 2002 13:36:14 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <E175YI5-0002LD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10205081329540.30697-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Alan Cox wrote:

> > I though about that, but what about corner cases where only a single
> > register can be accessed ? (typically alt status). Provide specific
> > routines ? Also, how does the extended addressing works ? by writing
> > several times to the cyl registers ? That would have to be dealt with
> > as well in each host driver then.
> 
> There are lots of cases we don't care about speed - things like setup of
> the controller, changing UDMA mode etc. 

Erm, think about the state diagram for testing the acceptance and command
migration if TAG is going to be  standard.

> 	Begin a disk write
> 	Begin a disk read

test command accept/reject

repeat 'til done:
check_status

> 	PIO transfer in
> 	PIO transfer out

io hardware atomic segment or burst

(for linus, "atomic" is what is needed to complete, not just linusism")

goto repeat if !done with entire request

The above is where data integrity is lost if error happens.

> 	End a disk I/O fastpaths (no error case)
> 
> 	Maybe ATAPI command writes ?
> 
> beyond that I doubt the rest are critical 

There are several other cases, but 95% is the command block execution.
The rest is sense data.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

