Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310424AbSCLFVX>; Tue, 12 Mar 2002 00:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCLFVM>; Tue, 12 Mar 2002 00:21:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26377 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310424AbSCLFVF>; Tue, 12 Mar 2002 00:21:05 -0500
Date: Mon, 11 Mar 2002 21:20:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D8C9C.3060208@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203112108140.1547-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Mar 2002, Jeff Garzik wrote:
>
> Dumb question, why create a separate request?

Because you need to anyway. Things like shutdown/suspend need to sync the
caches, and that's a command that needs to go down the pipe to the disk.

> Why not just have some way to wait for request X (and flag it for
> no-merge/barrier treatment, etc.)?  bios have end_io callbacks...

The bio's are just fragment descriptors, they don't really stand on their
own. A bio needs a request in order to move down to the driver.

The request is the place where you find the actual command - the bio just
contains the fragment data of the command.

Of course, the "just" is a big simplification. Since a block command can
be a chain of hundreds of blocks which each actually have a lifetime of
their own, unlike the network later, the fragments are a lot more
complicated than a "skb_frag_t".

So bio's are complex entities in themselves, and they have a life of their
own. It's just that you cannot send a raw bio to a device - the device
wouldn't know what to do with it.

		Linus

