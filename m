Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUDWFcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUDWFcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 01:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbUDWFcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 01:32:46 -0400
Received: from [82.138.8.106] ([82.138.8.106]:19444 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264717AbUDWFZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 01:25:23 -0400
X-Comment-To: Andrew Morton
Cc: Linus Torvalds <torvalds@osdl.org>, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       alex@clusterfs.com
Subject: Re: ext3 reservation question.
References: <200404211655.47329.pbadari@us.ibm.com>
	<Pine.LNX.4.58.0404211959560.18945@ppc970.osdl.org>
	<20040421204036.4e530732.akpm@osdl.org>
From: Alex Tomas <alex@clusterfs.com>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Fri, 23 Apr 2004 09:22:55 +0400
Message-ID: <m365bre09c.fsf@bzzz.home.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> That worked fine on ext2.  But on ext3 we have a transaction open in
 AM> prepare_write(), and the forced writeback will cause arbitrary amounts of
 AM> unexpected metadata to be pumped into the current transaction, causing the
 AM> fs to explode.

why to open transaction for ->prepare_write()? as for me, it doesn't
touch metadata to be stored on a disk.

I've partial implemented following idea:

->prepare_write() recognizes are blocks being written holes or reserved.
  it they are holes and haven't reserved yet, then set a flag about this.
  note that ->prepare_write() doesn't look right place to put reservation
  in because copy_from_user() in generic_file_aio_write_nolock() may fail.

->commit_write() looks at that flag and if it's set tries to reserve blocks.
  if reservation fails then ->commit_write() returns -ENOSPC, ext3_file_write()
  recognizes this, requests flushing and wait for free space.

->invalidatepage() drops reservation if space for page still non-allocated

->writepages() and ->writepage() drop reservation upon real allocation

I expect data=ordered mode to be very simple to implement: just put bio
submited in ->writepages() on list for correspondend transaction and
wait for completion of bio's in commit_transaction().

does this all make sense?

thanks, Alex

