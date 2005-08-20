Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVHTQ30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVHTQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHTQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 12:29:26 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:32785 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932394AbVHTQ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 12:29:25 -0400
To: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: open("foo", 3)
Message-Id: <E1E6WCz-0005ym-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 20 Aug 2005 18:28:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus et Al,

Access mode of 3 is undocumented but it does do something halfway sane
on all linuxes (checked back to 2.0.X).

The open requires both read and write permission to succeed, but the
resulting file descriptor can neither be read nor written.

The responsible code in filp_open() is this:

	namei_flags = flags;
	if ((namei_flags+1) & O_ACCMODE)
		namei_flags++;

	/* ... */

	error = open_namei(filename, namei_flags, mode, &nd);
	if (!error)
		return dentry_open(nd.dentry, nd.mnt, flags);

And in dentry_open():

	f->f_mode = ((flags+1) & O_ACCMODE) | /* ... */

Note, that open_namei() is checking permissions, and dentry_open()
sets f->f_mode, but calculates it differently.

My question is: is this deliberate or accidental?  Wouldn't it be more
logical to not require any permission to open such file?  Or is there
some security concern with that?

Thanks,
Miklos
