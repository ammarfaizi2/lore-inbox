Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWHPJe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWHPJe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWHPJe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:34:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52702 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751062AbWHPJe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:34:26 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815114912.d8fa1512.akpm@osdl.org> 
References: <20060815114912.d8fa1512.akpm@osdl.org>  <20060815104813.7e3a0f98.akpm@osdl.org> <20060815065035.648be867.akpm@osdl.org> <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> <29717.1155662998@warthog.cambridge.redhat.com> <6241.1155666920@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 16 Aug 2006 10:34:12 +0100
Message-ID: <29660.1155720852@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > > SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
> > 
> > I wonder if this is something to do with it.
> 
> `echo 0 > /selinux/enforce' "fixes" it.

Aha!!!!

	[root@andromeda ~]# ls -l /net/trash
	total 87
	drwxr-xr-x   2 root root       3072 Aug 10 04:10 bin/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 boot/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 dev/
	drwxr-xr-x 133 root root      10240 Aug 16 10:01 etc/
	drwxr-xr-x   2 root root       1024 Jul 12 09:48 home/
	drwxr-xr-x  12 root root       7168 Aug 10 04:10 lib/
	drwxrwsr-x   2 root cambridge  1024 Aug  1 20:41 local/
	drwx------   2 root root      12288 Aug  1 16:12 lost+found/
	drwxr-xr-x   2 root root       1024 Jul 12 09:48 media/
	drwxr-xr-x   2 root root       1024 Jul 24 14:17 misc/
	dr-xr-xr-x   2 root root       1024 Aug  3 09:35 net/
	dr-xr-xr-x   2 root root       1024 Aug  9 16:27 netopt/
	?---------   ? ?    ?             ?            ? /net/trash/mnt
	?---------   ? ?    ?             ?            ? /net/trash/usr
	drwxr-xr-x   2 root root       1024 Jul 12 09:48 opt/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 proc/
	dr-xr-xr-x   2 root root       1024 Aug  3 09:26 project/
	drwxr-x---   4 root root       1024 Aug 16 09:59 root/
	drwxr-xr-x   2 root root      11264 Aug 10 04:10 sbin/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 selinux/
	drwxr-xr-x   2 root root       1024 Jul 12 09:48 srv/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 sys/
	drwxr-xr-x   3 root root       1024 Aug  1 20:27 tftpboot/
	drwxrwxrwt   4 root root       3072 Aug 16 09:46 tmp/
	drwxr-xr-x  29 root root       1024 Aug  1 19:56 var/
	drwxr-xr-x   2 root root       1024 Aug  9 11:35 warthog/

Look familiar?

Requires: autofs4, nfs and SELinux in enforcing mode.

Check your audit logs.  I knew auditing had to be good for something...

| pid 3500: autofs4_lookup: name = trash
| pid 3500: autofs4_lookup: pid = 3500, pgrp = 3500, catatonic = 0, oz_mode = 0
| pid 3500: try_to_fill_dentry: dentry=c0887354 trash ino=00000000
| pid 3500: try_to_fill_dentry: waiting for mount name=trash
| pid 3500: autofs4_wait: new wait id = 0x00000003, name = trash, nfy=1
| 
| pid 3500: autofs4_notify_daemon: wait id = 0x00000003, name = trash, type=0
| audit(1155719601.431:214): avc:  denied  { read } for  pid=3503 comm="showmount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
| audit(1155719601.483:215): avc:  denied  { name_bind } for  pid=3503 comm="showmount" src=712 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:reserved_port_t:s0 tclass=udp_socket
| audit(1155719601.543:216): avc:  denied  { read } for  pid=3501 comm="automount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
| audit(1155719601.567:217): avc:  denied  { name_bind } for  pid=3501 comm="automount" src=710 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:reserved_port_t:s0 tclass=udp_socket
| pid 3501: autofs4_dir_mkdir: dentry c0887354, creating trash
| audit(1155719601.627:218): avc:  denied  { read } for  pid=3507 comm="mount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:mount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file

Autofs magic up to this point.

| --> nfs_init_server()
| --> nfs_get_client(trash,172.16.18.103:264,3)
| --> nfs_get_client() = c0703800 [new]
| SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
| <-- nfs_init_server() = 0 [new c0703800]

That created and initialised an NFS common client and FSID-specific client
struct (struct nfs_server).

| --> nfs_probe_fsinfo()
| <-- nfs_probe_fsinfo() = 0
| Server FSID: 303:0

Determine the FSID.

| NFS: nfs_fhget(0:18/0 ct=1)

Get the dummy root (s_root).

| NFS: nfs_fhget(0:18/2 ct=1)

Get the actual root (inode 2).

| SELinux: initialized (dev 0:18, type nfs), uses genfs_contexts

And that's the NFS superblock set up.

| pid 3507: autofs4_dentry_release: releasing c0c13514
| pid 3507: autofs4_lookup: name = trash:
| pid 3507: autofs4_lookup: pid = 3507, pgrp = 3207, catatonic = 0, oz_mode = 1
| audit(1155719601.775:219): avc:  denied  { read } for  pid=3501 comm="automount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
| audit(1155719601.799:220): avc:  denied  { name_bind } for  pid=3501 comm="automount" src=713 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:reserved_port_t:s0 tclass=udp_socket
| NFS: nfs_update_inode(0:18/2 ct=1 info=0x6)
| NFS: permission(0:18/2), mask=0x1, res=0

Looks reasonable up to here.

| NFS: permission(0:18/2), mask=0x1, res=0
| NFS: lookup(/usr)
| NFS: permission(0:18/2), mask=0x3, res=0
| audit(1155719601.839:221): avc:  denied  { write } for  pid=3501 comm="automount" name="" dev=0:18 ino=2 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:nfs_t:s0 tclass=dir
| NFS: dentry_delete(/usr, 0)
| audit(1155719601.867:222): avc:  denied  { read } for  pid=3501 comm="automount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
| audit(1155719601.891:223): avc:  denied  { name_bind } for  pid=3501 comm="automount" src=715 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:reserved_port_t:s0 tclass=udp_socket

It seems that the automounter is attempting to do things to /usr.

| NFS: permission(0:18/2), mask=0x1, res=0
| NFS: permission(0:18/2), mask=0x1, res=0
| NFS: lookup(/mnt)
| NFS: permission(0:18/2), mask=0x3, res=0
| audit(1155719601.927:224): avc:  denied  { write } for  pid=3501 comm="automount" name="" dev=0:18 ino=2 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:nfs_t:s0 tclass=dir
| NFS: dentry_delete(/mnt, 0)

And /mnt.

| pid 3207: autofs4_root_ioctl: cmd = 0x00009360, arg = 0x00000003, sbi = c54beaa0, pgrp = 3207
| pid 3500: try_to_fill_dentry: mount done status=0
| NFS: nfs_update_inode(0:18/2 ct=1 info=0x6)
| NFS: permission(0:18/2), mask=0x4, res=0
| NFS: opendir(0:18/2)
| NFS: readdir(/) starting at cookie 0
| NFS: nfs_update_inode(0:18/2 ct=1 info=0x6)
| NFS: nfs_fhget(0:18/2502657 ct=1)
| NFS: dentry_delete(/local, 0)
| NFS: nfs_fhget(0:18/10770433 ct=1)
| NFS: dentry_delete(/srv, 0)
| NFS: nfs_fhget(0:18/11 ct=1)
| NFS: dentry_delete(/lost+found, 0)
| NFS: nfs_fhget(0:18/10317825 ct=1)
| NFS: dentry_delete(/tmp, 0)
| NFS: nfs_fhget(0:18/2541569 ct=1)
| NFS: dentry_delete(/bin, 0)
| NFS: nfs_fhget(0:18/7063553 ct=1)
| NFS: dentry_delete(/media, 0)
| NFS: nfs_fhget(0:18/2594817 ct=1)
| NFS: dentry_delete(/lib, 0)
| NFS: nfs_fhget(0:18/10704897 ct=1)
| NFS: dentry_delete(/var, 0)
| NFS: dentry_delete(/usr, 8)
| NFS: dentry_delete(/mnt, 8)

And then it proceeds as normal, barring the fack that the dentried for
trash:/usr and trash:/mnt already exist.

Putting SELinux into permissive mode, I see:

: pid 3376: autofs4_lookup: name = trash
: pid 3376: autofs4_lookup: pid = 3376, pgrp = 3376, catatonic = 0, oz_mode = 0
: pid 3376: try_to_fill_dentry: dentry=c56874b4 trash ino=00000000
: pid 3376: try_to_fill_dentry: waiting for mount name=trash
: pid 3376: autofs4_wait: new wait id = 0x00000001, name = trash, nfy=1
: 
: pid 3376: autofs4_notify_daemon: wait id = 0x00000001, name = trash, type=0
: pid 3377: autofs4_dir_mkdir: dentry c56874b4, creating trash
: audit(1155719382.989:183): avc:  denied  { read } for  pid=3383 comm="mount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:mount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
: --> nfs_init_server()
: --> nfs_get_client(trash,172.16.18.103:264,3)
: --> nfs_get_client() = c752e000 [new]
: SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
: <-- nfs_init_server() = 0 [new c752e000]
: --> nfs_probe_fsinfo()
: <-- nfs_probe_fsinfo() = 0
: Server FSID: 303:0
: NFS: nfs_fhget(0:18/0 ct=1)
: NFS: nfs_fhget(0:18/2 ct=1)
: SELinux: initialized (dev 0:18, type nfs), uses genfs_contexts
: pid 3383: autofs4_lookup: name = trash:
: pid 3383: autofs4_lookup: pid = 3383, pgrp = 3207, catatonic = 0, oz_mode = 1
: NFS: nfs_update_inode(0:18/2 ct=1 info=0x6)
: NFS: permission(0:18/2), mask=0x1, res=0

Looks okay up to here.

: NFS: permission(0:18/2), mask=0x1, res=0
: NFS: lookup(/usr)
: NFS: permission(0:18/2), mask=0x3, res=0
: audit(1155719383.149:184): avc:  denied  { write } for  pid=3377 comm="automount" name="" dev=0:18 ino=2 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:nfs_t:s0 tclass=dir
: audit(1155719383.165:185): avc:  denied  { add_name } for  pid=3377 comm="automount" name="usr" scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:nfs_t:s0 tclass=dir
: audit(1155719383.181:186): avc:  denied  { create } for  pid=3377 comm="automount" name="usr" scontext=root:system_r:automount_t:s0 tcontext=root:object_r:nfs_t:s0 tclass=dir
: NFS: mkdir(0:18/2), usr

What is going on here?????????????????????????????????????????????????????

stracing the automount daemon, I see:

[pid  3803] mkdir("/net", 0555)         = -1 EEXIST (File exists)
[pid  3803] stat64("/net", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
[pid  3803] mkdir("/net/trash", 0555)   = -1 EEXIST (File exists)
[pid  3803] stat64("/net/trash", {st_mode=S_IFDIR|0755, st_size=1024, ...}) = 0
[pid  3803] mkdir("/net/trash/usr", 0555) = -1 EACCES (Permission denied)

I think that would be the problem.  Ian?

David
