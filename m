Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUFDPv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUFDPv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUFDPv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:51:27 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:12974 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S265841AbUFDPvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:51:06 -0400
Date: Fri, 4 Jun 2004 17:51:03 +0200
From: Eduard Bloch <blade@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [HOWTO...] LUFS, readpage and large files
Message-ID: <20040604155103.GA15021@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while writting a new LUFS plugin (to emulate large file support on
FAT32;) I stumbled over a problem with it's kernel communication module.
The symptoms were the same as with broken programs that use int or long
int instead of size_t (or even long long) for storing file offsets.
However, here the broken offsets (modulo 4GB) came from kernel so I
traced it down to this method:

static int lu_file_readpage(struct file *f, struct page *p)
{
    int res;
    struct iovec siov[3], riov;
    long long offset;
    unsigned long count;
    struct server_slot *slot;

    TRACE("in\n");

    if((slot = lu_getslot(GET_INFO(f->f_dentry->d_sb))) == NULL)
    	return -ERESTARTSYS;

    get_page(p);

    if((res = lu_getname(f->f_dentry, slot->s_buf, LU_MAXDATA)) < 0){
      WARN("lu_getname failed!\n");
      goto out;
    }

    offset = p->index << PAGE_CACHE_SHIFT;
    count = PAGE_SIZE;

The problem is, page->index indeed contains a short datatype for offset -
...but where to get the correct data? (the long long offset).

I tried to look at how other filesystems manage it but they become too
complex when it comes to details. Unfortunately, most documentation
about VFS and filesystems (found on Internet) simply sucks when it comes
to such details, especially for Large Files.
The autors simply refer to "block lockup methods" or similar things but
nobody gives an example explanation or correct description of how the
way of the data should like (complete - all steps between the request,
page allocation, translation of addresses etc.pp.).

Regards,
Eduard.
-- 
Eine Freude vertreibt hundert Sorgen.
