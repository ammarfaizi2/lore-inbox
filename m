Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBNNNy>; Wed, 14 Feb 2001 08:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbRBNNNo>; Wed, 14 Feb 2001 08:13:44 -0500
Received: from allman.localnet.com ([207.251.201.40]:7316 "EHLO
	allman.localnet.com") by vger.kernel.org with ESMTP
	id <S129137AbRBNNNh>; Wed, 14 Feb 2001 08:13:37 -0500
Message-ID: <3A8A850B.29CDAC50@localnet.com>
Date: Wed, 14 Feb 2001 08:15:55 -0500
From: Allen Barnett <barnett@localnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Parallel Printer in 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code worked OK in kernel 2.2 for talking to an HP printer connected
to a parallel port:
----------------------------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define UEL "\033%%-12345X"
#define COMMAND1 "@PJL INFO CONFIG\r\n"
#define COMMAND2 "@PJL INFO VARIABLES\r\n"

int main ( int argc, char* argv[] )
{
  char buffer[33];
  int i, n;

  int fd = open( "/dev/lp0", O_RDWR | O_SYNC );

  write( fd, UEL, strlen(UEL) );
  write( fd, COMMAND1, strlen(COMMAND1) );
  write( fd, COMMAND2, strlen(COMMAND2) );
  write( fd, UEL, strlen(UEL) );

  usleep( 4000000 ); /* Wait for the printer to digest the command */

  /* Once for each command */
  for ( i=0; i<2; i++ ) {
    while ( n = read( fd, buffer, sizeof(buffer)-1 ) ) {
      buffer[n] = '\0';
      printf( "%s", buffer );
    }
  }

  close( fd );
}
---------------------------------------------------------------
The output from *each* PJL INFO command was treated by the kernel as one
string and read() returned 0 after all the bytes of one INFO command
were read (thus the for loop over 2).

Under 2.4.0, after the returned data from the first INFO command is
read, the second read() command hangs. The kernel produces syslog
messages like:

parport0: No more nibble data (15 bytes)
parport0: Nibble timeout at event 9 (0 bytes)

Is this a bug or is there a new (or better) procedure for reading data
through the lp device in 2.4?

Thanks,
Allen
