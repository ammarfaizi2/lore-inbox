Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVIMUJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVIMUJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVIMUJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:09:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30093
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932516AbVIMUJB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:09:01 -0400
Date: Tue, 13 Sep 2005 13:08:42 -0700 (PDT)
Message-Id: <20050913.130842.52078742.davem@davemloft.net>
To: kloczek@rudy.mif.pg.gda.pl
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org,
       aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.13-rc6-git13/sparc64]: Slab corruption (possible stack or
 buffer-cache corruption)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.BSO.4.62.0509131148020.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
	<20050912.161326.131841878.davem@davemloft.net>
	<Pine.BSO.4.62.0509131148020.5000@rudy.mif.pg.gda.pl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Tue, 13 Sep 2005 12:12:22 +0200 (CEST)

> # grep "^Sep 12" /var/log/messages | grep kernel: | uniq | cut -d " " -f 6- | sort | uniq -c | sort -n | tail -n 2
>      509 svc: bad direction 268435456, dropping request
>      653 eth0: Happy Meal out of receive descriptors, packet dropped.
> 
> As you see one of this two messagess occures avarange one time per ~two 
> minutes.
> Second looks like some error in sunhme.c. eth0 it is:

It's not a bug, per se, your system is simply receiving more
network traffic than the kernel can receive.  So the network
adapter runs out of receive descriptors in which to receive
new packets, and starts dropping them until the kernel catches
up again.  That's what that message means.

The "svc: " one I've seen before, it looks like something is
clobbering the sunrpc message, for example a freed up buffer is having
some bit set in one of it's words.  This 268435456 value is
"0x10000000" hexadecimal.  The code expects the value zero, and we
have a stray bit being set in there, bit 28 to be exact.  This would
actually be expected after you trigger something like that
destroy_inode() bug as a buffer is being free'd up twice.
