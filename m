Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVD2SW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVD2SW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVD2SW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:22:58 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:13966 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262872AbVD2SW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:22:56 -0400
Message-ID: <42727B60.7010507@ens-lyon.org>
Date: Fri, 29 Apr 2005 20:22:24 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
Cc: Caitlin Bestler <caitlin.bestler@gmail.com>,
       Bill Jordan <woodennickel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, David Addison <addy@quadrics.com>
Subject: Re: RDMA memory registration
References: <20050425135401.65376ce0.akpm@osdl.org>	<20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>	<20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>	<20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>	<426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>	<5ebee0d105042907265ff58a73@mail.gmail.com>	<469958e005042908566f177b50@mail.gmail.com> <52d5sdjzup.fsf_-_@topspin.com>
In-Reply-To: <52d5sdjzup.fsf_-_@topspin.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier a écrit :
> 2) For fork() support:
> 
>    a) Extend mprotect() with PROT_DONTCOPY so processes can avoid
>       copy-on-write problems.
> 
>    b) (maybe someday?) Add a VM_ALWAYSCOPY flag and extend mprotect()
>       with PROT_ALWAYSCOPY so processes can mark pages to be
>       pre-copied into child processes, to handle the case where only
>       half a page is registered.
> 
> I believe this puts the code that must be trusted into the kernel and
> gives userspace primitives that let apps handle the rest.

Do you plan to work with David Addison from Quadrics ?
For sure, your hardware have very different capabilities.
But ioproc_ops is a really nice solution and might help a lot
when dealing with deregistration and fork.

For instance, instead of adding PROT_DONT/ALWAYSCOPY, you may use
an ioproc hook in the fork path. This hook (a function in your driver)
would be called for each registered page. It will decide whether
the page should be pre-copied or not and update the registration
table (or whatever stores address translations in the NIC).
In addition, the driver would probably pre-copy cow pages when
registering them.

It's nice to see these two works coming to LKML at the same time.
It would be great if we could merge them and get a generic solution
that's suitable to both registration based cards (IB/Myri/Ammasso)
and MMU-based cards (Quadrics).

Brice
