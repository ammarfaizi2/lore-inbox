Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273992AbRJDJEl>; Thu, 4 Oct 2001 05:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273789AbRJDJEb>; Thu, 4 Oct 2001 05:04:31 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43529 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S274209AbRJDJET>; Thu, 4 Oct 2001 05:04:19 -0400
Message-ID: <3BBC2603.7C1327AC@idb.hist.no>
Date: Thu, 04 Oct 2001 11:04:03 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.11-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Ian Thompson <ithompso@stargateip.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How can I jump to non-linux address space?
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBEEGJCAAA.ithompso@stargateip.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Thompson wrote:
> 
> Hi all,
> 
> I'm sorry if this is off-topic, but I wasn't sure where else to ask...
> 
> My kernel is running from RAM, and I want to jump to an address in ROM
> (which unfortunately, the kernel doesn't seem to know anything about).  I

The kernel can get to know - all you need is code that maps the
ROM address range into some available virtual address range.
Look at device driver code - they do such mapping for ROM and/or
memory-based io regions.

> don't plan on trying to resume the kernel after doing this.  However, I'm
> getting a prefetch abort.  If I try and load the data, I get a similar
> error: "Unable to handle kernel paging request at virtual address 00003000"
> where 0x3000 is the ROM address I'm trying to jump to / load from.  How can
> I pass execution to this address?  Do I have to turn off the MMU?  

How to set up the cpu before jumping to a ROM that won't return
can be tricky indeed.  This depends on what that ROM code expect!

Do that ROM code work when the MMU has remapped its adresses so it
appears at some adress completely different from the bus address?  (only
if it contains relative jumps only - no absolute addresses.) Does
it work with 4G segments?  Does it work at all in protected mode,
with all interrupts routed to the linux kernel instead of the bios?
Does this code expect to find something (data, device interfaces,
vga memory) at certain addresses?  If so, this must be mapped too.
For linux moves all this around.

In practise, existing ROM's tend to assume that the machine is
in a state close to what the bios initializes it to,
with 64k segments, no MMU, and a lot of assumptions about
how interrupts and hw devices are set up.  _All_ of these
assumptions break after you start linux, and resetting 
everything is so hard that it is usually done by
running the bios cold boot code.

Helge Hafting
