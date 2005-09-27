Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVI0VAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVI0VAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVI0VAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:00:20 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:38097 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932216AbVI0VAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:00:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][Fix] Fix Bug #4959 (take 2)
Date: Tue, 27 Sep 2005 23:00:36 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200509241936.12214.rjw@sisk.pl> <200509271007.03865.rjw@sisk.pl> <20050927133218.GB9484@openzaurus.ucw.cz>
In-Reply-To: <20050927133218.GB9484@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509272300.37197.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 27 of September 2005 15:32, Pavel Machek wrote:
> Hi!
> 
> I do not really like new exports from swsusp.c, but I'm afraid
> there's no way around.

Well, there is one, if we use a static buffer, as you propose, since
in that case we will not need get_usable_pages() etc. outside of
swsusp.c.  The drawback of this, however, is that we will limit the
size of RAM for which it is possible to suspend (we need at least 1 page
for the PGD, 1 page for a PUD plus as many pages as there are GBs of
RAM for PMDs).  If we want to cover the huge-RAM cases, the buffer will
be too large for the average case, but otherwise some boxes will not
be able to suspend.

> > The following patch fixes Bug #4959.  For this purpose it creates temporary
> > page translation tables including the kernel mapping (reused) and the direct
> > mapping (created from scratch) and makes swsusp switch to these tables
> > right before the image is restored.
> 
> Why do you need *two* mappings? Should not just kernel mapping be enough?

The kernel mapping is for the kernel text.  The direct mapping maps the physical
RAM linearly to the set of virtual addresses starting at PAGE_OFFSET.

> > NOTES:
> > (1) I'm quite sure that to fix the problem we need to use temporary page
> > translation tables that won't be modified in the process of copying the image.
> > (2) These page translation tables have to be present in memory before the
> > image is copied, so there are two possible ways in which they can be created:
> > 	(a) in the startup kernel code that is executed before calling swsusp
> > 	on resume, in which case they have to be marked with PG_nosave,
> > 	(b) in swsusp, after the image has been loaded from disk (to set up
> > 	the tables we need to know which pages will be overwritten while
> > 	copying the image).
> > However, (a) is tricky, because it will only work if the tables are always located
> > at the same physical addresses, which I think would be quite difficult to achieve.
> 
> Why? Reserve ten pages for them... static char resume_page_tables[10*PAGE_SIZE] does not
> sound that bad.

That will allow us to suspend if there's no more that 8GB of RAM in the box.
Is it acceptable?

> > Moreover, such a code would have to be executed on every boot and the
> > temporary page tables would always be present in memory.
> 
> Yep, but I do not see that as a big problem.

OK

I can reserve the static buffer (10 pages) in suspend.c and mark it as nosave.
The code that creates the mappings can stay in suspend.c either except it
won't need to call get_usable_page() and free_eaten_memory() any more
(__next_page() can be changed to get pages from the static buffer instead
of allocating them).  The code can also be simplified a bit, as we assume that
there will be only one PGD entry in the direct mapping.

If that sounds good to you, please confirm.

Greetings,
Rafael
