Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTKBHtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTKBHtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:49:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:11398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261552AbTKBHtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:49:43 -0500
Date: Sat, 1 Nov 2003 23:52:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/[0-9]*/maps where did the (deleted) status go?
Message-Id: <20031101235203.1721da10.akpm@osdl.org>
In-Reply-To: <3FA47EAF.3070802@hundstad.net>
References: <3FA47EAF.3070802@hundstad.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey E. Hundstad" <jeffrey@hundstad.net> wrote:
>
> Hello,
> 
> In the 2.4.x kernels the /proc/[process id]/maps file contains that 
> processes current mappings.  This is also true with 2.6.0-test9 but I've 
> noticed a difference.  It is a feature I'll miss.  In the 2.4 kernels 
> when a file is mapped but no longer exists (because it has been removed) 
> the mapping line would contain the text "(deleted)" after it.
> 
> I've used this feature after I've updated libraries on my system.  I ran 
> a little scriptlet (see below).  It'd tell me which processes were 
> running with the old copy of the library.  This way I restart those 
> processes.
> 
> Is this a feature that can be restored, or perhaps there's a better way 
> to do it.  Let me know?

I see no difference between 2.4 and 2.6:


vmm:/home/akpm> uname -r
2.6.0-test9-mm2
vmm:/home/akpm> cat t.c
#include <sys/mman.h>
#include <fcntl.h>
#include <stdlib.h>

int main()
{
        int fd;
        char buf[4096];
        void *p;

        fd = open("foo", O_RDWR|O_CREAT, 0666);
        write(fd, buf, 4096);
        p = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
        if (p == MAP_FAILED)
                perror("mmap");
        else
                sleep(1000);
}

vmm:/home/akpm> ./a.out&
[1] 1397
vmm:/home/akpm> cat /proc/$(pidof a.out)/maps
08048000-08049000 r-xp 00000000 03:02 1425796    /home/akpm/a.out
08049000-0804a000 rw-p 00000000 03:02 1425796    /home/akpm/a.out
40000000-40015000 r-xp 00000000 03:02 1406303    /lib/ld-2.3.2.so
40015000-40016000 rw-p 00014000 03:02 1406303    /lib/ld-2.3.2.so
40016000-40017000 rw-p 00000000 00:00 0 
40017000-40018000 rw-p 00000000 03:02 1425798    /home/akpm/foo
42000000-4212e000 r-xp 00000000 03:02 523311     /lib/tls/libc-2.3.2.so
4212e000-42131000 rw-p 0012e000 03:02 523311     /lib/tls/libc-2.3.2.so
42131000-42133000 rw-p 00000000 00:00 0 
bfffc000-c0000000 rwxp ffffd000 00:00 0 
vmm:/home/akpm> rm foo
vmm:/home/akpm> cat /proc/$(pidof a.out)/maps
08048000-08049000 r-xp 00000000 03:02 1425796    /home/akpm/a.out
08049000-0804a000 rw-p 00000000 03:02 1425796    /home/akpm/a.out
40000000-40015000 r-xp 00000000 03:02 1406303    /lib/ld-2.3.2.so
40015000-40016000 rw-p 00014000 03:02 1406303    /lib/ld-2.3.2.so
40016000-40017000 rw-p 00000000 00:00 0 
40017000-40018000 rw-p 00000000 03:02 1425798    /home/akpm/foo\040(deleted)
42000000-4212e000 r-xp 00000000 03:02 523311     /lib/tls/libc-2.3.2.so
4212e000-42131000 rw-p 0012e000 03:02 523311     /lib/tls/libc-2.3.2.so
42131000-42133000 rw-p 00000000 00:00 0 
bfffc000-c0000000 rwxp ffffd000 00:00 0 
