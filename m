Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSGaNIR>; Wed, 31 Jul 2002 09:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSGaNIR>; Wed, 31 Jul 2002 09:08:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:32780 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318294AbSGaNIP>; Wed, 31 Jul 2002 09:08:15 -0400
Date: Wed, 31 Jul 2002 10:11:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: BUG at rmap.c:212
In-Reply-To: <AD3C93230E@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44L.0207311006500.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Petr Vandrovec wrote:

> > Line 212 is   'pte_chain_unlock(page);'   right ?
>
> Nope. On my system (2.5.29-changeset548) it is a BUG() call which was
> added by akpm in rmap.c revision 1.5, in his 'Add BUG() on a can't-happen
> code path in page_remove_rmap()'. It just added #else BUG() branch
> to #ifdef DEBUG_RMAP conditional.

> Probably because of your code did not do anything special when
> 'Not found. This should NEVER happen!' code path triggers.

It used to, until I found out that that regularly blew up
for people mmap()ing devices and I had to remove that code
again ;)

The reason for that problem is that a device driver would
allocate memory, set PG_reserved on it and then let user
programs mmap() it.

These reserved pages do not get a pte chain because the
memory isn't swappable and if the page stays reserved
page_remove_rmap won't even try searching for the pte
chain.

However, some drivers (nvidia) clear PG_reserved without
first having the programs exit, so page_remove_rmap will
end up searching for the pte chain, which of course
doesn't exist...

Of course, ntpd is probably running into a different problem,
but the printk's enabled with DEBUG_RMAP should give us some
hints.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

