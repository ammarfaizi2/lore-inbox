Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUBVUxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUBVUxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:53:41 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:64167 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261747AbUBVUxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:53:37 -0500
Subject: Re: dm-crypt, new IV and standards
From: Christophe Saout <christophe@saout.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402221920.i1MJKt303325@adam.yggdrasil.com>
References: <200402221920.i1MJKt303325@adam.yggdrasil.com>
Content-Type: text/plain
Message-Id: <1077483221.27809.9.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 22 Feb 2004 21:53:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 22.02.2004 schrieb Adam J. Richter um 20:20:

> >I've started to write a userspace program for reencryption. I don't know
> >if this is very clever because I have to lock the part that is currently
> >beeing reencrypted (deadlocks & co). Perhaps as another dm target like
> >dm-mirror for pvmove? We'd have to keep a log or something because we
> >don't *exactly* know what has been successfully written. This would mean
> >a lot of seeks. It's complicated if it has to be safe against crashes
> >and power outages.
> 
> 	Device-mapper already has support for different regions of a
> device being mapped differently (for example a single disk where
> 0-100GB is mapped to disk A, 100GB-200GB is mapped to disk B), and
> I believe it has some support for changing this mapping while the
> device is opened or mounted.  So, if you wanted to add support for
> rekeying an encrypted block device while it is active, you could
> probably do it in fewer lines of code with an approach based on
> device-mapper than one based on a device.

Yes, sure. As I said, I've already written something.

http://www.saout.de/misc/dm-convert-0.1.tar.bz2

I fixed it up so that it actually somehow. If it fails it leaves some
devices around that you'll have to remove by hand. It has support for
being interrupted and resumed later but I currently don't catch the
signal to put it into a reasonable state so don't interrupt it.

Syntax: dmconvert <source> <dest>

Where <source> and <dest> are the dm device names. <source> and <dest>
should be the same size and be backed by the same device (but can be
differently encrypted). <source> can be mounted and if dmconvert
finishes will use the mapping <dest> used, <dest> will be removed.

> 	One scheme for reencryption with minimal extra seeks and
> data transfers would be to configure a gap of, say, 128kB, at the
> front (or back) of a block device.  During rekeying, this gap would
> incrementally be moved forward (or backward).  The area before the
> gap would be encrypted with key A, and the area after
> the gap would be encrypted with key B.  Before you move the gap,
> you arrange so that the old location of the gap has the same
> contents as the new location of the gap, except that the old location
> was encrypted with the old key, and the new location was encrypted with
> the new key.  I can detail this more if my description is unclear,
> but I suspect you get the picture.

Yes. The block that is currently being converted is mapped to a third
temporary target that is suspended by dm so no I/O gets dispatched
there. Then the other two temporary targets are used to actually copy
that data (they contain the mappings of the original <source> and
<dest>). The <source> target (where the fs can be mounted on) maps to
all three temporary targets. After conversion of a block is finished,
the suspended target is resumed, the mappings updated and the next block
started.

If the machine crashes, well... good luck. :)


