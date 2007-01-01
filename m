Return-Path: <linux-kernel-owner+w=401wt.eu-S932892AbXAADey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbXAADey (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbXAADey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:34:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:41893 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892AbXAADex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:34:53 -0500
In-Reply-To: <20061231154103.GA7409@infradead.org>
References: <20061230.211941.74748799.davem@davemloft.net> <459784AD.1010308@firmworks.com> <45978CE9.7090700@flex.com> <20061231.024917.59652177.davem@davemloft.net> <20061231154103.GA7409@infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, dmk@flex.com, wmb@firmworks.com,
       jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Mon, 1 Jan 2007 04:33:13 +0100
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> All we've done is created a trivial implementation for exporting
>>> the device tree to userland that isn't burdened by the powerpc
>>> and sparc legacy code that's in there now.
>>
>> So now we'll have _3_ different implementations of exporting
>> the OFW device tree via procfs.  Your's, the proc_devtree
>> of powerpc, and sparc's /proc/openprom
>>
>> That doesn't make any sense to me, having 3 ways of doing the same
>> exact thing and making no attempt to share code at all.

Not the same exact thing -- using a text representation for
the property contents is a very different thing (and completely
braindead).

>> If you want to do something new that consolidates everything, with the
>> goal of deprecating the existing stuff, that's great!  But with they
>> way you're doing this, all the sparc and powerpc implementations
>> really can't take advantage of it.

The problem is that it is almost impossible to consolidate the
current OF code.  It would be possible to consolidate the
filesystem code only though (and that's a good plan of course).

>> Am I the only person who sees something very wrong with this?
>
> No, I completely agree with you on this.
>
> If firmworks really wants to have a spearate filesystem that's fine.
> But please start with the ppc or sparc code and massage it into a
> a separate filesystem before adding support for a new platform.

It's so much easier to start from scratch in this case ;-)

> In case anyone wants to start this based on ppc I'd gladfully help
> to test this on pmac (32 and 64bit) and cell (64 bit).

Let's not base it on the PowerPC code, we don't want /proc.

How about this as a high-level design, it would be simple for
the OLPC guys to implement, and very easy for the other archs
to hook up to:

Every architecture that supports the device tree filesystem,
initialises a "struct device_tree_ops" with a bunch of
pointers to functions that allow you to traverse the device
tree and read its properties (and maybe write properties, or
even delete and create new nodes.  The devtree filesystem code
simply calls into these functions to do the actual operations
on the device tree (access an in-kernel data structure, call
the OF, or both -- or something entirely different, who knows).


Segher

