Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUCJTgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCJTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:36:34 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:61128 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262799AbUCJTfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:35:42 -0500
Date: Wed, 10 Mar 2004 20:35:40 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [Program for testing] cow behaviour for hard links
Message-ID: <20040310193540.GC4589@wohnheim.fh-wedel.de>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040310193429.GB4589@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here is the userspace program to fiddle with the cowlink flag.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001

/**
 * cowlink - set, unset and query the cowlink flag to files
 *
 * Copyright (C) 2004 Jörn Engel <joern@wh.fh-wedel.de>
 *
 * This is *not* open source.  The rights granted to anyone by the
 * author are the rights to
 * - look at the code,
 * - make verbatim copies and distribute them,
 * - compile it,
 * - send patches to the author.
 *
 * Nothing else.  If you don't like the license, feel free to discuss it
 * over a beer.  You can send me beer and discuss via email, if you like. ;)
 *
 * Seriously, this program shouldn't exist at all.  It would make more sense
 * to merge it into chmod, at least in the authors opinion.  We'll see...
 *
 * Oh yeah, the compiled binary is free, there are no strings attached to
 * it whatsoever.
 */
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#define F_LINUX_SPECIFIC_BASE   1024
#define F_SETCOW        (F_LINUX_SPECIFIC_BASE+3)
#define F_GETCOW        (F_LINUX_SPECIFIC_BASE+4)
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static long mode = -1;
static long get = 0;
static int recursive = 0;

static void do_file(const char *name)
{
	int fd, ret;

	fd = open(name, O_RDONLY);
	if (fd < 0)
		return perror(name);

	switch (mode) {
	default:
		break;
	case 0: /* fall through */
	case 1:
		ret = fcntl(fd, F_SETCOW, mode);
		if (ret)
			return perror(name);
	}

	if (get) {
		ret = fcntl(fd, F_GETCOW);
		if (ret < 0)
			return perror(name);
		printf("%d	%s\n", ret, name);
	}

	close(fd);
}

static void do_dir(const char *name)
{
	do_file(name);

	DIR *dir = opendir(name);
	if (!dir) {
		switch (errno) {
		case ENOTDIR:
			return;
		default:
			return perror(name);
		}
	}

	if (!recursive)
		return;

	char *newname, *end;
	{
		size_t len = strlen(name);
		newname = malloc(len + 4096);
		strcpy(newname, name);
		newname[len] = '/';
		end = newname + len + 1;
	}

	for (struct dirent *de = readdir(dir); de; de = readdir(dir)) {
		strcpy(end, de->d_name);

		struct stat status;
		lstat(newname, &status);

		if (S_ISDIR(status.st_mode)) {
			if (!strcmp(de->d_name, "."))
				continue;
			if (!strcmp(de->d_name, ".."))
				continue;
			do_dir(newname);
		}
		if (S_ISREG(status.st_mode))
			do_file(newname);
	}
	free(newname);
	closedir(dir);
}

int main(int argc, char **argv)
{
	for (;;) {
		int oi = 1;
		char short_opts[] = "cgRrs";
		static const struct option long_opts[] = {
			{"clear",	0, 0, 'c'},
			{"get",		0, 0, 'g'},
			{"recursive",	0, 0, 'r'},
			{"set",		0, 0, 's'},
			{0, 0, 0, 0}
		};
		int c = getopt_long(argc, argv, short_opts, long_opts, &oi);
		if (c == -1)
			break;
		switch (c) {
		case 'c':
			mode = 0;
			break;
		case 'g':
			get = 1;
			break;
		case 'R': /* fall through */
		case 'r':
			recursive = 1;
			break;
		case 's':
			mode = 1;
			break;
		default:
			fprintf(stderr, "BUG\n");
			exit(EXIT_FAILURE);
		}
	}

	while (optind < argc)
		do_dir(argv[optind++]);

	return 0;
}
