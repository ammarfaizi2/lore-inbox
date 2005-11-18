Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbVKRMd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbVKRMd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVKRMd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:33:27 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:35782 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161084AbVKRMdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:33:05 -0500
Date: Fri, 18 Nov 2005 18:03:07 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, ak@suse.de,
       ebiederm@xmission.com
Subject: Re: [PATCH 3/10] kdump: export per cpu crash notes pointer through sysfs
Message-ID: <20051118123307.GF7217@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117140723.3cd2e831.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117140723.3cd2e831.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 02:07:23PM -0800, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > +	/*
> > +	 * Might be reading other cpu's data based on which cpu read thread
> > +	 * has been scheduled. But cpu data (memory) is allocated once during
> > +	 * boot up and this data does not change there after. Hence this
> > +	 * operation should be safe. No locking required.
> > +	 */
> > +	get_cpu();
> > +	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
> > +	rc = sprintf(buf, "%Lx\n", addr);
> > +	put_cpu();
> 
> I don't think the get_cpu() and put_cpu() are needed here?

Thanks. I have done the changes. Please find attached the incremental patch.

Thanks
Vivek


o Removes the call to get_cpu() and put_cpu() as it is not required.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-mm2-1M-root/drivers/base/cpu.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/base/cpu.c~kdump-export-crash-notes-sysfs-remove-get-cpu drivers/base/cpu.c
--- linux-2.6.15-rc1-mm2-1M/drivers/base/cpu.c~kdump-export-crash-notes-sysfs-remove-get-cpu	2005-11-18 16:08:28.000000000 +0530
+++ linux-2.6.15-rc1-mm2-1M-root/drivers/base/cpu.c	2005-11-18 16:08:28.000000000 +0530
@@ -101,10 +101,8 @@ static ssize_t show_crash_notes(struct s
 	 * boot up and this data does not change there after. Hence this
 	 * operation should be safe. No locking required.
 	 */
-	get_cpu();
 	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
 	rc = sprintf(buf, "%Lx\n", addr);
-	put_cpu();
 	return rc;
 }
 static SYSDEV_ATTR(crash_notes, 0400, show_crash_notes, NULL);
_
