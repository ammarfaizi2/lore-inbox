Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSE0EZ6>; Mon, 27 May 2002 00:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSE0EZ6>; Mon, 27 May 2002 00:25:58 -0400
Received: from bitmover.com ([192.132.92.2]:4573 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314094AbSE0EZz>;
	Mon, 27 May 2002 00:25:55 -0400
Date: Sun, 26 May 2002 21:25:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] MAINTAINERS file addition: Al Viro
Message-ID: <20020526212556.K30610@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <E17CAjP-0005eK-00@wagner.rustcorp.com.au> <Pine.GSO.4.21.0205262353240.18603-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 12:11:09AM -0400, Alexander Viro wrote:
> 	Oh, for crying out loud...  Even mail(1) supports aliases - say
> echo alias bastard viro@math.psu.edu >> ~/.mailrc and enjoy.  If your
> MUA doesn't have aliases/address book/etc. - switch to something sane.

I got sick of everything not having this about 15 years ago.  If you 
compile this as cc -o Alias alias.c and then do stuff like

	alias	mutt='Alias mutt'

then it will do the lookup and tell you how it is rewriting the addresses
as you pop into the tool.  

static char *id = "@(#)alias.c 1.2 - main, strsav; mcvoy@rsch.wisc.edu";

/* Alias - provide front end for whatever that loads aliases.
 * Look in ~/.fingerc for aliases.  You could link this to .mailrc.
 *
 * An alias is the regular expression:
 *
 *       ^alias[ <tab>]+name[ <tab>]+full_name
 *
 * and "finger name" gets translated to finger fullname.  Exception: any
 * fullname that contains a "!" is ignored (can't do uucp, only internet).
 *
 * Options: -I ignores the dotfiles; a good way to finger a local john instead
 * of the aliased john.
 *
 * Revisions:
 *  1/May/87: Add support for general machine aliasing as well as people
 * 	aliasing.  A machine alias for seismo is
 *
 *	alias	seismo	@siesmo.css.gov
 *
 * 	and finger foo@seismo will rewrite to foo@seismo.css.gov
 *
 *  5/May/87:  Make this a general interface to any program.  Usage is:
 *	Alias program args
 *
 * and typical usage is
 *
 *	alias	mail	'Alias Mail \!*'
 */

#include      <stdio.h>
#include      <ctype.h>

char   *malloc();
char   *strcpy();
char   *strsav();
char   *index();
char   *PROG;
int     quiet;

main(ac, av, ev)
	char  **av;
	char  **ev;
{
	char    fingerc[255], buf[500], machine[100];
	register i;
	FILE   *f = (FILE *) - 1;

	sprintf(fingerc, "%s/.fingerc", getenv("HOME"));

	/* quiet or noisy? */
	if (!strcmp(av[1], "-Q")) {
		quiet++;
		for (i = 1; i < ac; i++)
			av[i] = av[i + 1];
		--ac;
	}
	/* grab new program name and shift argv down */
	PROG = av[1];
	av[0] = PROG;
	for (i = 1; i < ac; i++)
		av[i] = av[i + 1];
	--ac;

	if (!(f = fopen(fingerc, "r"))) {
		execvp(PROG, av);
		perror(PROG);
	}
	/* stupid alg: scan the file for each av, but there's usually only one. */
	for (i = 1; i < ac; i++) {
		register len = strlen(av[i]);
		register mlen = 0;

		/* optimization: ignore options */
		if (*av[i] == '-')
			continue;

		rewind(f);

		/* grab machine name, it might be an alias */
		if (index(av[i], '@')) {
			strcpy(machine, index(av[i], '@') + 1);
			mlen = strlen(machine);
		} else
			machine[0] = 0;

		while (fgets(buf, sizeof(buf), f)) {
			register char *s;
			register char *t;

			/* chop newline */
			buf[strlen(buf) - 1] = 0;

			/* only aliases, please (sorry alice) */
			if (strncmp(buf, "alias", 5))
				continue;
			for (s = buf + 5; *s && isspace(*s); s++);

			/* match user alias? */
			if (!strncmp(s, av[i], len) && isspace(*(s + len))) {
				s += len;
				for (; *s && isspace(*s); s++);
				/* is it really a user or is it a machine? */
				if (*s == '@')
					s++;
				for (t = s; *t && !isspace(*t); t++);
				if (!index(s, '!')) {
					if (!quiet)
						fprintf(stderr, "%s --> %s\n", av[i], s);
					av[i] = strsav(s);
					break;	/* while, get next i */
				}
			}
			/* match system alias? */
			if (mlen && !strncmp(machine, s, mlen)) {
				char    buf2[200];
				register char *save;

				/* get to @full.name.part */
				s += mlen;
				for (; *s && isspace(*s); s++);
				if (*s++ != '@')
					continue;
				for (t = s; *t && !isspace(*t); t++);
				*t = NULL;

				*(index(av[i], '@') + 1) = NULL;
				sprintf(buf2, "%s%s", av[i], s);
				if (!quiet)
					fprintf(stderr, "%s%s --> %s\n", av[i], machine, buf2);
				av[i] = strsav(buf2);
				break;	/* while, get next i */
			}
		}
	}
	execvp(PROG, av);
	perror(PROG);
}

char   *
strsav(s)
	register char *s;
{
	register char *t = malloc(strlen(s) + 1);

	return strcpy(t, s);
}
