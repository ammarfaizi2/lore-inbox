Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbSI1BPd>; Fri, 27 Sep 2002 21:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbSI1BPc>; Fri, 27 Sep 2002 21:15:32 -0400
Received: from [24.77.26.115] ([24.77.26.115]:32905 "EHLO completely")
	by vger.kernel.org with ESMTP id <S262671AbSI1BPb>;
	Fri, 27 Sep 2002 21:15:31 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Fri, 27 Sep 2002 18:20:27 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020926235741.GC10551@think.thunk.org> <20020927041234.GS22795@clusterfs.com>
In-Reply-To: <20020927041234.GS22795@clusterfs.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dPQl9KPVt3r7B0g"
Message-Id: <200209271820.41906.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dPQl9KPVt3r7B0g
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 26, 2002 21:12, Andreas Dilger wrote:
> After that, we'd be happy if you could test with a loopback filesystem:

Okay, got another one:
"EXT3-fs error (device loop(7,0)): ext3_add_entry: bad entry in directory #2: 
rec_len is smaller than minimal - offset=0, inode=0, rec_len=8, name_len=0"
fsck then reported:
"Directory inode 2, block 166, offset 0: directory corrupted"

This is while deleteing an old fsstress directory (a full fsck had been 
performed since the last time the fsstress directory had been touched) while 
running a few instances of the attached program.

You guys have any idea what's going on yet? 

- -Ryan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lQPpLGMzRzbJfbQRAlzdAJ9mbiu8lRBbcFZXE/tD94Ad9DoAowCdFzab
JkelXV/8C4fsqEqg9TfBvb0=
=VA58
-----END PGP SIGNATURE-----

--Boundary-00=_dPQl9KPVt3r7B0g
Content-Type: text/x-csrc;
  charset="big5";
  name="dir-ream.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dir-ream.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>

#define MAX_FILE_COUNT	4000000

int main(int argc, char *argv[])
{
	while(1) 
	{
		unsigned int seed;
		struct timeval tv;
		int i;
		int count;

		gettimeofday(&tv, NULL);
		seed = tv.tv_usec;
		count = seed % MAX_FILE_COUNT;

		srand(seed);
		printf("Creating %i files\n" , count);
		for(i = 0; i < count;i++)
		{
			char filename[32];
			snprintf(filename, 32, "%x", rand());
			close(open(filename, O_CREAT | O_RDONLY));
		}

		printf("Performing %i random lookups\n" , count);
		for(i = 0; i < count;i++)
		{
			char filename[32];
			struct stat useless;

			snprintf(filename, 32, "%x", rand());
			stat(filename, &useless);
		}

		srand(seed);
		printf("Unlinking %i files\n" , count);
		for(i = 0; i < count;i++)
		{
			char filename[32];
			snprintf(filename, 32, "%x", rand());
			unlink(filename);
		}
	}
}

--Boundary-00=_dPQl9KPVt3r7B0g--
