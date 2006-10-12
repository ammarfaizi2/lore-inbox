Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWJLOLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWJLOLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWJLOLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:11:42 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:59373 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030295AbWJLOLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:11:40 -0400
Message-ID: <452E4D1A.9000409@grupopie.com>
Date: Thu, 12 Oct 2006 15:11:38 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
References: <20061012140422.93e7330c.maxextreme@gmail.com>
In-Reply-To: <20061012140422.93e7330c.maxextreme@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda Sandonis wrote:
> Andrew, here it is the patch for converting the cfag12864b driver
> to a framebuffer driver as Pavel requested and as I promised :)

Very nice :)

Just a few comments, see below.

> Pavel, yep, now I can login in my tiny 128x64 LCD.
> It is pretty amazing to run vi on it... ;)
> 
> Tested and working fine.
> ---
[...]
> +static void cfag12864b_update(void *arg)
[...]
> +	for (i = 0; i < CFAG12864B_CONTROLLERS; i++) {
> +		cfag12864b_controller(i);
> +		cfag12864b_nop();
> +		for (j = 0; j < CFAG12864B_PAGES; j++) {
> +			cfag12864b_page(j);
> +			cfag12864b_nop();
> +			for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
> +				cfag12864b_address(k);
> +				cfag12864b_nop();
> +				cfag12864b_nop();

Doesn't the LCD controller automatically advance the address when 
writing data?

If it does, the address should only be needed before this loop and you 
could write 64 bytes in a row without any "nop"'s. This should really 
improve the time it takes to refresh the display.

Also, keeping a "low level cache" of the physical display state and only 
sending bytes that have actually changed might be a good improvement too.

Remember, the host CPU is probably much much faster than your interface 
to the LCD, so if it takes a few cycles to check the cache and decide 
not to send a byte, it's already a big win. A simple memcmp might be 
used skip full pages.

Also, what do these "nop"'s do? Isn't there a way to read the "busy" 
status from the controller and just write as fast as possible?

> [...]
> +	  The LCD framebuffer driver can be attached to a console.
> +	  It will work fine. However, you can't attach it to the fbdev driver
> +	  of the xorg server.

This is probably because your driver can't be mmapped, no?

Although the controller is only accessible through the parallel port, it 
might be possible to mmap it. I vaguely remember that when I was reading 
LDD3, I thought that this should be doable in a sequence like:

  - accept the mmap as if you had the memory for the device available
  - at "nopage" time, mark the buffer as "dirty" and map it to user space
  - using a timer at the actual refresh rate, check the dirty flag. If 
it is dirty, unmap the buffer and refresh the display

I'm not describing the locking details (and a lot of other details, 
too), but it should work in principle.

It will probably make things easier if your buffer size is PAGE_SIZE, 
and your "internal" operations (fillrect, copyarea, imageblit) also work 
over the same buffer and just mark the buffer as dirty.

I don't know if X will be able to run in 128x64, but it is easier to 
make applications mmap the buffer and use it directly.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
