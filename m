Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSBMWNL>; Wed, 13 Feb 2002 17:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSBMWNC>; Wed, 13 Feb 2002 17:13:02 -0500
Received: from linux.viasys.com ([194.100.28.130]:12045 "HELO linux.viasys.com")
	by vger.kernel.org with SMTP id <S289010AbSBMWMx>;
	Wed, 13 Feb 2002 17:12:53 -0500
Date: Thu, 14 Feb 2002 00:12:42 +0200
From: Ville Herva <vherva@viasys.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, Mark Cooke <mpc@star.sr.bham.ac.uk>,
        jfr@viasys.com
Subject: Re: Quick question on Software RAID support.
Message-ID: <20020214001242.A14015@viasys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020213225449.B10409@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I'd like to try that, too, so if you can send me the program ...

I run it on /dev/md0 (which consists of one hd on each HPT370 channel).  
You can also do it for /dev/hd{e,g} in parallel - the effects are pretty
much the same. To make it trigger easier, try "ping -f -s 64000" on
background and stress scsi system if you have one. I think any pci load
affects it, but I found 3c905b network load by far the easiest way to
trigger the bug (I even got OOPSes if 3c905b was in certain slot while
doing that.)

Oh, and please excuse the state of the code - it was meant as a quick hack
only...

--
Ville Herva            vherva@viasys.com             +358-50-5164500
Viasys Oy              Hannuntie 6  FIN-02360 Espoo  +358-9-2313-2160
PGP key available: http://www.iki.fi/v/pgp.html  fax +358-9-2313-2250

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="wrchk.c"
Content-Transfer-Encoding: 8bit

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
//#include <fcntl.h>
#include <asm/fcntl.h>
                     
#define KB (1024)
#define MB (1024 * KB)
#define GB (1024 * MB)

int main(int argc, char** argv)
{
    char* dev = "/tmp/jöötti";
    unsigned long long blocksz = 64*MB;
    unsigned long long maxs = 0;
    unsigned iter = 0;
    const unsigned long long qgiga = 1024 * 1024 * 1024 / 4;
    
    char *buffer1, *buffer2;
    int i;
    int devfd;
    int err = 0;
    char ch;
    int round = 0;

    if (argc > 1) dev = argv[1];
    if (argc > 2) maxs = (long long)atoi(argv[2]) * (long long)MB;
    if (argc > 3) blocksz = (long long)atoi(argv[3]) * (long long)MB;
    if (argc > 4) iter = atoi(argv[4]);

    fprintf(stderr, "This test WILL RUIN THE CONTENTS OF %s!\n", dev);
    fprintf(stderr, "Are you 120%% sure you want to do this [Y/N] ? ");
    scanf("%c", &ch);
    fprintf(stderr, "\n");
    if (ch != 'Y') 
    {
       fprintf(stderr, "exiting.\n");
       exit(13);
    }

    fprintf(stderr, "testing %s, max size %llu, block size=%u...\n", 
            dev, maxs, blocksz);

    buffer1 = malloc(blocksz);
    buffer2 = malloc(blocksz);
    if (!buffer1 || !buffer2) 
    {
        perror("malloc failed");
        exit(1);
    }
    for (i = 0; i < blocksz; i++)
        buffer1[i] = (i + rand()) % 256;

    for (round = 0; round < iter || iter == 0; round++)
    {
        unsigned long long nwritten = 0, nread = 0;
        int nr = 0;
        time_t t = time(NULL);

        devfd = open(dev, O_LARGEFILE | O_WRONLY | O_TRUNC | O_CREAT);
        if (devfd < 0)
        {
           perror("open device failed");
           exit(1);
	}

        lseek64(devfd, 0, SEEK_SET);

	while ((nr = write(devfd, buffer1, blocksz)) > 0)
	{
	    nwritten += nr;
	    if (nwritten % qgiga == 0) fprintf(stderr, ".");
	    if (nwritten % (qgiga * 20) == 0) fprintf(stderr, "%lluG", nwritten / (qgiga * 4));
            if (maxs && nwritten > maxs) break;
	}
	fprintf(stderr, "\n");	

        fprintf(stderr, "round %i: Wrote %llu bytes, %2.1f MB/s.\n",
                round, nwritten,
		(float)nwritten / 1024.0 / 1024.0 / (float)(time(NULL) - t));

        close (devfd);

        devfd = open(dev, O_LARGEFILE | O_RDONLY);
        if (devfd < 0)
        {
           perror("open device failed");
           exit(1);
	}
        lseek64(devfd, 0, SEEK_SET);
        t = time(NULL);

	while ((nr = read(devfd, buffer2, blocksz)) > 0)
        {
             if (nr < 0)
             {
                perror("read");
                exit(-2);
             }
             if (memcmp(buffer1, buffer2, nr))
             {
                int l, erbytes = 0, erbytes2 = 0, erbytes3 = 0, l2;
                err++;
                for (l = 0; l < nr; l++)
                    if (buffer1[l] != buffer2[l])
                          erbytes++;
                for (l = 0; l < nr; l++)
                    if (buffer1[l] != buffer2[l])
                          erbytes2++;
                for (l = 0; l < nr; l++)
                    if (buffer1[l] != buffer2[l])
                          erbytes3++;
                fprintf(stderr, "\n%llu byte block at %llu DIFFERS in %i/%i/%i bytes (read %i)!\nFirst 50 bytes:\n",
                        blocksz, nread, erbytes, erbytes2, erbytes3, nr);

                for (l = l2 = 0; l < nr && l2 < 50; l++)
                    if (buffer1[l] != buffer2[l])
                    {
                          fprintf(stderr, "at %8i: %02x vs %02x\n", 
                                  l, (unsigned char)buffer1[l], (unsigned char)buffer2[l]);
                          l2++;
                    }
             }

             nread += nr;

 	     if (nread % qgiga == 0) fprintf(stderr, ".");
 	     if (nread % (qgiga * 20) == 0) fprintf(stderr, "%lluG", nread / (qgiga * 4));
             if (maxs && nread > maxs) break;
        }
	fprintf(stderr, "\n");	

        fprintf(stderr, "round %i: Read %llu bytes, %2.1f MB/s.\n",
                round, nread,
		(float)nread / 1024.0 / 1024.0 / (float)(time(NULL) - t));
		
	close(devfd);
    }

    close(devfd);
    free(buffer1);
    free(buffer2);

    return err;
}

--GvXjxJ+pjyke8COw--
