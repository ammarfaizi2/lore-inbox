Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVAVUed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVAVUed (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAVUed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:34:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:41680 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262698AbVAVUe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:29 -0500
Message-Id: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:00 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 0/13] NFSACL protocol extension for NFSv3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the NFSACL protocol extension, which consists
of the GETACL and SETACL RPCs. I would appreciate to have these patches
in -mm to give them more exposure. (This has nothing to do with NFSv4
acls, by the way.)

The actual access decisions are performed using the ACCESS RPC which is
part of NFSv3 proper, and is independent of acls. The GETACL and SETACL
RPCs are mainly used by tools like getfacl and setfacl, and ls (which
merely displays whether or not a file's permissions go beyond the file
mode permission bits). In addition, for files created inside directories
that have a default acl, SETACL is used at file create time to implement
the POSIX ACL file create semantics (see the comment in
nfsacl-umask.diff for a detailed explanation).

We have been shipping a slightly older version of this patch in SuSE
Linux 8.2, 9.0, 9.1, and SLES9. Until recently acls were not cached on
the client side; we didn't see this as a huge performance issue.
Nevertheless, this version now also caches acls on the client.

The protocol is compatible with the Solaris version. Solaris has
slightly different acl semantics; they are based on an earlier
POSIX acl draft than the Linux version. Other than Linux, Solaris does
not allow three-entry acls (user::, group::, other::). Where Linux has
three-entry acls, Solaris makes up a fourth mask:: entry with the same
permissions as the group:: entry. The NFSACL protocol follows the
Solaris semantics, so we also fake a fourth entry for three-entry
acls, and give it the group:: entry permissions. When receiving a
four-entry acl, we cannot tell three-entry from four-entry acls if the
group:: entry permissions equal the mask:: entry permissions. (If they
differ, we know we have a "real" four-entry acl).  This incompatibility
causes mask entries to be lost in very rare cases.

Four-entry acls are extremely rare and not very useful; I never stumbled
upon them in real life. Judging from that and from the experience of
shipping with this incompatibility for almost two years now, I guess we
can safely continue to ignore this issue. It's not fixable within NFSACL
without breaking Solaris, anyway.

Regards,
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

