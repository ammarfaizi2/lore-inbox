Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424056AbWLHCRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424056AbWLHCRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 21:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423857AbWLHCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 21:17:43 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:39399 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164377AbWLHCRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 21:17:42 -0500
Date: Thu, 7 Dec 2006 21:17:14 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
Message-ID: <20061208021714.GA14363@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235471170-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr> <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 07:46:50PM +0100, Jan Engelhardt wrote:
> I smell a big conspiracy! So yet again it's mixed mixed
> 
> fs$ grep __init */*.c | grep -v ' init_'
> sysfs/mount.c:int __init sysfs_init(void)
> sysv/inode.c:int __init sysv_init_icache(void)
> proc/vmcore.c:static int __init vmcore_init(void)
> proc/nommu.c:static int __init proc_nommu_init(void)
> proc/proc_misc.c:void __init proc_misc_init(void)
> proc/proc_tty.c:void __init proc_tty_init(void)
> proc/root.c:void __init proc_root_init(void)
 
Yep.
 
> >> > >+void __unionfs_mknod(void *data)
> >> > >+{
> >> > >+	struct sioq_args *args = data;
> >> > >+	struct mknod_args *m = &args->mknod;
> >> > 
> >> > Care to make that: const struct mknod_args *m = &args->mknod;?
> >> > (Same for other places)
> >>  
> >> Right.
> > 
> >If I make the *args = data line const, then gcc (4.1) yells about modifying
> >a const variable 3 lines down..
> >
> >args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
> >
> >Sure, I could cast, but that seems like adding cruft for no good reason.
> 
> No I despise casts more than missing consts. Why would gcc throw a warning?
> Let's take this super simple program

No, this program doesn't tickle the problem.. Try to compile this one:

<<<
struct mknod_args {
	int mode;
	int dev;
};

void  __mknod(const void *data)
{
	const struct mknod_args *args = data;
	args->mode = 0;
}

int main(void) {
	const struct mknod_args *m;
	__mknod(m);
	return 0;
}
>>>

$ gcc -Wall -c test.c
test.c: In function âmknodâtest.c:10: error: assignment of read-only location


Josef "Jeff" Sipek.

-- 
Reality is merely an illusion, albeit a very persistent one.
		- Albert Einstein
