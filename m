Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267840AbTAHSW5>; Wed, 8 Jan 2003 13:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTAHSW5>; Wed, 8 Jan 2003 13:22:57 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:60434 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267838AbTAHSWz>; Wed, 8 Jan 2003 13:22:55 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
	methods
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0301081142190.21171-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0301081142190.21171-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Jan 2003 02:19:51 +0800
Message-Id: <1042050026.982.172.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 18:47, Geert Uytterhoeven wrote:
> On Tue, 7 Jan 2003, James Simmons wrote:
> > > Why? (a) only those which will use putcs, and (b) I see no 512 chars limit
> > > anywhere in new code. And in old code it is there only because of passed
> > > data are only 16bit, not 32bit wide... With simple search&replace you can
> > > extend it to any size you want, as long as you'll not use sparse font
> > > bitmap.
> > 
> > The current "core" console code screen_buf layout is designed after VGA 
> > text mode. 16 bits which only 8 bits are used to represent a character, 9 
> > if you have high_fonts flag set. The other 8,7 bits are for attributes. 
> > This is very limiting and it does effect fbcon.c :-( I like to the console
> > system remove these awful limitation in the future. This why I like to see 
> > fbdev drivers avoid touching strings from the console layer.
> 
> Please note that Tony's new accel_putcs() code uses __u32 to pass the character
> indices.  So it's not limited to 256/512 characters per font. Fonts can be as
> large as you want. Sparse fonts can be handled as well, if accel_putcs() takes
> care of the conversion from sparse character indices to dense character
> indices.
> 
> His code can be viewed as a way to do multiple monochrome to color expansions
> with one single call, using a predefined table of patterns. Quite generic,
> unless you want to have multi-color fonts later :-)
> 
:-) I did not want prolong the discussion, but...

Geert is correct that the functions are generic. The fb_putcs() and
fb_setfont() can be compared to Tile blitting.  Tile blitting is a
common operation in some games such as Warcraft, Starcraft, and most
RPG's. I'm think there is Tile Blitting support in DirectFB.

In a tile-based game, the basic unit is a Tile which is just a bitmap
with a predefined width and height. The game has several tiles stored in
memory each with it's own unique id.  To draw the background/layer, a
TileMap is constructed which is basically another array.  Its format is
something like this -  TileMap[x] = y which means draw Tile y at screen
position x.

In the fbcon perspective, we can think of each character as a Tile, and
fontdata as the collection of tiles. fb_char.data is basically a
TileMap.  Of course, tile blitting in games is more complicated than
this, since games have multiple layers for the background, so layer
position, transparency, etc has to be considered.

So maybe if we can rename fb_putcs() to fb_tileblit(), fb_setfont() to
fb_loadtiles(), struct fb_chars to struct fb_tilemap and struct
fb_fontdata to struct fb_tiledata, maybe it will be more acceptable?

It can be even be expanded by including fb_tiledata.depth
fb_tiledata.cmap so we can support multi-colored tiled blitting.

Tony




