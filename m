Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUAFUgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 15:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAFUgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 15:36:24 -0500
Received: from thunk.org ([140.239.227.29]:32485 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265130AbUAFUgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 15:36:14 -0500
Date: Tue, 6 Jan 2004 15:32:41 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: venom@sns.it, "Randy.Dunlap" <rddunlap@osdl.org>, sglines@is-cs.com,
       linux-kernel@vger.kernel.org
Subject: Re: file system technical comparisons
Message-ID: <20040106203241.GA13448@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>, venom@sns.it,
	"Randy.Dunlap" <rddunlap@osdl.org>, sglines@is-cs.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0401061300550.13594-100000@cibs9.sns.it> <3FFACC5C.7050900@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <3FFACC5C.7050900@namesys.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2004 at 05:55:24PM +0300, Hans Reiser wrote:
> 
> htree has performance problems that are due to its architecture --- I 
> think this is why they don't make it on by default --- it actually slows 
> ext3 down substantially for average directory sizes.....  you can see 
> that on our benchmarks page, or just by copying around some copies of 
> the linux kernel yourself with it on and off.

Actually, the reason why we didn't enable by default was more because
of conservatism; it's a new feature, and during the bug shakedown
phase, we didn't want to impact users with some of the initial memory
leaks, NFS server incompatibilities, etc., that have since been all
fixed.

Htree has performance problems for certain workloads --- specifically,
workloads that do a readdir() followed by a stat().  This is because
readdir() returns inodes in hash value order, instead of in the order
that the files were created (which generally meant increasing inode
order).  Because accesses to the inode table now become random, this
adversely impacts certain workloads, such as the kernel tar and untar
benchmark.  

This can be easily fixed by changing the application to sort the
inodes by inode number, or by using an LD_PRELOAD library to do the
sorting in userspace.  (See attached).

Whether or not this performance issue is a problem in real life is a
different story.  If you are just doing accesses in random order and
are doing lookups by name, such as in a squid cache, you won't see
this issue at all, and htree will be a huge win.  However, if like
sendmail the program is running readdir() and then stat'ing all files,
then the following LD_PRELOAD library is necessary to avoid a
performance regression caused by htree returning files in hash order.

(Note that this LD_PRELOAD library will often speed up readdir/stat
workloads on non-htree filesystems as well, since in general most
inode-based filesystems are happier when you access files in inode
order, and over time, directories tend to get disordered and are no
longer in create/inode number sorted order.)

						- Ted

--HlL+5n6rz5pIUxbD
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="spd_readdir.c"

/*
 * readdir accelerator
 *
 * (C) Copyright 2003 by Theodore Ts'o.
 *
 * %Begin-Header%
 * This file may be redistributed under the terms of the GNU Public
 * License.
 * %End-Header%
 * 
 */

#define ALLOC_STEPSIZE	100
#define MAX_DIRSIZE	0

#define DEBUG

#ifdef DEBUG
#define DEBUG_DIR(x)	{if (do_debug) { x; }}
#else
#define DEBUG_DIR(x)
#endif

#define _GNU_SOURCE
#define __USE_LARGEFILE64

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <errno.h>
#include <dlfcn.h>

struct dirent_s {
	unsigned long long d_ino;
	long long d_off;
	unsigned short int d_reclen;
	unsigned char d_type;
	char *d_name;
};

struct dir_s {
	DIR	*dir;
	int	num;
	int	max;
	struct dirent_s *dp;
	int	pos;
	struct dirent ret_dir;
	struct dirent64 ret_dir64;
};

static int (*real_closedir)(DIR *dir) = 0;
static DIR *(*real_opendir)(const char *name) = 0;
static struct dirent *(*real_readdir)(DIR *dir) = 0;
static struct dirent64 *(*real_readdir64)(DIR *dir) = 0;
static off_t (*real_telldir)(DIR *dir) = 0;
static void (*real_seekdir)(DIR *dir, off_t offset) = 0;
static unsigned long max_dirsize = MAX_DIRSIZE;
#ifdef DEBUG
static int do_debug = 0;
#endif

static void setup_ptr()
{
	char *cp;

	real_opendir = dlsym(RTLD_NEXT, "opendir");
	real_closedir = dlsym(RTLD_NEXT, "closedir");
	real_readdir = dlsym(RTLD_NEXT, "readdir");
	real_readdir64 = dlsym(RTLD_NEXT, "readdir64");
	real_telldir = dlsym(RTLD_NEXT, "telldir");
	real_seekdir = dlsym(RTLD_NEXT, "seekdir");
	if ((cp = getenv("SPD_READDIR_MAX_SIZE")) != NULL) {
		max_dirsize = atol(cp);
	}
#ifdef DEBUG
	if (getenv("SPD_READDIR_DEBUG"))
		do_debug++;
#endif
}

static void free_cached_dir(struct dir_s *dirstruct)
{
	int i;

	if (!dirstruct->dp)
		return;

	for (i=0; i < dirstruct->num; i++) {
		free(dirstruct->dp[i].d_name);
	}
	free(dirstruct->dp);
	dirstruct->dp = 0;
}	

static int ino_cmp(const void *a, const void *b)
{
	const struct dirent_s *ds_a = (const struct dirent_s *) a;
	const struct dirent_s *ds_b = (const struct dirent_s *) b;
	ino_t i_a, i_b;
	
	i_a = ds_a->d_ino;
	i_b = ds_b->d_ino;

	if (ds_a->d_name[0] == '.') {
		if (ds_a->d_name[1] == 0)
			i_a = 0;
		else if ((ds_a->d_name[1] == '.') && (ds_a->d_name[2] == 0))
			i_a = 1;
	}
	if (ds_b->d_name[0] == '.') {
		if (ds_b->d_name[1] == 0)
			i_b = 0;
		else if ((ds_b->d_name[1] == '.') && (ds_b->d_name[2] == 0))
			i_b = 1;
	}

	return (i_a - i_b);
}


DIR *opendir(const char *name)
{
	DIR *dir;
	struct dir_s	*dirstruct;
	struct dirent_s *ds, *dnew;
	struct dirent64 *d;
	struct stat st;

	if (!real_opendir)
		setup_ptr();

	dir = (*real_opendir)(name);
	if (!dir)
		return NULL;

	dirstruct = malloc(sizeof(struct dir_s));
	if (!dirstruct) {
		(*real_closedir)(dir);
		errno = -ENOMEM;
		return NULL;
	}
	dirstruct->num = 0;
	dirstruct->max = 0;
	dirstruct->dp = 0;
	dirstruct->pos = 0;
	dirstruct->dir = 0;

	if (max_dirsize && (stat(name, &st) == 0) && 
	    (st.st_size > max_dirsize)) {
		DEBUG_DIR(printf("Directory size %ld, using direct readdir\n",
				 st.st_size));
		dirstruct->dir = dir;
		return (DIR *) dirstruct;
	}

	while ((d = (*real_readdir64)(dir)) != NULL) {
		if (dirstruct->num >= dirstruct->max) {
			dirstruct->max += ALLOC_STEPSIZE;
			DEBUG_DIR(printf("Reallocating to size %d\n", 
					 dirstruct->max));
			dnew = realloc(dirstruct->dp, 
				       dirstruct->max * sizeof(struct dir_s));
			if (!dnew)
				goto nomem;
			dirstruct->dp = dnew;
		}
		ds = &dirstruct->dp[dirstruct->num++];
		ds->d_ino = d->d_ino;
		ds->d_off = d->d_off;
		ds->d_reclen = d->d_reclen;
		ds->d_type = d->d_type;
		if ((ds->d_name = malloc(strlen(d->d_name)+1)) == NULL) {
			dirstruct->num--;
			goto nomem;
		}
		strcpy(ds->d_name, d->d_name);
		DEBUG_DIR(printf("readdir: %lu %s\n", 
				 (unsigned long) d->d_ino, d->d_name));
	}
	(*real_closedir)(dir);
	qsort(dirstruct->dp, dirstruct->num, sizeof(struct dirent_s), ino_cmp);
	return ((DIR *) dirstruct);
nomem:
	DEBUG_DIR(printf("No memory, backing off to direct readdir\n"));
	free_cached_dir(dirstruct);
	dirstruct->dir = dir;
	return ((DIR *) dirstruct);
}

int closedir(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	if (dirstruct->dir)
		(*real_closedir)(dirstruct->dir);

	free_cached_dir(dirstruct);
	free(dirstruct);
	return 0;
}

struct dirent *readdir(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;
	struct dirent_s *ds;

	if (dirstruct->dir)
		return (*real_readdir)(dirstruct->dir);

	if (dirstruct->pos >= dirstruct->num)
		return NULL;

	ds = &dirstruct->dp[dirstruct->pos++];
	dirstruct->ret_dir.d_ino = ds->d_ino;
	dirstruct->ret_dir.d_off = ds->d_off;
	dirstruct->ret_dir.d_reclen = ds->d_reclen;
	dirstruct->ret_dir.d_type = ds->d_type;
	strncpy(dirstruct->ret_dir.d_name, ds->d_name,
		sizeof(dirstruct->ret_dir.d_name));

	return (&dirstruct->ret_dir);
}

struct dirent64 *readdir64(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;
	struct dirent_s *ds;

	if (dirstruct->dir)
		return (*real_readdir64)(dirstruct->dir);

	if (dirstruct->pos >= dirstruct->num)
		return NULL;

	ds = &dirstruct->dp[dirstruct->pos++];
	dirstruct->ret_dir64.d_ino = ds->d_ino;
	dirstruct->ret_dir64.d_off = ds->d_off;
	dirstruct->ret_dir64.d_reclen = ds->d_reclen;
	dirstruct->ret_dir64.d_type = ds->d_type;
	strncpy(dirstruct->ret_dir64.d_name, ds->d_name,
		sizeof(dirstruct->ret_dir64.d_name));

	return (&dirstruct->ret_dir64);
}

off_t telldir(DIR *dir)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	if (dirstruct->dir)
		return (*real_telldir)(dirstruct->dir);

	return ((off_t) dirstruct->pos);
}

void seekdir(DIR *dir, off_t offset)
{
	struct dir_s	*dirstruct = (struct dir_s *) dir;

	if (dirstruct->dir) {
		(*real_seekdir)(dirstruct->dir, offset);
		return;
	}

	dirstruct->pos = offset;
}

--HlL+5n6rz5pIUxbD--
