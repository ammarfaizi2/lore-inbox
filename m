Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293645AbSCATYT>; Fri, 1 Mar 2002 14:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293648AbSCATYK>; Fri, 1 Mar 2002 14:24:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293645AbSCATX6>;
	Fri, 1 Mar 2002 14:23:58 -0500
Message-ID: <3C7FD550.DCB0D3F5@mandrakesoft.com>
Date: Fri, 01 Mar 2002 14:24:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Various 802.1Q VLAN driver patches. [try3]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <20020301183059.V23151@mea-ext.zmailer.org> <3C7FB6F1.1040801@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> --- linux/drivers/net/tulip/interrupt.c Fri Nov  9 22:45:35 2001
> +++ linux.dev/drivers/net/tulip/interrupt.c     Tue Dec 11 09:24:36 2001
> @@ -128,8 +128,8 @@
>                                    dev->name, entry, status);
>                 if (--rx_work_limit < 0)
>                         break;
> -               if ((status & 0x38008300) != 0x0300) {
> -                       if ((status & 0x38000300) != 0x0300) {
> +               if ((status & (0x38000000 | RxDescFatalErr | RxWholePkt)) != RxWholePkt) {
> +                       if ((status & (0x38000000 | RxWholePkt)) != RxWholePkt) {
>                                 /* Ingore earlier buffers. */
>                                 if ((status & 0xffff) != 0x7fff) {
>                                         if (tulip_debug > 1)
> @@ -155,10 +155,10 @@
>                         struct sk_buff *skb;
> 
>  #ifndef final_version
> -                       if (pkt_len > 1518) {
> +                       if (pkt_len > 1522) {
>                                 printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\n",
>                                            dev->name, pkt_len, pkt_len);
> -                               pkt_len = 1518;
> +                               pkt_len = 1522;
>                                 tp->stats.rx_length_errors++;
>                         }


Tulip handles fragmented packets by choking hard.  I'll probably copy
the fragmented-packed slow path from 8139cp.c, which will change this
patch immensely.

The REAL vlan tulip patch will look almost exactly like the 8139cp patch
in 2.5.6-pre2.

	Jeff




-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
