Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319211AbSIDQb6>; Wed, 4 Sep 2002 12:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319209AbSIDQb6>; Wed, 4 Sep 2002 12:31:58 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:28395 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S319211AbSIDQb5>; Wed, 4 Sep 2002 12:31:57 -0400
Date: Wed, 4 Sep 2002 09:57:43 -0700
From: Matt Porter <porter@cox.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Craig Arsenault <penguin@wombat.ca>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Message-ID: <20020904095743.A27144@home.com>
References: <20020904142636.GL761@opus.bloom.county> <137715274.1031128333@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <137715274.1031128333@[10.10.2.3]>; from Martin.Bligh@us.ibm.com on Wed, Sep 04, 2002 at 08:32:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 08:32:15AM -0700, Martin J. Bligh wrote:
> 
> >> In 2.4.x (currently using 2.4.18), for PPC, there is a value for
> >> "MAX_LOW_MEM" defined in "arch/ppc/mm/pgtable.c" as 768MB RAM.  Any
> >> memory above 768MB is considered "high" memory.  Now our problem is
> >> that we have 1024MB of onboard RAM on our card.  I do *NOT* wish to
> >> compile with "CONFIG_HIGHMEM" set to true (see below for why), but i
> >> do wish to have full use of the 1024MB of RAM onboard, or at least
> >> 992MB which is the minimum for our app.
> >> So what I did was just change "MAX_LOW_MEM" to be 0x3E000000
> >> (0x30000000), ie. change it to 992 from 768.   I recompiled and tested
> >> our application.  Things seemed to be running normal with a max of
> >> 992MB of RAM.
> >>
> >> Is this a potential problem, or will this cause some lurking bug that
> >> anyone can think of?  (ie. I'm sure "MAX_LOW_MEM" was set to 768MB for
> >> a reason, but what is that reason).   We don't want to move higher
> >> than 1Gig RAM for now, so are we going to be okay doing what I
> >> describe above?  Any suggestions or comments as to why that's a very
> >> bad idea would be greatly appreciated.  Again, this is for a
> >> PPC-specific board, I'm not sure what the x86 architecture's low
> >> memory max is.
> 
> I think you'll find yourself with no virtual address space left to
> do vmalloc / fixmap / kmap type stuff. Or at least you would on i386,
> I presume it's the same for ppc. Sounds like you may have left
> yourself enough space for fixmap & kmap, but any calls to vmalloc
> will probably fail ?

Correct.  The solution, in the context of the linuxppc_2_4_devel tree,
is to do the following:

        Enable "Prompt for advanced kernel configuration options"
        Enable "High memory support"
        Enable "Set maximum low memory" and set to 0x40000000
        Enable "Set custom kernel base address" and set to 0xa0000000

Note that highmem support will not be used in his case (he didn't
want to use it), because PAGE_OFFSET is at 0xa0000000 and
MAX_LOW_MEM is at 1GB.  With this configuration, VMALLOC_START
will be at 0xe0000000 + VMALLOC_OFFSET leaving ample vmalloc
space for most applications.  All system memory is mapped as
lowmem .

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
