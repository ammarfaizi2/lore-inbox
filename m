Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWGaRDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWGaRDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGaRDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:03:07 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:20998 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030252AbWGaRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:03:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Xuqan5izdfkjBm6MN4OCyAqK7/0o2oiU8k+FqRzSYxLjzMynuyVHkSPNKwN/euB2UJh8MIxuP+FfYZTd6C6mmaiLlkbUtnckD92jn5ZkzL7wK4qJ/97lhiI1KzGa7HlgEwvmvdCl8V+qX6f2EW2dIIQj2Kx7tW40jpyMIFHSpLI=
Message-ID: <44CE37CF.1010804@gmail.com>
Date: Tue, 01 Aug 2006 02:03:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "J.A. Magall?n" <jamagallon@ono.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
References: <20060728134550.030a0eb8@werewolf.auna.net> <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net> <44CE2908.8080502@gmail.com> <1154363489.7230.61.camel@localhost.localdomain> <20060731165011.GA6659@htj.dyndns.org>
In-Reply-To: <20060731165011.GA6659@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> On Mon, Jul 31, 2006 at 05:31:29PM +0100, Alan Cox wrote:
>> Ar Maw, 2006-08-01 am 01:00 +0900, ysgrifennodd Tejun Heo:
>>> These are patches #110-112.  Andrew, can you drop those patches for the 
>>> time being?  I'm working on integrating those into libata #upstream now. 
>> If you drop the host_set and tuning patches please drop all the PATA
>> stuff and my other patches out. I don't have time to field a second
>> batch of hundreds of "why has my drive stopped working, why is the speed
>> wrong" emails. 
> 
> Didn't realize pata stuff relies on it.
> 
>> It'll be easier just to work outside the -mm tree with all this
>> continued in/out random breakage if people are just going to say "drop
>> xyz patch" rather than actually specifying *what is actually wrong* and
>> getting me to fix the merge (Tejun that last one sentence is a hint ;))
> 
> Okay, took the hint.  Magallon, can you please try the following
> patch?

Hit send a bit too fast.

Alan, the reason why the second port disappeared is a bug in 
init_legacy_mode().  probe_ent->n_ports is fxied to 1 and port_no gets 
incremented while initializing the second port ending up initializing 
part of the third port.

Another problem is that probe_ent/ap->hard_port_no are meaningless. 
hard_port_no is used to get port_no right on legacy cases where index of 
host_set->ports[] doesn't match the actual port_no.  When there is only 
one host_set, port_no should always equal hard_port_no.  For legacy 
hosts, the original code ended up assigning the wrong hard_port_no's.

I killed hard_port_no by s/ap->hard_port_no/ap->port_no/g without 
actually reviewing the usages (man, those are a LOT).  If all pata 
drivers always relied on ap->hard_port_no representing the actual port 
index in the controller, there shouldn't be a problem.  But, just in 
case, please review the change.

If this fixes Magallon's problem and you agree with the fix, I'll break 
it down to two patches and submit'em to you with proper heading and all.

Thanks.  :)

-- 
tejun
