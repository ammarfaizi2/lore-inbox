Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143539AbRAHMrz>; Mon, 8 Jan 2001 07:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143592AbRAHMrq>; Mon, 8 Jan 2001 07:47:46 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:32989 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S143539AbRAHMrf>; Mon, 8 Jan 2001 07:47:35 -0500
Message-ID: <3A59B83F.F39503E3@uow.edu.au>
Date: Mon, 08 Jan 2001 23:53:19 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: timw@splhi.com, Christian Loth <chris@gidayu.max.uni-duisburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
In-Reply-To: <3A598474.3A69C684@uow.edu.au> from "Andrew Morton" at Jan 08, 2001 08:12:20 PM <E14FauT-0004Nn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Obviously, something changed between 2.2.14 and more current
> > kernels which broke pump.  I don't believe it's a driver change
> > because it also affects the 3c90x driver.  I don't have a theory
> > as to why this affects the 3com NICs though.  But I'm assuming
> > that whatever broke pump also broke dhcpcd.
> 
> The classic thing that pump catches drivers with is that interface goes
> up/down/up in rapid succession. That broke the acenic driver at one point
> too

That's interesting.

The open() and probe() logic in the 2.2.18 driver is basically unchanged
since 2.2.14.  And 3com's driver breaks with pump too.  AFAIK it's
completely unchanged.

This makes one wonder what a successful return from open() actually
_means_.  Autonegotiation takes up to three seconds, and we return from open()
with it still in progress.  So the interface is not yet usable. 

> > I note that with 3c59x in 2.4.0, pump-0.7.3 basically freezes up.
> > It spits out a single bootp packet then goes to lunch.  I got
> > bored waiting after ten minutes. So an upgrade is definitely needed.
> 
> strace would be interesting

It's very sick.  It forks a daemon.  The child process gets to
the stage where it has written out your new /etc/resolv.conf
and then it gets stuck making no system calls, chewing 100%
of CPU.

Yes, it ups and downs the interface a couple of times,
but everything seems happy.  In fact, killing off the
bisbehaving pump leaves the interface in a working state,
so perhaps I have not in fact reproduced the problem.  Hopefully
Christian can retest with a later pump and let me know.

1801  read(6, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1748
1801  read(6, "", 4096)                 = 0
1801  close(6)                          = 0
1801  munmap(0x40014000, 4096)          = 0
1801  open("/etc/ld.so.cache", O_RDONLY) = 6
1801  fstat(6, {st_mode=S_IFREG|0644, st_size=24405, ...}) = 0
1801  mmap(NULL, 24405, PROT_READ, MAP_PRIVATE, 6, 0) = 0x40014000
1801  close(6)                          = 0
1801  open("/lib/libnss_files.so.2", O_RDONLY) = 6
1801  fstat(6, {st_mode=S_IFREG|0755, st_size=292788, ...}) = 0
1801  read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\36"..., 4096) = 4096
1801  mmap(NULL, 37640, PROT_READ|PROT_EXEC, MAP_PRIVATE, 6, 0) = 0x40110000
1801  mprotect(0x40118000, 4872, PROT_NONE) = 0
1801  mmap(0x40118000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 6, 0x7000) = 0x40118000
1801  close(6)                          = 0
1801  munmap(0x40014000, 24405)         = 0
1801  socket(PF_UNIX, SOCK_STREAM, 0)   = 6
1801  connect(6, {sin_family=AF_UNIX, path="
               /var/run/.nscd_socket"}, 110) = -1 ENOENT (No such file or directory)
1801  close(6)                          = 0
1801  open("/etc/host.conf", O_RDONLY)  = 6
1801  fstat(6, {st_mode=S_IFREG|0644, st_size=26, ...}) = 0
1801  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
1801  read(6, "order hosts,bind\nmulti on\n", 4096) = 26
1801  read(6, "", 4096)                 = 0
1801  close(6)                          = 0
1801  munmap(0x40014000, 4096)          = 0
1801  open("/etc/hosts", O_RDONLY)      = 6
1801  fcntl(6, F_GETFD)                 = 0
1801  fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
1801  fstat(6, {st_mode=S_IFREG|0644, st_size=314, ...}) = 0
1801  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
1801  read(6, "10.0.0.15\t\tmnm.uow.edu.au mnm\n10"..., 4096) = 314
1801  read(6, "", 4096)                 = 0
1801  close(6)                          = 0
1801  munmap(0x40014000, 4096)          = 0
1801  open("/etc/resolv.conf", O_RDONLY) = 6
1801  fstat(6, {st_mode=S_IFREG|0644, st_size=40, ...}) = 0
1801  read(6, "nameserver 61.8.0.5\nnameserver 6"..., 40) = 40
1801  close(6)                          = 0

*** End of output.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
