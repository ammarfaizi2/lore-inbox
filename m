Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVKUVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKUVMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKUVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:12:44 -0500
Received: from ylpvm53-ext.prodigy.net ([207.115.57.84]:20166 "EHLO
	ylpvm53.prodigy.net") by vger.kernel.org with ESMTP
	id S1750721AbVKUVMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:12:43 -0500
Message-ID: <438238DE.2060503@softplc.com>
Date: Mon, 21 Nov 2005 15:15:10 -0600
From: Dick Hollenbeck <dick@softplc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: serial port FIONREAD from realtime thread
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem Conditions:

1) linux 2.6.11.7, but is probably otherplaces too
1) realtime thread
2) serial port open()ed *either* with NON_BLOCKING or not
3) ioctl( FIONREAD ) always returns zero

int ncharin;
ioctl( fd, FIONREAD, &ncharin )

The above lines of code operate incorrectly from a real time thread on a 
normal PC serial port.  They ncharin is always set to zero if called 
from a loop.  The work around is to block the calling realtime thread 
with a sleep of some kind.  Said workaround is ugly.  Need this to work 
from a realtime thread.

The program below illustrates the problem, but requires two computers.  
On one computer run minicom and connect an RS-232 cross over cable to 
the test box (at COM2, per the test source).  Compiler and run the 
program below on the test box.  Set minicom to 38400 kbaud to match the 
baudrate in the program below.  Compile test program.  Run the test 
program as root so it can escalate the priority to realtime.

It will only run for 20 seconds, while it's running, you should send 
characters from minicom to the test box and you will see the buffered 
count of characters increment by 1.  That is how it is supposed to 
work.  Then comment out the usleep() call and recompile and do the same 
test again.  Here you see the test program does not operate properly.  
The buffered character count remains at 0.     What causes this?  Where 
do I patch?

-----------------------------------

#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/serial.h>
#include <sched.h>
#include <time.h>

int fd;

int openPort();
void setRealtimePriority();


int main( int argc, char** argv )
{
    int         ncharin;
    int         last;
    time_t      start;
   
    if( openPort() != 0 )
    {
        fprintf( stderr, "unable to open port\n" );
        exit(1);
    }
   
    setRealtimePriority();
   
    // poll the FIONREAD and print the number of chars in the recv buffers

    start = time(NULL);   

    // run only for 20 seconds, since realtime priority steals cpu from 
consoles.
    while( time(NULL) - start < 20 )
    {
        if( -1 == ioctl( fd, FIONREAD, &ncharin ) )
        {
            printf( "error from ioctl\n" );
            ncharin = 0;
        }

        // if this line is commented out, then ioctl FIONREAD does not work.
        usleep(1);
   
        if( last != ncharin )
        {
            // this should show a monotonically increasing number of 
characters.
            printf(" %d", ncharin );
       
            fflush(stdout);
           
            last = ncharin;
        }
    }
}


int openPort()
{
    struct termios     t;

    /*  The O_NDELAY flag tells UNIX that this program doesn't care what
        state the DCD signal line is in - whether the other end of the port
        is up and running. If you do not specify this flag, your process 
will
        be put to sleep until the DCD signal line is the space voltage.
    */
    fd = open( "/dev/ttyS1", O_RDWR
                            | O_NDELAY
                            | O_NOCTTY );

    if( fd == -1 )
        return -1;

    memset( &t, 0, sizeof(t) );

    cfsetispeed( &t, B38400 );
    cfsetospeed( &t, B38400 );

    // Enable the receiver and set local mode...
    //  CLOCAL  : local connection, no modem contol
    //  CREAD   : enable receiving characters
    t.c_cflag |= (CLOCAL | CREAD);

    t.c_cflag &= ~CSTOPB;

    t.c_cflag &= ~CSIZE;    // Mask the character size bits
    t.c_cflag |= CS8;       // Select 8 data bits

    t.c_cflag &= ~PARENB;
    t.c_cflag &= ~CSTOPB;

    // Raw input is unprocessed.
    // Input characters are passed through exactly as they are received,
    // when they are received. Generally you'll deselect the ICANON, ECHO,
    // ECHOE, and ISIG options when using raw input:
    t.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);

    // Raw output is selected by resetting the OPOST option in the  
c_oflag member:
    t.c_oflag &= ~OPOST;

    t.c_cc[VMIN]  = 1;
    t.c_cc[VTIME] = 0;

    // Set the new options for the port...
    tcsetattr( fd, TCSANOW, &t );

    return 0;
}



void setRealtimePriority()
{
    int ec;

    printf("setRealtimePriority()\n");
   
    struct sched_param     p;

    memset( &p, 0, sizeof(p) );

    p.sched_priority = 2;

    ec = sched_setscheduler( 0, SCHED_RR, &p );
    if( ec != 0 )
    {
        fprintf(stderr, "pthread_setschedparam ec=%d, %s\n", ec, 
strerror(ec) );
        fflush(stderr);
        exit(2);
    }
}


