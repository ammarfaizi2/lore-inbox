Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBGHag>; Wed, 7 Feb 2001 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129173AbRBGHa1>; Wed, 7 Feb 2001 02:30:27 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:60681 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129138AbRBGHaM>; Wed, 7 Feb 2001 02:30:12 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Feb 2001 08:30:07 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: having a hard time with 2.4.x
Message-ID: <3A810780.15805.1C14E0@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some news on the topic of timekeeping in Linux-2.4:

As Alan Cox pointed out the ACPI changes between 2.4.0 and 2.4.1 created a 
extremely slow console output (if not more). Configuring away ACPI support 
solved that problem.

However there is still a problem that I cannot explain. I wrote a test program 
for my modified kernel (I did not try the original one). I'll include the 
program plus results (if you want to see the patch go to 
ftp.kernel.org/pub/linux/daemons/ntp/PPS and get PPS-2.4.0-pre3.tar.bz2 (patch 
plus signature)):

#include	<time.h>
#include	<stdio.h>
#define	NTP_NANO
#include	<sys/timex.h>

int	main()
{
	struct timex	tx;
	long		lastns = 0;

	tx.modes = 0;
	while(1)
	{
		adjtimex(&tx);
		printf("%d %d %d\n",
		       tx.time.tv_sec, tx.time.tv_nsec,
		       tx.time.tv_nsec - lastns);
		lastns = tx.time.tv_nsec;
		fflush(stdout);
	}
}
/*----------------------------------------------------------------------
The following anomalies were examined by running the program for a few
seconds, redirecting output into a file:
981488742 428870884 428870884
981488742 429242679 371795
981488742 429258279 15600
981488742 429266001 7722
981488742 429273781 7780
981488742 429281142 7361
...this is just the startup, filling the caches; 7us seems acceptable
981488742 442133766 7235
981488742 442155740 21974
981488742 442164248 8508
981488742 442171719 7471
... some occasional jitter seems acceptable, too
981488742 451557086 7280
981488742 451564393 7307
981488742 461600593 10036200
981488742 461609928 9335
981488742 461617263 7335
...here we lost 10ms, possibly due to scheduling
981488742 991589894 7317
981488742 991597171 7277
981488743 1628395 -989968776
981488743 1636937 8542
...the new second seems to begin a bit early; I'm missing about 8ms
981488743 991650854 7411
981488743 991658147 7293
981488744 1724546 -989933601
981488744 1732344 7798
...this is quite reproducible
981488751 294943079 7327
981488751 294950364 7285
981488751 294957703 7339
981488751 294964994 7291
981488751 294964995 1
981488751 294964996 1
981488751 294964997 1
981488751 294964998 1
981488751 294964999 1
...here something strange happened: time refused to advance, forcing
...the code to generate synthetic time (add 1ns). Here comes the end:
981488751 294967294 1
981488751 294967295 1
981488747 0 -294967295
981488747 37804096 37804096
981488747 37811711 7615
981488747 37819006 7295
...time went back by four seconds! This happened again:
981488752 294967292 1
981488752 294967293 1
981488752 294967294 1
981488752 294967295 1
981488748 0 -294967295
981488748 100304297 100304297
981488748 100311973 7676
981488748 100319231 7258
...but sometimes the second overflows correctly:
981488748 999987866 7315
981488748 999995152 7286
981488749 2417 -999992735
981488749 9995 7578
981488749 17227 7232
...
981488749 999991971 30023
981488750 747 -999991224
981488750 8405 7658
981488750 15531 7126

Here is a simplified sample with microseconds instead, after having removed
two spinlocks (as they are in 2.2.18):

981487863 665701 665701
981487863 666048 347
981487863 666062 14
981487863 666071 9
981487863 666078 7
...start as usual
981487863 668825 7
981487863 668832 7
981487863 668855 23
981487863 668863 8
...some jitter
981487863 673861 7
981487863 673869 8
981487863 673876 7
981487863 683930 10054
981487863 683938 8
981487863 683946 8
...and scheduling
981487863 993871 8
981487863 993879 8
981487864 3905 -989974
981487864 3913 8
981487864 3920 7
...we still lack 10ms during overflow...
981487869 293860 7
981487869 293867 7
981487869 293875 8
981487869 293875 0
981487869 293875 0
...then time also refuses to advance
981487869 293941 0
981487869 293941 0
981487866 28937 -265004
981487866 28946 9
981487866 28954 8
...eventually loosing a few seconds

Possible explanation for negative time: 2^32/500000000 == 8.5,
i.e. the low 32bit of the TSC will overflow every 8.5 seconds on a
500MHz CPU, probably causing a bad interpolation between ticks.
But: Why doesn't the effect occur with kernel 2.2??? 

 *----------------------------------------------------------------------*/

Regards,
Ulrich
P.S.: I'm not subscribed here, so CC: is appreciated.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
