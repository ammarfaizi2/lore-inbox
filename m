Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUBVDIT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUBVDIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:08:19 -0500
Received: from [61.49.148.218] ([61.49.148.218]:5628 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261650AbUBVDIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:08:14 -0500
Date: Sun, 22 Feb 2004 11:20:55 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200402221920.i1MJKt303325@adam.yggdrasil.com>
To: christophe@saout.de
Subject: Re: dm-crypt, new IV and standards
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2004-02-19 22:20:37, Christophe Saout wrote:
>I've started to write a userspace program for reencryption. I don't know
>if this is very clever because I have to lock the part that is currently
>beeing reencrypted (deadlocks & co). Perhaps as another dm target like
>dm-mirror for pvmove? We'd have to keep a log or something because we
>don't *exactly* know what has been successfully written. This would mean
>a lot of seeks. It's complicated if it has to be safe against crashes
>and power outages.

	Device-mapper already has support for different regions of a
device being mapped differently (for example a single disk where
0-100GB is mapped to disk A, 100GB-200GB is mapped to disk B), and
I believe it has some support for changing this mapping while the
device is opened or mounted.  So, if you wanted to add support for
rekeying an encrypted block device while it is active, you could
probably do it in fewer lines of code with an approach based on
device-mapper than one based on a device.

	One scheme for reencryption with minimal extra seeks and
data transfers would be to configure a gap of, say, 128kB, at the
front (or back) of a block device.  During rekeying, this gap would
incrementally be moved forward (or backward).  The area before the
gap would be encrypted with key A, and the area after
the gap would be encrypted with key B.  Before you move the gap,
you arrange so that the old location of the gap has the same
contents as the new location of the gap, except that the old location
was encrypted with the old key, and the new location was encrypted with
the new key.  I can detail this more if my description is unclear,
but I suspect you get the picture.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
