Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSGYM1V>; Thu, 25 Jul 2002 08:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSGYM1V>; Thu, 25 Jul 2002 08:27:21 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41226
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311025AbSGYM1U>; Thu, 25 Jul 2002 08:27:20 -0400
Date: Thu, 25 Jul 2002 05:25:15 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Insch <vofka@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oddities with HighPoint HPT374, 2.4.19-pre10-ac2
In-Reply-To: <200207251249.02531.vofka@hotpop.com>
Message-ID: <Pine.LNX.4.10.10207250507480.4719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The oddities are the fact I have not finished creating the channel and
drive set inner-lock sequence code :-/  If you run it in master mode only
one drive per channel, it is perfectly safe.  The problem happens the
instant you pair drives on the channels.  I have not figured out the
correct interrupt sequence ordering and blocking recipe.

The issue stands to deal with double hwgroups locking and having more than
two channels to the effective HBA.

Instead of 

HPT374
  ide4
  ide5
HPT374
  ide6
  ide7

It has to evlolve to

HPT374
  ide4p
  ide4s
  ide5p
  ide5s

This means extened minor on the second half of each major must be created.
There is not enough sane bandwith in the driver, nor would anybody take
such an exotic solution.

Sorry,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 25 Jul 2002, Mike Insch wrote:

> Hi,
> 
> I have a system with an ABIT AT7 Motherboard (Duron 1200, 256MB PC2100 RAM), 
> and have 8 80GB Maxtor IDE HDD's connected to the HPT374 controller on the 
> board, configured as a single RAID-0 Array in hardware.
> 
> When copying data from another disk connected to the VIA IDE Controller, the 
> kernel oopses with an 'Unable to handle NULL pointer dereference at virtual 
> address 00000004' after about 5MB has copied.  The process implicated by the 
> oops is the kjournald process for the only partition on the RAID array.
> 
> Sorry I have no output from the oops - it locks totally, and the oops is never 
> logged :(
> 
> Copying large amounts of data from a Samba Share on the network (over 15GB!) 
> has produced no similar problems - so I'm guessing that kjournald, or the 
> HPT374 drivers don't like the 640GB array when data is being committed too 
> fast. (All the drives involved are UDMA 133 Drives, both the one on the VIA 
> Controller, and all 8 on the HPT Controller).
> 
> I know it's hard to say without me giving more info, but does anyone have any 
> idea what could possibly cause this?  Have there been updates in newer 
> releases to either the HPT374 Code, or to the kjournald code that could solve 
> this?  Is it worth me getting and compiling 2.4.19-rc3-ac3 to see if the 
> problem is solved there?  Any and all info. which may help tracking down this 
> gremlin would be greatly appreciated....
> 
> (I can post detailed info. about the hardware (lspci, dmesg etc), and kernel 
> configurations if that would be of any use?)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

