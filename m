Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318309AbSGYDKZ>; Wed, 24 Jul 2002 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSGYDKZ>; Wed, 24 Jul 2002 23:10:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41993 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318309AbSGYDKY>;
	Wed, 24 Jul 2002 23:10:24 -0400
Message-ID: <3D3F6EBB.3B7817C5@zip.com.au>
Date: Wed, 24 Jul 2002 20:21:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] 2.5.28: VM strict overcommit
References: <1027556984.3581.1643.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Andrew and Linus,
> 
> Here again is a port of Alan's VM strict overcommit to the 2.5 kernel,
> with the new policy design Alan and I discussed.
> 

static int shmem_notify_change(struct dentry * dentry, struct iattr *attr)
{
	struct inode *inode = dentry->d_inode;
	int error;

	if (attr->ia_valid & ATTR_SIZE) {
		/*
	 	 * Account swap file usage based on new file size	
	 	 */
		long change = (attr->ia_size>>PAGE_SHIFT) - (inode->i_size >> PAGE_SHIFT);

If the size is changing from 4096 to 4097, `change' will be zero, yes?

Should be

	((ia_size + PAGE_SIZE - 1) >> PAGE_SHIFT) -
		((i_size + PAGE_SIZE - 1) >> PAGE_SHIFT)


----------------------

static ssize_t
shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
{
...
	maxpos = inode->i_size;
	if (pos + count > inode->i_size) {
		maxpos = pos + count;
		if (!vm_enough_memory((maxpos - inode->i_size) >> PAGE_SHIFT)) {
			err = -ENOMEM;
			goto out_nc;
		}
	}

tmpfs supports holes.  Looks to me like a small write which creates
a big hole will be severely over-accounted for?

vm_enough_memory() looks really slow.  I'll bench this a bit.

The expression `(maxpos - inode->i_size) >> PAGE_SHIFT' doesn't accurately
count the number of pages which will be added....

-----------------------

dum_mmap():

		if (mpnt->vm_flags & VM_ACCOUNT) {
			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;

are vm_start and vm_end guaranteed to be a multiple of PAGE_SIZE?


General comment: the on-demand beancounting in vm_enough_memory()
may be something we need in other places - thinking here of
balance_dirty_pages().   Its current policy of "throttle if 40%
of memory is dirty" is junk.  It really wants to know more
information about the dynamic state of the system.  So tracking
all those datums on-the-fly would be handy.  One day.

-
