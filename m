Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266012AbUFOX1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266012AbUFOX1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUFOX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:27:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:45508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266012AbUFOX06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:26:58 -0400
Date: Tue, 15 Jun 2004 16:26:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: foo@porto.bmb.uga.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-Id: <20040615162607.5805a97e.akpm@osdl.org>
In-Reply-To: <20040615150036.GB12818@porto.bmb.uga.edu>
References: <20040615062236.GA12818@porto.bmb.uga.edu>
	<20040615030932.3ff1be80.akpm@osdl.org>
	<20040615150036.GB12818@porto.bmb.uga.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

foo@porto.bmb.uga.edu wrote:
>
> On Tue, Jun 15, 2004 at 03:09:32AM -0700, Andrew Morton wrote:
> > Wait for it to happen again, then do
> > 
> > 	echo t > /proc/sysrq-trigger
> > 	dmesg -s 1000000 > foo
> > 
> > then send foo, foo.
> 
> Here you go.  I did dump 2f /dev/null /export/home.  The first time it
> completed, the second it hung right away.
> 
> This is with 2.6.7-rc3-bk6 with no other patches, also compiled with a
> newer gcc.
> 
> ...

> dump          D 000017f4796ce9b2     0  1887   1853                     (NOTLB)
> 000001001ae8dbb8 0000000000000006 000001003ffd5948 000001006a6f96f0 
>        0000000000009235 ffffffff803e23a0 000001006a6f9a08 ffffffff802fd643 
>        0000000000000212 0000000000000001 
> Call Trace:<ffffffff802fd643>{raid5_unplug_device+291} <ffffffff80377d0b>{io_schedule+43} 
>        <ffffffff80155f6a>{__lock_page+250} <ffffffff80155c40>{page_wake_function+0} 
>        <ffffffff80155c40>{page_wake_function+0} <ffffffff801567f6>{do_generic_mapping_read+502} 
>        <ffffffff80156a70>{file_read_actor+0} <ffffffff80156d14>{__generic_file_aio_read+372} 
>        <ffffffff80156dfb>{generic_file_read+123} <ffffffff80169994>{handle_mm_fault+292} 
>        <ffffffff80122ad8>{do_page_fault+440} <ffffffff80130948>{recalc_task_prio+424} 
>        <ffffffff8037748c>{thread_return+41} <ffffffff8017bca7>{vfs_read+199} 
>        <ffffffff8017bf19>{sys_read+73} <ffffffff80123f81>{ia32_sysret+0} 
>        

OK, well I'd be suspecting that either devicemapper or raid5 lost an I/O
completion, causing that page to never be unlocked.

Please try the latest -mm kernel, which has a few devicemapper changes,
although they are unlikely to fix this.

If it's possible to remove either raid5 or devicemapper from the picture,
that would help us find the problem.

Other than that, the chances of getting this fixed are proportional to your
skill in finding us a way of reproducing it.  A good start would be to tell
us exactly which commands were used to set up the LVM and the raid array. 
That way a raid/LVM ignoramus like me can take a look ;)

