Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264128AbRFDHC0>; Mon, 4 Jun 2001 03:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264129AbRFDHCR>; Mon, 4 Jun 2001 03:02:17 -0400
Received: from colorfullife.com ([216.156.138.34]:34829 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S264128AbRFDHCM>;
	Mon, 4 Jun 2001 03:02:12 -0400
Message-ID: <3B1B3268.2A02D2C@colorfullife.com>
Date: Mon, 04 Jun 2001 09:02:00 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: multicast hash incorrect on big endian archs
In-Reply-To: <3B1A9558.2DBAECE7@colorfullife.com> <15130.61778.471925.245018@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Manfred Spraul writes:
>  > I noticed that the multicast hash calculations assumed little endian
>  > byte ordering in the winbond-840 driver, and it seems that several other
>  > drivers are also affected:
>  >
>  > 8139too, epic100, fealnx, pci-skeleton, sis900, starfile, sundance,
>  > via-rhine, yellowfin
>  > perhaps drivers/net/pcmcia/xircom_tulip_cb
> 
> Many big-endian systems already need to provide little-endian bitops,
> for ext2's sake for example.
> 
> We should formalize this, with {set,clear,change,test}_le_bit which
> technically every port has implemented in some for or another already.
>
The multicast hash is written into a nic register with

	set_bit(crc(...),mc_list);
	...
	out{b,w,l}(mc_list[i],ioaddr);

set_bit_le only helps for outb. My patch uses set_bit_16 and set_bit_32.

Another option would be
	set_bit_le(crc(...),mc_list)
	...
	out{w,l}(le{16,32}_to_cpu(mc_list[i]),ioaddr);

but I think set_bit_{8,16,32,64} are the better solution.

Obviously we could move them into a header file.

--
	Manfred
