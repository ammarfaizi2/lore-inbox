Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbQLLKZ4>; Tue, 12 Dec 2000 05:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130121AbQLLKZq>; Tue, 12 Dec 2000 05:25:46 -0500
Received: from pusa.informat.uv.es ([147.156.24.61]:46088 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S129756AbQLLKZa>; Tue, 12 Dec 2000 05:25:30 -0500
Date: Tue, 12 Dec 2000 10:54:58 +0100
To: linux-kernel@vger.kernel.org
Subject: BUG and fix: area->map's size is incorrect
Message-ID: <20001212105458.A19546@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

the bug doesn't impact stability but wastes memory, when more memory
you have more memory you waste. please look this, it's a ONE line patch!

this is an email I sent here two weeks ago, since I've got no reply (and
neigher from linux-mm) i resend it to again, I've also attached aditional 
info at the end

On Thu, Nov 30, 2000 at 10:17:42AM +0100, ulisses wrote:
> 
> In a 2.4 kernel, mm/page_alloc.c:free_area_init_core(), in the following
> assignement...
> 
> 	bitmap_size = size >> i;
> 
> ...makes bitmap_size be the double of the needed size, this calculum
> assumes that with a 512 byte map size the kernel is mapping 8*512= 4096 chunks 
> of memory, that is: one bit of the map is used for each chunk of memory, 
> and that's not true. 
> 
> Really one bit of area->map is used to map two chunks of memory, so in the 
> example above an area->map of just 256 bytes is really needed, the other 256
> bytes are _never accessed_.
> 
> So the righ thing would be to do is:
> 
> 	bitmap_size = size >> (i+1);
> 
> 
> also I tested it and it works ok, so I believe I'm right...
> 
> 
> Please CC: your replies to (I'm not subscribed to this list)
> 
> Ulisses Alonso Camaró	<uaca@NOSPAM.alumni.uv.es>	
> 
> PD: my nick on #kernelnewbies is despistao

an easy to understand indicator to see that I am right is to see 
(for instance) how a page index of area->map is calculated, 
in __free_pages_ok() we can see the following:

page_idx = page - base;		
index = page_idx >> (1 + order);	

Imagine the order is 0, that is a continious block of PAGE_SIZE size,
we still shift page_idx one bit, that is two blocks of "order" size are 
maped in each bit of area->map

you can also see that MARK_USED macro also makes this shift

Please CC: your replies to (I'm not subscribed to this list)
 
Ulisses Alonso Camaró	<uaca@NOSPAM.alumni.uv.es>	
 
PD: my nick on #kernelnewbies is despistao

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
