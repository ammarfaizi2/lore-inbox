Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUF1U1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUF1U1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUF1U1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:27:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265198AbUF1U1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:27:48 -0400
Date: Mon, 28 Jun 2004 13:25:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Scott Wood <scott@timesys.com>
Cc: oliver@neukum.org, zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040628132531.036281b0.davem@redhat.com>
In-Reply-To: <20040628141517.GA4311@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406270631.41102.oliver@neukum.org>
	<20040626233423.7d4c1189.davem@redhat.com>
	<200406271242.22490.oliver@neukum.org>
	<20040627142628.34b60c82.davem@redhat.com>
	<20040628141517.GA4311@yoda.timesys>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 10:15:17 -0400
Scott Wood <scott@timesys.com> wrote:

> On Sun, Jun 27, 2004 at 02:26:28PM -0700, David S. Miller wrote:
> > On Sun, 27 Jun 2004 12:42:21 +0200
> > Oliver Neukum <oliver@neukum.org> wrote:
> > 
> > > OK, then it shouldn't be used in this case. However, shouldn't we have
> > > an attribute like __nopadding__ which does exactly that?
> > 
> > It would have the same effect.  CPU structure layout rules don't pack
> > (or using other words, add padding) exactly in cases where it is
> > needed to obtain the necessary alignment.
> 
> No, it wouldn't, as you could drop the assumption that the base of
> the struct can be misaligned.  Thus, the compiler only needs to
> generate unaligned loads and stores for fields which are unaligned
> within the struct, which in this case would be none of them.
> 
> While it's rather unlikely that a struct like this one would ever
> need packing, it would help those structs that do need it by reducing
> the number of fields subjected to unaligned loads and stores.

That's true.  But if one were to propose such a feature to the gcc
guys, I know the first question they would ask.  "If no padding of
the structure is needed, why are you specifying this new
__nopadding__ attribute?"

I think it's bad to just "smack this attribute onto any structure that
_MIGHT_ need it on some platform"  I never do that in my drivers,
and they work on all platforms.  For example, if you have a simple
DMA descriptor structure such as:

	struct txd {
		u32 dma_addr;
		u32 length;
	};

It is just total and utter madness to put a packed or the proposed
__nopadding__ attribute on that structure.  Yet this seems to be
what was suggested now and at the beginning of this thread.
