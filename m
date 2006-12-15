Return-Path: <linux-kernel-owner+w=401wt.eu-S965075AbWLOEbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWLOEbA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 23:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWLOEa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 23:30:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58917 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965075AbWLOEa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 23:30:58 -0500
Date: Thu, 14 Dec 2006 20:30:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 007 of 14] knfsd: SUNRPC: Provide room in svc_rqst for
 larger addresses
Message-Id: <20061214203044.915cedfc.akpm@osdl.org>
In-Reply-To: <1061212235911.21440@suse.de>
References: <20061213105528.21128.patches@notabene>
	<1061212235911.21440@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 10:59:11 +1100
NeilBrown <neilb@suse.de> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> Expand the rq_addr field to allow it to contain larger addresses.

This patch breaks the NFS server on my heroically modern RH FC1 machine.

There's a mysterious 30-second pause when initscripts are bringing up
mountd.

showmount (from a FC5 client) works:

box:/usr/src/25> 0 showmount -e vmm
Export list for vmm:
/         *
/mnt/hda5 *

But things get really exciting when we try to mount it:


box:/usr/src/25> 0 mount vmm:/mnt/hda5 /mnt         
*** buffer overflow detected ***: mount terminated
======= Backtrace: =========
/lib64/libc.so.6(__chk_fail+0x2f)[0x32adbdfaef]
mount[0x40bcf8]
mount[0x4044c5]
mount[0x405850]
mount[0x406388]
/lib64/libc.so.6(__libc_start_main+0xf4)[0x32adb1ce54]
mount[0x4034a9]
======= Memory map: ========
00400000-00414000 r-xp 00000000 08:01 3041513                            /bin/mount
00513000-00514000 rw-p 00013000 08:01 3041513                            /bin/mount
00514000-00516000 rw-p 00514000 00:00 0 
00613000-00615000 rw-p 00013000 08:01 3041513                            /bin/mount
00615000-00636000 rw-p 00615000 00:00 0                                  [heap]
32ad900000-32ad91a000 r-xp 00000000 08:01 1619031                        /lib64/ld-2.4.so
32ada19000-32ada1a000 r--p 00019000 08:01 1619031                        /lib64/ld-2.4.so
32ada1a000-32ada1b000 rw-p 0001a000 08:01 1619031                        /lib64/ld-2.4.so
32adb00000-32adc3f000 r-xp 00000000 08:01 1619091                        /lib64/libc-2.4.so
32adc3f000-32add3f000 ---p 0013f000 08:01 1619091                        /lib64/libc-2.4.so
32add3f000-32add43000 r--p 0013f000 08:01 1619091                        /lib64/libc-2.4.so
32add43000-32add44000 rw-p 00143000 08:01 1619091                        /lib64/libc-2.4.so
32add44000-32add49000 rw-p 32add44000 00:00 0 
32ade00000-32ade02000 r-xp 00000000 08:01 1619011                        /lib64/libuuid.so.1.2
32ade02000-32adf02000 ---p 00002000 08:01 1619011                        /lib64/libuuid.so.1.2
32adf02000-32adf03000 rw-p 00002000 08:01 1619011                        /lib64/libuuid.so.1.2
32ae000000-32ae002000 r-xp 00000000 08:01 1619095                        /lib64/libdl-2.4.so
32ae002000-32ae102000 ---p 00002000 08:01 1619095                        /lib64/libdl-2.4.so
32ae102000-32ae103000 r--p 00002000 08:01 1619095                        /lib64/libdl-2.4.so
32ae103000-32ae104000 rw-p 00003000 08:01 1619095                        /lib64/libdl-2.4.so
32ae200000-32ae20e000 r-xp 00000000 08:01 1619005                        /lib64/libdevmapper.so.1.02
32ae20e000-32ae30e000 ---p 0000e000 08:01 1619005                        /lib64/libdevmapper.so.1.02
32ae30e000-32ae310000 rw-p 0000e000 08:01 1619005                        /lib64/libdevmapper.so.1.02
32ae400000-32ae408000 r-xp 00000000 08:01 1619066                        /lib64/libblkid.so.1.0
32ae408000-32ae508000 ---p 00008000 08:01 1619066                        /lib64/libblkid.so.1.0
32ae508000-32ae509000 rw-p 00008000 08:01 1619066                        /lib64/libblkid.so.1.0
32b0600000-32b060d000 r-xp 00000000 08:01 1619093                        /lib64/libgcc_s-4.1.1-20060525.so.1
32b060d000-32b070d000 ---p 0000d000 08:01 1619093                        /lib64/libgcc_s-4.1.1-20060525.so.1
32b070d000-32b070e000 rw-p 0000d000 08:01 1619093                        /lib64/libgcc_s-4.1.1-20060525.so.1
32b2800000-32b2814000 r-xp 00000000 08:01 1619102                        /lib64/libselinux.so.1
32b2814000-32b2913000 ---p 00014000 08:01 1619102                        /lib64/libselinux.so.1
32b2913000-32b2915000 rw-p 00013000 08:01 1619102                        /lib64/libselinux.so.1
32b2915000-32b2916000 rw-p 32b2915000 00:00 0 
32b2a00000-32b2a38000 r-xp 00000000 08:01 1619101                        /lib64/libsepol.so.1
32b2a38000-32b2b37000 ---p 00038000 08:01 1619101                        /lib64/libsepol.so.1
32b2b37000-32b2b38000 rw-p 00037000 08:01 1619101                        /lib64/libsepol.so.1
32b2b38000-32b2b42000 rw-p 32b2b38000 00:00 0 
2b9eea00c000-2b9eea00d000 rw-p 2b9eea00c000 00:00 0 
2b9eea032000-2b9eea036000 rw-p 2b9eea032000 00:00 0 
2b9eea036000-2b9eea039000 r-xp 00000000 08:01 1618858                    /lib64/libsetrans.so.0
2b9eea039000-2b9eea138000 ---p 00003000 08:01 1618858                    /lib64/libsetrans.so.0
2b9eea138000-2b9eea139000 rw-p 00002000 08:01 1618858                    /lib64/libsetrans.so.0
2b9eea139000-2b9eea143000 r-xp 00000000 08:01 1619053                    /lib64/libnss_files-2.4.so
2b9eea143000-2b9eea242000 ---p 0000a000 08:01 1619053                    /lib64/libnss_files-2.4.so
2b9eea242000-2b9eea243000 r--p 00009000 08:01 1619053                    /lib64/libnss_files-2.4.so
2b9eea243000-2b9eea244000 rw-p 0000a000 08:01 1619053                    /lib64/libnss_files-2.4.so
7fffc0a88000-7fffc0a9e000 rw-p 7fffc0a88000 00:00 0                      [stack]
ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0                  [vdso]
zsh: abort      0 mount vmm:/mnt/hda5 /mnt


btw, knfsd-sunrpc-cache-remote-peers-address-in-svc_sock.patch breaks the build:

net/sunrpc/svcsock.c: In function 'svc_recvfrom':
net/sunrpc/svcsock.c:581: error: 'svsk' undeclared (first use in this function)
net/sunrpc/svcsock.c:581: error: (Each undeclared identifier is reported only once

but the next patch
(knfsd-sunrpc-dont-set-msg_name-and-msg_namelen-when-calling-sock_recvmsg.patch)
fixes that.


