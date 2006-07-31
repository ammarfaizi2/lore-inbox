Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWGaSd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWGaSd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWGaSd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:33:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59885 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030259AbWGaSd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:33:56 -0400
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: "J.A. Magall?n" <jamagallon@ono.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44CE37CF.1010804@gmail.com>
References: <20060728134550.030a0eb8@werewolf.auna.net>
	 <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>
	 <44CE2908.8080502@gmail.com>
	 <1154363489.7230.61.camel@localhost.localdomain>
	 <20060731165011.GA6659@htj.dyndns.org>  <44CE37CF.1010804@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 19:52:52 +0100
Message-Id: <1154371972.7230.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 02:03 +0900, ysgrifennodd Tejun Heo:
> Alan, the reason why the second port disappeared is a bug in 
> init_legacy_mode().  probe_ent->n_ports is fxied to 1 and port_no gets 
> incremented while initializing the second port ending up initializing 
> part of the third port.

Ouch yes.

> Another problem is that probe_ent/ap->hard_port_no are meaningless. 
> hard_port_no is used to get port_no right on legacy cases where index of 
> host_set->ports[] doesn't match the actual port_no.  When there is only 
> one host_set, port_no should always equal hard_port_no.  For legacy 
> hosts, the original code ended up assigning the wrong hard_port_no's.

Agreed. I looked at that but it seemed that it isn't true that you can
assume port_no == hard_port_no because you may have a device which has
the primary port disabled and the secondary port set legacy. This also
sort of comes up in mixed devices but we don't handle them and I think
it comes out correctly once we do the pure legacy case right.

> I killed hard_port_no by s/ap->hard_port_no/ap->port_no/g without 
> actually reviewing the usages (man, those are a LOT).  If all pata 
> drivers always relied on ap->hard_port_no representing the actual port 
> index in the controller, there shouldn't be a problem.  But, just in 
> case, please review the change.

Think about the following execution sequence

ati_pci_init_one
	primary port already stolen by drivers/ide 
	secondary port free

	legacy_mode = ATA_PORT_SECONDARY
	ata_pci_init_legacy_port

	port_num = 0
	hard_port_num = 1

	*kerunnccchhhhhh*


> If this fixes Magallon's problem and you agree with the fix, I'll break 
> it down to two patches and submit'em to you with proper heading and all.

I agree with the theory and the diagnosis. I'm a bit worried about
hard_port_no however and I don't think that bit is safe in the secondary
only corner case. Registering both always and disabling one works for me
as a cleanup.

If you do that then I'll audit all the drivers use of ->port_no against
the patches.

Alan

