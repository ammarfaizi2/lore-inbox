Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317909AbSFNNHk>; Fri, 14 Jun 2002 09:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317910AbSFNNHj>; Fri, 14 Jun 2002 09:07:39 -0400
Received: from guardian.hermes.si ([193.77.5.150]:44813 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP
	id <S317909AbSFNNHh>; Fri, 14 Jun 2002 09:07:37 -0400
Message-ID: <FED7EB450413D511ABC100B0D0211732064F7725@hal9000.hermes.si>
From: Tomaz Susnik <tomaz.susnik@hermes.si>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 kernel lseek() bug
Date: Fri, 14 Jun 2002 15:07:33 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] 	Problem description 
----------------------------------

 	a call to lseek() fails with EINVAL under the following conditions:
		- it is called on a disk device file
		- required offset is larger than the target disk device size


[2] 	Kernel version
---------------------------
	This problem seems to be limited to version 2.4.18
	I tested also on kernel 2.4.2 but everythng works fine there.

[3] 	Reproducing the problem
-----------------------------------------

	Compile the following program (lseektest.c):

	#define _LARGEFILE64_SOURCE 
	#define _FILE_OFFSET_BITS 64  
	#include <unistd.h>
	#include <sys/types.h>
	#include <sys/stat.h>
	#include <fcntl.h>
	#include <errno.h>

	main(int argc, char *argv[])
	{
	    int fd;
	    int i;
	    off_t ret;

	    printf("Attempting to seek through file %s \n", argv[1]);
	    fd = open(argv[1], O_RDONLY | O_NONBLOCK, 0);
	    printf("Executed file open. errno = %d\n", errno);
    
	    for (i=1; i<10; i++ )
	    {
	        errno = 0;
	
	        ret = lseek (fd, (off_t)1024 *(off_t)1024 *(off_t)1024
*(off_t)i, SEEK_SET);
	        printf("lseek(%i Gb     ): errno = %i ret = %lli\n", i,
errno, ret );

	    };
	    close (fd);
	}
	

	Run it with 1 parameter being an existing disk device file. For
example:

	./lseektest /dev/hda3


	Sample output on a machine with kernel 2.4.2, displaying the CORRECT
behaviour
	(/dev/hda3 is a device file repersenting disk image of size 7517151
kb):

	Attempting to seek through file /dev/hda3 

	Executed file open. errno = 0
	lseek(1 Gb     ): errno = 0 ret = 1073741824
	lseek(2 Gb     ): errno = 0 ret = 2147483648
	lseek(3 Gb     ): errno = 0 ret = 3221225472
	lseek(4 Gb     ): errno = 0 ret = 4294967296
	lseek(5 Gb     ): errno = 0 ret = 5368709120
	lseek(6 Gb     ): errno = 0 ret = 6442450944
	lseek(7 Gb     ): errno = 0 ret = 7516192768
	lseek(8 Gb     ): errno = 0 ret = 8589934592
	lseek(9 Gb     ): errno = 0 ret = 9663676416

	
	Sample output on the same machine, but booted with kernel 2.4.18:

	Attempting to seek through file /dev/hda3 

	Executed file open. errno = 0
	lseek(1 Gb     ): errno = 0 ret = 1073741824
	lseek(2 Gb     ): errno = 0 ret = 2147483648
	lseek(3 Gb     ): errno = 0 ret = 3221225472
	lseek(4 Gb     ): errno = 0 ret = 4294967296
	lseek(5 Gb     ): errno = 0 ret = 5368709120
	lseek(6 Gb     ): errno = 0 ret = 6442450944
	lseek(7 Gb     ): errno = 0 ret = 7516192768
	lseek(8 Gb     ): errno = 22 ret = -1
	lseek(9 Gb     ): errno = 22 ret = -1



[5] 	Special NOTE
---------------------------
	Improper behaviour was noticed on device files only. When "normal"
files 
	are in question, everything seems to be fine.


[6] 	Reason for reporting this problem
---------------------------------------------------
	Our multi-platform backup product relies on proper behaviour of the
lseek() 
	command to calculate a rawdisk size.

	
[7]	Submitter
----------------------
	Tomaz Susnik, Hermes SoftLab, Slovenia
	tomaz.susnik@hermes.si
	




