Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUIAPnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUIAPnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUIAPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:40:49 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:60317 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266901AbUIAPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:38:04 -0400
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, viro@parcelfarce.linux.theplanet.co.uk,
       mst@mellanox.co.il, filia@softhome.net
Content-Type: text/plain
Organization: 
Message-Id: <1094052981.431.7160.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Sep 2004 11:36:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
> On Wed, Sep 01, 2004 at 03:50:11AM -0600, filia@softhome.net wrote:

>> Stop being arrogant. Can you please elaborate on how
>> to make Linux kernel support e.g. motion controllers?
>> They do not fit *any* known to me driver interface.
>> They have several axes, they have about twenty
>> parameters (float or integer), and 
>
> parameters nicely fit in sysfs.

Per-command parameters included?

People really do want private syscalls. An ioctl
is that, in a namespace defined by the file
descriptor. So ioctl() provides local scope to
something that would otherwise be global.

The alternative is to add a zillion odd syscalls.

Life is messy.

>> they have several commands, a-la start, graceful stop,
>> abrupt stop. Plus obviously diagnostics - about ten
>> another commands with absolutely different parameters.
>> And about ten motion monitoring commands. And this is 
>> one example I were need to program. 
>
> a write() interface doesn't work???
> Hard to believe, you even call them commands.
> fd = open("/dev/funkydevice");
> write(fd, "start");
>
> doesn't sound insane to me

That's just a double-crufty ioctl in disguise.
See also: "the /proc filesystem"

It looks like encouragement of choices that will
tend toward the creation of buffer overflows in
the kernel. Nearly all buffer overflows involve
parsing ASCII. Sure, nobody should make mistakes...

People won't do that though. Know what you'll
get if ioctl isn't used? Here you go:

///////////////////////  Look ma, no ioctl!  /////
struct ctldata scd;
struct ctldata *scdp = &scd;

scd.command = GET_MOTOR_TEMPERATURE;
scd.arg[0] = MOTOR_Z;

// Arjan wants it this way.
// (for Viro, must print the pointer in decimal)
write(fd, &scdp, sizeof ctldata);

motor_temp.current = scd.ret[0];
motor_temp.peak    = scd.ret[1];
/////////////////////////////////////////////////


