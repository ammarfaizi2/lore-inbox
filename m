Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937385AbWLDU5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937385AbWLDU5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937391AbWLDU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:57:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937384AbWLDU5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:57:37 -0500
Message-ID: <45748929.20406@redhat.com>
Date: Mon, 04 Dec 2006 15:46:33 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Russell Cattelan <cattelan@thebarn.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com>	<20061122153603.33c2c24d.akpm@osdl.org>	<456B7A5A.1070202@redhat.com>	<20061127165239.9616cbc9.akpm@osdl.org>	<456CACF3.7030200@redhat.com>	<20061128162144.8051998a.akpm@osdl.org>	<456D2259.1050306@redhat.com>	<456F014C.5040200@redhat.com> <20061201132329.4050d6cd.akpm@osdl.org> <45730E36.10309@redhat.com> <45745207.4030107@thebarn.com>
In-Reply-To: <45745207.4030107@thebarn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Cattelan wrote:
> Wendy Cheng wrote:
>
>> Linux kernel, particularly the VFS layer, is starting to show signs 
>> of inadequacy as the software components built upon it keep growing. 
>> I have doubts that it can keep up and handle this complexity with a 
>> development policy like you just described (filesystem is a dumb 
>> layer ?). Aren't these DIO_xxx_LOCKING flags inside 
>> __blockdev_direct_IO() a perfect example why trying to do too many 
>> things inside vfs layer for so many filesystems is a bad idea ? By 
>> the way, since we're on this subject, could we discuss a little bit 
>> about vfs rename call (or I can start another new discussion thread) ?
>>
>> Note that linux do_rename() starts with the usual lookup logic, 
>> followed by "lock_rename", then a final round of dentry lookup, and 
>> finally comes to filesystem's i_op->rename call. Since lock_rename() 
>> only calls for vfs layer locks that are local to this particular 
>> machine, for a cluster filesystem, there exists a huge window between 
>> the final lookup and filesystem's i_op->rename calls such that the 
>> file could get deleted from another node before fs can do anything 
>> about it. Is it possible that we could get a new function pointer 
>> (lock_rename) in inode_operations structure so a cluster filesystem 
>> can do proper locking ?
>
> It looks like the ocfs2 guys have the similar problem?
>
> http://ftp.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-upstream-linus-20060924/0009-PATCH-Allow-file-systems-to-manually-d_move-inside-of-rename.txt 
>
>
>

Thanks for the pointer. Same as ocfs2, under current VFS code, both 
GFS1/2 also need FS_ODD_RENAME flag for the rename problem - got an ugly 
~200 line draft patch ready for GFS1 (and am looking into GFS2 at this 
moment). The issue here is, for GFS, if vfs lock_rename() can call us, 
this complication can be greatly reduced. Will start another thread to 
see whether the wish can be granted.

-- Wendy

