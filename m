Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWJKCPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWJKCPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 22:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWJKCPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 22:15:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28570
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932333AbWJKCPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 22:15:44 -0400
Date: Tue, 10 Oct 2006 19:15:47 -0700 (PDT)
Message-Id: <20061010.191547.83619974.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061011001338.GA30093@mellanox.co.il>
References: <20061010104315.61540986@freekitty>
	<20061011001338.GA30093@mellanox.co.il>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Wed, 11 Oct 2006 02:13:38 +0200

> Maybe I can patch linux to allow SG without checksum?
> Dave, maybe you could drop a hint or two on whether this is worthwhile
> and what are the issues that need addressing to make this work?
> 
> I imagine it's not just the matter of changing net/core/dev.c :).

You can't, it's a quality of implementation issue.  We sendfile()
pages directly out of the filesystem page cache without any
blocking of modifications to the page contents, and the only way
that works is if the card computes the checksum for us.

If we sendfile() a page directly, we must compute a correct checksum
no matter what the contents.  We can't do this on the cpu before the
data hits the device because another thread of execution can go in and
modify the page contents which would invalidate the checksum and thus
invalidating the packet.  We cannot allow this.

Blocking modifications is too expensive, so that's not an option
either.

