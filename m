Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUDJLxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 07:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUDJLxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 07:53:06 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:35601 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262003AbUDJLxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 07:53:02 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.2/2.4/2.6] broken memsets in net/sk_mca.c (multicast)
Date: Sat, 10 Apr 2004 14:52:51 +0300
User-Agent: KMail/1.5.4
Cc: Alfred Arnold <aarnold@elsa.de>, Jeff Garzik <jgarzik@pobox.com>
References: <20040410102040.022ffb3c.khali@linux-fr.org>
In-Reply-To: <20040410102040.022ffb3c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404101450.55800.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 April 2004 11:20, Jean Delvare wrote:
> [Please CC: me on reply, I'm not subscribed (yet)]
>
> Hi all,
>
> I just found two very weird memsets in drivers/net/sk_mca.c. I am not
> working on that driver at all, but some grepping of the kernel source
> pointed me to it so I thought I wouldn't keep quiet about it.
>
> Here is the offending code:
>
> static void skmca_set_multicast_list(struct net_device *dev)
> {
> 	(...)
> 	if (dev->flags & IFF_ALLMULTI) {	/* get all multicasts */
> 		memset(block.LAdrF, 8, 0xff);
> 	} else {		/* get selected/no multicasts */
> 		(...)
> 		memset(block.LAdrF, 8, 0x00);
> 		(...)
> 	}
> 	(...)
> }
>
> Is it just me, or are these two memsets just plain broken? Not only the
> size is hardcoded, but the parameters are swapped! I guess that this
> driver never worked in multicast mode. The correct memsets are
> obviously:
> 		memset(block.LAdrF, 0xff, sizeof(block.LAdrF));
> and
> 		memset(block.LAdrF, 0x00, sizeof(block.LAdrF));
> respectively.
>
> The odd thing is that the bug is there since the driver was introduced
> in the 2.2.10 kernel. So, 2.2, 2.4 and 2.6 kernels are all affected.
>
> I admit I'm a bit surprized that this could survive until today, so just
> tell me if it's me missing the point ;)

Good catch!

No, I don't think you're missing the point. There are lots of drivers,
and unlike core kernel code, drivers have corner cases which are never
tested. Work on drivers is always welcome.

Feel free to make patch and submit it to Jeff Garzik <jgarzik@pobox.com>.
For 2.2 and 2.4, I think you can CC kernel maintainers too.
--
vda

