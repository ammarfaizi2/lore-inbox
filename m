Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272056AbSISRju>; Thu, 19 Sep 2002 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272108AbSISRju>; Thu, 19 Sep 2002 13:39:50 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:60343 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S272056AbSISRjs>;
	Thu, 19 Sep 2002 13:39:48 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Thu, 19 Sep 2002 19:44:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Cc: dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <24181C771D3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 02 at 13:22, Richard B. Johnson wrote:

> > >>A short snippet of sys_poll, with irrelavant data removed.
> > >>
> > >>sys_poll(struct pollfd *ufds, .. , ..) {
> > >>    ...
> > >>    ufds++;
> > >>    ...
> 
> Well which one?  Here is an ioctl(). It certainly modifies one
> of its parameter values.

poll(), as was already noted. Program below should
print same value for B= and F=, but it reports f + 8*c instead
(where c = number of filedescriptors passed to poll).

And you must call it from assembly, as your calls to getpid() or
ioctl() (or poll()) are wrapped in libc - and glibc's code begins with
push %ebx because of %ebx is used by -fPIC code.

It is questinable whether we should try to not modify parameters
passed into functions. It is definitely nice behavior, but I think
that we should only guarantee that syscalls do not modify unused
registers.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
 
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/poll.h>

struct pollfd f[5];

int main(int argc, char* argv[]) {
    unsigned int i;
    void * reg;

    for (i = 0; i < 5; i++) {
        f[i].fd = 0;
        f[i].events = POLLIN;
    }
    __asm__ __volatile__("int $0x80\n" : "=b"(reg) : "a"(168), "0"(f), "c"(5), "d"(1));
    printf("B=%p F=%p\n", reg, f);
    return 0;
}
