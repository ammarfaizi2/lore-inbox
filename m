Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTFFMED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFFMED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:04:03 -0400
Received: from smtp.wp.pl ([212.77.101.161]:18736 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S261280AbTFFMD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:03:59 -0400
Message-ID: <002f01c32c26$18c85f30$010110ac@uran238>
From: "MarKol" <markol4@wp.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
Date: Fri, 6 Jun 2003 14:20:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since I was an initiator of this topic on one of the Polish Linux groups
I'd like to explain some issues. We've been porting some larger piece of
software from Solaris to Linux and problem has arisen. Below is
corrected
example (with errors checking after function calls), where isolated
problem
is presented. I hope this will cut off any suggestions that some of
function
calls return errors which aren't detected and handled.

An experiment shows that there is no error occurrences while running
these
examples on Linux and sender blocks on sendto() (after sending
_successfully_
some datagrams to the receiver) when select() returns with ready to
write descriptor.

The same example works _correct_ on Solaris and QNX (sender blocks on
select() call and _never_ on sendto() ).

Question is:
Am I doing something wrong or maybe there is a bug in select() function
under Linux?



/* ---------- start: sender source ----------- */
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

int                 socketUn;
struct sockaddr_un  addrUn;
int                 lenUn;
char                datagram[2000];
int                 dgramCounter = 0;
fd_set              writeFdToWatch;


void sockInit(void);


int main(){
  sockInit();

  while(1) {
    FD_ZERO(&writeFdToWatch);
    FD_SET(socketUn, &writeFdToWatch);

    printf("slct:"); fflush(stdout);
    int retval = select(socketUn+1, (fd_set *)NULL,
                        &writeFdToWatch,(fd_set *)NULL,
                        (struct timeval *)NULL);

    if (retval==-1){       // select returned error
      perror("select() : "); exit(-1);
    }else if (retval==0){  // timeout or another wakeup reason
      printf("????\n"); fflush(stdout);
    }else{                 // there are ready descriptors
      if ( FD_ISSET(socketUn, &writeFdToWatch) ) {
        printf("sndt:"); fflush(stdout);
        int size = sendto(socketUn, &datagram, sizeof(datagram),
                          0, (struct sockaddr *)&addrUn, lenUn);
        if (size == -1){
          perror("sendto() : "); exit(-1);
        }else if ( size!=sizeof(datagram) ){
          perror("sendto() - size incorrect : "); exit(-1);
        }
        printf("sent - %3d\n", ++dgramCounter); fflush(stdout);
      }else{               // disaster??
        printf("????\n"); fflush(stdout);
      }
    }
  }
  return 0;
}

void sockInit(void) {
  socketUn = socket(AF_UNIX, SOCK_DGRAM, 0);
  if (socketUn == -1){
    perror("socket() : "); exit(-1);
  }
  addrUn.sun_family = AF_UNIX;
  strcpy(addrUn.sun_path, "/tmp/tempUn");
  lenUn = strlen(addrUn.sun_path) + sizeof(addrUn.sun_family);
}
/* ---------- end: sender source ----------- */

/* ---------- start: receiver source ----------- */
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

int                 socketUn;
struct sockaddr_un  addrUn;
int                 lenUn;
int                 size;
char                datagram[2000];

void sockInit(void);

int main() {
  sockInit();

  while(1) {
    printf("Sleep ...\n");
    sleep(15);

    do {
      size = recvfrom(socketUn, &datagram, sizeof(datagram), 0,
                      (struct sockaddr*)NULL, (socklen_t *)NULL);
      if (size == -1){
        if (errno != EAGAIN){ // there is no data available now
          perror("recvfrom() : ");  exit(-1);
        }
        break;
      }else if ( size != sizeof datagram ){
        perror("recvfrom() - size : ");  exit(-1);
      }
      printf ("Ok:"); fflush(stdout);
    }
    while( size!=-1 );
  }
}


void sockInit(void) {
  if ( unlink("/tmp/tempUn") == -1 ){
    perror("unlink() : ");
  }

  socketUn = socket(AF_UNIX, SOCK_DGRAM, 0);
  if (socketUn == -1){
    perror("socket() : "); exit(-1);
  }

  addrUn.sun_family = AF_UNIX;

  strcpy(addrUn.sun_path, "/tmp/tempUn");
  lenUn = strlen(addrUn.sun_path) + sizeof(addrUn.sun_family);
  if ( bind(socketUn, (struct sockaddr *)&addrUn, lenUn) == -1 ){
    perror("bind() : "); exit(-1);
  }

  if ( fcntl(socketUn, F_SETFL, O_APPEND|O_NONBLOCK) == -1 ){
    perror("fcntl() : "); exit(-1);
  }
}
/* ---------- end: receiver source ----------- */

PS.
You should run receiver before sender in order to perform this test
successfully

Regards
--
Marek Kolacz

