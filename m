Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUGNDhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUGNDhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUGNDhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:37:32 -0400
Received: from dsl-203-113-208-44.QLD.netspace.net.au ([203.113.208.44]:21766
	"EHLO mx.jeeves.gotdns.org") by vger.kernel.org with ESMTP
	id S264815AbUGNDh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:37:28 -0400
From: Ben Hoskings <ben@jeeves.gotdns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Wed, 14 Jul 2004 13:37:24 +1000
User-Agent: KMail/1.6.2
References: <070920041901.1676.40EEEB880003599F0000068C2200763704970A059D0A0306@comcast.net> <20040709190823.GC11106@artselect.com>
In-Reply-To: <20040709190823.GC11106@artselect.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141337.24890.ben@jeeves.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004 05:08, Pete Harlan wrote:
> Reiser3 lets a directory have more than 32000 subdirectories already.
> I ran into this problem two weeks ago on an ext3 filesystem and found
> Reiser didn't have the problem.  My reiser3 directory had 1million+
> subdirs before I killed my test program.
>
> I believe it still has a similar limit on the number of hard links,
> but it doesn't implement ".." as a hard link.
>
> --Pete

I wrote a little test program the other day as well, and experimented with the 
same thing. For interest's sake, my results were as follows.

Interesting to note the differences in time that the operations took. Also, 
although the creation on reiserfs is extremely quick, the unlinking seems to 
be a lot more expensive -- deleting those 1m directories took well over 10 
minutes.

Ben

/* output *******************************************************/
$ mount | grep create-dirs
/dev/hda7 on /mnt/create-dirs type ext3 (rw)
$ time ./create-dirs /mnt/create-dirs/ 40000
--- output removed ---
Bailed out at i = 31997.

real    0m50.412s
user    0m0.292s
sys     0m43.010s


$ mount | grep create-dirs
/dev/hda7 on /mnt/create-dirs type reiserfs (rw)
$ time ./create-dirs /mnt/create-dirs/ 40000
--- output removed ---
Created 40000 dirs. All done.

real    0m2.211s
user    0m0.149s
sys     0m2.041s


$ mount | grep create-dirs
/dev/hda7 on /mnt/create-dirs type reiserfs (rw)
$ time ./create-dirs /mnt/create-dirs/ 1000000
--- output removed ---
Created 1000000 dirs. All done.

real    1m1.159s
user    0m3.677s
sys     0m54.872s


/* create-dirs.c *******************************************************/
#include <cstdio>
#include <cstdlib>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#define LEN 64

int main(int argc, char **argv)
{
    int i, max, ret;
    char path[LEN];
    
    if (argc != 3)
    {
        printf("Two arguments: /path/for/dirs/, number_of_dirs.\n");
        return 1;
    }
    
    max = atoi(argv[2]);
    
    if (max < 1)
    {
        printf("Bad number of dirs.\n");
        return 1;
    }
    
    for (i = 0; i < max; i++)
    {
        snprintf(path, LEN, "%s/%d", argv[1], i);
        
        if (i % 100 == 0)
            printf("\n%d\t", i);
        
        ret = mkdir(path, 0755);
        
        if (ret != 0)
        {
            printf("\nBailed out at i = %d.\n", i);
            return 1;
        }
        
        printf(".");
        fflush(stdout);
    }

    printf("Created %d dirs. All done.\n", max);
}
