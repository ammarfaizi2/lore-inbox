Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWHPMYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWHPMYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWHPMYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:24:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbWHPMYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:24:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <30157.1155722439@warthog.cambridge.redhat.com> 
References: <30157.1155722439@warthog.cambridge.redhat.com>  <29660.1155720852@warthog.cambridge.redhat.com> <20060815114912.d8fa1512.akpm@osdl.org> <20060815104813.7e3a0f98.akpm@osdl.org> <20060815065035.648be867.akpm@osdl.org> <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> <29717.1155662998@warthog.cambridge.redhat.com> <6241.1155666920@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 16 Aug 2006 13:23:47 +0100
Message-ID: <6237.1155731027@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> ...
>  (8) An unconstructed dentry is left, which causes the "?---------" lines to
>      appear in the ls -l listing.
> ...
> However, (8) might well represent a bug in NFS.

I've done some investigation into this:

The automount point before mounting has one security label and another after
mounting:

	[root@andromeda ~]# ls -Zd /net/trash
	dr-xr-xr-x  root root system_u:object_r:autofs_t       /net/trash/
	[root@andromeda ~]# ls -l /net/trash
	total 87
	drwxr-xr-x   2 root root       3072 Aug 10 04:10 bin/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 boot/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 dev/
	drwxr-xr-x 133 root root      10240 Aug 16 12:36 etc/
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
	drwxr-x---   7 root root       1024 Aug 16 11:49 root/
	drwxr-xr-x   2 root root      11264 Aug 10 04:10 sbin/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 selinux/
	drwxr-xr-x   2 root root       1024 Jul 12 09:48 srv/
	drwxr-xr-x   2 root root       1024 Aug  1 16:13 sys/
	drwxr-xr-x   3 root root       1024 Aug  1 20:27 tftpboot/
	drwxrwxrwt   4 root root       3072 Aug 16 11:49 tmp/
	drwxr-xr-x  29 root root       1024 Aug  1 19:56 var/
	drwxr-xr-x   2 root root       1024 Aug  9 11:35 warthog/
	[root@andromeda ~]# ls -Zd /net/trash
	drwxr-xr-x  root root system_u:object_r:nfs_t          /net/trash/

Automount daemons all have the automount_t label:

	[root@andromeda ~]# ps -Zaux | grep automount
	Warning: bad syntax, perhaps a bogus '-'? See /usr/share/doc/procps-3.2.6/FAQ
	root:system_r:automount_t       root      ... /usr/sbin/automount --timeout=60
	root:system_r:automount_t       root      ... /usr/sbin/automount --timeout=60
	root:system_r:automount_t       root      ... /usr/sbin/automount --timeout=60
	root:system_r:automount_t       root      ... /usr/sbin/automount --timeout=60


I added this patch to instrument nfs_lookup():

	--- fs/nfs/dir.c.orig	2006-08-14 09:08:28.000000000 +0100
	+++ fs/nfs/dir.c	2006-08-16 12:49:20.000000000 +0100
	@@ -890,6 +890,10 @@ static struct dentry *nfs_lookup(struct 
		struct nfs_fh fhandle;
		struct nfs_fattr fattr;

	+	printk("-->nfs_lookup(%s,%s,{%x,%x,%x})\n",
	+	       dentry->d_parent->d_name.name, dentry->d_name.name,
	+	       nd->flags, nd->intent.open.flags, nd->intent.open.create_mode);
	+
		dfprintk(VFS, "NFS: lookup(%s/%s)\n",
			dentry->d_parent->d_name.name, dentry->d_name.name);
		nfs_inc_stats(dir, NFSIOS_VFSLOOKUP);
	@@ -904,8 +908,10 @@ static struct dentry *nfs_lookup(struct 
		lock_kernel();

		/* If we're doing an exclusive create, optimize away the lookup */
	-	if (nfs_is_exclusive_create(dir, nd))
	+	if (nfs_is_exclusive_create(dir, nd)) {
	+		printk("exlusive_create\n");
			goto no_entry;
	+	}

		error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
		if (error == -ENOENT)
	@@ -933,6 +939,7 @@ no_entry:
	 out_unlock:
		unlock_kernel();
	 out:
	+	printk("<--nfs_lookup() = %p\n", res);
		return res;
	 }

And saw the following appear in the kernel log around the problem bit for
trash:/usr:

| ...
| SELinux: initialized (dev 0:18, type nfs), uses genfs_contexts
| audit(1155729189.533:468): avc:  denied  { read } for  pid=6472 comm="automount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
| audit(1155729189.557:469): avc:  denied  { name_bind } for  pid=6472 comm="automount" src=716 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:reserved_port_t:s0 tclass=udp_socket

Not sure what's going on here.  The automounter tried to do bind a socket to a
reserved port perhaps and was denied.

| NFS: nfs_update_inode(0:18/2 ct=1 info=0x6)
| NFS: permission(0:18/2), mask=0x1, res=0

sys_mkdirat() calls do_path_lookup(), which checks MAY_EXEC on the dir.

| NFS: permission(0:18/2), mask=0x1, res=0

lookup_create() is called.  This calls __lookup_hash(), which checks MAY_EXEC
on the dir.

| -->nfs_lookup(,usr,{200,80,44e3069a})

__lookup_hash() then looks up the new dentry with intent to create:

	VARIABLE			VALUE
	===============================	===============================
	nd->flags			LOOKUP_CREATE
	nd->intent.open.flags		O_EXCL
	nd->intent.open.create_mode	weird value, even in octal

This means that nfs_lookup() considers this to be "an exclusive create" of
this node, and dispenses with the LOOKUP RPC call to the server.

| NFS: lookup(/usr)
| exlusive_create

Just to confirm that the lookup is skipped.

| <--nfs_lookup() = 00000000

We return the dentry we were given, but don't return an error.  The dentry we
were given is left negative (on the assumption it's about to be created), but
does get attached to the directory.

| NFS: permission(0:18/2), mask=0x3, res=0

vfs_mkdir() calls may_create() which checks that the directory has MAY_WRITE
and MAY_EXEC permissions.  This firstly calls nfs_permission, which grants
permission.

| audit(1155729189.605:470): avc:  denied  { write } for  pid=6472 comm="automount" name="" dev=0:18 ino=2 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:nfs_t:s0 tclass=dir

And secondly calls security_inode_permission() though which SELinux which
_denies_ permission.

| NFS: dentry_delete(/usr, 0)

vfs_mkdir() returns -ENOACCES to sys_mkdirat() which releases its hold on the
dentry, but leaves the negative dentry attached to the directory.


The negative dentry wouldn't normally be a problem, even though it's attached
to its parent directory... except for the small matter that it's subsequently
listed in a directory read operation.

However, the dcache still retains the negative dentry.  I'm not sure how to
deal with this.  I think nfs_lookup() _must_ contact the server and prefill
the dentry if it can.  Trond?

David
