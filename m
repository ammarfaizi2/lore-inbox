Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132546AbQL1WsL>; Thu, 28 Dec 2000 17:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbQL1WsB>; Thu, 28 Dec 2000 17:48:01 -0500
Received: from Cantor.suse.de ([194.112.123.193]:38158 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132546AbQL1Wrt>;
	Thu, 28 Dec 2000 17:47:49 -0500
Date: Thu, 28 Dec 2000 23:17:22 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001228231722.A24875@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 12:59:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 12:59:22PM -0800, Linus Torvalds wrote:
>  - we absolutely do _not_ want to make "struct page" bigger. We can't
>    afford to just throw away another 8 bytes per page on adding a new list
>    structure, I feel. Even if this would be the simplest solution.

BTW..

The current 2.4 struct page could be already shortened a lot, saving a lot
of cache.
(first number for 32bit, second for 64bit) 

- Do not compile virtual in when the kernel does not support highmem
(saves 4/8 bytes) 
- Instead of having a zone pointer mask use a 8 or 16 byte index into a 
zone table. On a modern CPU it is much cheaper to do the and/shifts than
to do even a single cache miss during page aging. On a lot of systems 
that zone index could be hardcoded to 0 anyways, giving better code.
- Instead of using 4/8 bytes for the age use only 16bit (FreeBSD which
has the same swapping algorithm even only uses 8bit) 
- Remove the waitqueue debugging (obvious @)
- flags can be __u32 on 64bit hosts, sharing 64bit with something that
is tolerant to async updates (e.g. the zone table index or the index) 
- index could be probably u32 instead of unsigned long, saving 4 bytes
on i386

Would you consider patches for any of these points? 


-Andi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
