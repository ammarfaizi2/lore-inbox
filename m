Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSJEDOk>; Fri, 4 Oct 2002 23:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbSJEDOj>; Fri, 4 Oct 2002 23:14:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23256 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261973AbSJEDOj>;
	Fri, 4 Oct 2002 23:14:39 -0400
Date: Fri, 4 Oct 2002 23:20:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.LNX.4.44.0210041851410.1253-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210042314130.21637-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Linus Torvalds wrote:

> The more I think about this, the more convinced I am this is the case. We
> just _mustn't_ set up a live PCI window at address 0, and expect it to not
> cause confusion.
> 
> Also, we've seen before that we must not blindly disable a PCI window
> either, since that will kill the system when the host bridge is disabled
> and there is any pending DMA, for example (*). We saw that earlier in the
> 2.4.x tree - some host bridges will just ignore the disable (which means
> that then we'd trigger the zero-base bug), and others will honour the
> disable (which in turn will cause the DMA and other random problems).
> 
> This is all probably dependently on host bridge / MCH behaviour, so it
> probably works fine on 90%+ of all machines, but clearly breaks enough to
> not be a viable approach in general.

It's getting better.  The thing _does_ survive if there is no cacheline
boundary between the calls of pci_write_config_dword(); otherwise it
dies on that boundary.  So it depends not only on machine and compiler,
but on kernel config, and in a pretty random way (functions are aligned,
indeed, but not cacheline-aligned, so change of length in a function can
shift the rest of image relative to cachelines).

