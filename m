Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRGIPUW>; Mon, 9 Jul 2001 11:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRGIPUM>; Mon, 9 Jul 2001 11:20:12 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:36357 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261289AbRGIPT7>; Mon, 9 Jul 2001 11:19:59 -0400
Date: Mon, 9 Jul 2001 16:19:47 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: =?iso-8859-1?Q?Fran=E7ois_romieu?= <romieu@zoreil.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New FarSync T-Series driver
Message-ID: <20010709161947.B15379@xyzzy.clara.co.uk>
In-Reply-To: <20010703182803.A13853@xyzzy.clara.co.uk> <20010704161845.A27070@zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010704161845.A27070@zoreil.com>; from romieu@zoreil.com on Wed, Jul 04, 2001 at 04:18:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the freedback guys.

Revised versions of the driver patches against 2.4.6-ac2 and 2.4.7-pre3
are available at:
http://www.xyzzy.clara.co.uk/farsync/farsync-patch-2.4.6ac2.gz and
http://www.xyzzy.clara.co.uk/farsync/farsync-patch-2.4.7pre3.gz



On Wed, Jul 04, 2001 at 04:18:45PM +0200, François romieu wrote:
> Just my HO:
Hey it's all good feedback.


> * error_1, error_2... error_n labels are ugly;
I don't like goto's either but in this function the structure kinda demands
it. Lot's of points where you fail and need to release an increasing list of
resources. Not sure a list of labels like this is any better.
    err_out_free_iqrx:
    err_out_free_iqtx:
    err_out_free_irq:
    err_out_iounmap:
    err_out_free_mmio_region:
    err_out_free_mmio_region0:
    err_out:

I've left this one as it is for the present. I have removed the gotos from
fst_open() however.


> * ioremap may fail;
Fixed that one, although it did add a "goto error_6" :-(


> * mix of spin_lock and FST_LOCK isn't nice (kill the latter ?);
Quite correct. Un-helpful information hiding. I've unwound the macros in
place and removed them.


> +                offset = BUF_OFFSET ( rxBuffer[pi][i]);
> [...]
> +                                card->mem + BUF_OFFSET ( rxBuffer[pi][rxp][0]),
> A bit of a macro abuse imho.
Not quite sure what you mean here. I have corrected the code so that BUF_OFFSET
sees a consistent argument.


> +        if ( ++port->txpos >= NUM_TX_BUFFER )
> +                port->txpos = 0;
> 
> Why not:
> port->txpos++;
> foo = port->txpos%NUM_TX_BUFFER;
I think mine is clearer but then I've always bumped and wrapped pointers and
indexs that way. Another alternative would be:
    port->txpos = ( port->txpos + 1 ) % NUM_TX_BUFFER;

Looks cleaner than both and lets the compiler decide, but if the % operator
produces a div operation instead of a mask on even one processor type then I
think we lose. If anyone can prove there's an optimal way to do this sort of
bump and wrap operation I'll gladly adopt it.


And finally one from Alan Cox:
> Don't assume short is 16bits. It is so far but that might change
> Use u8/u16/u32 (or for user exposed structs __u16/__u32 etc)
Oh God! how did I miss that one!
And after I'd taken the NT driver writers to task over the same issue :(
Still corrected now.

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
