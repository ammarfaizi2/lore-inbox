Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbRAUVOu>; Sun, 21 Jan 2001 16:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRAUVOm>; Sun, 21 Jan 2001 16:14:42 -0500
Received: from colorfullife.com ([216.156.138.34]:27919 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129401AbRAUVOe>;
	Sun, 21 Jan 2001 16:14:34 -0500
Message-ID: <3A6B5125.6781E69D@colorfullife.com>
Date: Sun, 21 Jan 2001 22:14:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Otto Meier <gf435@gmx.net>, Holger Kiehl <Holger.Kiehl@dwd.de>,
        Hans Reiser <reiser@namesys.com>, edward@namesys.com,
        Ed Tomlinson <tomlins@cam.org>,
        Nils Rennebarth <nils@ipe.uni-stuttgart.de>,
        David Willmore <n0ymv@callsign.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
In-Reply-To: <14955.19182.663691.194031@notabene.cse.unsw.edu.au>
Content-Type: multipart/mixed;
 boundary="------------C35DBE21505B0B7D9D6BE1E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C35DBE21505B0B7D9D6BE1E3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've attached Holger's testcase (ext2, SMP, raid5)
boot with "mem=64M" and run the attached script.
The script creates and deletes 9 directories with 10.000 in each dir.
Neil, could you run it? I don't have an raid 5 array - SMP+ext2 without
raid5 is ok.

Holger, what's your ext2 block size, and do you run with a degraded
array?

--
	Manfred
--------------C35DBE21505B0B7D9D6BE1E3
Content-Type: text/plain; charset=us-ascii;
 name="fsd.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fsd.c"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include <errno.h>

static void create_files(int, int, char *),
            delete_files(char *);


/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ fsd $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
int
main(int argc, char *argv[])
{
   int  no_of_files,
        file_size;
   char dirname[1024];

   if (argc == 4)
   {
      no_of_files = atoi(argv[1]);
      file_size = atoi(argv[2]);
      (void)strcpy(dirname, argv[3]);
   }
   else
   {
      (void)fprintf(stderr,
                    "Usage: %s <number of files> <file size> <directory>\n",
                    argv[0]);
      exit(1);
   }
   create_files(no_of_files, file_size, dirname);
   delete_files(dirname);
   exit(0);
}


/*+++++++++++++++++++++++++++ create_files() ++++++++++++++++++++++++++++*/
static void
create_files(int no_of_files, int file_size, char *dirname)
{
   int  i, fd;
   char *ptr;

   ptr = dirname + strlen(dirname);
   *ptr++ = '/';
   for (i = 0; i < no_of_files; i++)
   {
      (void)sprintf(ptr, "this_is_dummy_file_%d", i);
      if ((fd = open(dirname, O_CREAT|O_RDWR, S_IRUSR|S_IWUSR)) == -1)
      {
         (void)fprintf(stderr, "Failed to open() %s : %s\n",
                       dirname, strerror(errno));
         exit(1);
      }
      if (lseek(fd, file_size - 1, SEEK_SET) == -1)
      {
         (void)fprintf(stderr, "Failed to lseek() %s : %s\n",
                       dirname, strerror(errno));
         exit(1);
      }
      if (write(fd, "", 1) != 1)
      {
         (void)fprintf(stderr, "Failed to write() to %s : %s\n",
                       dirname, strerror(errno));
         exit(1);
      }
      if (close(fd) == -1)
      {
         (void)fprintf(stderr, "Failed to close() %s : %s\n",
                       dirname, strerror(errno));
      }
   }
   ptr[-1] = 0;
   return;
}


/*++++++++++++++++++++++++++++ delete_files +++++++++++++++++++++++++++++*/
static void
delete_files(char *dirname)
{
   char          *ptr;
   struct dirent *dirp;
   DIR           *dp;

   ptr = dirname + strlen(dirname);
   if ((dp = opendir(dirname)) == NULL)
   {
      (void)fprintf(stderr, "Failed to opendir() %s : %s\n",
                    dirname, strerror(errno));
      exit(1);
   }
   *ptr++ = '/';
   while ((dirp = readdir(dp)) != NULL)
   {
      if (dirp->d_name[0] != '.')
      {
         (void)strcpy(ptr, dirp->d_name);
         if (unlink(dirname) == -1)
         {
            (void)fprintf(stderr, "Failed to open() %s : %s\n",
                          dirname, strerror(errno));
            exit(1);
         }
      }
   }
   ptr[-1] = 0;
   if (closedir(dp) == -1)
   {
      (void)fprintf(stderr, "Failed to closedir() %s : %s\n",
                    dirname, strerror(errno));
   }
   return;
}

--------------C35DBE21505B0B7D9D6BE1E3
Content-Type: text/plain; charset=us-ascii;
 name="start_fsd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="start_fsd"

#!/bin/sh

NO_OF_PROCESS=9
NUMBER_OF_FILES=10000
FILE_SIZE=2048

counter=0
while [ $counter -lt $NO_OF_PROCESS ]
do
   if [ ! -d $counter ]
   then
      mkdir $counter
   fi
   ./fsd $NUMBER_OF_FILES $FILE_SIZE $counter &
   counter=`expr "$counter" + 1`
done

--------------C35DBE21505B0B7D9D6BE1E3--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
