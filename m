Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272093AbRH2V7P>; Wed, 29 Aug 2001 17:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272095AbRH2V7F>; Wed, 29 Aug 2001 17:59:05 -0400
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:9663 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S272093AbRH2V6r>; Wed, 29 Aug 2001 17:58:47 -0400
Date: Wed, 29 Aug 2001 23:20:28 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yenta resource allocation fix
Message-ID: <20010829232028.A2411@storm.local>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010829013318.A16910@storm.local> <Pine.LNX.4.33.0108290645140.8173-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108290645140.8173-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 06:48:26AM -0700, Linus Torvalds wrote:
> 
> On Wed, 29 Aug 2001, Andreas Bombe wrote:
> >
> > I have no idea why the 0xfff was in place.  Or, on second thought, this
> > might be to allocate memory space behind official end as slack?  This
> > would defy the end > start check then, anyway.  Linus?
> 
> I've looked more at the issue.
> 
> 0xfff is definitely right for memory windows and is generally right for
> PCI-PCI bridges too - they cannot have IO or memory windows that are
> anything but 4kB aligned.
> 
> But it turns out that the Yenta specification actually expanded on the
> PCI-PCI bridge window specs for IO space - a Yenta bridge is supposed to
> be able to handle IO windows at 4-byte granularity, not the 4kB a regular
> PCI bridge does.

Even then the old code would have been incorrect.  Further down the
yenta_allocate_res() function, allocate_resource() is called with
align = 1024 and size = 256 for IO port windows.  It also promptly got
0x1000-0x10ff and 0x1400-0x14ff allocated.

> Does this alternate patch work for you?

Ignoring the unrelated vmscan.c patch, yes, it works as it should,
thanks (I never hit the memory window case anyway, since that is
allocated fine before yenta.c gets to it).

About the other thing with missed card insertion events there is nothing
new.  I tried a few things but nothing helped.  There is the suspicious
thing that CB_SOCKET_STATE has CB_CBCARD always set, whether there is a
card or not, but I don't know enough of the code to see where it
matters.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
