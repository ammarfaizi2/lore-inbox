Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTKXWVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTKXWVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:21:34 -0500
Received: from aneto.able.es ([212.97.163.22]:34218 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261384AbTKXWVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:21:31 -0500
Date: Mon, 24 Nov 2003 23:21:29 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Linux 2.4.23-rc4] NFS mounts on top of initrd
Message-ID: <20031124222129.GC1823@werewolf.able.es>
References: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet> (from marcelo.tosatti@cyclades.com on Mon, Nov 24, 2003 at 19:58:06 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.24, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes -rc4, fixing modular IDE breakage present in 2.4.23 kernels.
> 
> Hopefully this will become final.
> 

Hi. 

This is tested with rc3, but as nothing has changed wrt NFS ;)
Client and server are _plain_ rc3, no strange patches applied (no -jam, no
bproc...)

Plz tell me what am I doing wrong, or if it is a bug. I boot with an initrd that
mounts /lib via NFS.
Then just try this:

        fd = open("/lib/libnss_files-2.3.2.so", O_RDONLY);
        res = read(fd,buf,512);

It fails. strace is like this:

execve("./tst", ["./tst"], [/* 10 vars */]) = 0
uname({sys="Linux", node="node00.net0.cluster", ...}) = 0
brk(0)                                  = 0x8049658
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/lib/i686/sse/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/sse/mmx", 0xbffff580) = -1 ENOENT (No such file or directory)
open("/lib/i686/sse/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/sse", 0xbffff580)     = -1 ENOENT (No such file or directory)
open("/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/i686/mmx", 0xbffff580)     = -1 ENOENT (No such file or directory)
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20]\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1237568, ...}) = 0
old_mmap(NULL, 1242756, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40015000
old_mmap(0x4013f000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12a000) = 0x4013f000
old_mmap(0x40142000, 9860, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40142000
close(3)                                = 0
open("/lib/libnss_files-2.3.2.so", O_RDONLY) = -1 ESTALE (Stale NFS file handle)
read(-1, 0xbffffc40, 512)               = -1 EBADF (Bad file descriptor)

No program can read that. So anything that tries to mmap it breaks, like
anything that tries to get protocol info:
      proto = getprotobyname("tcp");

open("/etc/nsswitch.conf", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1744, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40145000
read(3, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1744
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40145000, 4096)                = 0
open("/lib/i686/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/sse/mmx/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/sse/mmx", 0xbffff4e0)      = -1 ENOENT (No such file or directory)
open("/lib/sse/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/sse", 0xbffff4e0)          = -1 ENOENT (No such file or directory)
open("/lib/mmx/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/mmx", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/libnss_files.so.2", O_RDONLY) = -1 ESTALE (Stale NFS file handle)

I can guess where the problem comes from (something that was suggested in
previous answers). I use an initrd built copying anything
I need before the NFS mounts, like ifup and so on. I have not messed with
syslinux or dietlibc, so some of the utils need libnss_files, and it is present
in the initrd. So I think the problem comes when I try to use a NFS file that
was also in the initrd, and is probably already mapped, because I used programs
that used it before the NFS mounts.

Should all this work ? Is my fault ? Is a bug ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc3-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
