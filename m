Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbTD2Wdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTD2Wdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:33:35 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:46601 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261888AbTD2Wdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:33:33 -0400
Message-ID: <3EAF01FE.2040600@kolumbus.fi>
Date: Wed, 30 Apr 2003 01:51:42 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: possible race condition in vfs code
References: <200304150922.07003.dsp@llnl.gov>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 30.04.2003 01:46:52,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 30.04.2003 01:46:28,
	Serialize complete at 30.04.2003 01:46:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That piece of code looks wrong in other ways also..if we have unmounted 
an active fs (which shouldn't be done but happens!) we shouldn't be at 
least writing back to it anything! The !sb test isn't useful (we never 
clear it in live inodes) and MS_ACTIVE handling is racy as hell wrt 
umount...

--Mika


Dave Peterson wrote:

>I think I found a race condition in some of the inode handling
>code.  Here's where I think it is:
>
>    1.  Task A is inside kill_super().  It clears the MS_ACTIVE
>        flag of the s_flags field of the super_block struct and
>        calls invalidate_inodes().  In invalidate_inodes(), it
>        attempts to acquire inode_lock and spins because task B,
>        executing inside iput(), just decremented the reference
>        count of some inode i to 0 and acquired inode_lock.
>
>    2.  Then the "if (!inode->i_nlink)" test condition evaluates
>        to false for task B so it executes the following chunk
>        of code:
>
>        01 } else {
>        02         if (!list_empty(&inode->i_hash)) {
>        03                 if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
>        04                         list_del(&inode->i_list);
>        05                         list_add(&inode->i_list, &inode_unused);
>        06                 }
>        07                 inodes_stat.nr_unused++;
>        08                 spin_unlock(&inode_lock);
>        09                 if (!sb || (sb->s_flags & MS_ACTIVE))
>        10                         return;
>        11                 write_inode_now(inode, 1);
>        12                 spin_lock(&inode_lock);
>        13                 inodes_stat.nr_unused--;
>        14                 list_del_init(&inode->i_hash);
>        15         }
>        16         list_del_init(&inode->i_list);
>        17         inode->i_state|=I_FREEING;
>        18         inodes_stat.nr_inodes--;
>        19         spin_unlock(&inode_lock);
>        20         if (inode->i_data.nrpages)
>        21                 truncate_inode_pages(&inode->i_data, 0);
>        22         clear_inode(inode);
>        23 }
>        24 destroy_inode(inode);
>
>        Now the test condition on line 02 evaluates to true, so
>        task B adds the inode to the inode_unused list and then
>        releases inode_lock on line 08.
>
>    3.  Now A acquires inode_lock and B spins on inode_lock inside
>        write_inode_now();
>
>    4.  Task A calls invalidate_list(), transferring inode i from
>        the inode_unused list to its own private throw_away list.
>
>    5.  Task A releases inode_lock, allowing B to acquire inode_lock
>        and continue executing.
>
>    6.  A attempts to destroy inode i inside dispose_list() while B
>        simultaneously attempts to destroy i, potentially causing
>        all sorts of bad things to happen.
>
>So, did I find a bug or are my eyes playing tricks on me?
>
>-Dave Peterson
> dsp@llnl.gov
>
>P.S.  Please CC my email address when responding to this message.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


