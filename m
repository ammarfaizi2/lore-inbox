Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVKRIEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVKRIEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVKRIEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:04:46 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10200
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030443AbVKRIEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:04:45 -0500
Date: Fri, 18 Nov 2005 00:04:14 -0800 (PST)
Message-Id: <20051118.000414.10534984.davem@davemloft.net>
To: hugh@veritas.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511180724060.5435@goblin.wat.veritas.com>
References: <437D6AD0.5080909@yahoo.com.au>
	<20051117.224516.118147408.davem@davemloft.net>
	<Pine.LNX.4.61.0511180724060.5435@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Fri, 18 Nov 2005 07:27:36 +0000 (GMT)

> On Thu, 17 Nov 2005, David S. Miller wrote:
> > From: Nick Piggin <nickpiggin@yahoo.com.au>
> > Date: Fri, 18 Nov 2005 16:46:56 +1100
> > 
> > > I think for 2.6.15, yes. We [read: I :(] was too hasty in removing
> > > this completely.
> 
> No, that was not too hasty: we all agreed that the case _ought_ not to
> arise, and we hadn't worked out the right code to handle it if it did
> arise.  What was disappointing is that nobody reported the messages
> while it was in -mm, but

The recent vbetool suspend-from-ram datapoint shows that it might be
important that the BIOS data area is application local,
ie. MAP_PRIVATE.  Ie. it works only if the writes are not performed
to the real BIOS data page.

If true, that means the MAP_PRIVATE+VM_UNPAGED case has legit users.
Although, such applications could just copy the interrupt vector plus
BIOS data area into an anonymously mapped region and have the vm86
execution work off that instead of the /dev/mem mapping.

So, just to make sure this all adds up, a PROT_WRITE+MAP_PRIVATE
mapping of /dev/mem results in any pages written to being COW'd.
Right?

It is a good question as to which cases doing stuff like this want to
make modifications to the real BIOS data area, and which ones do not.
Aparently vbetool does not.
