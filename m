Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbUJ1ViE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUJ1ViE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUJ1VgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:36:14 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:44556 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262885AbUJ1VUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:20:18 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: How to safely reduce stack usage in nfs code?
Date: Fri, 29 Oct 2004 00:20:01 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got one stack overflow sometime ago.
Partially due to NFS stack usage.

2.6.9 uniprocessor i386 'make checkstack | grep nfs[34]*' results:

0xc01d012a nfs3_proc_create:                            544
0xc01d541a _nfs4_do_open:                               516
0xc01c3cbe nfs_readdir:                                 412
0xc01c53f3 nfs_symlink:                                 368
0xc01d4dc3 _nfs4_open_delegation_recall:                368
0xc01d05a2 nfs3_proc_rename:                            364
0xc01d4b69 _nfs4_open_reclaim:                          364
0xc01c4e54 nfs_mknod:                                   352
0xc01c4f34 nfs_mkdir:                                   352
0xc01cb57a nfs_proc_create:                             344
0xc01d06f9 nfs3_proc_link:                              328
0xc01c4217 nfs_lookup_revalidate:                       312
0xc01c4733 nfs_lookup:                                  292
0xc01d85f1 _nfs4_do_setlk:                              260
0xc01c6b65 nfs_statfs:                                  220
0xc01d082f nfs3_proc_symlink:                           216
0xc01d0b96 nfs3_proc_readdir:                           216
0xc01c62db nfs_sb_init:                                 212
0xc01cfa9b nfs3_proc_lookup:                            212
0xc01d0cfe nfs3_proc_mknod:                             208
0xc01cfc1a nfs3_proc_access:                            192
0xc01d0992 nfs3_proc_mkdir:                             192
0xc01cfda2 nfs3_proc_readlink:                          176
0xc01d0428 nfs3_proc_remove:                            176
0xc01d0aa7 nfs3_proc_rmdir:                             176
0xc01d82e3 _nfs4_proc_unlck:                            164
0xc05ad18a root_nfs_get_handle:                         160
0xc01c796b __nfs_revalidate_inode:                      152
0xc01d7c92 nfs4_proc_setclientid:                       152
0xc01c72e1 nfs_setattr:                                 148
0xc01d7f7c _nfs4_proc_getlk:                            148
0xc01d68d6 nfs4_proc_create:                            144
0xc01e21e0 nfs_idmap_id:                                116
0xc01e2409 nfs_idmap_name:                              112
0xc01c4b27 nfs_cached_lookup:                           108

Many of them are due to on-stack structures.

structs nfs_fh and nfs_fattr take together ~300 bytes
and are one of the most frequently used:

# cd fs/nfs; grep 'struct nfs_fh [a-z0-9_]*;' * ; grep 'struct nfs_fattr [a-z0-9_]*;' *
callback.h:     struct nfs_fh fh;
callback.h:     struct nfs_fh fh;
dir.c:  struct nfs_fh fhandle;
dir.c:  struct nfs_fh fhandle;
dir.c:  struct nfs_fh fhandle;
dir.c:  struct nfs_fh fhandle;
dir.c:  struct nfs_fh sym_fh;
nfsroot.c:      struct nfs_fh fh;
dir.c:  struct nfs_fattr fattr;
dir.c:  struct nfs_fattr fattr;
dir.c:  struct nfs_fattr fattr;
dir.c:  struct nfs_fattr fattr;
dir.c:  struct nfs_fattr fattr;
dir.c:  struct nfs_fattr sym_attr;
inode.c:        struct nfs_fattr fattr;
inode.c:        struct nfs_fattr fattr;
inode.c:        struct nfs_fattr fattr;
nfs3proc.c:             struct nfs_fattr res;
nfs4proc.c:                     struct nfs_fattr fattr;

I can convert these into kmalloc'ed variants but hesitate to do so
because of possible 'need to kmalloc in order to free memory for kmalloc'
deadlocks.

Any advice how to handle this without creating subtle bugs?
--
vda

