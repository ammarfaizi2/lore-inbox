Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWEPBgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWEPBgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWEPBgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:36:37 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:54627 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751003AbWEPBgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:36:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=spmsmfqolkKO71vcUMlzdjgvqRDZq8dVUBFSAbkiEt8eYR47CCiEQQAN6nXhZJsUz6GUok0sCMvAKajXT5qNeMJpncITgaGJZV3cnvZnkDaAO1aIxP6A2MyhlyOvH+nmuwN6MZAG86qomMRTE77aleI3IR7Y3uPsFWz8pJReaOg=
Message-ID: <44692CA1.5000903@gmail.com>
Date: Mon, 15 May 2006 19:36:33 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>
Subject: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Im getting nfsroot build error on 2 configs, both carried forward
from good rc4 and from rc3-mm1 builds.
turning off nfsroot fixes the err.

[jimc@harpo linux-2.6.17-rc4-mm1-sk]$ make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
fs/built-in.o(.init.text+0x15d4): In function `nfs_root_setup':
fs/nfs/nfsroot.c:399: undefined reference to `root_nfs_parse_addr'
fs/built-in.o(.init.text+0x15dc):fs/nfs/nfsroot.c:399: undefined 
reference to `root_server_addr'
fs/built-in.o(.init.text+0x16d6): In function `nfs_root_data':
fs/nfs/nfsroot.c:310: undefined reference to `root_server_path'
fs/built-in.o(.init.text+0x1733):fs/nfs/nfsroot.c:331: undefined 
reference to `root_server_addr'
make: *** [.tmp_vmlinux1] Error 1

A little digging suggests the problem is in here:

git-klibc.patch:13607:-u32 root_server_addr = INADDR_NONE;    /* Address 
of NFS server */
git-klibc.patch:13840:-    if (root_server_addr == INADDR_NONE)
git-klibc.patch:13841:-        root_server_addr = ic_servaddr;
git-klibc.patch:14682:- *  need to have root_server_addr set _before_ 
IPConfig gets called as it
git-klibc.patch:14752:-         && root_server_addr == INADDR_NONE
git-klibc.patch:14806:-    if (root_server_addr == INADDR_NONE)
git-klibc.patch:14807:-        root_server_addr = addr;
git-klibc.patch:14842:-    printk(", rootserver=%u.%u.%u.%u", 
NIPQUAD(root_server_addr));
git-klibc.patch:78496:+static u_int32_t root_server_addr;
git-klibc.patch:78882:+    s = getenv("root_server_addr");
git-klibc.patch:78884:+        root_server_addr = strtoul(s, NULL, 10);
git-klibc.patch:78900:+    if ((servaddr = root_server_addr) == 
INADDR_NONE) {


Im likely to try taking 'static' off of line 78496,
but that lands in: devel-akpm/usr/klibc/tests/nfs_no_rpc.c
so I suspect I dont know the proper fix.
or indeed, whether it isnt a bonehead error.


thanks in advance
Jim Cromie
