Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbRBWVTo>; Fri, 23 Feb 2001 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbRBWVTe>; Fri, 23 Feb 2001 16:19:34 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:57359 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129129AbRBWVTX>; Fri, 23 Feb 2001 16:19:23 -0500
Date: Fri, 23 Feb 2001 22:18:56 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mason@suse.com
Subject: reiserfs: still problems with tail conversion
Message-ID: <20010223221856.A24959@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am running linux-2.4.2-pre4 with Chris Mason's tailconversion bug fix
applied, but I still have problems with null bytes in files. I wrote a
little test program that clearly shows the problem:


/* reisertest.c: test for tailconversion bug in reiserfs
 *
 * Compile with: gcc -O2 -o reisertest reisertest.c
 */
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define MAXBYTES	8192

int main(int argc, char *argv[])
{
	int fd;
	int i;
	char name[32];
	char buf[MAXBYTES];
	char check[MAXBYTES];
	
	memset(buf, 0x55, MAXBYTES);

	fprintf(stderr, "Creating %d files ... ", MAXBYTES);

	for(i = 0; i < MAXBYTES; i++) {
		sprintf(name, "reiser-%05d.test", i);
		fd = open(name, O_WRONLY | O_CREAT, 0644);
		write(fd, buf, i);
		close(fd);
	}

	fprintf(stderr, "done\n");
	fprintf(stderr, "Appending to the files ... ");	

	for(i = 0; i < MAXBYTES; i++) {
		sprintf(name, "reiser-%05d.test", i);
		fd = open(name, O_WRONLY | O_APPEND);
		write(fd, buf, MAXBYTES - i);
		close(fd);
	}

	fprintf(stderr, "done\n");
	fprintf(stderr, "Checking files for null bytes ...\n");

	for(i = 0; i < MAXBYTES; i++) {
		sprintf(name, "reiser-%05d.test", i);
		fd = open(name, O_RDONLY);
		read(fd, check, MAXBYTES);
		if(memcmp(buf, check, MAXBYTES) != 0) 
			fprintf(stderr, "  %s contains null bytes\n", name);
	}

	fprintf(stderr, "Checking done\n");

	return 0;
}


When I run this on a reiserfs partition, I get output like this:


erik@arthur:~/reisertest/foo> ../reisertest
Creating 8192 files ... done
Appending to the files ... done
Checking files for null bytes ...
  reiser-00193.test contains null bytes
  reiser-00220.test contains null bytes
  reiser-00256.test contains null bytes
  reiser-00289.test contains null bytes
  reiser-00329.test contains null bytes
  reiser-00338.test contains null bytes
  reiser-00374.test contains null bytes
  reiser-00407.test contains null bytes
  reiser-00415.test contains null bytes
  reiser-00430.test contains null bytes
  reiser-00438.test contains null bytes
  reiser-00445.test contains null bytes
  reiser-00459.test contains null bytes
  reiser-00481.test contains null bytes
  reiser-00501.test contains null bytes
  reiser-00508.test contains null bytes
  reiser-00521.test contains null bytes
  reiser-00534.test contains null bytes
  reiser-00558.test contains null bytes
  reiser-00577.test contains null bytes
  reiser-00583.test contains null bytes
  reiser-00600.test contains null bytes
  reiser-00606.test contains null bytes
  reiser-00612.test contains null bytes
  reiser-00623.test contains null bytes
  reiser-00634.test contains null bytes
  reiser-00645.test contains null bytes
  reiser-00665.test contains null bytes
  reiser-00685.test contains null bytes
  reiser-00730.test contains null bytes
  reiser-00735.test contains null bytes
  reiser-00740.test contains null bytes
  reiser-00745.test contains null bytes
  reiser-00750.test contains null bytes
  reiser-00759.test contains null bytes
  reiser-00764.test contains null bytes
  reiser-00773.test contains null bytes
  reiser-00778.test contains null bytes
  reiser-00787.test contains null bytes
  reiser-00796.test contains null bytes
  reiser-00805.test contains null bytes
  reiser-00814.test contains null bytes
  reiser-00866.test contains null bytes
  reiser-00915.test contains null bytes
  reiser-00930.test contains null bytes
  reiser-00934.test contains null bytes
  reiser-00938.test contains null bytes
  reiser-00942.test contains null bytes
  reiser-00946.test contains null bytes
  reiser-00950.test contains null bytes
  reiser-00954.test contains null bytes
  reiser-00958.test contains null bytes
  reiser-00965.test contains null bytes
  reiser-00969.test contains null bytes
  reiser-00973.test contains null bytes
  reiser-00977.test contains null bytes
  reiser-00984.test contains null bytes
  reiser-00988.test contains null bytes
  reiser-00995.test contains null bytes
  reiser-00999.test contains null bytes
  reiser-01006.test contains null bytes
  reiser-01010.test contains null bytes
  reiser-01017.test contains null bytes
Checking done


Running the test a couple of times doesn't really show a pattern,
sometimes the same files contains null bytes, sometimes others do. The
files with null bytes seem to be with index < 1024.

I did the same test with an ext2 filesystem, but didn't see any error.
System is SuSE 7.0, compiler gcc-2.95.2.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
