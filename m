Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbULBDJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbULBDJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 22:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULBDJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 22:09:08 -0500
Received: from [61.48.53.101] ([61.48.53.101]:35832 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261545AbULBDJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 22:09:01 -0500
Date: Wed, 1 Dec 2004 18:59:02 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412020259.iB22x2D24700@adam.yggdrasil.com>
To: akpm@osdl.org, chrisw@osdl.org
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
>* Andrew Morton (akpm@osdl.org) wrote:
>> That's all well and good, but sysfs_new_dirent() should be using a
>> standalone slab cache for allocating sysfs_dirent instances.  That way, we
>> use 36 bytes for each one rather than 64.

>Reasonable, here's a patch (lightly tested).  [...]

	Great.  That way 32-bit architectures should be able to
benefit from some another shrink of sysfs_dirent that I'd like
to do, and it will also help 64-bit architectures (where sysfs_dirent
is still larger than 32 bytes even with my change).

	I applied Chris's patch on top of my own (which still
saves about 14kB on my machine and shrinks the source code by 11
lines) and I am running it now.  It looks fine to me, although I
haven't looked into making a separate slab cache before.  I guess
it's okay that there is no alignment requirement on it for now,
as there are a lot of sysfs_dirent structure and more every day,
and programs that would access these structures frequently would
also probably cause access to a lot of them at the same time (by
scanning the sysfs tree), so inter-processor cache line contention
might be offset by the more efficient utilization of the processor's
cache.

	Chris's patch file applied without conflict (there was a
one line offset in fs/sysfs/sysfs.h), so it should be easy to
integrate both patches.  Please let me know if there is anything
further I should or can do to help make that happen, as I'd like
to have my fs/sysfs tree in sync before trying to unpin the
struct dirent and struct inode for sysfs directories, as I
expect that to be a more complex patch (and unpin hundreds of kbytes).

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
