Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWGaSwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWGaSwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWGaSwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:52:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:6034 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030317AbWGaSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:52:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OTgafM5g1+vP/ukCKXp8LSSwN/VmJTzGtt6WZZz6QLSPbZL9sURiSH4WoFF57uNyvoqIJ6DMm+0heS8JLIWWlxNoyShsP9J2DzJMI71yKJYTwkFcis32jroFo/PF40XsBDh1ls0el/SP+eU/MPmYzVCVRjqfbXFuzuEA0x3ZLME=
Message-ID: <44CE515B.1060302@gmail.com>
Date: Tue, 01 Aug 2006 03:52:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "J.A. Magall?n" <jamagallon@ono.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
References: <20060728134550.030a0eb8@werewolf.auna.net>	 <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>	 <44CE2908.8080502@gmail.com>	 <1154363489.7230.61.camel@localhost.localdomain>	 <20060731165011.GA6659@htj.dyndns.org>  <44CE37CF.1010804@gmail.com> <1154371972.7230.95.camel@localhost.localdomain>
In-Reply-To: <1154371972.7230.95.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan Cox wrote:
[--snip--]
>> I killed hard_port_no by s/ap->hard_port_no/ap->port_no/g without 
>> actually reviewing the usages (man, those are a LOT).  If all pata 
>> drivers always relied on ap->hard_port_no representing the actual port 
>> index in the controller, there shouldn't be a problem.  But, just in 
>> case, please review the change.
> 
> Think about the following execution sequence
> 
> ati_pci_init_one
> 	primary port already stolen by drivers/ide 
> 	secondary port free
> 
> 	legacy_mode = ATA_PORT_SECONDARY
> 	ata_pci_init_legacy_port
> 
> 	port_num = 0
> 	hard_port_num = 1
> 
> 	*kerunnccchhhhhh*

Ah... You're right.  That will make port_no different from the hw port#.

>> If this fixes Magallon's problem and you agree with the fix, I'll break 
>> it down to two patches and submit'em to you with proper heading and all.
> 
> I agree with the theory and the diagnosis. I'm a bit worried about
> hard_port_no however and I don't think that bit is safe in the secondary
> only corner case. Registering both always and disabling one works for me
> as a cleanup.
> 
> If you do that then I'll audit all the drivers use of ->port_no against
> the patches.

I like 'registering both always and disabling one' approach for 
partially stolen legacy devices.  We can make ->hard_port_no do the job 
as before, but IMHO it's error-prone and only useful for very limited 
cases (first legacy port stolen).

Jeff, what do you think?

-- 
tejun
