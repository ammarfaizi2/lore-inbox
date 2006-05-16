Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWEPFrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWEPFrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWEPFrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:47:13 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:60679 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751460AbWEPFrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:47:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fradkt3S/MSNtU6nqJTHQ5LQWHoRHxu/4UIzRaeGvU/RIFVIGgBbgqrRgkSwsOpU4L/xfJV+gB1BbFMO4rwa9zWWPdFXzcEfycFASMjoWeBLwQuiOyDEj1qlMpyRO2GhI3BwdnlyRONh6OR3is66OpJqKCqXEYqsWd1B6IG0ftc=
Message-ID: <4469675E.7050803@gmail.com>
Date: Mon, 15 May 2006 23:47:10 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
CC: Linux kernel <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com>
In-Reply-To: <44692CA1.5000903@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
>
> Im getting nfsroot build error on 2 configs, both carried forward
> from good rc4 and from rc3-mm1 builds.
> turning off nfsroot fixes the err.
>
> A little digging suggests the problem is in here:
>
> git-klibc.patch:

I backed out these:

[jimc@harpo lxbuild]$ diff broken-out/series broken-out/nfsroot-fix-series
229,231c229,231
< git-klibc.patch
< git-klibc-alpha-fixes.patch
< git-klibc-ident-fix.patch
---
 > # git-klibc.patch
 > # git-klibc-alpha-fixes.patch
 > # git-klibc-ident-fix.patch

with this it compiled cleanly, but broke on boot

[   23.133338] eth0: Setting full-duplex based on negotiated link 
capability.
[   23.151837] IP-Config: Complete:
[   23.155028]       device=eth0, addr=192.168.42.100, 
mask=255.255.255.0, gw=192.168.42.1,
[   23.163329]      host=soekris, domain=, nis-domain=(none),
[   23.168943]      bootserver=192.168.42.1, rootserver=192.168.42.1, 
rootpath=
[   23.181928] Looking up port of RPC 100003/2 on 192.168.42.1
[   23.193280] Looking up port of RPC 100005/1 on 192.168.42.1
[   23.295101] TSC appears to be running slowly. Marking it as unstable
[   20.564000] Time: pit clocksource has been installed.
[   42.836000] portmap: server localhost not responding, timed out
[   42.840000] RPC: failed to contact portmap (errno -5).
[   77.852000] portmap: server localhost not responding, timed out
[   77.856000] RPC: failed to contact portmap (errno -5).
[  112.864000] portmap: server localhost not responding, timed out
[  112.868000] RPC: failed to contact portmap (errno -5).
[  112.876000] BUG: unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[  112.884000]  printing eip:
[  112.888000] c01d4523
[  112.888000] *pde = 00000000
[  112.892000] Oops: 0000 [#1]
[  112.892000] last sysfs file:
[  112.892000] Modules linked in:
[  112.892000] CPU:    0
[  112.892000] EIP:    0060:[<c01d4523>]    Not tainted VLI
[  112.892000] EFLAGS: 00010286   (2.6.17-rc4-mm1-sk #1)
[  112.892000] EIP is at _atomic_dec_and_lock+0xf/0x44
[  112.892000] eax: c02fc508   ebx: 00000000   ecx: 00000000   edx: 000000c0
[  112.892000] esi: fffffff4   edi: fffffff4   ebp: c113bcec   esp: c113bce8
[  112.892000] ds: 007b   es: 007b   ss: 0068
[  112.892000] Process idle (pid: 1, threadinfo=c113a000 task=c11395b0)
[  112.892000] Stack: <0>00000000 c113bd00 c0199545 00000000 c02fc508 
c12c2c14 c113bd10 c0199a21
[  112.892000]        00000000 c113bd66 c113bd40 c019a56a c12c2c14 
c12c2c14 c112b4d0 c113bd44
[  112.892000]        c015bfa0 00000004 00000001 c113bd66 00000060 
c113bde8 c113bdf4 c01a0162
[  112.892000] Call Trace:
[  112.892000]  <c0102fe2> show_stack_log_lvl+0x8b/0x95   <c010315f> 
show_registers+0x124/0x18a
[  112.892000]  <c0103420> die+0x14d/0x20f   <c010c76d> 
do_page_fault+0x438/0x52e
[  112.892000]  <c0102b7f> error_code+0x4f/0x60   <c0199545> 
nfs_put_client+0x2a/0x9f
[  112.892000]  <c0199a21> nfs_free_server+0xae/0xd4   <c019a56a> 
nfs_create_server+0x46e/0x47d
[  112.892000]  <c01a0162> nfs_get_sb+0x458/0x475   <c014cb4d> 
vfs_kern_mount+0x34/0x95
[  112.892000]  <c014cbea> do_kern_mount+0x28/0x3c   <c015fef2> 
do_mount+0x5d7/0x621
[  112.892000]  <c015ffa8> sys_mount+0x6c/0xa6   <c036a6be> 
do_mount_root+0x13/0x8c
[  112.892000]  <c036a92e> mount_root+0x6d/0xd9   <c036aa1c> 
prepare_namespace+0x82/0xae
[  112.892000]  <c01003d9> init+0x13a/0x1ed   <c0101005> 
kernel_thread_helper+0x5/0xb
[  112.892000] Code: d1 0a c1 e2 0a 8d 43 01 0f a4 d1 0a c1 e2 0a 89 06 
8d 65 f8 89 d0 89 ca 5b 5e 5d c3 55 89 e5 53 8b 5d 08 8b 45 0c e8 8f dd 
0c 00 <8b> 03 85 c0 75 10 68 d4 56 2b c0 e8 7d d8 f3 ff e8 e9 ea f2 ff
[  112.892000] EIP: [<c01d4523>] _atomic_dec_and_lock+0xf/0x44 SS:ESP 
0068:c113bce8
[  112.892000]  <0>Kernel panic - not syncing: Attempted to kill init!
[  112.900000]  <0>Rebooting in 5 seconds..

POST: 0123456789bcefghipajklnopq,,,tvwxy

If theres more I should try, send, etc, please let me know.

thanks
Jim Cromie
