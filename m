Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266674AbRGOQYl>; Sun, 15 Jul 2001 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266684AbRGOQYc>; Sun, 15 Jul 2001 12:24:32 -0400
Received: from weta.f00f.org ([203.167.249.89]:11396 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266674AbRGOQYW>;
	Sun, 15 Jul 2001 12:24:22 -0400
Date: Mon, 16 Jul 2001 04:24:26 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716042426.D10713@weta.f00f.org>
In-Reply-To: <E15LntD-000489-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <E15LntD-000489-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 15, 2001 at 04:32:59PM +0100, Alan Cox wrote:

    Another way is to time

    	write block
    	write barrier
    	write same block
    	write barrier
    	repeat

    If the write barrier is working you should be able to measure the
    drive rpm 8)

OK, I just wrote this in order to test just that, test on a raw device
and turn caching off if you can.

For my drives, I cannot disable caching (I don't know if it is on or
not) and I get abysmal speed, but nothing unrealistic,

Anyhow, I just wrote this and tested it a couple of times, if it
breaks or east your disk, don't bitch at me.

Otherwise, flames and comments on my god awful code welcome.



  --cw

--dc+cDN39EJAMEtIO
Content-Type: text/x-csrc; charset=us-ascii
Content-Description: More of Blondie's awful code
Content-Disposition: attachment; filename="write-bench.c"

/*
 * write-bench.c
 *
 * test write-performance to a device for n loops, designed for
 * testing to a raw device where the underlying physical device has
 * caching turned off
 *
 * cw@f00f.org --- Mon Jul 16 04:21:12 NZST 2001
 *
 * USE AT YOUR OWN RISK! NO WARRANTY GIVEN OR IMPLIED
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
/* #include <publib.h> */

/* XXX edit for your CPU */
const float MHz = 860.947 * 1000 * 1000;

/* some kind of 64-bit tsc is required */
#ifdef __i386__
#define rdtsc(low,high) \
    __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
#else /* __i386__ */
#error "Please define rdtsc(low32,high32) for your architecture"
#endif /* __i386__ */


int main(int argc,char *argv[])
{
    const int secsize = 512;
    int f, i, loops;
    char *buf;
    double sum = 0.0, sumsq = 0.0, duration;
    union jack {
        unsigned int l[2];
        unsigned long long v;
    }before_io, after_io;

    if(argc != 3){
        fprintf(stderr,"please supply two arguments; "
                "the device and the number of loops\n");
        return 2;
    }

    loops = atoi(argv[2]);

    if(!(buf = malloc(secsize))){
        perror("malloc");
        return 1;
    }
    if(((long)buf) % secsize){
        free(buf);
        if(!(buf = malloc(secsize*2 - 1))){
            perror("malloc");
            return 1;
        }
        (long)buf = ((long)buf + secsize - 1) & ~(secsize - 1);
    }
    /* memfill(buf, secsize, "wibble", 6); */
    memset(buf, 'r', secsize);

    if(-1 == (f = open(argv[1], O_RDWR))){
        perror("open");
        return 1;
    }

    rdtsc(before_io.l[0],before_io.l[1]);
    for(i=0;i<loops;++i){
#ifdef PWRITE_WORKS
        if(-1 == pwrite(f, buf, secsize, 0)){
            perror("pwrite");
            return 1;
        }
#else /* PWRITE_WORKS */
        if(-1 == lseek(f, 0, SEEK_SET)){
            perror("lseek");
            return 1;
        }
        if(-1 == write(f, buf, secsize)){
            perror("write");
            return 1;
        }
#endif /* PWRITE_WORKS */
        rdtsc(after_io.l[0],after_io.l[1]);

        duration = (after_io.v - before_io.v) / MHz;
        sum += duration;
        sumsq += duration * duration;

        before_io.v = after_io.v;
    }

    printf("Loops              %-8d\n", loops);
    printf("Total time taken   %-8.4f s\n", sum);
    printf("Average write time %-8.4f ms\n", 1000.0 * sum / loops);
    printf("  (std. dev)       %-8f ms\n", 1000.0 * sqrt(sumsq - sum*sum/loops) / (loops - 1));
    printf("Writes/second      %-8.4f s^-1\n", loops / sum);

    return 0;
}

--dc+cDN39EJAMEtIO--
