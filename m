Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbTJOXZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTJOXZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:25:19 -0400
Received: from pchome.iram.es ([150.214.224.97]:32640 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262597AbTJOXZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:25:10 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 15 Oct 2003 20:16:58 +0200
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       jbglaw@lug-owl.de
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031015181658.GA9652@iram.es>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de> <20031015131015.GR16158@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015131015.GR16158@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 06:10:15AM -0700, William Lee Irwin III wrote:
> On Tue, 2003-10-14 15:56:38 -0700, cliff white <cliffw@osdl.org>
> >> Marco, if you could supply time on a small client box, and a desired .config,
> >> we can add you as a Tinderbox client,
> >>  then you have a place to point people when the size increases. 
> 
> On Wed, Oct 15, 2003 at 02:48:42PM +0200, Jan-Benedict Glaw wrote:
> > I can put on the table:
> > 486SLC, 12MB RAM
> > i386, 8MB RAM (hey, this box is nearly build up by discrete parts:)
> > Am386, 8MB RAM
> > P-Classic, 32MB RAM (even that much RAM can go short after an uptme of
> > about a month...)
> > Unfortunately, you need an additional kernel patch because nearly all
> > distros are using mach==i486 which gives you nice sigills on an i386
> > otherwise...
> > MfG, JBG
> 
> Can you quantify the performance impact of cmov emulation (or whatever
> it is)? I have a vague notion it could be hard given the daunting task
> of switching userspace around to verify it.

It can't be cmov emulation since neither 486 or Pentia have cmov, but
one of the following (differences between 386 and 486):

- cmpxchg: not used by UP kernels AFAICT, used by threading libraries,
  but maybe it's infrequent enough that it can be emulated

- xadd: can't tell whether it's used, could be emulated in any case
  since it looks so rare that you'll have to write specific code
  to exercise the emulator ;-)

- bswap: heavily used by network code at least, both applications and 
  kernel (ntohl/htonl). Emulation would probably be too expensive.

- invlpg: kernel only, easy to test and flush the whole TLB instead,
  perhaps even by boot-time patching of the code to minimize size.
  (I have no ideas of the number of occurences in an average kernel
  but it should be rather small).

- invd/wbinvd: only listed here for completeness :-)

The other problem of the 386 is that it has a fundamental MMU flaw:
no write protection on kernel mode accesses to user space, which makes 
put_user() intrinsically racy on a 386 and way more bloated when it is
inlined (access_ok has to call a function which searches the VMA tree).

	Regards,
	Gabriel
