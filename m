Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUENRvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUENRvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUENRuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:50:54 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:31371 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261976AbUENRsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:48:45 -0400
Date: Fri, 14 May 2004 11:48:37 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
Message-ID: <20040514174837.GF18086@schnapps.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E1BOQmf-0005cP-4Q@thunk.org> <20040513195310.5725fa43.akpm@osdl.org> <20040514043743.GA22593@thunk.org> <20040513214922.24639ae3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513214922.24639ae3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 13, 2004  21:49 -0700, Andrew Morton wrote:
> Andreas's patch is a bit sneaky: it simply sets ->h_sync on the current
> transaction then does journal_stop().  I think your patch can do the same
> thing?

Well, actually my patch just waited on the _previous_ transaction to commit
(which can be done anywhere without retrying the operation) and then set
h_sync on the _current_ transaction so that as soon as the current operations
are completed it will also be committed and the blocks released.  One can't
of course arbitrarily call journal_stop() or that breaks the transaction
atomicity.

For 99.9% of cases this should be sufficient and doesn't involve changing
the code everywhere - only in ext3_new_block().  Also, Ted's approach
of retrying the operations "outside" the transaction won't work if there
are nested journal transactions being done - those will hold the transaction
open so doing journal_stop/journal_start doesn't really accomplish anything.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

