Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267378AbSLLAMW>; Wed, 11 Dec 2002 19:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267380AbSLLAMV>; Wed, 11 Dec 2002 19:12:21 -0500
Received: from ip67-93-141-186.z141-93-67.customer.algx.net ([67.93.141.186]:63883
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id <S267378AbSLLAMU>; Wed, 11 Dec 2002 19:12:20 -0500
Date: Wed, 11 Dec 2002 19:21:10 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Measurements and Lots of Files and Inodes
Message-ID: <20021212002110.GA27532@ducksong.com>
References: <20021211235258.GA10857@ducksong.com> <3DF7D3BE.59F4B212@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF7D3BE.59F4B212@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andrew Morton: Dec 11 16:09]
> "Patrick R. McManus" wrote:
> > 
> > ...
> > Just sitting back and watching vmstat while this runs my 'free' memory
> > drops from ~600MB to about ~16MB.. the buffers and cache remain roughly
> > constant.. at 16MB some sort of garbage collection kicks in - there is
> > a notable system pause and ~70MB moves from the used to the 'free'
> > column... this process repeats more or less in a steady state.
> 
> Probably `negative dentries' - cached directory entries which say
> "this file isn't there" so we don't need to go into the fs to
> find that out.
> 
> If you could share your test apps that would help a lot.

sure! this is the "lots of files" program.

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define BSZ 2000
unsigned char buf[BSZ+256];

main ()
{
    int fd,i,j;
    unsigned int ctr=0;
    unsigned char r=0;
    char f1[32],f2[32],f3[32],f4[32];
    
    while (1)
    {
        sprintf (f1,"fxa_%06d",ctr++);  sprintf (f2,"fxa_%06d",ctr++);
        sprintf (f3,"fxa_%06d",ctr++);  sprintf (f4,"fxa_%06d",ctr++);

        fd = open (f1,O_CREAT | O_RDWR);
        memset (buf,r++,BSZ+256);  write (fd,buf,BSZ+r);    close (fd);
        
        fd = open (f2,O_CREAT | O_RDWR);
        memset (buf,r++,BSZ+256);   write (fd,buf,BSZ+r);    close (fd);
        
        fd = open (f3,O_CREAT | O_RDWR);
        memset (buf,r++,BSZ+256);   write (fd,buf,BSZ+r);     close (fd);
        
        fd = open (f4,O_CREAT | O_RDWR);
        memset (buf,r++,BSZ+256);  write (fd,buf,BSZ+r);      close (fd);
        
        unlink (f1);   unlink (f2);    unlink (f3);   unlink (f4);
        if (!r)
          fprintf (stdout,".");fflush (stdout);
    }
}

and this is the "gimme 300MB even though free sez I hardly have
anything" program:

#define BS (30*1024*1024)
main()
{
    char *x;
    x = malloc (BS);
    if (!x)
        printf ("heh - x is NULL\n");
    else
    {
        printf ("allocd\n");
        memset (x,0x31,BS);
        printf ("set\n");
        free (x);
        printf ("freed\n");
    }
}

> On your machine it'll be "all of swap plus all of physical memory
> minus whatever malloc'ed memory you're using now minus 8-12 megabytes".
> There isn't much memory which cannot be reclaimed unless you have a
> huge machine or you're doing odd things.

this is useful advice, thanks. Basically what the new procps does?
