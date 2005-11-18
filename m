Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbVKRIgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbVKRIgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbVKRIgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:36:19 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35520
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030511AbVKRIgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:36:19 -0500
Date: Fri, 18 Nov 2005 00:36:06 -0800 (PST)
Message-Id: <20051118.003606.59385217.davem@davemloft.net>
To: hugh@veritas.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511180813110.5788@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
	<20051118.000802.81426185.davem@davemloft.net>
	<Pine.LNX.4.61.0511180813110.5788@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Fri, 18 Nov 2005 08:13:54 +0000 (GMT)

> On Fri, 18 Nov 2005, David S. Miller wrote:
> > From: Hugh Dickins <hugh@veritas.com>
> > Date: Fri, 18 Nov 2005 08:02:02 +0000 (GMT)
> > 
> > > That code is necessary to reproduce the existing behaviour, which has
> > > always done COW on PageReserved mappings without complaint - if the
> > > vm_page_prot didn't already let you slip through without a WP fault.
> > 
> > And there is evidence today that this is really needed, at least
> > by vbetool.
> > 
> > Ok, we need COW on VM_UNPAGED. :)
> 
> Are you so sure of that, that we should even skip adding a warning?

Yes, I'm pretty sure.  The datapoints are like this:

1) Existing vbetool with 2.6.14 and previous works
2) 2.6.15 w/no-COW-on-reserved makes existing vbetool fail
   immediately (of course)
3) 2.6.15 w/no-COW-on-reserved still fails with MAP_SHARED
   patched vbetool
4) 2.6.15 w/COW-on-VM_UNPAGED works with existing vbetool
5) 2.6.15 w/COW-on-VM_UNPAGED _FAILS_ with MAP_SHARED patched
   vbetool

That #5 is the key.

If we use MAP_SHARED and let vbetool modify the real BIOS data
area, resume fails.  That's convincing enough for me :)
