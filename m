Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUKRXRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUKRXRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUKRXRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:17:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35061 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262981AbUKRXON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:14:13 -0500
Date: Thu, 18 Nov 2004 15:14:06 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] a very tiny /sbin/hotplug
Message-ID: <20041118231406.GA11239@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

So, a number of people have complained over the past few years about the
fact that /sbin/hotplug was a shell script.  Funny enough, it's the
people on the huge boxes, with huge number of devices that are
complaining, not the embedded people with limited resources (ironic,
isn't it...)

Anyway, attached below is a replacement /sbin/hotplug written in c.
Compiling it with klibc gives you me the following size:
$ size hotplug 
   text    data     bss     dec     hex filename
   4149      28      20    4197    1065 hotplug
$ ls -l hotplug 
-rwxr-xr-x  1 greg users 4636 Nov 18 15:08 hotplug

Which is smaller than /bin/true on my boxes (and /bin/true is linked
dynamically, this is a static binary.  Linked dynamically, it's still
smaller than /bin/true.  gnu programs, go figure...)

I'll be putting this all togther in a "hotplug-ng" type tarball, as I
slowly replace the existing hotplug scripts with rewrites based on the
fact that we've learned things over the past 4 years, and dropping
support for 2.4 and previous kernels.  But for now, have fun with this
program.

Oh, and yeah, I know I need to fix up the fact that if /dev/null isn't
present, we should create it ourselves and go from there.  That's next
on the list after putting it all in a project.

thanks,

greg k-h

p.s. the list.h and logging.h files come from the udev project, if you
want to build this yourself.

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hot.c"

/*
 * hot.c - /etc/hotplug.d/ multiplexer
 * 
 * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
 * Copyright (C) 2004 Kay Sievers <kay@vrfy.org>
 *
 *	This program is free software; you can redistribute it and/or modify it
 *	under the terms of the GNU General Public License as published by the
 *	Free Software Foundation version 2 of the License.
 */

/*
 * This essentially emulates the following shell script logic in C:
 *
 *	DIR="/etc/hotplug.d"
 *
 *	for I in "${DIR}/$1/"*.hotplug "${DIR}/"default/ *.hotplug ; do
 *		if [ -f $I ]; then
 *			test -x $I && $I $1 ;
 *		fi
 *	done
 *	exit 1
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include <dirent.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>

#include "logging.h"
#include "list.h"

#define HOT_DIR		"/etc/hotplug.d"
#define HOT_SUFFIX	".hotplug"

#define strfieldcpy(to, from) \
do { \
	to[sizeof(to)-1] = '\0'; \
	strncpy(to, from, sizeof(to)-1); \
} while (0)

#ifdef LOG
unsigned char logname[LOGNAME_SIZE];
void log_message(int level, const char *format, ...)
{
	va_list args;

	va_start(args, format);
	vsyslog(level, format, args);
	va_end(args);
}
#endif

static char *subsystem;

static int run_program(const char *filename)
{
	pid_t pid;

	dbg("running %s", filename);
	pid = fork();
	switch (pid) {
	case 0:
		/* child */
		execl(filename, filename, subsystem, NULL);
		dbg("exec of child failed");
		_exit(1);
	case -1:
		dbg("fork of child failed");
		break;
		return -1;
	default:
		waitpid(pid, NULL, 0);
	}

	return 0;
}

struct files {
	struct list_head list;
	char name[PATH_MAX];
};

/* sort files in lexical order */
static int file_list_insert(char *filename, struct list_head *file_list)
{
	struct files *loop_file;
	struct files *new_file;

	list_for_each_entry(loop_file, file_list, list) {
		if (strcmp(loop_file->name, filename) > 0) {
			break;
		}
	}

	new_file = malloc(sizeof(struct files));
	if (new_file == NULL) {
		dbg("error malloc");
		return -ENOMEM;
	}

	strfieldcpy(new_file->name, filename);
	list_add_tail(&new_file->list, &loop_file->list);
	return 0;
}


/* calls function for every file found in specified directory */
static int call_foreach_file(const char *dirname)
{
	struct dirent *ent;
	DIR *dir;
	char *ext;
	struct files *loop_file;
	struct files *tmp_file;
	LIST_HEAD(file_list);

	dbg("open directory '%s'", dirname);
	dir = opendir(dirname);
	if (dir == NULL) {
		dbg("unable to open '%s'", dirname);
		return -1;
	}

	while (1) {
		ent = readdir(dir);
		if (ent == NULL || ent->d_name[0] == '\0')
			break;

		if (ent->d_name[0] == '.')
			continue;

		/* look for file with specified suffix */
		ext = strrchr(ent->d_name, '.');
		if (ext == NULL)
			continue;

		if (strcmp(ext, HOT_SUFFIX) != 0)
			continue;

		dbg("put file '%s/%s' in list", dirname, ent->d_name);
		file_list_insert(ent->d_name, &file_list);
	}

	/* call function for every file in the list */
	list_for_each_entry_safe(loop_file, tmp_file, &file_list, list) {
		char filename[PATH_MAX];

		snprintf(filename, PATH_MAX, "%s/%s", dirname, loop_file->name);
		filename[PATH_MAX-1] = '\0';

		run_program(filename);

		list_del(&loop_file->list);
		free(loop_file);
	}

	closedir(dir);
	return 0;
}
/* 
 * runs files in these directories in order:
 * 	argv[1]/
 * 	default/
 */
int main(int argc, char *argv[], char *envp[])
{
	char dirname[PATH_MAX];
	int fd;

	fd = open("/dev/null", O_RDWR);
	if (fd >= 0) {
		dup2(fd, STDOUT_FILENO);
		dup2(fd, STDIN_FILENO);
		dup2(fd, STDERR_FILENO);
	}
	close(fd);

	subsystem = argv[1];
	logging_init("hotplug");

	snprintf(dirname, PATH_MAX, "%s/%s", HOT_DIR, subsystem);
	dirname[PATH_MAX-1] = '\0';
	call_foreach_file(dirname);

	snprintf(dirname, PATH_MAX, "%s/default", HOT_DIR);
	dirname[PATH_MAX-1] = '\0';
	call_foreach_file(dirname);

	logging_close();
	return 0;
}

--3V7upXqbjpZ4EhLz--
