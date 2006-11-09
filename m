Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424146AbWKIRNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424146AbWKIRNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424144AbWKIRNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:13:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424127AbWKIRM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:12:58 -0500
Message-ID: <45536192.1050501@sandeen.net>
Date: Thu, 09 Nov 2006 11:12:50 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jeff Layton <jlayton@redhat.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/3] new_inode_autonum: add per-sb lastino counter and
 add	new_inode_autonum function that guarantees i_ino uniqueness
References: <1163085879.21469.45.camel@dantu.rdu.redhat.com>
In-Reply-To: <1163085879.21469.45.camel@dantu.rdu.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
> - add a new per superblock s_nextino counter and change iunique to use it
>   instead of its global inode counter
> - make the size of the counter conditional on CONFIG_COMPAT. This is to try
>   prevent userspace EOVERFLOWs when 32-bit programs not compiled with large
>   offsets are run on 64-bit kernels
> - add new_inode_autonum which guarantees that i_ino is assigned a unique val
>   on the filesystem.
> - Change new_inode to assign i_ino to 0 to catch filesystems that use it and
>   don't reset it to a unique value.

I like the general approach.  A few tidbits...

- the comment for __new_inode isn't accurate, there is no @autonum
parameter added.

- I'm not sure what the point of wrapping __new_inode() in new_inode()
is.  Why not just remove the i_ino setting from new_inode, (or
initialize it to 0*), and let new_inode_autonum() call new_inode();
iunique() ?  Less indirection IMHO....

- *does setting the new i_ino to 0 really help catch anything?  And if
it does, perhaps just setting it in alloc_inode() with all the other
field initializations would be more consistent.

- the comment for the s_nextino field is a bit misleading, it is
actually not used in new_inode(), only in iunique().

-Eric
