Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUJMBjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUJMBjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJMBjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:39:37 -0400
Received: from blood.actrix.co.nz ([203.96.16.160]:60308 "EHLO
	blood.actrix.co.nz") by vger.kernel.org with ESMTP id S268166AbUJMBje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:39:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Charles Manning <manningc2@actrix.gen.nz>
Reply-To: manningc2@actrix.gen.nz
To: linux-kernel@vger.kernel.org
Subject: Using ilookup?
Date: Wed, 13 Oct 2004 14:42:43 +1300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20041013013930.9BB6649E9@blood.actrix.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm the maintainer for YAFFS, the NAND-specific file system used in many 
mobile/embedded Linux devices over the last two years.

There is a problem that I'm unsure how to best fix. I thought perhaps using 
ilookup might be a good idea, but I see a big fat warning that ilookup is 
perhaps not the function to be using. I therefore seek help.

YAFFS allocates its own "objectId"s which are used as inode numbers for most 
purposes. When objects get deleted (== unlinked), the object numbers get 
recycles.  Sometimes though the Linux cache has an inode after the object has 
been deleted. Then if that object id gets recycled before the cached inode is 
released, a problem occurs since iget() gets the old inode instead of 
creating a new one. We then end up with an inconsistency.

Someone has been able to force this by doing the following:
# cd /test; rm -rf /test

I think I need to do one of two things:

1)  Somehow plug myself into the inode iput() chain so that I know when an 
inode is removed from the cache. I can then make sure that I don't free up 
the inode number for reuse until the inode is not in the cache. Any hints on 
how to do that?

2) When creating inode numbers, I could test for if there is a corresponding 
inode in the cache first and just not recycle that number if there is. To do 
this is ilookup the correct/safe thing to do?

2') A further issue here is that ilookup is not available in some older 2.4.x 
versions. Is it Ok to just patch the ilookup code in, say, 2.4.27 back into 
earlier versions (say 2.4.18 which seems a popular vintage for embedded stuff 
for some reason or other).


Thanx

-- Charles


