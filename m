Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264253AbTCXPz0>; Mon, 24 Mar 2003 10:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264254AbTCXPz0>; Mon, 24 Mar 2003 10:55:26 -0500
Received: from files.ssi.bg ([217.79.71.21]:50953 "HELO files.ssi.bg")
	by vger.kernel.org with SMTP id <S264253AbTCXPzZ>;
	Mon, 24 Mar 2003 10:55:25 -0500
Date: Mon, 24 Mar 2003 18:01:25 +0200
From: Alexander Atanasov <alex@ssi.bg>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux@brodo.de, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
 looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
Message-Id: <20030324180125.2606b046.alex@ssi.bg>
In-Reply-To: <1048514373.25136.4.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
	<1048514373.25136.4.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On 24 Mar 2003 13:59:33 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 2003-03-24 at 09:55, Alexander Atanasov wrote:
> > i can't reproduce the hang but it seems that drives without driver
> > can get both in ata_unused and idedefault_driver.drives and lists go
> > nuts. It kills ata_unused and uses idedefault_driver.drives only,
> > boots fine here. I'd guess you have ide-cd as module, and the two
> > drives handled by it couse the trouble - first joins the lists
> > second couses the loop.
> 
> We need to know the difference between the two really so I would much
> rather ensure we don't end up on both lists at once (which is a bug)
> than lose a list
> 

	I don't understand, what's the difference and how the list is lost?
ata_unused used to hold all drives that were not claimed by any driver,
now idedefault_driver claims all that drives, all drives go in the .list
of its driver. ide_register_driver wants to take all unused drives and
attach them to the newly registered driver, so take all drives that use
idedefault_driver, and try, if they fail to find a driver they end up
again with the same driver and list (idedefault_driver). I think
idedefault_driver.list and ata_unused became dublicates, and the proper
place is to hold drives with no real driver is idedefault_driver, so the
patch. list from ata_unused becomes idedefault_driver.list, and does
exactly the same as ata_unused. I want to understand where i'm wrong, 
please?

The bug is there,  and waiting to explode, keeping both lists would mean to 
add one more  list head  in ide_drive_t,  is that the fix you want?

--
have fun,
alex
 
