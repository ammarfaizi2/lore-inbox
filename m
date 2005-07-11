Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVGKTVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVGKTVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVGKTIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:08:51 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:61616 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262389AbVGKTFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:05:11 -0400
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
In-Reply-To: <20050711175135.GD15292@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
	 <20050630195043.GE23538@serge.austin.ibm.com>
	 <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil>
	 <20050711175135.GD15292@serge.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 11 Jul 2005 15:03:59 -0400
Message-Id: <1121108639.3528.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 12:51 -0500, serue@us.ibm.com wrote:
> I can imagine a few ways of fixing this:
> 
> 	1.	We simply expect that only one module use xattrs.  This
> 	is probably unacceptable, as we will want both EVM and selinux
> 	to store xattrs.

Note that these particular hooks are only used for filesystems like
devpts and tmpfs where there is no underlying storage for the security
xattrs but we still need a way to [gs]et the incore inode security label
from userspace.

> 	2.	A module registers an xattr name when it registers
> 	itself.  Then only the registered module is consulted on one of
> 	these calls.  If no module is registered, all are consulted as
> 	they are now.

SELinux already checks the name suffix in inode_getsecurity and
inode_setsecurity, and returns -EOPNOTSUPP if it isn't selinux.  Hence,
stacker could just iterate through the modules until it gets a result
other than -EOPNOTSUPP, relying on the modules to check the name.

listsecurity is different, as it is supposed to yield the list of
attribute names concatenated together, but that shouldn't be difficult
for stacker to construct, similar to your getprocattr logic but without
the need to add tags.

> 		This prevents a module like capability from deciding
> 	based on its own credentials whether another module's hook
> 	should be called.  Is that a good or bad thing?

These hooks aren't supposed to be doing permission checking; that is
handled by the separate security_inode_*xattr hooks.  They are just for
getting/setting the incore inode security label.

> 		This might have the added bonus of obviating the need
> 	for a separate cap_stack module.

I don't think so - different hooks are involved (inode_setxattr vs.
inode_setsecurity).

-- 
Stephen Smalley
National Security Agency

