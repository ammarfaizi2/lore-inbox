Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261163AbRERQ7S>; Fri, 18 May 2001 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261165AbRERQ7I>; Fri, 18 May 2001 12:59:08 -0400
Received: from waste.org ([209.173.204.2]:18525 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261163AbRERQ6y>;
	Fri, 18 May 2001 12:58:54 -0400
Date: Fri, 18 May 2001 11:59:54 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Alternatives to device nodes as directories idea?
Message-ID: <Pine.LNX.4.30.0105181117310.24909-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that Linus' idea of making device nodes work like
directories is a little too clever and probably overkill but the only
alternative I've seen suggested is Al's per-device filesystems which seems
similarly excessive.

Few devices will have a need for multiple streamable interfaces and should
probably be fine with one acting as the 'normal' device and another acting
as a control device replacing ioctl. This would leave most of these weird
directory-like objects containing only one file. And then there's the
issue that the naming and permissions of that file ends up being a matter
of kernel policy.

As an alternative, I suggest something like:

struct devicetype
{
	char name[16];
	struct list_head isa; /* base types */
};

struct devicereg
{
	kdev_t dev; /* kdev_t could also include the following */
	char name[16]; /* symbolic in-kernel name for this device */
	struct devicetype devtype;
	int block; /* block or char */
	dev_t major, minor; /* legacy numbers, deprecated */
};

int register_devices(const devicereg *d, int n);

Register_devices then makes a single call to a userspace helper,
passing it a list of symbolic names and major/minor numbers associated
with a detected device. This lets the helper configure them as a
group. It can even mount per-device tmpfs directories to look like
Al's world.

Still missing is a scheme to allow the kernel to rendezvous with
userspace when a user wants to open a device that's a module and has
therefore not been detected yet. Presumably the userspace helper
mentioned above keeps a mapping of kernel name->userspace name, so
using the inverse of this map with autofs should allow module
probing-like behavior.

This still leaves cases that don't work: booting off IDE, SCSI built
as a module, trying to mount a SCSI disk by UUID... But that doesn't
work now.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

