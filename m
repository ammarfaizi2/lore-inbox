Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282646AbRLRNFQ>; Tue, 18 Dec 2001 08:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLRNFI>; Tue, 18 Dec 2001 08:05:08 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:24587 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S282655AbRLRNEv>; Tue, 18 Dec 2001 08:04:51 -0500
Message-ID: <3C1F3EF5.D1A6D0C1@idb.hist.no>
Date: Tue, 18 Dec 2001 14:04:53 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: zap_page_range in a module
In-Reply-To: <Pine.LNX.4.21.0112162341400.444-100000@notebook.diehl.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Diehl wrote:
> 
> On Fri, 14 Dec 2001, Benjamin LaHaise wrote:
> 
> > > I have a 64k sliding "window" into a 1MB region. You can only access
> > > 64k at a time then you have to switch the "bank" to access the next
> > > 64k. Address 0xa0000-0xaffff is the 64k window. The actual 1MB of
> > > memory is above the top of memory and not directly addressable by the
> > > CPU, you have to go through the banks.
> >
> > Stop right there.  You can't do that.  The code will deadlock on page
> > faults for certain usage patterns.  It's slow, inefficient and a waste
> > of effort.
> 
> Would you mind giving a hint how the predicted deadlock path would look
> like or what the usage pattern might be, please?
> 
> I'm asking because I'm happily doing something very similar to what
> Matthew describes without ever running into trouble - and this operates
> at major page fault rates up to 1000/sec here. What I'm doings is:

Some processors have instructions that require 2 or more pages
present simultaneously to execute.  That _will_ fail
spectacularly if the two pages belongs to different banks
in the above scenario, as only one bank can be present at a time.

Some examples for x86 processors:

1. The string move/compare instructions.  Fine for copying blocks of
   memory around.  The above case is a framebuffer, using
   "movsd" to copy from one location to another isn't
   all that uncommon.  The two locations might be in different banks.

2. An unaligned read or write, such as writing a 32-bit quantity
   to the last even address in the first bank.  The the rest hits
   the first part of the next bank.  (A 16-bit quantity written to
   the last odd address does the same thing.)

3. An instruction that cross a bank bounddary, or lives in one
   and access data in another bank.  Of course you don't usually
   store instructions in a frame buffer. :-)

4. Processor-specific structures (page tables, interrupt
   vectors... stored so they cross a bank.)  Not applicable
   to framebuffers, but there might be strange machines with
   bank-switched main memory around.

In any of these cases, the following happens:
1. You get a page fault for the page in the missing bank.
2. The page fault handler switch banks.
3. The instruction is restarted as the page fault handler returns
4. You get a page fault for the now missing page in the bank
   that was switched off.
5. The page fault handler switch banks
7. the instruction is restarted.  Repeat from 1 in
   an endless loop.  Your machine is now deadlocked.  Perhaps
   you're so lucky that some other processes still gets 
   scheduled - lets hope none of them need the bank-switched 
   memory _at all_.

Helge Hafting
