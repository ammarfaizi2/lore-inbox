Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbTHDHY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 03:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271411AbTHDHY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 03:24:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:17311 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271407AbTHDHYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 03:24:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: Steven Micallef <steven.micallef@world.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: chroot() breaks syslog() ?
Date: Mon, 4 Aug 2003 09:23:47 +0200
User-Agent: KMail/1.4.3
References: <6416776FCC55D511BC4E0090274EFEF5080024A9@exchange.world.net>
In-Reply-To: <6416776FCC55D511BC4E0090274EFEF5080024A9@exchange.world.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308040923.51241.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 04 August 2003 07:27, Steven Micallef wrote:
> Hi all,
>
> I've stumbled onto what seems to have broken somewhere between 2.4.8 and
> 2.4.18 (sorry, I've been unable to test it on a later version just yet).
> Basically, when using chroot(), syslog() calls don't work.
>
> The following simple example is broken on 2.4.18:
>
> #include    <stdio.h>
> #include    <sys/syslog.h>
>
> int main(void) {
>     chroot("/home/steve");
>     syslog(LOG_ALERT, "TEST");
> }

consider syslogd's -a option. Or simply call openlog(3) with LOG_NDELAY before 
chroot(). Or place the first call to syslog() before chroot(). Syscall() does 
not close the socket between calls.

int main(void) {
  openlog( "klaus", LOG_NDELAY, LOG_NEWS);
  chroot("/tmp");
  printf( "before\n" ); fflush( stdout );
  syslog(LOG_ALERT, "TEST1");
  printf( "between\n" ); fflush( stdout );
  syslog(LOG_ALERT, "TEST2");
}

strace give the following output:

...

socket(PF_UNIX, SOCK_DGRAM, 0)          = 3
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
connect(3, {sin_family=AF_UNIX, path="/dev/log"}, 16) = 0
chroot("/tmp")                          = 0

...

write(1, "before\n", 7before
)                 = 7

...

send(3, "<57>Aug  4 07:17:09 klaus: TEST1", 32, 0) = 32
rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 8) = 0
write(1, "between\n", 8between
)                = 8

...

send(3, "<57>Aug  4 07:17:09 klaus: TEST2", 32, 0) = 32
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/LgoGwicyCTir8T4RAqbzAJ9SPwFSnLyinG0C+ya/uTJRR4vwGQCeLxiV
ilmX6A7oJjou6ympLhFsDC4=
=mfSg
-----END PGP SIGNATURE-----
