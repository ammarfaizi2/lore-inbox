Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTEMMQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTEMMQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:16:49 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:8698 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263656AbTEMMQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:16:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Yoav Weiss <ml-lkml@unpatched.org>, 76306.1226@compuserve.com
Subject: Re: The disappearing sys_call_table export.
Date: Tue, 13 May 2003 07:11:43 -0500
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305130138350.15817-100000@marcellos.corky.net>
In-Reply-To: <Pine.LNX.4.44.0305130138350.15817-100000@marcellos.corky.net>
MIME-Version: 1.0
Message-Id: <03051307114300.19075@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 May 2003 17:57, Yoav Weiss wrote:
> On Mon, 12 May 2003 17:51:25 EDT, Chuck Ebbert said:
> > > man dd ?
> >
> >   "That can be done manually" does not get you the check mark in
> > the list of features.  Management wants idiot-resistant security.
>
> It has nothing to do with idiot-resistance.  Why should this multi-write
> operation be done in kernel ?  mkswap is a usermode program.  mkfs is a
> usermode program.  If you want to have a wipeswap script that copies a
> chunk of your /dev/zero to the swap, it should also be in usermode.  Just
> run it in wherever rc file you use to swapoff.
>
> However, it'll just give you false sense of security.  First of all, its
> hardware dependent.  Second, it won't get wipe in case of a crash (which
> is likely to happen when They come to take your disk).

It is also not a valid wipe either.

This particular object reuse assumes the hardware is in a secured area. If it
is in a secured area then you don't need to wipe it. It remains completely 
under the systems control (even during a crash and reboot). The interval 
between crash and reboot is covered by the requirement to be in a secured 
area. As long as the system doesn't reallocate the data to another process
everything is acceptable. The only condition is that the area is erased
BEFORE allocation. And if it is erased by the NEW data, then the old data
is gone. In the case of swap, the page is first zeroed (given to process as
a demand zero, or preloaded with the users data), then written to swap and
allocated. This last twostep is the only question - is it written first, then
allocated, or allocated and written?

> Until linux gets a real encrypted swap (the kind OpenBSD implements), you
> can settle for encrypting your whole swap with one random key that gets
> lost on reboot.  Encrypted loop dev with a key from /dev/random easily
> gives you that.

Ahhh not a good idea if you want job restart or suspend/resume. And large 
systems DO want a job restart... as do laptops. During suspension you can
do anything to the disk (as in remove it, insert in another system, read
it, then put it back ...)

Such low level object reuse is not viable. This is from the same book that
states it must be overwritten 3-5 times (something in that range). The full
overhead reduces throughput to about 25-50% of total capacity. The object
reuse erasure applies to memory as well.

You also cannot guarantee erasure on disk errors either. The bad sectors are
ignored, and remapped to alternate sectors - the data is not deleted. Full
object reuse was written long before disks were performing this action. It
assumes the remapping is done by the OS, and hence, is also to overwrite the
bad sectors as well.
