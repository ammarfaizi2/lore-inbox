Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWB0Mrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWB0Mrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWB0Mrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:47:45 -0500
Received: from kanga.kvack.org ([66.96.29.28]:23008 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750874AbWB0Mro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:47:44 -0500
Date: Mon, 27 Feb 2006 09:47:37 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Largret <largret@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060227154737.GA4463@dmt.cnet>
References: <5KvnZ-4uN-27@gated-at.bofh.it> <4401F5E3.3090003@shaw.ca> <20060226215627.GB4979@dmt.cnet> <1140987370.5178.9.camel@shogun.daga.dyndns.org> <20060227002254.GA4393@dmt.cnet> <1141004895.17427.13.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141004895.17427.13.camel@shogun.daga.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 05:48:15PM -0800, Chris Largret wrote:
> On Sun, 2006-02-26 at 18:22 -0600, Marcelo Tosatti wrote:
> > On Sun, Feb 26, 2006 at 12:56:10PM -0800, Chris Largret wrote:
> > > $ readelf -S vmlinux
> > > There are 52 section headers, starting at offset 0x2548488:
> > 
> > <snip>
> > 
> > >   [49] .shstrtab         STRTAB           0000000000000000  02548212
> > >        0000000000000273  0000000000000000           0     0     1
> > >   [50] .symtab           SYMTAB           0000000000000000  02549188
> > >        00000000000b3898  0000000000000018          51   20791     8
> > >   [51] .strtab           STRTAB           0000000000000000  025fca20
> > >        0000000000096692  0000000000000000           0     0     1
> > 
> > More than 40MB, that should partially explain it...
> 
> Ouch. I hadn't noticed that and will have to see about bringing that
> down a little. It's the same size when compiling without SMP, and the
> OOM Killer doesn't cause problems then. There is something else that is
> causing these problems.

Indeed, this only explains why the DMA zone is full.

The floppy driver is asking for a large contiguous chunk of memory
in the DMA zone, which the allocator tries to satistify by killing
applications.

Andrew's patch makes the allocator give up easier, which allows the
driver to fallback to non-contiguous memory (that is the real problem).

> >From using ls on the *.o files, it appears (as expected) that most of
> this is the built-in drivers. The pruning should be fun. :)

There should be no need to prune it to fix the OOM issue, it explains
why the DMA memory is full though.

