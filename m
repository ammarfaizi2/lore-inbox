Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUCRPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUCRPnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:43:20 -0500
Received: from lx.quiotix.com ([199.164.185.7]:8378 "EHLO lx.quiotix.com")
	by vger.kernel.org with ESMTP id S262719AbUCRPnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:43:06 -0500
Message-ID: <4059C381.1000601@quiotix.com>
Date: Thu, 18 Mar 2004 07:42:57 -0800
From: Jeffrey Siegal <jbs@quiotix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is fsync so much slower than O_SYNC?
References: <40587F90.1040903@quiotix.com> <20040318003335.6bf3eb41.akpm@osdl.org>
In-Reply-To: <20040318003335.6bf3eb41.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> This is because ext3 is being dumb.  It is forcing a journal commit even
> when the inode has not been altered.
> 
> Here's a moderately-tested 2.6 fix.  A 2.4 fix would be similar.
> 
> 
> File overwrite:
> 
> 	vmm:/mnt/hda5> ~/fsync-is-sucky 
> 	O_SYNC:
> 	Creating
> 	Starting
> 	iter = 1000, latency = 0.191464ms
> 
> 	O_DSYNC:
> 	Creating
> 	Starting
> 	iter = 1000, latency = 0.181637ms
> 
> 	fsync:
> 	Creating
> 	Starting
> 	iter = 1000, latency = 0.186326ms
> 
> 	fdatasync:
> 	Creating
> 	Starting
> 	iter = 1000, latency = 0.193013ms

Hmm, this doesn't seem right.  For an overwrite, it should still be 
waiting for just the data page to be written out, and that should take 
about 8ms (for a 7200rpm drive), and the append case should take longer, 
since it requires writing both the data page and then the journal.

