Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268716AbUIBUNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268716AbUIBUNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUIBUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:13:13 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:49559
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268716AbUIBUM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:12:29 -0400
Date: Thu, 2 Sep 2004 13:10:57 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: benh@kernel.crashing.org, akpm@osdl.org, wli@holomorphy.com,
       davem@redhat.com, raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040902131057.0341e337.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
	<20040815165827.0c0c8844.davem@redhat.com>
	<Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
	<20040815185644.24ecb247.davem@redhat.com>
	<Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<1094012689.6538.330.camel@gaston>
	<Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com>
	<1094080164.4025.17.camel@gaston>
	<Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com>
	<20040901215741.3538bbf4.davem@davemloft.net>
	<Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 09:24:47 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Why was it done that way? Would it not be better to add the new
> functionality by giving the function another name?
> 
> Like f.e. set_pte_mm()
> 
> then one could add the following in asm-generic/pgtable.h
> 
> #ifndef __HAVE_ARCH_SET_PTE_MM
> #define set_pte_mm(mm, address, ptep, pte) set_pte(ptep, pte)
> #endif
> 
> which would avoid having to update the other platforms and woud allow a
> gradual transition.

In order for it to be useful, every set_pte() call has to get the
new args.  If there are exceptions, then it doesn't work out cleanly.

All of the call sites of set_pte() have the information available,
so implementing it properly in all cases is nearly trivial, it's
just a lot of busy work.  So we should get it over with now.

I did all of the generic code, it's just each platform's code that
needs updating.

And BTW it's not just set_pte(), it's also pte_clear() and some of
the other routines that need the added mm and address args.
