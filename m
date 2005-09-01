Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVIAGY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVIAGY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVIAGY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:24:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28102
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965029AbVIAGY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:24:28 -0400
Date: Wed, 31 Aug 2005 23:24:30 -0700 (PDT)
Message-Id: <20050831.232430.50551657.davem@davemloft.net>
To: ecashin@coraid.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: aoe fails on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87vf1mm7fk.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87vf1mm7fk.fsf@coraid.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 31 Aug 2005 11:50:55 -0400

> Jim MacBaine <jmacbaine@gmail.com> writes:
> 
> > Aug 31 15:18:49 sunny kernel: devfs_mk_dir: invalid argument.<6>
> > etherd/e0.0: unknown partition table
> > Aug 31 15:18:49 sunny kernel: aoe: 0011d8xxxxxx e0.0 v4000 has
> > 67553994410557440
> > sectors
> 
> OK.  67553994410557440 is 61440 byte swapped in 64 bits, and 30MB is
> 61440 sectors, so this should be a simple byte order fix.

More strangely, the upper and lower 32-bit words are swapped.
The bytes within each 32-bit word are swapped correctly.

So the calculation maybe should be something like:

	__le32 *p = (__le32 *) &id[100 << 1];
	u32 high32 = le32_to_cpup(p);
	u32 low32 = le32_to_cpup(p + 1);

	ssize = (((u64)high32 << 32) | (u64) low32);

But that doesn't make any sense, and even ide_fix_driveid() in
drivers/ide/ide-iops.c does a le64_to_cpu() for this value:

	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);

I wonder if this is some artifact of how AOE devices encode
this field when sending it to the client.
