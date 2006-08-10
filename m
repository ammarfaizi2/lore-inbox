Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWHJFnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWHJFnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWHJFnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:43:04 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59781 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932387AbWHJFnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:43:01 -0400
Date: Thu, 10 Aug 2006 14:44:51 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: mpm@selenic.com, npiggin@suse.de, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta
 information
Message-Id: <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
	<20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 22:13:27 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 10 Aug 2006, KAMEZAWA Hiroyuki wrote:
> 
> > > There is no freelist for slabs. slabs are immediately returned to the page
> > > allocator.  The page allocator has its own per cpu page queues that should provide
> > > enough caching.
> > > 
> > 
> > I think that the advantage of Slab allocator is 
> > - object is already initizalized at setup, so you don't have to initialize it again at
> >   allocation.
> > - object is initialized only once when slab is created.
> 
> If you do that then you loose the cache hot advantage. It is advantageous 
> to initialize the object and then immediately use it. If you initialize it 
> before then the cacheline will be evicted and then brought back.

hmm, I don't know precise analization of the perfromance benefit of slab on
current (Linux + Fast CPU/Bus + Large Cache) systems. I'm grad if you show the
performance of new "Simple Slab" next time.

> 
> > If a slab page is returned to page allocator ASAP, # of object initilization may
> > increase. 
> 
> The initializers in the existing slab are only used in rare cases in the 
> kernel.
> 
> 

Because of inode_init_once, many codes which uses inode uses initilization code.
And inode is one of heavy users of slab.

[kamezawa@aworks linux-2.6.18-rc4]$ grep init_once /proc/kallsyms
c0155cdf t init_once
c0163e00 t init_once
c016ef02 t init_once
c0172a01 T inode_init_once
c0172b77 t init_once
c0187704 t init_once
c019a19f t init_once
c01aa643 t init_once
c01abd3f t init_once
c01acdab t init_once
c01b2500 t init_once
c01d3139 t init_once
c01db8b3 t init_once
c02f9a62 t init_once
c0358ab5 t init_once
c03b9f6c r __ksymtab_inode_init_once
c03c28fe r __kstrtab_inode_init_once

performance measurement related to inode will show good data. maybe

Thanks,
- Kame

