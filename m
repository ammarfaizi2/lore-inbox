Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUBRWPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUBRWPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:15:47 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:41608 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268279AbUBRWPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:15:44 -0500
Subject: Re: 2.6.3-mm1
From: Christophe Saout <christophe@saout.de>
To: Brandon Low <lostlogic@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040218205206.GD449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org> <40338FE8.60809@tmr.com>
	 <20040218200439.GB449@lostlogicx.com>
	 <20040218122216.62bb9e82.akpm@osdl.org>
	 <20040218203325.GC449@lostlogicx.com>
	 <20040218125227.0bf7dc2f.akpm@osdl.org>
	 <20040218205206.GD449@lostlogicx.com>
Content-Type: text/plain
Message-Id: <1077142536.27450.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 23:15:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 18.02.2004 schrieb Brandon Low um 21:52:

> I am just reading up on dm now, but correct me if I am wrong, I will
> need to do losetup, dmcreate, mount in that order in order to use
> dmcrypt on loop where with cryptoloop, I could just do "mount"... there
> must be an easier way to handle this!

You don't need to know everything about dm to set up encrypted devices.

Basically dmsetup is something like losetup, only that it's much more
flexible.

To set up a device basically:

echo 0 `blockdev --getsize /dev/bla` crypt <cipher> <key> 0 /dev/bla 0 |
dmsetup create <newname>

is enough. And it's just temporary, because no special tool has been
written yet. dmsetup is the most low-level dm tool, mostly for
developers. I've written a shell script named cryptsetup for the
meantime, it asks for a passphrase and does all the magic you need.

"cryptsetup create test /dev/hda5" will ask for a passphrase and set up
/dev/mapper/test. Voila. "cryptsetup remove test" removes it and
"cryptsetup status test" shows some status information.

mount -o loop is basically a hack. mount uses parts of losetup to do an
ioctl. The encryption support as mount argument is an additional patch.
Even worse, some do passphrase hashing, some don't... it works but it's
not a very clean solution either.

BTW: dmsetup is NOT a big program. It has two parts: a libdevmapper.so
in /lib and the dmsetup binary itself. Every part is 16k in size (if
compiled statically into one binary it's just 27k), and it's still
linked against glibc. If linked against dietlibc or klibc it would be
even smaller. Nobody needs LVM tools or something. It's just a small
client for the dm ioctl, just like losetup is a client for the loop
ioctl.

There are some plans to write a unified plugin based key management
tool. You might want to have your key stored on a USB stick. Or
encrypted in the first sector of your device and you want to unlock it
using a password (so you can change your password without needing to
reencrypt your data). This would be much more flexible than most of the
crap floating around.

So, you see. NO NEED TO PANIC. Cryptoloop won't disappear over night.
There will be some nice to user interface. At the moment dm-crypt is
only a *kernel implementation* and not meant to be used by every end
user immediately. Nobody will force you to drop cryptoloop until there
is a clean solution for everybody out there.


