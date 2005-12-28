Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVL1SrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVL1SrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVL1SrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:47:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45726 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964866AbVL1SrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:47:04 -0500
Date: Wed, 28 Dec 2005 18:47:04 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Parag Warudkar <parag.warudkar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc7] udf/balloc.c : Fix use of uninitialized data
Message-ID: <20051228184704.GG27946@ftp.linux.org.uk>
References: <82e4877d0512280913s66a43d4ida9eda3640520c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e4877d0512280913s66a43d4ida9eda3640520c1@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 12:13:37PM -0500, Parag Warudkar wrote:
> 2.6.15-rc7 - GCC warns correctly -
>  fs/udf/balloc.c: In function 'udf_table_new_block':
>  fs/udf/balloc.c:757: warning: 'goal_eloc.logicalBlockNum' may be used
> uninitialized in this function
> 
> Variable goal_eloc is automatic, non-static and initialized conditionally -
> 
>  if (nspread < spread)
>  {
>      ...........
>      goal_eloc = eloc;
>      ...........
>  }
> 
>  The following patch fixes this by initializing the goal_eloc variable to zero.
> Hopefully zero should be better than some random data!

Wrong.  RTFS, please.  They have

	spread = 0xffffffff;
	while (....) {
		...
		if (nspread < spread) {
			spread = nspread;
			...
			goal_eloc = eloc;
			...
		}
		...
	}
	...
	if (spread == 0xffffffff) {
		...
		return 0;
	}
	....
	use goal_eloc

which is absolutely correct - to reach the use of goal_eloc we have to
have passed through reassignment of spread between spread = 0xffffffff
and departure via if (spread == 0xffffffff).  Such reassignment could
happen only in one block and in the same block we have assignment to
goal_eloc.
