Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135697AbRDSUit>; Thu, 19 Apr 2001 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135698AbRDSUig>; Thu, 19 Apr 2001 16:38:36 -0400
Received: from pop.gmx.net ([194.221.183.20]:22 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135696AbRDSUiN>;
	Thu, 19 Apr 2001 16:38:13 -0400
Message-ID: <3ADE6C70.5A12D80A@gmx.de>
Date: Thu, 19 Apr 2001 06:41:20 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: kambo@home.com
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PACKET_MMAP help
In-Reply-To: <10336.010418@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kambo@home.com wrote:
> 
> 1. for tp_frame_size, I dont want to truncate any data on ethernet, I
> need 1514 bytes, is this the best way to do it and not waste space?
> 
> static const int TURBO_FRAME_SIZE=
>      TPACKET_ALIGN(TPACKET_ALIGN(sizeof(tpacket_hdr)) +
>                    TPACKET_ALIGN(sizeof(struct sockaddr_ll)+ETH_HLEN) + 1500);

Looks OK.  Maybe instead of ETH_HLEN min(ETH_HLEN,16)?  The framesize
calculation is really strange...

> 2. what is tp_block_nr for?  I dont understand it, I just set it to 1
> and make tp_block_size big enough for all the frames I need, so its
> just one contiguous space, all I need is about a megabyte I think.

Better go the other way around - set tb_block_size to PAGE_SIZE and
tb_block_nr appropriate.  tb_block_size is the contiguous physical memory
the kernel tries to allocate.  Anything above PAGE_SIZE is likely to fail.
For you that would mean only 2 packets per 4k-page.  You could try to
start with bigger (power of 2) block sizes and go down to smaller ones if
it fails (ENOMEM). [1].  Btw, there's in implicit limit on tb_block_nr.
The vector to manage the blocks is kmalloc'ed and may not be larger than
128kb giving max 32768 blocks.  Hmm... moment... seems there's a similar
limit for tp_frame_nr (max 32768 frames).  I'm pretty sure _that_ limit
was not there when I worked with this during 2.3.  Not so nice on gigabit
ethernet :-(

> 3. is this the general approach for the api?
> [...]

Looks OK too.

>    if (tp->status == 0) poll() for pollin on the socket  /* is there a
>    race here? */

No race.

> 4. what does the copy threshold setsockopt tuning accomplish? doesnt it always
> have to copy anyway, to the mmaped area?

I haven't used it myself.  Reading the sources it does something different.
Afaics when active if there's a packet that has been truncated by the
framesize it is additionally stored in the socket's receive queue to be
fetched by a normal read/recv.  It notifies you about this by setting
the TP_STATUS_COPY bit.  So it seems to mean: copy to socket if threshold
(framesize) exceeded.

Ciao, ET.


[1] The PACKET_RX_RING sockopt accepts all block sizes that are a multiple
of PAGE_SIZE but always allocates a power of 2 size chunk.  So using non
power of 2 sizes will waste locked kernel memory.

