Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVB1UzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVB1UzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVB1UzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:55:06 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:40892 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261736AbVB1Uy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:54:29 -0500
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Subject: x86_64: 32bit emulation problems
Date: Mon, 28 Feb 2005 21:54:03 +0100
User-Agent: KMail/1.6.2
Cc: nfs@lists.sourceforge.net, bernd-schubert@gmx.de
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm just looking into a very strange problem. Some of our systems have 
athlon64 CPUs. Due to our diskless nfs environment we currently still prefer 
a 32bit userspace environment, but would like to be able to use a 64-bit 
chroot environment.

Well, currently there seems to be a stat64()  NFS problem when a x86_64 kernel 
is booted and stat64() comes from a 32bit libc.

Here's just an example:

hitchcock:/home/bernd/src/tests# ./test_stat64 /mnt/test/yp
stat() works fine.


hitchcock:/home/bernd/src/tests# ./test_stat32 /mnt/test/yp
stat for /mnt/test/yp failed 


The test program looks rather simple:

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>


int main(int argc, char **argv)
{
        char *dir;
        struct stat buf;

        dir = argv[1];

        if (stat (dir, &buf) == -1)
                fprintf(stderr, "stat for %s failed \n", dir);
        else
                fprintf(stderr, "stat() works fine.\n");
        return (0);
}


Here are the strace outputs:
=====================

32bit:
------
hitchcock:/home/bernd/src/tests# strace32 ./test_stat32 /mnt/test/yp
execve("./test_stat32", ["./test_stat32", "/mnt/test/yp"], [/* 39 vars */]) = 
0
uname({sys="Linux", node="hitchcock", ...}) = 0
brk(0)                                  = 0x80ad000
brk(0x80ce000)                          = 0x80ce000
stat64("/mnt/test/yp", {st_mode=S_IFDIR|0755, st_size=2704, ...}) = 0
write(2, "stat for /mnt/test/yp failed \n", 30stat for /mnt/test/yp failed 
) = 30
exit_group(0)                           = ?

64bit:
-------
hitchcock:/home/bernd/src/tests# strace ./test_stat64 /mnt/test/yp
execve("./test_stat64", ["./test_stat64", "/mnt/test/yp"], [/* 39 vars */]) = 
0
uname({sys="Linux", node="hitchcock", ...}) = 0
brk(0)                                  = 0x572000
brk(0x593000)                           = 0x593000
stat("/mnt/test/yp", {st_mode=S_IFDIR|0755, st_size=2704, ...}) = 0
write(2, "stat() works fine.\n", 19stat() works fine.
)    = 19
_exit(0)                                = ?



Anyone having an idea whats going on? The ethereal capture also looks pretty 
normal. The kernel of this system is 2.6.9, but it also happens on another 
system with 2.6.11-rc5.
As usual we are using unfs3 for /etc and /var, but for me that looks like a 
client problem. I'm even not sure if this is limited to NFS at all.


Thanks in advance,
 Bernd
