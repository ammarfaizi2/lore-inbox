Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbSLECdM>; Wed, 4 Dec 2002 21:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSLECdM>; Wed, 4 Dec 2002 21:33:12 -0500
Received: from dp.samba.org ([66.70.73.150]:29653 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267188AbSLECdL>;
	Wed, 4 Dec 2002 21:33:11 -0500
Date: Thu, 5 Dec 2002 13:38:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205023847.GA1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212050144.gB51iH105366@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 07:44:17PM -0600, James Bottomley wrote:
> david@gibson.dropbear.id.au said:
> > Do you have an example of where the second option is useful?  Off hand
> > the only places I can think of where you'd use a consistent_alloc()
> > rather than map_single() and friends is in cases where the hardware's
> > behaviour means you absolutely positively have to have consistent
> > memory. 
> 
> Well, it comes from parisc drivers.  Here you'd really rather have
> consistent memory because it's more efficient, but on certain
> platforms it's just not possible.

Hmm... that doesn't seem sufficient to explain it.

Some background: I work with PPC embedded chips (the 4xx family) whose
only way to get consistent memory is by entirely disabling the cache.
However in some cases you *have* to have consistent memory despite
this very high cost.  In all other cases you want to use inconsistent
memory (just allocated with kmalloc() or get_free_pages()) and
explicit cache flushes.

It seems the "try to get consistent memory, but otherwise give me
inconsistent" is only useful on machines which:
	(1) Are not fully consisent, BUT
	(2) Can get consistent memory without disabling the cache, BUT
	(3) Not very much of it, so you might run out.

The point is, there has to be an advantage to using consistent memory
if it is available AND the possibility of it not being available.

Otherwise, drivers which absolutely need consistent memory, no matter
the cost, should use consistent_alloc(), all other drivers just use
kmalloc() (or whatever) then use the DMA flushing functions which
compile to NOPs on platforms with consistent memory.

Are there actually any machines with the properties described above?
The machines I know about don't:
	- x86 and normal PPC are fully consistent, so the question
doesn't arise
	- PPC 4xx and 8xx are incconsistent if cached, so you never
want consistent if you don't absolutely need it
	- PA Risc is fully non-consistent (I'm told), so the question
doesn't arise.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
