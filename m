Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVAHWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVAHWJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVAHWGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:06:12 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:43435
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261969AbVAHWBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:01:53 -0500
Date: Sat, 8 Jan 2005 13:56:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, akpm@osdl.org, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
Message-Id: <20050108135636.6796419a.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005 21:12:10 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> Christoph, a late comment: doesn't this effectively replace
> do_anonymous_page's clear_user_highpage by clear_highpage, which would
> be a bad idea (inefficient? or corrupting?) on those few architectures
> which actually do something with that user addr?

Good catch, it probably does.  We really do need to use
the page clearing routines that pass in the user virtual
address when preparing new anonymous pages or else we'll
get cache aliasing problems on sparc, sparc64, and mips
at the very least.  That is what the virtual address argument
was added for to begin with.

The other way to deal with this is to make whatever routine
the kscrubd thing invokes do all the cache flushing et al.
magic so that the above works when taking pages from the
pre-zero'd pool (only, if no pre-zero'd pages are available
we sill need to invoke clear_user_highpage() with the proper
virtual address).
