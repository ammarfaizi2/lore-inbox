Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSEVNp2>; Wed, 22 May 2002 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSEVNp1>; Wed, 22 May 2002 09:45:27 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:3847 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313589AbSEVNp0>; Wed, 22 May 2002 09:45:26 -0400
Date: Wed, 22 May 2002 15:45:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205211752350.3589-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205221523450.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 May 2002, Linus Torvalds wrote:

> > > x86, to be exact ;(
> >
> > IMO that's not really problem, the pmd tables are created and destroyed
> > with the pgd table.
> 
> unmap()?

We already don't let the general vm touch the pgd entries for the same
reason, so I don't think that's really a big problem.
Using the present bit has another consequence. unmap() had to be done in
two phases:
1. Disable the table entries at the highest possible level. Using the
previous and following vma avoids scanning the tables (something like
free_pgtables already does, only more accurate).
2. Scan the tables and free all the disabled entries. At this point we
don't have worry about any tlb issues anymore.

I can see a few advantages doing it this way. The first phase could be
quite fast even for large unmaps and so reducing the time holding the
page_table_lock. It avoids the race mentioned by Paul (although a
ptep_clear_present() would still be needed). It would also free up more
unused tables. The tlb shootdown stuff would be simpler as well.
On the other hand it's a rather rough idea and I don't know how feasible
it really is, but without the exit case it should become easier and IMO
worth a try. 

bye, Roman

