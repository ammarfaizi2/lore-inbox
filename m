Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283045AbRLHRz4>; Sat, 8 Dec 2001 12:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283245AbRLHRzr>; Sat, 8 Dec 2001 12:55:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:32482 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S283045AbRLHRzh>;
	Sat, 8 Dec 2001 12:55:37 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Dec 2001 17:55:31 GMT
Message-Id: <UTC200112081755.RAA240574.aeb@cwi.nl>
To: andersen@codepoet.org
Subject: Re: On re-working the major/minor system
Cc: alan@lxorguk.ukuu.org.uk, dalecki@evision.ag, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Erik Andersen <andersen@codepoet.org>

    So we have POSIX, ls, tar, du, mknod, and mount and tons of other
    apps all with illicit insider knowledge of what a dev_t looks
    like.

    To currently, to do pretty much anything nifty related to devices
    in usespace, usespace has to peek under the kernel's skirt to
    know how to change a major and minor number into a dev_t and/or
    to sanely populate a struct stat.

    To change things, we 1) need some sortof sane interface by which
    userspace can refer sensibly to devices without resorting to evil
    illicit macros and 2) we certainly need some sort of a static
    mapping such that existing devices end up mapping to the same
    thing they always did or 3) we will need a flag day where we say
    that all pre-2.5.x created tarballs and user space apps are
    declared broken...

No flag day required. These things have been discussed
many times already, and there are easy and good solutions.

Code like

	dev_t dev;
	u64 d = dev;
	int major, minor;

	if (d & ~0xffffffff) {
		major = (d >> 32);
		minor = (d & 0xffffffff);
	} else if (d & ~0xffff) {
		major = (d >> 16);
		minor = (d & 0xffff);
	} else {
		major = (d >> 8);
		minor = (d & 0xff);
	}

will handle dev_t fine, regardless of whether it is 16, 32 or 64 bits.
You see that change of the size of dev_t does not change the values
of major and minor found in your tarballs.
We already use such code for isofs.

Andries
