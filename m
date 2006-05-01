Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWEANpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWEANpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWEANpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:45:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:41411 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932100AbWEANpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:45:45 -0400
Date: Mon, 1 May 2006 15:45:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/4] MultiAdmin LSM
In-Reply-To: <20060421150529.GA15811@kroah.com>
Message-ID: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
References: <20060417162345.GA9609@infradead.org>
 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 0/4] MultiAdmin LSM
         (was: Re: Time to remove LSM
         (was: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks))


0. Preface
==========
Thanks to Greg who, requiring me to post more-split patches, made me
reconsider the code. I did nothing less than to simplified the whole patch
cruft (shrunk by factor 10) and removed what seemed unreasonable. This
thread posts MultiAdmin *1.0.5*.



1. Super-short description
==========================
Three user classes exist (determined by user-defined UID ranges),
    - superadmin, the usual "root"
    - subadmin
    - normal users

A usual (non-multiadm,non-selinux) system has only one superadmin (UID 0)
and a number of normal users, and the superadmin can operate on
everything.

The "subadmin" can read in some superadmin-only places, and is allowed to
fully operate on processes/files/ipc/etc. of normal users. The full list
(possibly incomplete) of permissions is available in the README.txt
(includes short description) in the out-of-tree tarball.
[http://freshmeat.net/p/multiadm/]



2. A small problem
==================
As cool as it may sound, I think the implementation is not as clean as
possible.

Let's pick a random starting point: The subadmin is allowed to call
drivers/char/lp.c:lp_ioctl():LPGETSTATS. Or
fs/quota.c:generic_quotactl_valid():Q_GET*/Q_XGET*. For that to work
without too much code changes, CAP_SYS_ADMIN must be given to the
subadmin.

However, CAP_SYS_ADMIN (others are affected too, but this is the main one)
is used for other things too (mostly write or ioctl operations), which is
actually something that should not be granted to the subadmin.

This poses a problem. Currently, it is solved by adding an extra LSM hook,
security_cap_extra(), called from capable(). The hooked function then
looks at current->*uid/*gid and returns 1 or 0, depending on whether an
action is allowed or not. For more details see patch #1.



3. Conclusion
=============
You might have noticed: MultiAdmin's concept is based on UIDs/GIDs, not
capabilities. This interferes with the capability framework, which is
currently... hardcoded.

At best I would want that capabilities get out of the core functions (e.g.
{kernel,fs,etc}/*.c) and have them get their place in security/*, so that
in case you load a security module that is not based around POSIX
capabilities, they don't get used. I will see if I can put this idea into
a working idea. But for now...

...the multiadm patch series, based upon giving CAP_almost_anything
to subadmin and 'reducing' permissions within the LSM.



4. Patches
==========
Compile-tested (defconfig + enabling SECURIY,SECURITY_NETWORK).
A small overview for pleasure:

[01] security_cap_extra() and more
[02] Use of capable_light()
[03] task_post_setgid()
[04] MultiAdmin module


Jan Engelhardt
-- 
