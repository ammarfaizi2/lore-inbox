Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWILEaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWILEaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 00:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWILEaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 00:30:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:4180 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965157AbWILEaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 00:30:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ic9C/yaaoR2p1YT58AIAvGXPvpn1v+Fp9j/fGo3OVGdckI5hX5gxQh+IpMe4WfWhXOISJan5G+0U6ZFHRBYm9UOwLLcZc8Pdj9Girtx6foHHWiLXBBjpG+4bBytE8mmUcA8V2x3XDQ//9LwZnDAWZkif0RTIhn0eTeFGGHCK22E=
Message-ID: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
Date: Tue, 12 Sep 2006 00:30:06 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: benh@kernel.crashing.org, jbarnes@virtuousgeek.org,
       alan@lxorguk.ukuu.org.uk, davem@davemloft.net, jeff@garzik.org,
       paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org, segher@kernel.crashing.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
> On Mon, 2006-09-11 at 11:08 -0700, Jesse Barnes wrote:

>> Ok, that's fine, though I think you'd only want the very weak
>> semantics (as provided by your __raw* routines) on write
>> combined memory typically?
>
> Well, that and memory with no side effects (like frame buffers)

Oh no, it's great for regular device driver work. I used this
type of system all the time on a different PowerPC OS.

Suppose you need to set up a piece of hardware. Assume that the
hardware isn't across some nasty bridge. You do this:

hw->x = 42;
hw->y = 19;
eieio();
hw->p = 11;
hw->q = 233;
hw->r = 87;
eieio()
hw->n = 101;
hw->m = 5;
eieio()

In that ficticious example, I get 7 writes to the hardware device
with only 3 "eieio" operations. It's not hard at all. Sometimes
a "sync" is used instead, also explicitly.

To get even more speed, you can mark memory as non-coherent.
You can even do this for RAM. There are cache control instructions
to take care of any problems; simply ask the CPU to write things
out as needed.

Linux should probably do this:

Plain stuff is like x86. If you want the performance of loose
ordering, ask for it when you get the mapping and use read/write
functions that have a "_" prefix. If you mix the "_" versions
with a plain x86-like mapping or the other way, the behavior you
get will be an arch-specific middle ground.
