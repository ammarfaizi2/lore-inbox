Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262417AbSI2Ibp>; Sun, 29 Sep 2002 04:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSI2Ibp>; Sun, 29 Sep 2002 04:31:45 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:18048 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262417AbSI2Ibn>;
	Sun, 29 Sep 2002 04:31:43 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: chrisl@gnuchina.org, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix htree dir corrupt after fsck -fD
Date: Sun, 29 Sep 2002 01:36:51 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020929070315.GA6876@vmware.com> <200209290117.02331.ryan@completely.kicks-ass.org>
In-Reply-To: <200209290117.02331.ryan@completely.kicks-ass.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jurl9qg2MHpnfEo"
Message-Id: <200209290136.53403.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jurl9qg2MHpnfEo
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 29, 2002 01:16, Ryan Cumming wrote:
> This is a completely fresh loopback EXT3 filesystem, untouched by fsck -D,
> and normally unmounted.

Oh, and I've attached the current version of my test program if anyone is 
interested.

It spawns 8 child processes which repeatedly create up to 1,000,000 files 
each, stat up to 1,000,000 (probably) non-existant files, and then unlink the 
files they created.

It also spawns another 4 processes which iterate over all of the directory 
entries using readdir(). For each file it encounters, it has an equal 
probability of renaming it, unlinking it, or truncating it to a random 
length.

It can corrupt my loopback test filesystems in under 5 minutes. Note that it 
will completely destroy any data in its working directory, however.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lrulLGMzRzbJfbQRAgxMAJ46Y/L4FA8nuwe76MyGCyhG+mSE3QCgjb5a
TBJbqp55p5yOU2BY0AnW/TA=
=cKn9
-----END PGP SIGNATURE-----

--Boundary-00=_jurl9qg2MHpnfEo
Content-Type: text/x-csrc;
  charset="big5";
  name="fs-ream.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fs-ream.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>

#define BLIND_THREADS			8
#define READDIR_THREADS			4
#define MAX_FILE_COUNT_PER_THREAD	200000
#define SYNC_INTERVAL			1
#define MAX_FILE_SIZE			(8 * 1024 * 1024)

void blind_thread();
void readdir_thread();

int main(int argc, char *argv[])
{
	int i = 0;

	for(i = 0;i < BLIND_THREADS;i++)
	{
		if (!fork())
		{
			blind_thread();
		}
	}
	for(i = 0;i < READDIR_THREADS;i++)
	{
		if (!fork())
		{
			readdir_thread();
		}
	}


	while(1)
	{
		sleep(SYNC_INTERVAL);
		sync();
	}

	return 0;
}

void blind_thread()
{
	while(1) 
	{
		unsigned int seed;
		struct timeval tv;
		int i;
		int count;

		gettimeofday(&tv, NULL);
		seed = tv.tv_usec;
		count = seed % MAX_FILE_COUNT_PER_THREAD;

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

void readdir_thread()
{
	while(1)
	{
		DIR *dir;
		struct dirent *entry;
		dir = opendir(".");

		while((entry = readdir(dir)))
		{
			struct stat st;
			stat(entry->d_name, &st);

			if (S_ISREG(st.st_mode))
			{
				switch(rand() % 3)
				{
				case 0:
					unlink(entry->d_name);
				case 1:
					truncate(entry->d_name, rand() % MAX_FILE_SIZE);
				case 2:
					{
						char filename[32];
						snprintf(filename, 32, "%x", rand());
						rename(entry->d_name, filename);
					}
				}
			}
		}

		closedir(dir);
	}
}

--Boundary-00=_jurl9qg2MHpnfEo--
