Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVAQW7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVAQW7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVAQW6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:58:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37775 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262944AbVAQWz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:55:26 -0500
Date: Mon, 17 Jan 2005 17:46:35 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050117194635.GD22202@logos.cnet>
References: <20050115233530.GA2803@darkside.22.kls.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115233530.GA2803@darkside.22.kls.lan>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 12:35:30AM +0100, Mario Holbe wrote:
> Hello,
> 
> mounting an ext2 (ext3 as well) filesystem seems to modify the
> block device's EOF behaviour: before the mount the device returned
> EOF, after the mount it doesn't anymore:
> 
> [on a fresh booted system]
> root@darkside:~# uname -a
> Linux darkside 2.4.27 #1 Sat Jan 15 17:07:20 CET 2005 i686 GNU/Linux
> root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> 9992366+0 records in
> 9992366+0 records out
> 5116091392 bytes transferred in 87,157394 seconds (58699453 bytes/sec)
> root@darkside:~# mke2fs /dev/hdg7
> ...
> Block size=4096 (log=2)
> Fragment size=4096 (log=2)
> 625248 inodes, 1249045 blocks
> ...
> root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> 9992366+0 records in
> 9992366+0 records out
> 5116091392 bytes transferred in 87,439332 seconds (58510184 bytes/sec)
> root@darkside:~# mount -t ext2 -o ro /dev/hdg7 /mnt
> root@darkside:~# umount /dev/hdg7
> root@darkside:~# dd if=/dev/hdg7 of=/dev/null
> attempt to access beyond end of device
> 22:07: rw=0, want=4996184, limit=4996183
> dd: reading `/dev/hdg7': Input/output error
> 9992360+0 records in
> 9992360+0 records out
> 5116088320 bytes transferred in 87,145443 seconds (58707468 bytes/sec)
> root@darkside:~# bc
> 1249045 * 4
> 4996180
> 1249045 * 4 * 2
> 9992360
> 
> Could somebody please explain this to me? Is this intentional?

No

> I could partly imagine the ext2 mount shrinking the block device's
> boundaries to the filesystem boundaries - for security reasons perhaps,
> even if I personally think this isn't the best idea at all, since it
> would violate layers encapsulation.
> However, I have no idea why a) if so, this is not reverted at least
> on umount and why b) the EOF behaviour of the block device changes -
> before there were an EOF sent to the application (dd) while after there
> isn't, but an I/O error instead.

Its indeed strange.

> Kernel is Debian's kernel-source-2.4.27 + kernel-patch-2.4-i2c +
> kernel-patch-2.4-lm-sensors.
> 
> It seems there were already some mails regarding this issue suggesting
> this could have shown up between 2.4.24 and 2.4.25, but it seems they
> were misunderstood, for example:
> 
> From: "ProNIC Solutions" <mot@pronicsolutions.com>
> Subject: 2.4.25: attempt to access beyond end of device
> Date: Tue, 16 Mar 2004 09:06:31 -0500
> Message-ID: <005201c40b5f$e21d34a0$0600a8c0@p17>
> 
> From: "Peter S. Mazinger" <ps.m@gmx.net>
> Subject: BUG in 2.4.25-rc1: attempt to access beyond end of device
> Date: Fri, 6 Feb 2004 13:53:40 +0100 (CET)
> Message-ID: <Pine.LNX.4.44.0402061347160.27376-100000@lnx.bridge.intra>

Actually these were fixed during v2.4.26-pre.

Can you please turn readahead off (hdparm -a 0 /dev/hdg) and repeat the tests?

The kernel is trying to read one block after EOD.

> attempt to access beyond end of device
> 22:07: rw=0, want=4996184, limit=4996183

So maybe an off-by-one read-ahead?

Also I suggest a dump_stack() to see where the read is coming
from.

Any other ideas?
