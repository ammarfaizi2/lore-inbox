Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSKXXcn>; Sun, 24 Nov 2002 18:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSKXXcn>; Sun, 24 Nov 2002 18:32:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48648 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261914AbSKXXcm>; Sun, 24 Nov 2002 18:32:42 -0500
Date: Mon, 25 Nov 2002 00:39:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Martin Mares <mj@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-ram: don't crash when kernel gets big
Message-ID: <20021124233954.GA6579@atrey.karlin.mff.cuni.cz>
References: <20021124225125.GA5115@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33L2.0211241535050.21261-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211241535050.21261-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> | > > +	pushl	$0			# Kill any dangerous flags
> | > > +	popfl
> | > > +	cli
> | > > +	cld
> | >
> | > Seems like you're trying to be 200% sure ;-)
> |
> | I was not sure if cli really *clears* it as name implies :-).
> 
> Yes, as Martin suggested.  8;)

Actually, as following proves, I wanted to be *300%* sure ;-).

        cli
        cld

# We are now probably running at something like 0x0000 : 0x1000
        call here
here:
        pop      %bx
        subw    $(here-wakeup_start), %bx
        shrw    $4, %bx

        # setup data segment
        movw    %cs, %ax
        addw    %bx, %ax
        movw    %ax, %ds                                        # Make
ds:0 point to wakeup_start
        movw    %ax, %ss
        mov     $(wakeup_stack-wakeup_code), %sp                #
Private stack is needed for ASUS board
        movw    $0x0e00 + 'S', %fs:(0x12)

        pushl   $0                                              # Kill
any dangerous flags
        popfl
        cli
        cld

Fixed now. [Not that it matters.]
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
