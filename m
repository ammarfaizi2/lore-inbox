Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263946AbUDZOF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUDZOF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUDZOFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:05:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56554 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263881AbUDZNvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:51:43 -0400
Date: Mon, 26 Apr 2004 15:08:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040426130807.GL2595@openzaurus.ucw.cz>
References: <E1B6on4-0005EW-00@gondolin.me.apana.org.au> <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426094834.GA4901@gondor.apana.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Mon 26-04-04 19:48:34, Herbert Xu wrote:
> > Yes, but as I wrote, only on one of the machines in question.
> 
> OK, I've finally found out why agpgart locks up the machine upon
> resuming from swsusp/pmdisk.
> 
> The reason is that the gatt table is remapped with ioremap_nocache,
> which on i386 machines capable of PSE will result in 4M pages being
> split.
> 
> When swsusp/pmdisk copies the pages back, the top page table is
> written before the entries that it points to are filled in.
> Depending on whether the second-level table lies before or after
> the 4M-page in question, this will result in a page fault.
> 
> A simple solution is to copy the pages in reverse.  This way the
> top page table is filled in last which should resolve this particular
> issue.  The following patch does exactly that and fixes the problem
> for me.

Thanks a lot for figuring this out!

But... I do not like the fix. It does depend on memory layout on
very subtle way.

What about switching to temporary, PSE-enabled pagetables
in nosave area for suspend? Copying pagetables soon after boot
should do the trick.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

