Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUD2Nmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUD2Nmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbUD2Nmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:42:40 -0400
Received: from ahk.pu.ru ([193.124.85.198]:64005 "EHLO ahk.pu.ru")
	by vger.kernel.org with ESMTP id S264513AbUD2Nmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:42:38 -0400
Date: Fri, 30 Apr 2004 17:45:17 +0400
From: Vyacheslav NightFlash <nightflash@land.ru>
To: linux-kernel@vger.kernel.org
Subject: [QUESTION] Atomicity/Journaling in VFS layer
Message-ID: <20040430134517.GA5574@VT10561.spb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that all journaling filesystems ordering their
ondisk modifications somehow Isn't it better to add
ability to order data/metadata modifications to VFS layer?

Also hacking VFS is the only way to provide data consistency
if application want "write A" to appear before "write B",
but A and B are on different filesystems.

I have some ideas how it could be done, but I dont know VFS much,
so I'll be happy to see comments from guru.

1) Every inode keeps list of "atoms".

2) Every "atom" keeps list of modified buffers, that can appear in
ondisk FS layout only together.

3) "atom" keeps list of "atom"s, that must be commited
before it can start its own writeback.

4) "atom" keeps list of "atom"s that are waiting for its commit,
so that they can be marked as "ready for writeback" as a part of
its io completition.

5) We can assign virtual inodes to journals & metadata structures,
so we can track data-journal-metadata write order using the same
"atom dependencies"

6) When process writes to fd new "atom" is created. It initialized
so that in could not be written before commit of data that process
has read/wrote before this "atom" creation.

7) Every buffer has link to his atom (or NULL if it's clean).
So we can add some more "dependencies" to atom that owns buffer.


