Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJDAnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTJDAnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 20:43:14 -0400
Received: from 12-207-41-15.client.attbi.com ([12.207.41.15]:36880 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S261606AbTJDAmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 20:42:51 -0400
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Alpha (EV56), lseek64, and /dev/kmem
Date: Fri, 3 Oct 2003 19:42:50 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310031942.50234.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just found that on my Alpha box, lseek64() has a bit of 
difficulty seeking through /dev/kmem to extremely high 
values--specifically, any value >=0x8000000000000000 (the 64th 
bit set).  Whenever it's supposed to seek to (and return) such a 
value, lseek64() returns -1 instead and sets errno to a 
seemingly random garbage value.  Userspace has no real choice 
except to interpret this as an error.

So far it's doing this on both xfs and ext2/3, so I'm betting 
it's fs-independent.  I suppose it could be the kmem driver 
itself deciding to be quirky?  I have no way of knowing if 
lseek64() will stumble like this on a real file, as I'd probably 
need more drive space than God to test that!

This wouldn't be a problem, except for stuff like klogd that 
seeks through /dev/kmem to discover module symbols.  This little 
quirk tends to make klogd segfault, it seems. :(

In case it matters:

Kernel:		2.4.21+SGI XFS 1.3.0
gcc:		3.2.3
glibc:		2.3.2
binutils:	2.14
modutils:	2.4.25
sysklogd:	1.4.1
distro:		generic from-scratch build

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

