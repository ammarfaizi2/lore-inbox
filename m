Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277983AbRJOCig>; Sun, 14 Oct 2001 22:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277985AbRJOCi1>; Sun, 14 Oct 2001 22:38:27 -0400
Received: from bitmover.com ([192.132.92.2]:6300 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S277983AbRJOCiL>;
	Sun, 14 Oct 2001 22:38:11 -0400
Date: Sun, 14 Oct 2001 19:38:44 -0700
From: Larry McVoy <lm@bitmover.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS file locking?
Message-ID: <20011014193844.C13153@work.bitmover.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200110141811.f9EIB4823631@work.bitmover.com> <15306.9552.673923.69404@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <15306.9552.673923.69404@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Mon, Oct 15, 2001 at 09:52:48AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Instead of creating a lock file, create a lock symlink.
>    Have the content of the symlink be something recognisably unique.
>    e.g. hostname.pid
>    If the "symlink" syscall succeeds, you have got the lock.
>    If it fails, issue a readlink and see if the content is what you
>    tried to create (RPC packet loss and retransmit could have caused
>    an incorrect failure return).  If it is, you have the lock.
>    If not, you don't.

OK, tried that too, here's the code.  Doesn't work.  Neither does the
link approach.  Am I doing something wrong?  It seems to me that I'm
completely at the mercy of the client NFS implementation - if it caches
stuff wrong, I'm hosed.  There has to be some cute trick to get past this.

--lm


int
sccs_lockfile(char *lockfile, int seconds)
{
	char	*s;
	char	buf[300];
	int	n, uslp = 1000, waited = 0;

	s = aprintf("%u %s", getpid(), sccs_gethost());
	for ( ;; ) {
		if (symlink(s, lockfile) == 0) return (0);
		n = readlink(lockfile, buf, sizeof(buf));
		if (n > 0) {
			buf[n] = 0;
			if (streq(s, buf)) return (0);
		}
		if (seconds && ((waited / 1000000) >= seconds)) {
			fprintf(stderr, "timed out waiting for %s\n", lockfile);
			free(s);
			return (-1);
		}
		usleep(uslp);
		waited += uslp;
		if (uslp < 20000) uslp <<= 1;
	}
	/* NOTREACHED */
}

/*
 * Usage: a.out iterations lockfile
 */
int
main(int ac, char **av)
{
	int	i, iter;
	int	me = getpid();

	unless (ac == 3) return (1);
	unless ((iter = atoi(av[1])) > 0) return (1);
	printf("%d starts\n", me);
	for (i = 1; i <= iter; ++i) {
		sccs_lockfile(av[2], 0);
		assert(mine(av[2]));
		unlink(av[2]);
		unless (i % 10) printf("%d locked %d times\n", me, i);
	}
	printf("%d done\n", me);
	return (0);
}

int
mine(char *file)
{
	char	buf[300];
	char	*s;
	int	n;

	n = readlink(file, buf, sizeof(buf));
	if (n > 0) {
		s = aprintf("%u %s", getpid(), sccs_gethost());
		buf[n] = 0;
		n = streq(s, buf);
		unless (n) fprintf(stderr, "%s != %s\n", s, buf);
		free(s);
		return (n);
	}
	return (0);
}

/*
 * This function works like sprintf(), except it return a
 * malloc'ed buffer which caller should free when done
 */
char *
aprintf(char *fmt, ...)
{
	va_list	ptr;
	int	rc, size = strlen(fmt) + 64;
	char	*buf = malloc(size);

	va_start(ptr, fmt);
	rc = vsnprintf(buf, size, fmt, ptr);
	va_end(ptr);
	/*
	 * On IRIX, it truncates and returns size-1.
	 * We can't assume that that is OK, even though that might be
	 * a perfect fit.  We always bump up the size and try again.
	 * This can rarely lead to an extra alloc that we didn't need,
	 * but that's tough.
	 */
	while ((rc < 0) || (rc >= (size-1))) {
		size *= 2;
		free(buf);
		buf = malloc(size);
		va_start(ptr, fmt);
		rc = vsnprintf(buf, size, fmt, ptr);
		va_end(ptr);
	}
	return (buf); /* caller should free */
}

char	*
sccs_gethost()
{
	static	char	host[256];

	if (gethostname(host, sizeof(host)) == -1) return "?";
	return (host);
}
