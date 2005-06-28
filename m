Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVF1Q0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVF1Q0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVF1Q0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:26:17 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:46609 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262137AbVF1Q0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:26:05 -0400
To: "Al Boldi" <a1426z@gawab.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kswapd flaw
References: <200506281535.SAA30164@raad.intranet>
From: Nix <nix@esperi.org.uk>
X-Emacs: well, why *shouldn't* you pay property taxes on your editor?
Date: Tue, 28 Jun 2005 17:25:51 +0100
In-Reply-To: <200506281535.SAA30164@raad.intranet> (Al Boldi's message of
 "Tue, 28 Jun 2005 18:35:00 +0300")
Message-ID: <8764vy4fe8.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Al Boldi murmured woefully:
> Nix wrote:{
> I don't think so, except on a process-by-process basis via mlockall().
> (/proc/sys/vm/swappiness lets you say that swapping is more or less
> desirable, but under enough memory pressure paging *will* happen regardless
> of the value of that variable.)
> 
> But I'm mystified as to why you might want to suppress paging. The only
> effect of suppressing it is to reduce the amount of memory you can allocate
> before you run completely out and start killing things.
> }
> 
> Nix,
> You start killing things because you overcommitted, when you were not
> supposed to fault in the first place because you have no swap.

The only thing that is blocked by having no swap is swapping. The only
things that go to swap are things that can't go anywhere else (because
swap is comparatievly slow). As far as I know, the only things that land
in swap are modified private writable file-backed mappings
(e.g. relocations in text sections of programs), and allocated anonymous
mappings (what most people think of as `data'). (Data allocated via
brk() is of the latter type.)

So if swap is turned off, the kernel can still acquire more memory when
short by discarding file-backed pages from the page cache --- this
includes non-modified text pages of programs and modified non-private
file mappings, as well as data read/written via read() and write().

That is, with no swapfile, the kernel can't swap. It can still *page*,
pushing stuff out to files if modified, throwing them out of memory if
not, and reloading them from their original file when needed.

> ( I couldn't find /proc/sys/vm/swappiness in 2.4, although I heard about it
> in 2.6.)

Yeah, it's a 2.6 thing.

-- 
`I lost interest in "blade servers" when I found they didn't throw knives
 at people who weren't supposed to be in your machine room.'
    --- Anthony de Boer
