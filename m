Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSAIFVM>; Wed, 9 Jan 2002 00:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288817AbSAIFVD>; Wed, 9 Jan 2002 00:21:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288811AbSAIFU4>; Wed, 9 Jan 2002 00:20:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: fs corruption recovery?
Date: 8 Jan 2002 21:20:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1gjuv$eak$1@cesium.transmeta.com>
In-Reply-To: <3C3BB082.8020204@fit.edu> <20020108200705.S769@lynx.adilger.int> <3C3BC0FC.30403@fit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C3BC0FC.30403@fit.edu>
By author:    Kervin Pierre <kpierre@fit.edu>
In newsgroup: linux.dev.kernel
> 
> Thanks for the reply,
> 
>  >Try "e2fsck -B 4096 -b 32768 <device>" instead.
>  >
> 
>   e2fsck -B 4096 -b 32768  /dev/hdc1
> 
> e2fsck 1.25 (20-Sep-2001)
> e2fsck: Attempt to read block from filesystem resulted in short read
> while trying to open /dev/hdc1
> Could this be a zero-length partition?
> 
> Does ext keep a backup of that backup?  :)
> 
> Are there any other options?
> 

You have bad media.  You need to read the disk sector by sector, save
it elsewhere, write it to another drive, and then try to fsck it --
HOWEVER, DON'T FSCK THE ORIGINAL.  Fsck can actually cause serious
damage if it guesses wrong.

The following is a small C program that I just threw together to read
sector by sector and dump the data on stdout.  No guarantees
whatsoever:


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

#define SECTORSIZE 512

int read_sector(int fd, void *buf)
{
  char *p = buf;
  int bytes = SECTORSIZE;
  int rv;

  while ( bytes ) {
    if ( (rv = read(fd, p, bytes)) <= 0 ) {
      if ( rv < 0 || errno == EINTR )
	continue;		/* Happens... */
      return 0;			/* Error */
    }
    p += rv;
    bytes -= rv;
  }

  return 1;			/* Success */
}

int main(int argc, char *argv[])
{
  unsigned long long count;
  unsigned long long n;
  int fd;
  char buffer[SECTORSIZE];

  if ( argc != 3 ) {
    fprintf(stderr, "Usage: %s device sectors\n", argv[0]);
    exit(1);
  }

  count = strtoull(argv[2], NULL, 0);
  
  fd = open(argv[1], O_RDONLY);
  if ( fd < 0 ) {
    perror(argv[1]);
    exit(1);
  }
  
  n = 0;
  while ( count-- ) {
    if ( !read_sector(fd, buffer) ) {
      fprintf(stderr, "Sector %llu: %s\n", n, strerror(errno));
      memset(buffer, 0, SECTORSIZE);
    }
    if ( fwrite(buffer, 1, SECTORSIZE, stdout) != SECTORSIZE ) {
      fprintf(stderr, "Sector %llu: output error: %s\n", n, strerror(errno));
      exit(1);
    }
    n++;
  }

  return 0;
}


	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
