Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274971AbRI1Awq>; Thu, 27 Sep 2001 20:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275065AbRI1Awg>; Thu, 27 Sep 2001 20:52:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29157 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274971AbRI1Aw0>;
	Thu, 27 Sep 2001 20:52:26 -0400
Date: Thu, 27 Sep 2001 20:52:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: new^H^H^Himproved devfs races
Message-ID: <Pine.GSO.4.21.0109272040390.1671-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Richard, your symlink-related race fixes do not fix anything.

Enter devfs_readlink()
Let it sleep in copy_to_user()
Have symlink unregistered
->registered is 0, ->refcount is 1, ->linkname points to link body
Have symlink registered again (module had been unloaded, now attacker
causes its reload)
->registered is checked. Looks OK.
->refcount is set to 1.
->linkname is set to _new_ link body
copy_to_user() wakes up and finishes.
devfs_readlink() decrements ->refcount to 0.
devfs_readlink() does kfree() on ->linkname (new one)
We are left with registered entry with zero refcount and linkname
pointing nowhere.

Same scenario applies to other places of that kind.

