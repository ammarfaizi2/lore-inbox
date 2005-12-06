Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVLFSry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVLFSry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVLFSry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:47:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:15576 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932619AbVLFSrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:47:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
Date: Tue, 6 Dec 2005 19:49:30 +0100
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       viro@ftp.linux.org.uk
References: <20051206035220.097737000@localhost> <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost>
In-Reply-To: <1133869108.7968.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512061949.33482.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 06 Dezember 2005 12:38, Pekka Enberg wrote:
> On Dinsdag 06 Dezember 2005 01:51, Paul Mackerras wrote:
> > > Remind me again why spufs is under arch/powerpc/ rather than fs/ ?
> 
> On Tue, 2005-12-06 at 11:18 +0100, Arnd Bergmann wrote:
> > We had a discussion about this in August, after the patch
> > at http://patchwork.ozlabs.org/linuxppc64/patch?id=2140
> > 
> > Nobody had voiced any objections against the arch/powerpc location,
> > and Pekka had good reasons against fs/, so I changed it.
> 
> It had arch specific hooks which IMHO do not belong into fs/.

Since the discussion came up again in irc, I looked up the existing file
systems.

outside of fs/, we have the following file systems.

find -name \*.c | grep -v ^./fs | xargs grep struct.file_system_type.*=
./arch/ia64/kernel/perfmon.c:static struct file_system_type pfm_fs_type = {
./drivers/infiniband/core/uverbs_main.c:static struct file_system_type uverbs_event_fs = {
./drivers/isdn/capi/capifs.c:static struct file_system_type capifs_fs_type = {
./drivers/misc/ibmasm/ibmasmfs.c:static struct file_system_type ibmasmfs_type = {
./drivers/oprofile/oprofilefs.c:static struct file_system_type oprofilefs_type = {
./drivers/usb/core/inode.c:static struct file_system_type usb_fs_type = {
./drivers/usb/gadget/inode.c:static struct file_system_type gadgetfs_type = {
./ipc/mqueue.c:static struct file_system_type mqueue_fs_type = {
./kernel/cpuset.c:static struct file_system_type cpuset_fs_type = {
./kernel/futex.c:static struct file_system_type futex_fs_type = {
./mm/shmem.c:static struct file_system_type tmpfs_fs_type = {
./mm/tiny-shmem.c:static struct file_system_type tmpfs_fs_type = {
./net/socket.c:static struct file_system_type sock_fs_type = {
./net/sunrpc/rpc_pipe.c:static struct file_system_type rpc_pipe_fs_type = {
./security/inode.c:static struct file_system_type fs_type = {
./security/selinux/selinuxfs.c:static struct file_system_type sel_fs_type = {

In fs/, most code deals with actual files stored on a disk or similar,
with the exception of:

./fs/binfmt_misc.c:static struct file_system_type bm_fs_type = {
./fs/block_dev.c:static struct file_system_type bd_type = {
./fs/debugfs/inode.c:static struct file_system_type debug_fs_type = {
./fs/devfs/base.c:static struct file_system_type devfs_fs_type = {
./fs/devpts/inode.c:static struct file_system_type devpts_fs_type = {
./fs/eventpoll.c:static struct file_system_type eventpoll_fs_type = {
./fs/hugetlbfs/inode.c:static struct file_system_type hugetlbfs_fs_type = {
./fs/inotify.c:static struct file_system_type inotify_fs_type = {
./fs/openpromfs/inode.c:static struct file_system_type openprom_fs_type = {
./fs/pipe.c:static struct file_system_type pipe_fs_type = {
./fs/proc/root.c:static struct file_system_type proc_fs_type = {
./fs/relayfs/inode.c:static struct file_system_type relayfs_fs_type = {
./fs/sysfs/mount.c:static struct file_system_type sysfs_fs_type = {

I guess there is no strict rule where these file systems go to, e.g.
hugetlbs could just as well live near mm/shmem.c or any of those outside
of fs/ could be moved in there.

I don't really care where I put spufs, but I would prefer to move
the files only one more time at most.
Initially, they were in fs/spufs, and I moved them to
arch/powerpc/platforms/cell/spufs at Pekkas suggestion.

	Arnd <><
