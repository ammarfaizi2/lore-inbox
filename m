Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTCOINb>; Sat, 15 Mar 2003 03:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTCOINb>; Sat, 15 Mar 2003 03:13:31 -0500
Received: from comtv.ru ([217.10.32.4]:42657 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261323AbTCOIN3>;
	Sat, 15 Mar 2003 03:13:29 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, bzzz@tmi.comex.ru,
       adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
	<m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com>
	<20030314205455.49f834c2.akpm@digeo.com>
	<20030315054910.GN20188@holomorphy.com>
	<20030315062025.GP20188@holomorphy.com>
	<20030314224413.6a1fc39c.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Date: 15 Mar 2003 11:16:10 +0300
In-Reply-To: <20030314224413.6a1fc39c.akpm@digeo.com>
Message-ID: <m3r899yrhx.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> Nope.  What we're trying to measure here is pure in-memory lock
 AM> contention, locked bus traffic, context switches, etc, etc.  To
 AM> do that we need to get the IO system out of the picture.

I simple use own pretty simple test. btw, you may disable preallocation
to increase allocation rate


bash-script:
============================================================
#!/bin/sh

# args:
# 1 - how many processes to create
# 2 - how many blocks in file to be written
# 3 - how many times to repeat (write+truncate)
# for example: cd.sh 2 32 100000

let i=0
while let "i < $1"; do
        if [ ! -d /mnt/$i ]; then
                mkdir /mnt/$i
        fi
        rm -rf /mnt/$i/*
        let "i=i+1"
done

sync
sync

let i=0
while let "i < $1"; do
        time /root/cdsingle $2 $3 /mnt/$i/1 &
        let "i=i+1"
done

wait
============================================================

C programm, which does loop over writes and truncate:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


main (int argc, char ** argv)
{
        int i, j, num, siz, err, k;
        int fd[1024];

        num = atoi(argv[2]);
        siz = atoi(argv[1]);
        
        for (i = 3; i < argc; i++) {
                fd[i] = creat(argv[i], 0666);
                if (fd[i] < 0) {
                        perror("can't create");
                        exit(1);
                }
        }

        for (j = 0; j < num; j++) {
                for (i = 3; i < argc; i++) {
                        for (k = 0; k < siz; k++)
                                if ((err = write(fd[i], main, 4096)) < 0) {
                                        printf("err=%d\n", err);
                                        perror("can't write");
                                        exit(1);
                                }
                }
                for (i = 3; i < argc; i++) {
                        ftruncate(fd[i], 0);
                        lseek(fd[i], 0, SEEK_SET);
                }
        }

        for(i = 3; i < argc; i++) {
                close(fd[i]);
                if (unlink(argv[i]) < 0)
                        perror("can't unlink");
        }
}


