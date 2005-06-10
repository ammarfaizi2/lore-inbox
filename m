Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVFJNR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVFJNR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVFJNRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:17:25 -0400
Received: from smtp808.mail.ukl.yahoo.com ([217.12.12.198]:46985 "HELO
	smtp808.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261632AbVFJNRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:17:15 -0400
Message-ID: <42A9A0C0.5030802@unixtrix.com>
Date: Fri, 10 Jun 2005 14:16:32 +0000
From: Alastair Poole <alastair@unixtrix.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: Major TCP connect() errors, don't release as stable.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested various kernels including 2.6.11.10 2.6.11.11 and
2.6.12-rc6 and am having unusual results regarding connect().  Earlier
kernels do not return the same strange results.

I have tested numerous basic port scanners, including my own, and
strangely ports which are NOT open are being reported as open.  I have
checked these ports by various means -- to be certain they are NOT open
-- and in various runlevels; the results are the same.  There are no TCP 
daemons running, nor RPC services.  This is definately kerenl related.

The number of ports listed changes in size and they appear to be
random.  For example, on one scan ports 22, 3455, 4532 and 6236 will
appear open; on another scan it might be 22, 3567, 3879, 3889, 6589 and
7374.

However, ports which ARE open do also appear as open alongside these
"rogue" ports.  I have also tested this on another system with the same
results.  It is also interesting to note that a basic TCP nmap scan of 
all ports does not return these unusual results.

I was initially told that the problem was not kernel related.  However, 
I have now reconfirmed with three seperate sources.  This is, indeed, 
quite a serious kernel related bug.  Please take this seriously.

Enclosed is example code that produces these results on the named
kernels and systems.

sincerely

Alastair Poole

########################################################################

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <time.h>
#include <string.h>

int
main (int argc, char **argv)
{
  int sd, result, server_port;
  *struct* hostent *he;
  *struct* sockaddr_in servaddr;

  printf ("Test TCP/IP port scanner:\n");

  *if* (argc != 2)
    {
      printf ("Usage: %s host\n", argv[0]);
      exit (1);
    }

  *if* ((he = gethostbyname (argv[1])) == NULL)
    {
      perror ("gethostbyname()");
      exit (1);
    }

  printf ("Scanning %s\n", argv[1]);

  *for* (server_port = 0; server_port < 65536; server_port++)
    {
      *if* ((sd = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1)
	{
	  perror ("socket()");
	  exit (1);
	}

      bzero (&servaddr, *sizeof* servaddr);
      servaddr.sin_family = AF_INET;
      servaddr.sin_port = htons (server_port);
      servaddr.sin_addr = *((*struct* in_addr *) he->h_addr);

      result = connect (sd, (*struct* sockaddr *) &servaddr, *sizeof* 
servaddr);

      *if* (result != -1)
	{
	  printf ("open port:  %d\n",server_port);
	}
      close (sd);
    }
  *return* result;
}


########################################################################

