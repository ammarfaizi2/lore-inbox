Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUKGKp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUKGKp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 05:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUKGKp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 05:45:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:8078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261571AbUKGKpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 05:45:50 -0500
Date: Sun, 7 Nov 2004 02:45:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Mesnier <mmesnier@ece.cmu.edu>
Cc: linux-kernel@vger.kernel.org, mmesnier@ece.cmu.edu
Subject: Re: delay in block_read_full_page()
Message-Id: <20041107024545.243ee610.akpm@osdl.org>
In-Reply-To: <418C7A22.3000205@ece.cmu.edu>
References: <418C7A22.3000205@ece.cmu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Mesnier <mmesnier@ece.cmu.edu> wrote:
>
> Hello,
> 
> Please cc: me directly in your response.
> 
> I'm running into some trouble with an installable file system I'm 
> writing. In myfs_readpage() I simply return block_read_full_page() which 
> subsequently calls myfs_get_block().  However, there's a delay before 
> the I/O actually gets issued to the device.  Running sync from the 
> command line causes the I/O to get issued immediately, so the sync call 
> (even it there aren't dirty buffers) also manages to schedule any 
> outstanding read I/Os. How should my fs indicate to the vfs that these 
> read I/Os need to be issued immediately after my_readpage() is called?

Normally we leave the I/O pending in the expectation that more readpage()
requests will occur.  This allow us to merge things in the disk request
queues.  We'll actually submit the I/O to the device if:

a) There's a lot of it pending or

b) There haven't been any more readpage() calls for a while or

c) Someone actually wants to wait on the I/O (say, via lock_page())

It is unusual that you want this I/O to kick off immediately.  You will
probably find that blk_run_backing_dev() will do what you want.


That's all for a 2.6 kernel - you didn't specify.  It it's a 2.4 kernel
then you'll need to use run_task_queue(&tq_disk) to flush the queued I/O
requests.
