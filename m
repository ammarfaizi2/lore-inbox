Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285414AbRLNQyf>; Fri, 14 Dec 2001 11:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285415AbRLNQy0>; Fri, 14 Dec 2001 11:54:26 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:50073
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S285414AbRLNQyN>; Fri, 14 Dec 2001 11:54:13 -0500
Date: Fri, 14 Dec 2001 11:49:28 -0500
From: Chris Mason <mason@suse.com>
To: Johan Ekenberg <johan@ekenberg.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        akpm@zip.com.au, jack@suse.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <3825380000.1008348567@tiny>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, Johan sent along stack traces, and the deadlock works a little like this:

linux-2.4.16 + reiserfs + quota v2

kswapd ->
prune_icache->dispose_list->dquot_drop->commit_dquot->generic_file_write->
mark_inode_dirty->journal_begin-> wait for trans to end

Some process in the transaction is waiting on kswapd to free ram.

So, this will hit any journaled FS that uses quotas and logs inodes under
during a write.  ext3 doesn't seem to do special things for quota anymore, so
it should be affected too.

The only fix I see is to make sure kswapd doesn't run shrink_icache, and to
have it done via a dedicated daemon instead.  Does anyone have a better idea?

-chris

