Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVEXQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVEXQkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVEXQge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:36:34 -0400
Received: from web53401.mail.yahoo.com ([206.190.37.48]:65402 "HELO
	web53401.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262146AbVEXQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:33:13 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=h0jAxZ3ZJEWJ+PCIdXTQQ3hXzpIPRVQHrqS630dMmmyZK3u4hIXx7g4mMbxckjcSFN/KI9F58sktDw46xW7t2API6SDYU/fJn/bttk3j1ytxhNmZIXr89vRUvJRUHeS9u7fiPGQzcO1isSVE8uKjdly3bE1b7J52bgo8aJM4woc=  ;
Message-ID: <20050524163309.74541.qmail@web53401.mail.yahoo.com>
Date: Tue, 24 May 2005 09:33:09 -0700 (PDT)
From: Bryan Wilkerson <bryanwilkerson@yahoo.com>
Reply-To: bryanwilkerson@yahoo.com
Subject: inotify 0.23 errno 28 (ENOSPC)
To: rlove@rlove.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-801951470-1116952389=:71688"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-801951470-1116952389=:71688
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,  

I read an earlier thread where you said that it was
possible to manually walk a tree and add all
directories to an inotify watch descriptor.  I wrote
some code to do this and the ioctl call fails on my
machine after adding 9,977 directories with ENOSPC.  

I've attached a small repro case.  Just point it at
the base of a large dir tree (e.g. inotify-r ~) to
use. 

My kernel is 2.6.12-rc3 with the inotify 0.23 patch. 
Let me know if you need more information.  

Please cc my e-mail addr in all replies.

Thanks,

-bryan
--0-801951470-1116952389=:71688
Content-Type: text/x-csrc; name="inotify-r.c"
Content-Description: 1249210018-inotify-r.c
Content-Disposition: inline; filename="inotify-r.c"


/*  this just demonstrates adding a large number of directories
    to inotify
*/

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <dirent.h>


#include "inotify.h"

int dirsWatched = 0;
int fd;

static void fatal_error(char *fmt, ...) __attribute__((noreturn));
static void fatal_error(char *fmt, ...) 
{
	fprintf(stderr, "\n\nFATAL ERROR:%d:%s: ", errno, strerror(errno));
	va_list ap;
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fprintf(stderr, "\n\nDirs successfully added to watch: %d\n", dirsWatched);
	exit(errno);
}


int add_dir(const char *path)
{
	struct inotify_watch_request iwr;
	iwr.mask = 0xffffffff;
	iwr.fd = open(path, O_RDONLY);
	if( iwr.fd <= 0 )
		fatal_error("Unable to open directory %s for reading", path);
	
	int wd = ioctl(fd, INOTIFY_WATCH, &iwr);
	close(iwr.fd);
	
	if (wd < 0) 
		fatal_error("Unable to create inotify watch on object: %s", path);
	else
		dirsWatched++;

	struct dirent **namelist;
	int i, n;
	struct stat statstruct;
	
	n = scandir(path, &namelist, 0, alphasort);
	if( n < 0 )
		fatal_error("scandir failed");

	for( i = 0; i < n; i++ )
	{
		char fileName[4096];
		int len = sprintf(fileName, "%s/%s", path, namelist[i]->d_name);
		
		if( !(strcmp(&fileName[len-2], "/.")==0 || strcmp(&fileName[len-3], "/..")==0) )
		{
			// most likely cause of not being able to stat is 
			// permissions which we quietly ignore and assume 
			// to be benign
			if( stat(fileName, &statstruct) == 0 )
			{
				if( S_ISDIR(statstruct.st_mode) )
				{
					// recursive add
					add_dir(fileName);
				}
			}
		}
		free(namelist[i]);
	}
	free(namelist);
}

int main(int argc, char **argv)
{
	if( argc < 2 || strcmp(argv[1], "--help") == 0 )
	{
		printf( "inotify-r - tests adding a directory recusively to an inotify descriptor\n"
			"\n"
			"Usage: inotify-r <path>\n");
		exit(1);
	}
	fd = open("/dev/inotify", O_RDONLY);
	if (fd < 0) 
		fatal_error("Unable to open inotify device.");

	add_dir(argv[1]);
	return 0;
}


--0-801951470-1116952389=:71688--
