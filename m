Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSGRX1p>; Thu, 18 Jul 2002 19:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSGRX1p>; Thu, 18 Jul 2002 19:27:45 -0400
Received: from [206.155.169.10] ([206.155.169.10]:27658 "EHLO spinbox.com")
	by vger.kernel.org with ESMTP id <S318356AbSGRX1o>;
	Thu, 18 Jul 2002 19:27:44 -0400
Date: Thu, 18 Jul 2002 19:30:46 -0400 (EDT)
From: Hayden Myers <hayden@spinbox.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2 to 2.4 migration
Message-ID: <Pine.LNX.4.10.10207181918410.32173-100000@compaq.skyline.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're finally migrating to the 2.4 kernel due to hardware
incompatibilities with the 2.4.  The 2.2 has worked better for us in the
past as far as our application performs.  Our application is an adserver
and becomes bogged down in 2.4 when sending files such as images across
the wire.  They're in general between 20-50k in size.  I've been
researching the differences between 2.4 and 2.2 and have noticed that a
lot of work has gone into autotuning with 2.4 and I'm wondering if this is
what's slowing things down.  When I do tcpdumps to see the traffic being
sent to the client I'm noticing that the receiver window is almost always
set to 6430 bytes.  When looking at the same transfer on our 2.2 boxes the
receiver window is almost always over 31000 bytes.  I've tried to increase
the size of the buffers using the proc settings that are provided however
this hasn't seemed to make a difference even after restarting servers
after each change the window is still 6430 bytes.  I've tried manually
settting the size with setsockopt calls in the server code but this hasn't
seemed to help.  I believe the problem is definately with sending the
files over the line.  We files are read into the socket to be sent across
the network byte by byte.  The boss says this is the best way to do it but
I'm curious if this is so.  The code that reads the file into the socket
to go across the network is below.


int output_block(int socket, char *filename)
{
int fd, count = 0;
size_t total_bytes = 0;
/*size_t buf_cnt = 1460;*/
size_t buf_cnt = 512;
char buffer[buf_cnt];
fd_set rfds;
struct timeval tv;

   if ((fd = open(filename, O_RDONLY)) < 0) {
      //fprintf(stderr, "Unable to open filename: %s\n", filename);
      return(-1);
   }

   while ((count = read(fd, &buffer, buf_cnt)) > 0) {

      FD_ZERO(&rfds);
      FD_SET(socket, &rfds);
      tv.tv_sec = 10;
      tv.tv_usec = 0;
      if (select(socket+1, NULL, &rfds, NULL, &tv) <= 0) {
         //fprintf(stderr, "Output_block timeout\n");
         break;
      }

      if (writen(socket, buffer, count) <= 0)
         break;
      total_bytes += count;
   }

   close(fd);
   return(total_bytes);

The application is a single threaded app using a multiprocess pre forking
model if that helps any.  I'm really baffled as to why using the 2.4
kernel is slowing us down.  Any help is appreciated.  Sorry if this has
come up before.  I really have been looking for help for quite some time
before posting this.

Hayden Myers	
Support Manager
Skyline Network Technologies	
hayden@spinbox.com
(410)583-1337 option 2


