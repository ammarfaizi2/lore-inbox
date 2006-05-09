Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWEIOlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWEIOlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWEIOlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:41:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751773AbWEIOk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:40:59 -0400
Date: Tue, 9 May 2006 07:40:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, manfred@colorfullife.com, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0605090737500.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>
  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost>
 <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 May 2006, Christoph Lameter wrote:
>
> On Mon, 8 May 2006, Pekka Enberg wrote:
> 
> > > I think it sounds like it's worth it, but I'm not going to really push it.
> > 
> > Sounds good to me. Andrew?
> 
> virt_to_page is not cheap on NUMA.

Right now the __cache_free() chain does "virt_to_page()" on NUMA 
regardless, through the

	#ifdef CONFIG_NUMA
	        {
	                struct slab *slabp;
	                slabp = virt_to_slab(objp);
	,,,

thing. The suggested patch obviously makes it do it _twice_: once to get 
the cachep, once to get the slabp. But some simple re-organization would 
make it do it just once, if we passed in the "struct page *" instead of 
the "struct cachep" - since in the end, every single path into the real 
core of the allocator does end up needing it.

			Linus
