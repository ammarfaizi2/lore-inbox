Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287016AbRL1UzU>; Fri, 28 Dec 2001 15:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287021AbRL1UzK>; Fri, 28 Dec 2001 15:55:10 -0500
Received: from bitmover.com ([192.132.92.2]:43171 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S287016AbRL1Uy4>;
	Fri, 28 Dec 2001 15:54:56 -0500
Date: Fri, 28 Dec 2001 12:54:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
        Keith Owens <kaos@ocs.com.au>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228125451.E4077@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>, Keith Owens <kaos@ocs.com.au>,
	"Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227180148.A3727@work.bitmover.com> <E16JxmP-0000Yo-00@the-village.bc.nu> <20011228094318.B3727@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011228094318.B3727@work.bitmover.com>; from lm@bitmover.com on Fri, Dec 28, 2001 at 09:43:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More numbers.  I coded up a little program (included below) which
reads paths from stdin, lstats() them, and builds an MDBM of inode ->
pathname entries.  I ran that 10 times on the 2.4 kernel, which had 8679
files matching *.[chSs].  I did a little tuning of page size and inital
DB size (reduces page split costs) and got it down to 105 millisecs from
200, so we're at 12 usecs per item.  Then I removed the mdbm_store()
call so I was doing everything except that.  That took 7 usecs/item.

Write path summary: the mdbm_store() cost is about 5 usecs/item, which
is about right.  To build a DB of the same number of items as source
files in the kernel should cost less than 50 milliseconds for the DB
part of the work.  In other words, it's basically free.

OK, on to the read path.  I generated the list of inodes as an ascii file
and wrote another program to open the mdbm and fetch each one.  Ran that 
10 times, it cost 40 milliseconds to look up all the items, so that's
about 4 usecs/item including the read of the data from stdin.  That's 
slower than I think it should be and I may go look to see what is going
on, but it's plenty fast for the config/build system.

Here's the code.  Sorry about the perlisms, wait, no I'm not, I like those,
but it will make you look at it twice before it makes sense.

------------------------------------------------------------------------------

/*
 * inode.c - create an MDBM of inode -> path mappings
 */
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include "mdbm.h"
#define	unless(x)	if (!(x))
#define	fnext(buf, f)	fgets(buf, sizeof(buf), f)
#define	u32		unsigned int

void
chomp(char *s)
{
	unless (s && *s) return;
	while (*s && (*s != '\n')) s++;
	*s = 0;
}

u32
inode(char *path)
{
	struct	stat sb;

	if (lstat(path, &sb)) return (0);
	return ((u32)sb.st_ino);
}

int
main()
{
	char	buf[1024];
	MDBM	*m;
	datum	k, v;
	u32	ino;

	unlink("ino.mdbm");
	unless (m = mdbm_open("ino.mdbm", O_RDWR|O_CREAT, 0644, 4<<10)) {
		perror("ino.mdbm");
		exit(1);
	}
	mdbm_pre_split(m, 128);
	while (fnext(buf, stdin)) {
		chomp(buf);
		unless (ino = inode(buf)) {
			perror(buf);
			continue;
		}
		printf("%u\n", ino);
		k.dptr = (void*)&ino;
		k.dsize = sizeof(u32);
		v.dptr = buf;
		v.dsize = strlen(buf) + 1;
		if (mdbm_store(m, k, v, MDBM_INSERT)) {
			perror(buf);
			exit(1);
		}
	}
	mdbm_close(m);
	exit(0);
}

------------------------------------------------------------------------------

/*
 * read.c - read items from the mdbm
 */
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include "mdbm.h"
#define	unless(x)	if (!(x))
#define	fnext(buf, f)	fgets(buf, sizeof(buf), f)
#define	u32		unsigned int

int
main()
{
	char	buf[1024];
	MDBM	*m;
	datum	k, v;
	u32	ino;

	unless (m = mdbm_open("ino.mdbm", O_RDONLY, 0644, 0)) {
		perror("ino.mdbm");
		exit(1);
	}
	while (fnext(buf, stdin)) {
		ino = atoi(buf);
		continue;
		k.dptr = (void*)&ino;
		k.dsize = sizeof(u32);
		v = mdbm_fetch(m, k);
		unless (v.dsize) {
			perror(buf);
			exit(1);
		}
	}
	mdbm_close(m);
	exit(0);
}
