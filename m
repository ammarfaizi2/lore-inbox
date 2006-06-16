Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWFPGez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWFPGez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWFPGez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:34:55 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:12233 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751093AbWFPGey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:34:54 -0400
From: Janne Karhunen <Janne.Karhunen@gmail.com>
To: Peter Staubach <staubach@redhat.com>
Subject: Re: NFSv3 client reordering RENAMEs
Date: Fri, 16 Jun 2006 09:25:50 +0300
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606151638.15792.Janne.Karhunen@gmail.com> <200606151754.33384.Janne.Karhunen@gmail.com> <44918545.2090002@redhat.com>
In-Reply-To: <44918545.2090002@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v7kkEmvhe0RpBw7"
Message-Id: <200606160925.51332.Janne.Karhunen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_v7kkEmvhe0RpBw7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 15 June 2006 19:05, Peter Staubach wrote:

> >Possibly .. if someone first acks that this indeed would be
> >considered as bug and not as a feature :/
>
> Yes, I believe that this would be considered to be a bug...

Looks that this is a vendor kernel issue, couldn't get it to
barf on mainline. Without any more knowledge of the extent 
of the problem testcase attached. Given that you suffer from
the problem you should occasionally see files vanishing.


-- 
// Janne

--Boundary-00=_v7kkEmvhe0RpBw7
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test.c"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <pthread.h>
#include <stdlib.h>

#ifndef ROTATION_CYCLE
#define ROTATION_CYCLE 60
#endif

char*     str = "Quick brown fox jumped over lazy dog %d\n";
char      buf[50] = { 0 };
int       rl=1;
int       rr=1;
pthread_t thr[2];

void* logger_thread ( void* ptr ) {
  int i=0, r, fd;

  fd = open ( "/mnt/nfs/file", O_RDWR|O_CREAT, 00600 );
  printf ( "logger starting, fd %d\n", fd );

  if ( fd <= 0 ) {
    printf ("%s\n", strerror(errno));
    return NULL;
  }
  while ( rl ) {
    r = sprintf ( &buf[0], str, i );
    r = write ( fd, &buf[0], strlen(&buf[0]) );
    if ( r <= 0 ) {
      printf ("\n\n%s\n", strerror(errno));
      goto exit;
    }
    i++;
    usleep ( 10000 );
  }
exit:
  printf ("logger exiting\n");
  close (fd);
  return NULL;
}

void* logrotate_thread ( void* ptr ) {
  int r;

  printf ( "rotater starting\n" );
  while ( rr ) {
    sleep(ROTATION_CYCLE);

    r = system ( "mv /mnt/nfs/file.4 /mnt/nfs/file.5" );
    r = system ( "mv /mnt/nfs/file.3 /mnt/nfs/file.4" );
    r = system ( "mv /mnt/nfs/file.2 /mnt/nfs/file.3" );
    r = system ( "mv /mnt/nfs/file.1 /mnt/nfs/file.2" );
    r = system ( "mv /mnt/nfs/file /mnt/nfs/file.1" );
    rl=0;
    sleep(2);
    rl=1;
    pthread_create ( &thr[1], 0, logger_thread, 0 );
  }
  printf ( "rotater exiting\n" );
  return NULL;
}

int main ( int a, char** b ) {
  pthread_create ( &thr[0], 0, logrotate_thread, 0 );
  pthread_create ( &thr[0], 0, logger_thread, 0 );

  while ( 1 )
    usleep ( 100000 );
  return 0;
}


--Boundary-00=_v7kkEmvhe0RpBw7--
