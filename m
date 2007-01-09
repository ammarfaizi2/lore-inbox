Return-Path: <linux-kernel-owner+w=401wt.eu-S932091AbXAIN5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbXAIN5f (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbXAIN5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:57:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46661 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091AbXAIN5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:57:34 -0500
Subject: Re: JFS: possible recursive locking detected
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: Tomasz Kvarsin <kvarsin@gmail.com>, linux-kernel@vger.kernel.org,
       jfs-discussion@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <45A3613F.1050604@in.ibm.com>
References: <5157576d0701082333h276b99f3l7a785f6e2f250c27@mail.gmail.com>
	 <45A3613F.1050604@in.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 13:56:14 +0000
Message-Id: <1168350974.13500.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 15:02 +0530, Srinivasa Ds wrote:
> Tomasz Kvarsin wrote:
> > This I got during boot with 2.6.20-rc4:
> > =============================================
> > [ INFO: possible recursive locking detected ]

... 

> So below patch should fix this problem,please test this. Let me know 
> your comments on this.

I'm sure there are several other places in the jfs code that need the
same treatment.  I've put this off too long already.  I'll get a
comprehensive lock annotation patch out today, starting with this one.

> 
> Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>

Thanks,
Shaggy

> 
> 
> plain text document attachment (jfs.fix)
>  namei.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.20-rc4/fs/jfs/namei.c
> ===================================================================
> --- linux-2.6.20-rc4.orig/fs/jfs/namei.c
> +++ linux-2.6.20-rc4/fs/jfs/namei.c
> @@ -104,8 +104,8 @@ static int jfs_create(struct inode *dip,
>  
>  	tid = txBegin(dip->i_sb, 0);
>  
> -	mutex_lock(&JFS_IP(dip)->commit_mutex);
> -	mutex_lock(&JFS_IP(ip)->commit_mutex);
> +	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, I_MUTEX_PARENT);
> +	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, I_MUTEX_CHILD);
>  
>  	rc = jfs_init_acl(tid, ip, dip);
>  	if (rc)
-- 
David Kleikamp
IBM Linux Technology Center

