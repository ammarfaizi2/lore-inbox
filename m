Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVCAWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVCAWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVCAWcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:32:35 -0500
Received: from smtp05.web.de ([217.72.192.209]:4787 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S262108AbVCAWbW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:31:22 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: x86_64: 32bit emulation problems
Date: Tue, 1 Mar 2005 23:30:41 +0100
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <200503012207.02915.bernd-schubert@web.de> <20050301214832.GA44624@muc.de>
In-Reply-To: <20050301214832.GA44624@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503012330.42154.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> strace didn't say so, and normally it doesn't lie about things like this.

Well, I show you the updated source code and strace output and if you still 
don't believe me, ask me for a login to our system ;)


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
        struct stat *buf;
        int err;

        dir = argv[1];

        buf = malloc(sizeof(struct stat));

        errno = 0;

        err = stat(dir, buf);
        if ( err ) {
                fprintf(stderr, "err = %i\n", err);
                fprintf(stderr, "stat for %s failed \n", dir);
                fprintf(stderr, "ernno: %i (%s)\n", errno, strerror(errno));
        } else
                fprintf(stderr, "stat() works fine.\n");

        return (0);
}


>
> > > bernd@hitchcock tests>./test_stat32 /mnt/test/yp
> > > stat for /mnt/test/yp failed
> > > ernno: 75 (Value too large for defined data type)
>
> errno is undefined unless a system call returned -1 before or
> you set it to 0 before.

See above.

>
> > > But why does stat64() on a 64-bit kernel tries to fill in larger data
> > > than
>
> A 64bit kernel has no stat64(). All stats are 64bit.

bernd@hitchcock tests>strace32 ./test_stat32 /mnt/test/yp
execve("./test_stat32", ["./test_stat32", "/mnt/test/yp"], [/* 43 vars */]) = 
0
uname({sys="Linux", node="hitchcock", ...}) = 0
brk(0)                                  = 0x80ad000
brk(0x80ce000)                          = 0x80ce000
stat64("/mnt/test/yp", {st_mode=S_IFDIR|0755, st_size=2704, ...}) = 0
write(2, "err = -1\n", 9err = -1
)               = 9
write(2, "stat for /mnt/test/yp failed \n", 30stat for /mnt/test/yp failed
) = 30
write(2, "ernno: 75 (Value too large for d"..., 50ernno: 75 (Value too large 
for defined data type)
) = 50
exit_group(0)                           = ?

You certainly know much better than me, but I think strace shows that its 
calling stat64.

>
> > > on a 32-bit kernel and larger data also only for nfs-mount points? Hmm,
> > > I will tomorrow compare the tcp-packges sent by the server.
> >
> > So I still think thats a kernel bug.
>
> Your data so far doesn't support this assertion.

I have to admit that knfsd-mount moints are not affected, but on the other 
hand, I really cant't see anything in the ethereal captures. If someone 
should be interested, I have uploaded them:

http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/nfs-stat/


Cheers,
 Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
