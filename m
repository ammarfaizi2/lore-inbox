Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUIMP6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUIMP6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUIMP45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:56:57 -0400
Received: from asplinux.ru ([195.133.213.194]:47625 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S268246AbUIMPuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:50:00 -0400
Message-ID: <4145C45E.2020705@sw.ru>
Date: Mon, 13 Sep 2004 20:01:34 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: BUG in writeback_inodes()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

It looks like there is a small race bug in writeback_inodes()
Have a look at this 2 call chains:

writeback_inodes()
{
	....
	sb->s_count++;
	spin_unlock(&sb_lock);
	....
	spin_lock(&sb_lock);
	if (__put_super(sb))		<<< X
		goto restart;
	}
}

deactivate_super()
{
	fs->kill_sb(s);
		kill_block_super(sb)
			generic_shutdown_super(sb)
			        spin_lock(&sb_lock);
			        list_del(&sb->s_list);	<<< Y
			        spin_unlock(&sb_lock);
	....
	put_super(s);
	        spin_lock(&sb_lock);
	        __put_super(sb);			<<< Z
         	spin_unlock(&sb_lock);
}

The problem with it is that writeback_inodes() supposes that if 
__put_super() returns 0 then no super block was deleted from the list 
and we can safely traverse sb list further.

But as it is obvious from the deactivate_super() it's not actually true. 
because at point Y we delete super block from the list and drop the 
lock. We do __put_super() very much later... So we can find sb with 
poisoned sb->s_list at point X and we won't be the last sb reference 
holders. The last reference will be dropped in point Z.

So in case of the following sequence of execution Y -> X -> Z we'll get 
an oops after point X in writeback_inodes().

Am I correct with it?

Kirill

