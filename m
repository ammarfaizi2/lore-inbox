Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTDGOzD (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTDGOzD (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:55:03 -0400
Received: from franka.aracnet.com ([216.99.193.44]:47042 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263488AbTDGOxq (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:53:46 -0400
Date: Mon, 07 Apr 2003 08:05:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 546] New: Close notification in poll/select never arrives
Message-ID: <2700000.1049727913@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=546

           Summary: Close notification in poll/select never arrives
    Kernel Version: 2.5.65, in general any 2.4.x, 2.5.x kernel, possibly
                    also earlie
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: sampo@symlabs.com


Distribution: any, problem not sensitive or specific to any distribution
Hardware Environment:	reproduces at least on i386, others not tested
Software Environment:	glibc-2.2.5, gcc-2.95.3
		       (Many other combinations reproduce the bug, too. The
			bug is not sensitive to user land config. Its a kernel
			problem.)
History:

  This bug was originally reported by thierry.lelegard@canal-plus.fr
  to linux.kernel under "Subject: PROBLEM: I/O system call never returns
  if file desc is closed in the meantime". Report date was 2001-06-06.

  Thierry tells me that discussion was had back then, but was not constructive
  and died away without the bug being fixed. Not very positive experience
  about open software community's ability to get bugs fixed.

  Thierry resubmitted the bug to comp.os.linux.development.system under
  "Subject: Close notification in poll/select (works on all OS except Linux)"
  on 2003-01-13. He never got an answer. I guess there are a lot of cracks
  and this one is falling through one of them.

  I have hit the very same problems as Thierry and have verified his bug
  report to be factually correct. I used 2.6.65 kernel instead of the
  various 2.4.x kernels he used and got substantially same results.
  I find it incredible that such well researched bug report has not
  lead to resolution of the bug.

Problem Description:

Thierry's report from January:

  I have a problem which has not been resolved in the last few years:
  an interaction problem between close and poll/select.

  Consider a multithreaded program (pthreads). One thread reads from
  a file descriptor (typically a TCP or UDP socket). At some time,
  another thread decides to close(2) the file descriptor while the
  first thread is blocked, waiting for input data.

  If the reading thread uses read(2) or recv(2), the system call returns
  with an error status at the time the file descriptor is closed (expected
  behavior).

  But, since we also need a timeout on the read, we do not use read(2)
  or recv(2). We set the file descriptor in non-blocking mode and we
  use poll(2) with a timeout.

  The problem is that poll(2) does not return when the file descriptor
  is closed. On all other operating systems we have here (Solaris, HP-UX
  and even non-UNIX systems like OpenVMS and Windows), poll(2) returns and
  reports an error condition as soon as the file descriptor is closed.

  The same behavior is observed if select(2) is used instead of poll(2).
  This has been observed in all kernels (currently using 2.4.18).

  Two things are noticeable:
  - If recv(2)/read(2) returns when the fd is closed, why not poll(2)?
  - All other O/S report an error, while Linux poll(2) hangs. This is a
    serious portability issue.

  Does anyone have an idea or workaround? How to implement a recv(2)
  with a timeout in such a way that the reading thread is unblocked
  when the file descriptor is closed from some other thread on Linux?

Thierry's original report (I have trimmed away redundant software
version information bloat):

  [2.] Full description of the problem/report:

  This report describes a problem in the usage of file descriptors across
  multiple threads. When one thread closes a file descriptor, another
  thread which waits for an I/O on that file descriptor is not notified
  and blocks forever.

  I don't know exactly what should be considered as "correct behavior"
  but all other operating systems we use (Sun Solaris, HP-UX, OpenVMS
  and Windows NT) have the exact same behavior. Linux is the only one
  to hang.

  Context: We use multi-threaded applications. Some threads perform I/O on
  file descriptors (usually sockets, but not only sockets). Each thread
  manages one file descriptor (a "communication"). A manager thread detects
  application-defined conditions and may decide to interrupt a communication.
  To interrupt the communication, this manager thread closes the file
  descriptor.
  If the close operation occurs while the "communication" thread is waiting
  for data on this file descriptor (using poll(2) for instance), this thread
  never returns from the I/O system call and hangs forever.

  On all other operating systems we use, the I/O system call in the
  "communication" thread returns and reports an error.

  See example program below.

  [3.] Keywords

  file-descriptor thread async-close

  [4.] Kernel version (from /proc/version):

  Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96
20000731   (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30
  EDT 2001

  [6.] A small shell script or example program which triggers the problem

  Here is an example program in C.

  From the main thread, the program creates an UDP socket and polls it
  using poll(2). Since no packet is received on this UDP port. poll blocks.
  From a second thread, after 2 seconds, the socket's file descriptor is
  closed (while the main thread is suspended on poll).

  On Solaris and HP-UX (as well as equivalent programs on OpenVMS and
  Windows NT), the poll returns in the main thread and reports an error
  on the file descriptor. On Linux, the poll never returns and the main
  thread is blocked forever.

  This example uses a socket but it works exactly the same way using
  a pipe or any device which may block long enough.

  --> Output on Solaris 5.8 and HP-UX B.11.00

  main: starting poll
  close_thread: starting thread
  close_thread: closing socket
  close_thread: close status = 0
  main: poll status = 1
  main: events   = 00000001
  main: revents  = 00000020

  ... and the program exits.

  --> Output on Linux RedHat 7.1 (kernel 2.4.2-2)

  main: starting poll
  close_thread: starting thread
  close_thread: closing socket
  close_thread: close status = 0

  ... and the program remains blocked.


Steps to reproduce:	compile and run program that follows. If kernel behaves
			correctly, the line marked `*** never reached' is
			reached. If the bug is present, it is not reached.
/*
 *  Test the asynchronous close of an UDP socket.
 *
 *  Linux   : gcc -o asclose_udp_c asclose_udp_c.c -lpthread
 *  Solaris : cc -o asclose_udp_c asclose_udp_c.c -lpthread -lsocket -lnsl
 *  HP-UX   : cc -o asclose_udp_c asclose_udp_c.c -lpthread
 */

# include <sys/types.h>
# include <sys/time.h>
# include <sys/socket.h>
# include <arpa/inet.h>
# include <netinet/in.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <unistd.h>
# include <poll.h>
# include <pthread.h>

# define UDP_PORT 6666
# define CLOSE_DELAY 2 /* seconds */

/* UDP socket descriptor */

static int sock_fd = -1;

/* This procedure is a thread which closes the socket after a delay */

static void* close_thread (void *arg)
{
    int status;
    struct timeval now;
    struct timezone tz;
    struct timespec timeout;
    pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

    printf ("close_thread: starting thread\n");

    /* Wait for the specified delay */

    pthread_mutex_lock (&mutex);
    gettimeofday (&now, &tz);
    timeout.tv_sec = now.tv_sec + CLOSE_DELAY;
    timeout.tv_nsec = now.tv_usec * 1000;
    pthread_cond_timedwait (&cond, &mutex, &timeout);
    pthread_mutex_unlock (&mutex);
   
    /* Close the socket while the main task is blocked in a poll(2) */

    printf ("close_thread: closing socket\n");
    status = close (sock_fd);
    printf ("close_thread: close status = %d\n", status);
    
    return NULL;
}

/* Main program */

int main (int argc, char *argv[])
{
    int status;
    pthread_t th;
    struct pollfd fdset;
    struct sockaddr_in saddr;

    /* Create a UDP socket */

    if ((sock_fd = socket (AF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
        perror ("socket");
        exit (EXIT_FAILURE);
    }

    saddr.sin_family = AF_INET;
    saddr.sin_port = htons (UDP_PORT);
    saddr.sin_addr.s_addr = 0;

    if (bind (sock_fd, (struct sockaddr*) &saddr, sizeof (saddr)) < 0) {
        perror ("bind");
        exit (EXIT_FAILURE);
    }

    /* Create a new thread to asynchronously close the socket */

    if ((status = pthread_create (&th, NULL, close_thread, NULL)) != 0) {
        fprintf (stderr, "pthread_create: %s\n", strerror (status));
        exit (EXIT_FAILURE);
    }

    /* Wait for input data using poll(2) and an infinite timeout */

    fdset.fd = sock_fd;
    fdset.events = POLLIN;
    fdset.revents = 0;

    printf ("main: starting poll\n");
    status = poll (&fdset, 1, -1);
    printf ("main: poll status = %d\n", status);   /* *** never reached */
    printf ("main: events   = %08X\n", fdset.events);
    printf ("main: revents  = %08X\n", fdset.revents);
}

