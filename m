Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWCWF06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWCWF06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWCWF06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:26:58 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:16598
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP id S932112AbWCWF05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:26:57 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: Re: BIOS causes (exposes?) modprobe (load_module) kernel oops
Date: Wed, 22 Mar 2006 21:26:56 -0800
User-Agent: KMail/1.5.2
References: <200603212005.58274.jzb@aexorsyst.com> <1143018365.2955.49.camel@laptopd505.fenrus.org> <200603221948.00568.jzb@aexorsyst.com>
In-Reply-To: <200603221948.00568.jzb@aexorsyst.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222126.56720.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 19:48, John Z. Bohach wrote:
> On Wednesday 22 March 2006 01:06, Arjan van de Ven wrote:
> > On Tue, 2006-03-21 at 20:05 -0800, John Z. Bohach wrote:
> > > Linux 2.6.14.2, yeah, I know, and sorry if this has been fixed...but
> > > read on, please, this is a new take...
> >
> > at least enable CONFIG_KALLSYMS to get us a readable backtrace
>
> I'll do you one better:  here's the failing line from module.c:
>
> 	/* Determine total sizes, and put offsets in sh_entsize.  For now
> 	   this is done generically; there doesn't appear to be any
> 	   special cases for the architectures. */
> 	layout_sections(mod, hdr, sechdrs, secstrings);
>
> 	/* Do the allocs. */
> 	ptr = module_alloc(mod->core_size);
> 	if (!ptr) {
> 		err = -ENOMEM;
> 		goto free_percpu;
> 	}
> !!! --->	memset(ptr, 0, mod->core_size);
> 	mod->module_core = ptr;
>

Let me summarize this a little better:

ptr = module_alloc(mod->core_size);

is fine, but when a few lines later, memset() tries to operate on that same
ptr to zero it out with

memset(ptr, 0, mod->core_size);

I get:

Unable to handle kernel paging request at virtual address f8806000
(f8806000 is (in this case) the value of ptr returned by module_alloc()).

I've validated the parameters, they all look okay.  I think the page fault for ptr
is normal(?), and the page fault handler is suppossed to set up this page???
but fails...

Yet it succeeds with a different BIOS and bootloader, is what I'm trying to say.

So it seems that the page fault handler is somehow affected by something that the
BIOS has/has not done, long after the system has booted and been running, with
many page faults under its belt...now I've seen it all...or not.

