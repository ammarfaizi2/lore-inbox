Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288445AbSADBsY>; Thu, 3 Jan 2002 20:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288448AbSADBsO>; Thu, 3 Jan 2002 20:48:14 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38622 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288445AbSADBr4>;
	Thu, 3 Jan 2002 20:47:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jan 2002 01:47:52 GMT
Message-Id: <UTC200201040147.BAA211896.aeb@cwi.nl>
To: alessandro.suardi@oracle.com, jgarzik@mandrakesoft.com
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
Cc: andries.brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From jgarzik@mandrakesoft.com Fri Jan  4 01:13:34 2002

    reiserfs is blindly storing the kernel's kdev_t value raw to disk.

    AFAICS this will need a policy decision not just cleanup, before it
    works in 2.5.2 properly.  If we switch the kernel to 12:20 major:minor
    numbers, suddenly the reiserfs disk format changes based on kernel
    version, and earlier kernels see corrupted major:minor numbers.

No, not really. For how to do this, see a fragment of example code
that Linus removed from kdev_t.h in pre6, it went something like
(adapted for 12+20 instead of 16+16):

int major(dev_t dev) {
	int ma;

	ma = (dev >> 20);
	if (!ma)
		ma = (dev >> 8);
	return ma;
}

int minor(dev_t dev) {
	if (dev >> 20)
		return (dev & 0xfffff);
	else
		return (dev & 0xff);
}

dev_t mkdev(int ma, int mi) {
	if (mi & ~0xff)
		return ((ma << 20) + mi);
	else
		return ((ma << 8) + mi);
}

(with the correctness conditions that ma is 12-bit,
mi is 20-bit, and major 0 has only 8-bit minors).

You see that the representation of old values does not change.
No disk corruption.

Andries


[I didnt spell it out, but you understand: the dev_t is the on-disk
format, the conversion finds the major and minor, and these are
combined again into a kdev_t for use by the kernel]

[Similar code occurs is isofs/rock.c, where a 64-bit dev
must be converted.]

[I don't know whether reiserfs is a Linux-only filesystem.
If it is not, and has a disk format that is OS-independent,
a third struct stat_data might be needed, since the 12+20
is not universal, so 32+32 would be the better choice.]
