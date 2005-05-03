Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVECOoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVECOoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVECOoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:44:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49862 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261689AbVECOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:43:31 -0400
Date: Tue, 3 May 2005 16:43:25 +0200
From: Jan Kara <jack@suse.cz>
To: cliff white <cliffw@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
Message-ID: <20050503144325.GF4501@atrey.karlin.mff.cuni.cz>
References: <20050421152345.6b87aeae@es175>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421152345.6b87aeae@es175>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Started seeing some odd behaviour with recent kernels, haven't been able to
> run it down, could use some suggestions/help.
> 
> Running re-aim7 with 2.6.12-rc2 and rc3, if I use xfs, jfs, or
> reiserfs things work just fine.
> 
> With ext3, the  test stalls, such that:
> CPU is 50% idle, 50% waiting IO (top)
> vmstat shows one process blocked wio
  I've looked through your dumps and I spotted where is the problem -
it's our well known and beloved lock inversion between PageLock and
transaction start (giving CC to Badari who's the author of the patch
that introduced it AFAIK).
  The correct order is: first get PageLock and *then* start transaction.
But in ext3_writeback_writepages() first ext3_journal_start() is called
and then __mpage_writepages is called that tries to do LockPage and
deadlock is there. Badari, could you please fix that (sadly I think that
would not be easy)? Maybe we should back out those changes until it gets
fixed...

								Honza

