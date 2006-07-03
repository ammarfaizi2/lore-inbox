Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWGCWHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWGCWHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGCWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:07:47 -0400
Received: from 1wt.eu ([62.212.114.60]:48137 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751013AbWGCWHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:07:46 -0400
Date: Tue, 4 Jul 2006 00:07:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Linux 2.4.33-rc2
Message-ID: <20060703220736.GA272@1wt.eu>
References: <20060621192756.GB13559@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621192756.GB13559@dmt>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 04:27:56PM -0300, Marcelo Tosatti wrote:
 
> Willy Tarreau:
>       Fix vfs_unlink/NFS NULL pointer dereference

Marcelo, I'm not sure this one is perfect yet. Today, while packaging
a lot of files for our distro at work, I came up with a problem where
deleting a file on NFS, and later simply accessing (read/write/create)
a file on the NFS file system did block. However, I could kill all the
offending processes. This was after a full day of mkdir/create/open/
unlink... (tens of thoudands of those), so it is not much reproduceable.

I could not unmount the NFS anymore, while other users had no problem.
Rebooting the client solved the problem. I caught an RPC trace (attached),
not sure if it can help. I must say that I'm also running Trond's NFS
patches which I suspected first, but with which I never encountered a
single problem for years.

The fact that the problem appeared during an rm -rf made me think about
the vfs_unlink() patch. I went to read it again an I'm wondering if we
have not inserted a new problem (please forgive my ignorance here) :

in 2.4.32, we had the following sequence :
        down(&dir->i_zombie);
        if (may_delete(dir, dentry, 0) != 0) return;
        lock_kernel();
        error = dir->i_op->unlink(dir, dentry);
        unlock_kernel();
        if (!error)
              d_delete(dentry);
        up(&dir->i_zombie);
        if (!error)
                inode_dir_notify(dir, DN_DELETE);


int 2.4.33-rc2, we have :
        if (may_delete(dir, dentry, 0) != 0) return;
        inode = dentry->d_inode;

        atomic_inc(&inode->i_count);
        double_down(&dir->i_zombie, &inode->i_zombie);
 
        lock_kernel();
        error = dir->i_op->unlink(dir, dentry);
        unlock_kernel();

        double_up(&dir->i_zombie, &inode->i_zombie);
        iput(inode);

        if (!error) {
                d_delete(dentry);
                inode_dir_notify(dir, DN_DELETE);
        }

What I notice is that in 2.4.32, d_delete(dentry) was performed
between down(&dir->i_zombie) and up(&dir->i_zombie), while now
it's completely outside. I wonder if this can cause race conditions
or not, but at least, I'm sure that we have changed the locking
sequence, which might have some impact.

Do you think I'm searching in the wrong direction ? I worry a
bit, because getting a deadlock after only one day, it's a bit
early :-/

Thanks,
Willy

--- dmesg after writing to /proc/sys/sunrpc/* ---
nfs: flush(a/100663641)
nfs: write(utm-gateway/truc(100663641), 5@0)
nfs: flush(a/100663641)
RPC: 43724 new task procpid 12145
RPC: 43724 rpc_execute flgs 1
RPC: 43724 deleting timer
RPC: 43724 call_start nfs3 proc 7 (async)
RPC: 43724 deleting timer
RPC: 43724 call_reserve
RPC: 43724 reserved req 925b01cc xid 8c207ac6
RPC: 43724 deleting timer
RPC: 43724 call_reserveresult (status 0)
RPC: 43724 deleting timer
RPC: 43724 call_allocate (status 0)
RPC:      allocated buffer 7faa7800
RPC: 43724 deleting timer
RPC: 43724 call_encode (status 0)
RPC: 43724 deleting timer
RPC: 43724 call_bind xprt 925b0000 is connected
RPC: 43724 deleting timer
RPC: 43724 call_transmit (status 0)
RPC: 43724 xprt_transmit(8c207ac6)
RPC: 43724 xprt_cwnd_limited cong = 0 cwnd = 4021
RPC:      xprt_sendmsg(0) = 188
RPC: 43724 xmit complete
RPC: 43724 sleep_on(queue "xprt_pending" time 7214624)
RPC: 43724 added to queue 925b0058 "xprt_pending"
RPC: 43724 setting alarm for 104 ms
RPC:      wake_up_next(925b004c "xprt_resend")
RPC:      wake_up_next(925b0040 "xprt_sending")
RPC:      udp_data_ready...
RPC:      udp_data_ready client 925b0000
RPC: 43724 received reply
RPC:      cong 256, cwnd was 4021, now 4021
RPC:      wake_up_next(925b004c "xprt_resend")
RPC:      wake_up_next(925b0040 "xprt_sending")
RPC: 43724 has input (136 bytes)
RPC: 43724 __rpc_wake_up_task (now 7214625 inh 0)
RPC: 43724 disabling timer
RPC: 43724 removed from queue 925b0058 "xprt_pending"
RPC: 43724 added to queue 9c46448c "schedq"
RPC:      __rpc_wake_up_task done



