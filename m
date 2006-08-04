Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWHDThZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWHDThZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWHDThZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:37:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:24988 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932605AbWHDThY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:37:24 -0400
Subject: Re: [Lhms-devel] [PATCH 4/10] hot-add-mem x86_64: Enable SPARSEMEM
	in	srat.c
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: lkml <linux-kernel@vger.kernel.org>, andrew <akpm@osdl.org>,
       discuss <discuss@x86-64.org>, Andi Kleen <ak@suse.de>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <44D364F9.3080703@kolumbus.fi>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	 <20060804131409.21401.58904.sendpatchset@localhost.localdomain>
	 <44D364F9.3080703@kolumbus.fi>
Content-Type: text/plain; charset=utf-8
Organization: Linux Technology Center IBM
Date: Fri, 04 Aug 2006 12:36:19 -0700
Message-Id: <1154720180.7722.28.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 18:17 +0300, Mika Penttilä wrote:
> Keith Mannthey wrote:
> > From: Keith Mannthey <kmannth@us.ibm.com>
> >
> >  Enable x86_64 srat.c to share code between both reserve and sparsemem based add memory
> > paths.  Both paths need the hot-add area node locality infomration (nodes_add).  This 
> > code refactors the code path to allow this. 
> >
> > Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
> >   
> Ok nice, but.... hotadd_enough_memory() is broken, it does weird things 
> with nd->start and nd->end which haven't been assigned even values yet. 
> Also, mysterious business with find_e820_area and last_area_end...These 
> areas are not in e820...
  Thats for pointing out the breakage in hotadd_enough_memory.  I think
the find_e820_area stuff is to make sure there box has the memory to
reserve the maps....but it doesn't look to do it right.  I can take a
pass at a re-write for this function. 
   

STAT hot-add memroy areas can be outside the e820.  The e820 just
exposes the end of memory the is present in the box even though there
maybe add area on the other size of that.

For example my memory is layed out as follows.

SRAT: Node 0 PXM 0 0-80000000
SRAT: Node 0 PXM 0 0-470000000
SRAT: Node 0 PXM 0 0-1070000000
SRAT: hot plug zone found 470000000 - 1070000000
SRAT: Node 1 PXM 1 1070000000-1160000000
SRAT: Node 1 PXM 1 1070000000-3200000000
SRAT: hot plug zone found 1160000000 - 3200000000

The e820 ends at 1160000000 but there is still a possible add zone on
the other side of that. 

The first hot plug zone is reserved by the e820 but no the 2nd. 
> And why the reserve_bootmem_node()? Areas not RAM (per e820) are 
> reserved anyways.

To make sure the areas are outside of the e820 are reserved.  

Thanks,
  Keith 

