Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbWJ3Qsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbWJ3Qsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWJ3Qsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:48:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965274AbWJ3Qs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:48:26 -0500
Date: Mon, 30 Oct 2006 08:44:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
In-Reply-To: <45462591.7020200@ce.jp.nec.com>
Message-ID: <Pine.LNX.4.64.0610300834060.25218@g5.osdl.org>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il>
 <45462591.7020200@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2006, Jun'ichi Nomura wrote:
> 
> The code is related to bd_claim_by_disk which is called when
> device-mapper or md tries to mark the underlying devices
> for exclusive use and creates symlinks from/to the devices
> in sysfs. The patch added error handlings which weren't in
> the original code.

Actually, looking closer at the code, the patch seems to add _incorrect_ 
error handling.

For example, look at bd_claim_by_kobject(): if the "bd_claim()" inside of 
it succeeds, we used to always return success. Now, we don't necessarily 
do that: we may have done a _successful_ "bd_claim()" call, but then we 
return an error because something else failed, and now we're returning 
with from bd_claim_by_kobject() with the bd_claim() done, but with an 
error return (so the caller will _not_ call "bd_release()", and the 
block_device will forever stay exclusive).

No?

Now, exactly why acpi stops working as a result, I don't know, but maybe 
something else tries to get exclusive access to a swap partition, for 
example, and now fails, causing some acpi sequence to not be set up? 
Dunno.

So I suspect it should be reverted, but maybe somebody can see exactly 
what goes wrong here.

		Linus
