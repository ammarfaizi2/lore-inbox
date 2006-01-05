Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWAEWHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWAEWHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAEWHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:07:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:34572 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1752164AbWAEWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:07:29 -0500
Date: Thu, 5 Jan 2006 23:07:19 +0100
From: Willy TARREAU <willy@w.ods.org>
To: =?iso-8859-1?Q?j=FCrgen?= baumann <jbaumann@is-kassel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.33pre1 kernel/sysctl.c missing spin_unlock()
Message-ID: <20060105220719.GA618@w.ods.org>
References: <43BD3AB7.9020003@is-kassel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43BD3AB7.9020003@is-kassel.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 04:26:47PM +0100, jürgen baumann wrote:
> possibly fixed yet, but maybe not:
> 
> in above patch there was a spinlock(&sysctl_lock) added in 
> function do_register_sysctl_table(), but no corresponding 
> spin_unlock() before return.
> 
> after starting the new kernel (unfortunately with further 
> patches), it hangs on trying to start the kswapd-thread.
> 
> after inserting the spin_unlock() all run fine.

Can you be more specific ? First, there's no function named
like this in 2.4.33-pre1. The most approaching change I can
find lies in kernel/sysctl.c:register_sysctl_table() and this
one uses valid locking :

struct ctl_table_header *register_sysctl_table(ctl_table * table, 
                                               int insert_at_head)
{
        struct ctl_table_header *tmp;
        tmp = kmalloc(sizeof(struct ctl_table_header), GFP_KERNEL);
        if (!tmp)
                return NULL;
        tmp->ctl_table = table;
        INIT_LIST_HEAD(&tmp->ctl_entry);
        tmp->used = 0;
        tmp->unregistering = NULL;
===>    spin_lock(&sysctl_lock);
        if (insert_at_head)
                list_add(&tmp->ctl_entry, &root_table_header.ctl_entry);
        else
                list_add_tail(&tmp->ctl_entry, &root_table_header.ctl_entry);
===>    spin_unlock(&sysctl_lock);
#ifdef CONFIG_PROC_FS
        register_proc_table(table, proc_sys_root, tmp);
#endif
        return tmp;
}

So possibly you found one real bug, but please tell us where you
had to patch !

Thanks in advance,
Willy

