Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbTCOKZa>; Sat, 15 Mar 2003 05:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbTCOKZa>; Sat, 15 Mar 2003 05:25:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:28296 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261379AbTCOKZ3>;
	Sat, 15 Mar 2003 05:25:29 -0500
Date: Sat, 15 Mar 2003 02:36:14 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove BKL from ext2's readdir
Message-Id: <20030315023614.3e28e67b.akpm@digeo.com>
In-Reply-To: <m3vfyluedb.fsf@lexa.home.net>
References: <m3vfyluedb.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 10:36:04.0913 (UTC) FILETIME=[AE629210:01C2EADE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> hi!
> 
> I took a look at readdir() in 2.5.64's ext2 and found it serialized by BKL.

Yes, I had this in -mm for ages, seem to have lost it.  Also removal of BKL
from lseek().

The theory is that the lock is there to avoid f_pos races against lseek.  We
ended up deciding that the way to address this is to ensure that all readdir
implementations do:

foo_readdir()
{
	loff_t pos = file->f_pos;

	....
	<code which doesn't touch file->f_pos, but which modifies pos>
	...

	file->f_pos = pos;
}

ext2 does this right and does not need the lock_kernel().  Once all
filesystems have been audited (and, if necessary, fixed) we can remove the
BKL from lseek also.

