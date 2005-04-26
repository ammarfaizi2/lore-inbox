Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVDZRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDZRHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDZRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:07:12 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:45706 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261494AbVDZRHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:07:03 -0400
Message-ID: <426E751A.2020507@ens-lyon.org>
Date: Tue, 26 Apr 2005 19:06:34 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: David Addison <addy@quadrics.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
References: <426E62ED.5090803@quadrics.com>
In-Reply-To: <426E62ED.5090803@quadrics.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Addison a écrit :
> Hi,
> 
> here is a patch we use to integrate the Quadrics NICs into the Linux 
> kernel.
> The patch adds hooks to the Linux VM subsystem so that registered 'IOPROC'
> devices can be informed of page table changes.
> This allows the Quadrics NICs to perform user RDMAs safely, without 
> requiring
> page pinning. Looking through some of the recent IB and Ammasso 
> discussions,
> it may also prove useful to those NICs too.

Hi,

I worked on a similar patch to help updating a registration cache on
Myrinet. I came to the problem of deciding between registering ioproc
to the entire address space (1) or only to some VMA (2).
You're doing (1), I tried (2).

(2) avoids calling ioproc hooks for all pages that are never involved
in any communication. This might be good if the amount of pages that
are involved is not too high and if the coproc_ops cost is a little bit
high.
Do you have any numbers about this in real applications on QsNet ?

I see two drawback in (2).
First, it requires to play with the list of ioproc_ops when VMA are
merged or split. Actually, it's not that bad since the list often
contains only 1 ioproc_ops.
Secondly, you have to add the ioproc to all involved VMA at some point.
It's easy when the API asks the application to register, you just add
the ioproc_ops to the target VMA during registration. But, I guess it's
not easy with Quadrics, right ?


I see in your patch that ioproc are not inherited during fork.
How do you support fork in your driver/lib then ?
What if a COW page is given to the son and the copy to the father
while some IO are being processed ? Do you require the application to
call a specific routine after forking ?
Don't you think it might be good to add a hook in the fork code
so that ioproc are inherited or duplicated pages are invalidated
in the card ?

Regards,
Brice
