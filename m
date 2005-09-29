Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVI2LZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVI2LZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 07:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVI2LZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 07:25:24 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:10972 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932096AbVI2LZX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 07:25:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Thu, 29 Sep 2005 13:25:47 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
References: <200509281624.29256.rjw@sisk.pl> <200509290011.41335.rjw@sisk.pl> <20050928223535.GA2010@elf.ucw.cz>
In-Reply-To: <20050928223535.GA2010@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509291325.48011.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 29 of September 2005 00:35, Pavel Machek wrote:
> Hi!
> 
> > > > > > The following patch fixes Bug #4959.  For this purpose it creates
> > > > > > temporary page translation tables including the kernel mapping (reused)
> > > > > > and the direct mapping (created from scratch) and makes swsusp switch
> > > > > > to these tables right before the image is restored.
> > > > > >
> > > > > > The code that generates the direct mapping is based on the code in
> > > > > > arch/x86_64/mm/init.c.
> > > > >
> > > > > Looks much better than before, but is there any reason you cannot
> > > > > share the code with the mm/init.c code?
> > > >
> > > > I think so.  I have to make the temporary page tables nosavedata or set
> > > > PG_nosave on them, so that swsusp doesn't overwrite them.  I'm not
> > > > sure if I could do this cleanly if I used the code from mm/init.c directly.
> > > 
> > > Just pass a flag for that.
> > 
> > Well, the code in mm/init.c is only executed really early, before zones
> > are initialized, and it uses alloc_low_page() to map memory.  Thus it seems
> > I only could make my code be executed next to init_memory_mapping(),
> > in which case I wouldn't be able to use page flags.  Apparently I'm missing
> > something but now I'm too tired to think efficiently.
> 
> I guess Andi meant "add a parameter to those mm/init.c functions".

Ahh, ok.

This does not seem to be enough, however, because the original code
in mm/init.c is __init, so I can't call it during resume.  Moreover, it calls
some more __init functions, so to use it I'll have to move the allocation
of the resume temporary page tables to the kernel initialization code.

If I do this, I'll have to mark the allocated pages as nosave (see below)
and make sure they will always get the same physical addresses.  I am
going to see if I can do this, but I need some time.

Anyway this could be a long-term solution, but in the short term the bug
is there and needs fixing ASAP.  One good thing about the current
solution is that it does not break anything outside of swsusp _for_ _sure_.

> (Otoh, you have reserved area, anyway, just set all of it PG_nosave,
> and you'll not need to modify mm/init.c stuff).

Rather I've reserved a set of individual pages that are only linked
via the page tables structure.  IMO it's better to mark them as nosave
as soon as they get allocated or I'll need to browse the entire
structure to do this.  Also, I need to make them get always the
same physical addresses and tell the memory management
they are not free.

Greetings,
Rafael
