Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUEIFOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUEIFOn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 01:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUEIFOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 01:14:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:31908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264275AbUEIFOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 01:14:36 -0400
Date: Sat, 8 May 2004 22:14:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       maneesh@in.ibm.com
Subject: Re: dentry bloat.
In-Reply-To: <20040508213643.08e7ae80.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405082143340.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org>
 <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
 <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
 <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com>
 <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com>
 <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
 <20040508211236.10481447.akpm@osdl.org> <Pine.LNX.4.58.0405082120290.1592@ppc970.osdl.org>
 <20040508213643.08e7ae80.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 May 2004, Andrew Morton wrote:
> 
> erk.  OK.  Things are (much) worse than I thought.  The 24 byte limit means
> that 20% of my names will be externally allocated, but that's no worse than
> what we had before.

In fact, it's better than what we had before at least on 64-bit 
archtiectures.

But I'd be happy to make the DNAME_INLINE_LEN_MIN #define larger - I just 
think we should try to shrink the internal structure fields first. 

Btw, at least for the kernel sources, my statistics say that filename
distribution (in a built tree, and with BK) is

   1:     5.04 % (    5.04 % cum -- 2246)
   2:     5.19 % (   10.23 % cum -- 2312)
   3:     0.55 % (   10.79 % cum -- 247)
   4:     3.30 % (   14.08 % cum -- 1469)
   5:     3.35 % (   17.43 % cum -- 1492)
   6:     4.35 % (   21.79 % cum -- 1940)
   7:     7.55 % (   29.34 % cum -- 3365)
   8:     9.64 % (   38.98 % cum -- 4293)
   9:     9.17 % (   48.15 % cum -- 4084)
  10:    10.98 % (   59.12 % cum -- 4891)
  11:     7.65 % (   66.77 % cum -- 3406)
  12:     7.01 % (   73.78 % cum -- 3122)
  13:     5.16 % (   78.94 % cum -- 2298)
  14:     3.83 % (   82.77 % cum -- 1706)
  15:     3.47 % (   86.24 % cum -- 1545)
  16:     2.11 % (   88.34 % cum -- 939)
  17:     1.47 % (   89.81 % cum -- 655)
  18:     1.06 % (   90.87 % cum -- 472)
  19:     0.68 % (   91.55 % cum -- 303)
  20:     0.42 % (   91.97 % cum -- 188)
  21:     0.29 % (   92.26 % cum -- 128)
  22:     0.24 % (   92.50 % cum -- 107)
  23:     0.14 % (   92.64 % cum -- 63)

ie we've reached 92% of all names with 24-byte inline thing.

For my whole disk, I have similar stats:

   1:     6.59 % (    6.59 % cum -- 71690)
   2:     6.86 % (   13.45 % cum -- 74611)
   3:     1.59 % (   15.04 % cum -- 17292)
   4:     3.77 % (   18.81 % cum -- 40992)
   5:     3.11 % (   21.92 % cum -- 33884)
   6:     4.13 % (   26.05 % cum -- 44898)
   7:     6.97 % (   33.01 % cum -- 75774)
   8:     8.13 % (   41.15 % cum -- 88451)
   9:     7.81 % (   48.96 % cum -- 84987)
  10:     9.56 % (   58.52 % cum -- 104021)
  11:     7.67 % (   66.19 % cum -- 83403)
  12:     8.07 % (   74.26 % cum -- 87826)
  13:     4.38 % (   78.65 % cum -- 47690)
  14:     3.36 % (   82.01 % cum -- 36592)
  15:     2.71 % (   84.71 % cum -- 29431)
  16:     1.78 % (   86.49 % cum -- 19311)
  17:     1.35 % (   87.84 % cum -- 14703)
  18:     1.05 % (   88.89 % cum -- 11410)
  19:     0.82 % (   89.71 % cum -- 8952)
  20:     0.77 % (   90.49 % cum -- 8423)
  21:     0.85 % (   91.34 % cum -- 9264)
  22:     0.72 % (   92.06 % cum -- 7798)
  23:     0.69 % (   92.75 % cum -- 7534)

so it appears that I'm either a sad case with a lot of source code on my 
disk, or you have overlong filenames that brings up your stats.

Or my program is broken. Entirely possible.

Whee. 149 characters is my winning entry:

	/usr/share/doc/HTML/en/kdelibs-3.1-apidocs/kdecore/html/classKGenericFactory_3_01KTypeList_3_01Product_00_01ProductListTail_01_4_00_01KTypeList_3_01ParentType_00_01ParentTypeListTail_01_4_01_4-members.html

That's obscene.

		Linus

-----
/*
 * (C) Copyright 2003 Linus Torvalds
 *
 * "bkr" - recusrive "bk" invocations aka "bk -r"
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <fcntl.h>
#include <dirent.h>
#include <string.h>
#include <regex.h>

/*
 * Very generic directory tree handling.
 */
static int bkr(const char *path, int pathlen,
	void (*regcallback)(const char *path, int pathlen, const char *name, int namelen),
	void (*dircallback)(const char *path, int pathlen, const char *name, int namelen))
{
	struct dirent *de;
	char fullname[MAXPATHLEN + 1];
	char *ptr = fullname + pathlen;
	DIR *base = opendir(path);

	if (!base)
		return 0;
	memcpy(fullname, path, pathlen);

	while ((de = readdir(base)) != NULL) {
		int len;

		len = strlen(de->d_name);
		memcpy(ptr, de->d_name, len+1);

		if (dircallback) {
			switch (de->d_type) {
			struct stat st;
			case DT_UNKNOWN:
				if (stat(fullname, &st))
					break;
				if (!S_ISDIR(st.st_mode))
					break;
			case DT_DIR:
				if (de->d_name[0] == '.') {
					if (len == 1)
						break;
					if (de->d_name[1] == '.' && len == 2)
						break;
				}
				ptr[len] = '/';
				ptr[len+1] = '\0';
				dircallback(fullname, pathlen + len + 1, de->d_name, len);
				continue;
			}
		}
		regcallback(fullname, pathlen + len, de->d_name, len);
	}
	closedir(base);
	return 0;
}

static int total;
static int len[256];

static void file(const char *path, int pathlen, const char *name, int namelen)
{
	total++;
	len[namelen]++;
}

static void dir(const char *path, int pathlen, const char *name, int namelen)
{
	file(path, pathlen, name, namelen);
	bkr(path, pathlen, file, dir);
}


int main(int argc, char **argv)
{
	int i;
	double sum = 0.0;

	bkr(".", 0, file, dir);
	for (i = 0; i < 256; i++) {
		int nr = len[i];
		if (nr) {
			double this = (double) nr * 100.0 / total;
			sum += this;
			printf("%4i: %8.2f %% (%8.2f %% cum -- %d)\n", i, this, sum, nr);
		}
	}
}
