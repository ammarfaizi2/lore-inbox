Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272527AbRIKTBr>; Tue, 11 Sep 2001 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272529AbRIKTBh>; Tue, 11 Sep 2001 15:01:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19699 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272527AbRIKTBZ>;
	Tue, 11 Sep 2001 15:01:25 -0400
Date: Tue, 11 Sep 2001 15:01:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Kara <jack@ucw.cz>
cc: vs@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Freeing inode
In-Reply-To: <20010907193935.A5166@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0109111456160.28376-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Sep 2001, Jan Kara wrote:

>   Hello,
> 
>   Vladimir pointed me to another bug in ext2 quota allocation. The problem is
> that when inode is being created but creation fails (either from user being
> over quota or from some other reason) then quota is decremented incorrectly
> (previously the usual case when user is over quota was handled by DQUOT_DROP()
> but this works no more because of DQUOT_INIT() in iput() and ext2_free_inode()).
>   I made a patch which marks inode as bad and then quota is not initialized on
> bad inodes (which makes sence anyway). The patch which is attached is just preliminary
> and nontested (just now I'm realizing that inode being marked as bad might be
> dirty which is not probably the best combination). I'd just like to know whether
> this approach is ok with you or whether you have some better ideas.

I think I have a better approach - grab quota before everything else in
ext2_new_inode() and explicitly release the leftovers in the end.  That
way we simply do not call ext2_free_inode() - if we got to allocation
we are done.

