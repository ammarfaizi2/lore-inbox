Return-Path: <linux-kernel-owner+w=401wt.eu-S965046AbWLOCg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWLOCg5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 21:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWLOCg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 21:36:57 -0500
Received: from smtp.saahbs.net ([70.235.213.234]:34700 "HELO smtp.saahbs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965046AbWLOCg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 21:36:57 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 21:36:56 EST
Date: Thu, 14 Dec 2006 20:30:14 -0600
From: Michal Sabala <lkml@saahbs.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 mmap hangs unrelated apps
Message-ID: <20061215023014.GC2721@prosiaczek>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

I am observing processes entering uninterruptible sleep apparently due
to an unrelated application using mmap over nfs. Applications in
"uninterruptible sleep" hang indefinitely while other applications
continue working properly.

The code causing the mmap nfs hangs does the following:
(as replicated by the included test-mmap.c file)

  1. create file on nfs (file_A, descr_A)
  2. make file_A a sparse 200MB file
  3. mmap descr_A
  4. close descr_A
  5. unlink file_A
  6. memcpy 200MB to mmaped buffer
  7. create a second file on nfs (file_B, descr_B)
  8. write() 200MB from mmaped buffer to descr_B
  9. close descr_B
  10. munmap first file

This code may need to be ran tens to hundred runs to trigger the condition.

During the execution of the above code, unrelated applications enter
uninterruptible sleep (D) - usually firefox2.0, Xorg/XFree86, gimp2.2, gconfd
or bash; probably the most active processes.

`dmesg` shows nothing of interest.

`free` shows anywhere between 1MB and 80MB of memory still remaining
free when the problem occurs.

`cat /proc/*PID*/wchan` for all hanging processes contains page_sync.

* Client Setups:

  Linux 2.6.18 debian kernel (not tainted)
  Intel P3/800
  512MB ram
  0 swap
  NFS root (rw,noatime,rsize=8192,wsize=8192,nfsvers=3,hard,lock,udp)
  NIC: 100mbit tulip Cardbus
  NFS server is Linux 2.6.8 (debian)
  Gnome running with ooffice, gimp2.2 and firefox2 open

  and

  Linux 2.6.18 debian kernel (not tainted)
  Intel P4/2.8
  mem=192M boot option
  0 swap
  NFS home (rw,nosuid,rsize=8192,wsize=8192,hard)
  NIC: 100mbit e100 PCI
  NFS server is Apple OSX 10.3
  Gnome running with ooffice, gimp2.2 and firefox2 open

This happens with NFS servers based on Linux 2.6.8 and OSX 10.3.x. There
is nothing unusual in the server log files. Other than large nfs mmaps
on limited ram clients, NFS clients are 100% stable (file locking, performance,
6 month uptimes, etc..)

NOTE:
  I also ran the same code on the P4 machine in /tmp (local disk)
and it too caused some applications to enter uninterruptible sleep
(dozens of consecutive runs were needed). As such this looks not to
be directly related to nfs.

I would like to assist in any way I can in tracking this bug. I am open
to running patched kernels, etc...

Thank You,
 Sincerely,

   Michal Sabala



PS. thank you for all the hard work on the Linux kernel.


----------- test-mmap.c: --------------------------------

#include <unistd.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#include <sys/mman.h>

int main (int argc, char * argv[] ){

  char * data = 0;
  int blocks = 12800;
  int bSize = 16384;
  
  char mmapFileName[] = "temp-XXXXXX";
  int mmapFileDes = mkstemp( mmapFileName );
  if ( mmapFileDes == -1 ){
    printf( "cannot make temporary file %s !\n", mmapFileName );
    exit( -1 );
  }

  printf( "using desc %d tempfile %s\n", mmapFileDes, mmapFileName );

  errno = 0;  
  if ( lseek( mmapFileDes, (blocks*bSize)-1, SEEK_SET ) == -1 ){
    if ( errno != 0 ){
	perror ( "lseek error: " );
    }
    printf(  "cannot lseek tempfile %s !\n", mmapFileName);
    close( mmapFileDes );
    unlink( mmapFileName );
    exit( -1 );
  }

  if ( write( mmapFileDes, "X", 1 ) != 1 ){
    printf(  "cannot sparse write tempfile %s !\n", mmapFileName);
    close( mmapFileDes );
    unlink( mmapFileName );
    exit( -1 );
  }

  data = mmap ( NULL, (blocks*bSize), PROT_READ | PROT_WRITE, MAP_SHARED, mmapFileDes, 0 );
  if ( data == (void *) -1 ){
    printf(  "mmap of %s failed!\n", mmapFileName );
    close( mmapFileDes );
    unlink( mmapFileName );
    exit( -1 );
  }

  printf( "block size: %d, blocks num: %d\n", bSize, blocks);

  close( mmapFileDes );
  unlink( mmapFileName );

  int i;
  char * ptr = data;
  for ( i = 1; i <= blocks; i++ ){
    printf( "wrote %d of %d blocks to %s\n", i, blocks, mmapFileName );
    memset( ptr, 0, bSize ); 
    ptr += bSize;
  }

  // msync( data, blocks*bSize, MS_SYNC );

  char destFile[] = "destination-XXXXXX";
  int destDes = mkstemp( destFile );
  if ( destDes == -1 ){
    printf( "cannot make destination file %s !\n", destFile );
    exit( -1 );
  }

  printf( "using desc %d destfile %s\n", destDes, destFile);
 
  ptr = data;
  for ( i = 1; i <= blocks; i++ ){
    int wLen = write( destDes, ptr, bSize );
    printf( "wrote %d of %d blocks to %s\n", i, blocks, destFile );
    if ( wLen != bSize ){
      printf( "debug: short write to %s at %d bytes\n", destFile, wLen );
    }
    ptr += bSize;
  }
  
  close( destDes );
  
  munmap( data, blocks*bSize );

  exit( 0 );
}

-- 
Michal "Saahbs" Sabala
