Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281015AbRKOTxC>; Thu, 15 Nov 2001 14:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281018AbRKOTww>; Thu, 15 Nov 2001 14:52:52 -0500
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:41299 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281015AbRKOTws>; Thu, 15 Nov 2001 14:52:48 -0500
Message-ID: <3BF41CF5.A88DC57E@mandrakesoft.com>
Date: Thu, 15 Nov 2001 14:52:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: harish.vasudeva@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Info on ScatterGather
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F0197A319@caexmta9.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

harish.vasudeva@amd.com wrote:
> 
> Hi All,
> 
>  I believe in the 2.4.x kernel LAN drivers can ask for scattered buffers on transmit. Is that what the NETIF_F_SG parm talks about?
> 
>  Also, on the receive side, is buffer chaining possible? ie, if the device gives us 2 buffers (for a single frame), can the driver send those 2 buffers directly to the OS or should the driver combine it into a single buffer before calling netif_rx ()


You need to fix your word wrap.

For transmit, NETIF_F_SG asks for scattered buffers, yes.  BUT.  You
need one of NETIF_F_HW_CSUM or NETIF_F_IP_CSUM along with it.  Otherwise
NETIF_F_SG is useless.  NETIF_F_HW_CSUM is for hardware that can
checksum a region of data. NETIF_F_IP_CSUM is for lesser hardware that
can only perform IP checksum on a pre-specified region of data.  
NETIF_F_IP_CSUM doesn't support IPv6 checksums for example, while
NETIF_F_HW_CSUM supports any protocol checksum.

For receive, you enable IP checksumming in a NIC-specific manner.  See
the long comment at the beginning of include/linux/skbuff.h.  If you
have lesser hardware that simply verifies the checksum, then you set
skb->ip_summed = CHECKSUM_UNNECESSARY, and value of skb->csum is
undefined.  If you have good network hardware, that supports checksum of
any region, then set skb->ip_summed = CHECKSUM_HW, and store the value
of the checksum in skb->csum.

Buffer chaining on Rx is possible.  Most people do not bother to
implement it, though, and instead ensure that the NIC always delivers
one packet in one buffer.  You have two options for Rx buffer chaining: 
store in skb_shinfo(skb)->frag_list, or skb_shinfo(skb)->frags array.
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

