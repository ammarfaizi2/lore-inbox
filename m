Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUIJIzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUIJIzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUIJIzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:55:14 -0400
Received: from asplinux.ru ([195.133.213.194]:59151 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267323AbUIJIxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:53:06 -0400
Message-ID: <41416E1A.5050905@sw.ru>
Date: Fri, 10 Sep 2004 13:04:26 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Q: bugs in generic_forget_inode()?
References: <413C52E2.10809@sw.ru> <20040906123534.3487839e.akpm@osdl.org>
In-Reply-To: <20040906123534.3487839e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Kirill Korotaev <dev@sw.ru> wrote:
> 
>>Hello,
>>
>>1. I found that generic_forget_inode() calls write_inode_now() dropping 
>>inode_lock and destroys inode after that. The problem is that 
>>write_inode_now() can sleep and during this sleep someone can find inode 
>>in the hash, w/o I_FREEING state and with i_count = 0.
> 
> The filesystem is in the process of being unmounted (!MS_ACTIVE).  So the
> question is: who is doing inode lookups against a soon-to-be-defunct
> filesystem?

Yup, I'm studing this issue.
But while looking at code I found this interesting place:

__writeback_single_inode()
{
         while (inode->i_state & I_LOCK) {
                 __iget(inode);			<<<<<<
                 spin_unlock(&inode_lock);
                 __wait_on_inode(inode);
                 iput(inode);			<<<<<<
                 spin_lock(&inode_lock);
        }
	return __sync_single_inode(inode, wbc); <<<<<<
}

the problem here is iget/iput.

There are 2 possible cases:
1. all callers of this function do hold reference on inode, then 
iget/iput is unneeded.
2. if 1) is incorrect then it's a bug, since inode is used after iput.

This place looks really ugly, or I don't understand something here?

Kirill

