Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSLEIEc>; Thu, 5 Dec 2002 03:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSLEIEc>; Thu, 5 Dec 2002 03:04:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10888 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262604AbSLEIEb>;
	Thu, 5 Dec 2002 03:04:31 -0500
Date: Thu, 5 Dec 2002 13:43:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: rddunlap@osdl.org
Cc: linux-kernel@vger.kernel.org, baldrick@wanadoo.fr,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Reserving physical memory at boot time
Message-ID: <20021205134354.A2363@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crash dump after kexec also needs something similar, to 
prevent the new kernel from allocating pages holding the dump from
the previous boot so that they aren't overwritten until the dump 
gets written out. The pages can be accessed(read) for the purpose of 
writeout. The Mission Critical implementation did this by patching 
the kernel to mark these pages as reserved early during bootup, 
much like the badmem mark pages as PG_Badmem. 

There is a common theme running here of a "mark_claimed_pages"
logic during early bootup, and "is_claimed_page" check at
other places. 

In the case of crash dump we have a fairly large number of
pages to be marked out this way. The layout is available in the
form of a map list, a pointer to which is passed on from the 
previous reboot. 

So if we are looking for very minimal infrastructure which all of
these can use, imposing a particular format in which such info 
(about unavailable memory) be passed in could become either less 
flexible or overgeneralized. Leaving the logic of identifying
pages to be claimed (not available to the kernel for allocation)
to the concerned subsystems appears to be a simpler and easier to
extend approach. 

Is there a good way to avoid embedding calls to early mem 
init code like mark_dump_pages, mark_bad_pages, mark_my_pages, 
etc and instead have each of these subsystems specify interest 
(a special section may be an overkill) so their corresponding 
routines get called ?

Regards
Suparna

In article <Pine.LNX.4.33L2.0212031952530.7246-100000@dragon.pdx.osdl.net> Randy.Dunlap wrote:
> On 3 Dec 2002, James Stevenson wrote:

> | On Tue, 2002-12-03 at 12:03, Duncan Sands wrote:
> | > I would like to reserve a particular page of physical memory when
> | > the kernel boots.  By reserving I mean that no one else gets to read
> | > from it or write to it: it is mine.  Any suggestions for the best way
> | > to go about this with a 2.5 kernel?
> |
> | try having a look for the linux badmem patches i belive they might do
> | the same sort of thing.

> see http://badmem.sourceforge.net/

> -- 
> ~Randy

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

