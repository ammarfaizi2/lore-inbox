Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWHZUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWHZUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWHZUW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 16:22:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63923 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1750802AbWHZUW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 16:22:56 -0400
Date: Sat, 26 Aug 2006 22:22:54 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200608262022.k7QKMs126222@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: flaw in the mount system call
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer maintain mount or util-linux, but people still
send mail concerning mount. One letter complained that
asking for a bind mount with flags nosuid,noexec does not work,
while first doing the bind mount, and then afterwards doing
a remount with nosuid,noexec does work (but is insecure).

And indeed, looking at a random recent kernel source I see

	mnt_flags := per_mountpoint_flags;

        if (flags & MS_REMOUNT)
                retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
                                    data_page);
        else if (flags & MS_BIND)
                retval = do_loopback(&nd, dev_name, flags & MS_REC);
        else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
                retval = do_change_type(&nd, flags);
        else if (flags & MS_MOVE)
                retval = do_move_mount(&nd, dev_name);
        else
                retval = do_new_mount(&nd, type_page, flags, mnt_flags,
                                      dev_name, data_page);

That is, the per-mountpoint flags are used for ordinary mounts
and for remounts, but ignored on bind mounts.
Probably do_loopback() should have an additional parameter.
Doing things one-by-one may be less good since it leaves a race.

Andries




