Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWCYEKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWCYEKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWCYEKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:10:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:927 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750766AbWCYEKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:10:40 -0500
Date: Fri, 24 Mar 2006 20:10:20 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, davem@davemloft.net,
       rdunlap@xenotime.net, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 03/08] NET: compat ifconf: fix limits
Message-ID: <20060325041020.GD16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

A recent change to compat. dev_ifconf() in fs/compat_ioctl.c
causes ifconf data to be truncated 1 entry too early when copying it
to userspace.  The correct amount of data (length) is returned,
but the final entry is empty (zero, not filled in).
The for-loop 'i' check should use <= to allow the final struct
ifreq32 to be copied.  I also used the ifconf-corruption program
in kernel bugzilla #4746 to make sure that this change does not
re-introduce the corruption.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/compat_ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.6.orig/fs/compat_ioctl.c
+++ linux-2.6.15.6/fs/compat_ioctl.c
@@ -687,7 +687,7 @@ static int dev_ifconf(unsigned int fd, u
 	ifr = ifc.ifc_req;
 	ifr32 = compat_ptr(ifc32.ifcbuf);
 	for (i = 0, j = 0;
-             i + sizeof (struct ifreq32) < ifc32.ifc_len && j < ifc.ifc_len;
+             i + sizeof (struct ifreq32) <= ifc32.ifc_len && j < ifc.ifc_len;
 	     i += sizeof (struct ifreq32), j += sizeof (struct ifreq)) {
 		if (copy_in_user(ifr32, ifr, sizeof (struct ifreq32)))
 			return -EFAULT;
