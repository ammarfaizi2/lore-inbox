Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311361AbSCLWSH>; Tue, 12 Mar 2002 17:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311360AbSCLWR5>; Tue, 12 Mar 2002 17:17:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16903 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311356AbSCLWRk>;
	Tue, 12 Mar 2002 17:17:40 -0500
Message-ID: <3C8E7E0C.816A3527@zip.com.au>
Date: Tue, 12 Mar 2002 14:15:40 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: linux-kernel@vger.kernel.org, aviro@math.psu.edu
Subject: Re: [RFC] write_super is for syncing
In-Reply-To: <205630000.1015970453@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> Hi everyone,
> 
> The fact that write_super gets called for both syncs and periodic
> commits causes problems for the journaled filesystems, since we
> need to trigger commits on write_super to have sync() behave
> properly.
> 
> So, this patch adds a new super operation called commit_super,
> and extends struct super.s_dirt a little so the filesystem
> can say: call me on sync() but don't call me from kupdate.
> 
> if (s_dirt & S_SUPER_DIRTY) call me from kupdate and on sync
> if (s_dirt & S_SUPER_DIRTY_COMMIT) call me on sync only.
> 

I'm not quite sure why these flags exist?  Would it not be
sufficient to just call ->write_super() inside kupdate,
and ->commit_super in fsync_dev()?  (With a ->write_super
fallback, of course).

Either way, this is good - ext3's write_super() can just
become a one-liner:  `sb->s_dirt = 0'.

-
