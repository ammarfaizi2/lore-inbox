Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTEOPL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTEOPKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:10:55 -0400
Received: from boden.synopsys.com ([204.176.20.19]:63425 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S264075AbTEOPJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:09:51 -0400
Date: Thu, 15 May 2003 11:22:31 -0400
From: Jim Nance <jlnance@us54.synopsys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org,
       gary.nifong@synopsys.COM, James.Nance@synopsys.COM,
       david.thomas@synopsys.COM
Subject: Re: NFS problems with Linux-2.4
Message-ID: <20030515112231.A28148@synopsys.com>
References: <20030513145023.GA10383@ncsu.edu> <16065.3323.449992.207039@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16065.3323.449992.207039@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, May 13, 2003 at 05:19:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2003 at 05:19:23PM +0200, Trond Myklebust wrote:
> 
> Could you please try with a newer kernel. The close-to-open cache
> consistency fixes are a relatively recent addition to the Linux NFS
> client. I dunno if RedHat's 2.4.18 kernel has them.
> 
>   2.4.7 certainly does not.

I tried again with the 2.4.20 based kernel that Red Hat released
yesterday (2.4.20-13.7bigmem).  The problem that I was seeing occurs
less frequently there, but it still happens.

I have attached a program which can reproduce this.  If you run it
under 2.4.7 it fails instantly.  If you use 2.4.20 it may take a
minute or so but it will also fail.

Thanks,

Jim

PS: Do you know if there is any way to work around this problem from
    within my program?

-- 
----------------------------------------------------------------------------
Jim Nance                                                           Synopsys
(919) 425-7219  Do you have sweet iced tea?        jlnance at synopsys.com
                No, but there's sugar on the table.

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p1.c"

/* This program demonstrates a problem with the close/open consistency
 * of NFS file systems under Linux.  It fails very rapidy with Red Hats
 * 2.4.7-10smp kernel.  This kernel was known to have bugs.  It also fails
 * with Red Hats 2.4.20-13.7bigmem kernel, which was thought to have this
 * bug fixed.  For my testcase both linux machines were talking to a
 * network applicance file server and mounted like this:
 *
 * na1-rtp:/vol/vol0/home/jlnance /home/jlnance nfs rw,v3,rsize=4096,\
 * wsize=4096,hard,intr,udp,lock,addr=na1-rtp 0 0
 *
 * This program needs to be run on 2 machines, assume hostnames A & B.
 * A and B need to share an NFS mounted file system.
 *
 * On machine A:
 *   cd /some/nfs/path/common/to/both
 *   ./p1 s
 *
 * On machine B:
 *   cd /some/nfs/path/common/to/both
 *   ./p1 c A
 *
 * After a while you may see output similar to:
 *   cayman> ./p1 s
 *   Failed to find #0 which client wrote
 *   Failed on file number 483
 */


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <netdb.h>

#define PORT 12387
#define FLEN 16

void die()
{
  perror("");
  exit(-1);
}

void Write(int fd, char *buff, size_t len)
{
  for(;;) {
    int nsent=write(fd, buff, len);
    if(nsent==0)
      exit(0);
    if(nsent==-1) {
      if(errno!=EINTR)
        die();
    } else {
      buff += nsent;
      len  -= nsent;
      if(len==0) {
        return;
      }
    }
  }
}

void Read(int fd, char *buff, size_t len)
{
  for(;;) {
    int nread=read(fd, buff, len);
    if(nread==0)
      exit(0);
    if(nread==-1) {
      if(errno!=EINTR)
        die();
    } else {
      buff += nread;
      len  -= nread;
      if(len==0) {
        return;
      }
    }
  }
}

int server()
{
  int sock = socket(AF_INET, SOCK_STREAM, 0);
  if(sock==-1) die(); else {
    struct sockaddr_in name;
    int                on = 1;
    name.sin_family       = AF_INET;
    name.sin_addr.s_addr  = htonl(INADDR_ANY);
    name.sin_port         = htons(PORT);

    setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof on);
    if(bind(sock, (struct sockaddr*)&name, sizeof(name))==-1) die(); else {
      if(listen(sock, 1)==-1) die(); else {
        int tsock = accept(sock, 0, 0);
        if(tsock!=-1) {
          int cnt;

          for(cnt=0; cnt<100000; cnt++) {
            int  fd;
            char dummy;
            char number[FLEN];
            struct stat sbuf;
            /*sprintf(number, "#%d", cnt);*/
            sprintf(number, "#%d", 0);
            Write(tsock, number, sizeof(number));
            Read(tsock, &dummy, 1);
            if(stat(number, &sbuf)) {
              fprintf(stderr, "Failed to find %s which client wrote\n", number);
              fprintf(stderr, "Failed on file number %d\n", cnt);
              exit(-2);
            }
            unlink(number);
          }
        }
      }
    }
  }

  return 0;
}

int client(char *server)
{
  struct hostent *info = gethostbyname(server);
  if(!info) die(); else {
    int rsocket = socket(AF_INET, SOCK_STREAM, 0);
    if(rsocket==-1) die(); else {
      struct sockaddr_in name;
      name.sin_family = AF_INET;
      name.sin_port   = htons(PORT);
      memcpy(&name.sin_addr, info->h_addr_list[0], sizeof(struct in_addr));
      if(connect(rsocket, (struct sockaddr*)&name, sizeof(name))==-1)
        die();
      else {
        for(;;) {
          int  fd;
          char fname[FLEN];
          char tname[FLEN+8];

          Read(rsocket, fname, sizeof(fname));
          strcpy(tname, fname);
          strcat(tname, ".tmp");

          fd = open(tname, O_WRONLY|O_CREAT, 0600);
          if(fd==-1) die();

          Write(fd, fname, sizeof(fname)); /* Junk data */
          close(fd);

          rename(tname, fname);

          Write(rsocket, fname, 1); /* Tells the server we are done */
        }
      }
    }
  }

  return 0;
}

void usage(char *prog)
{
  fprintf(stderr, "Usage:\n");
  fprintf(stderr, " %s s\n", prog);
  fprintf(stderr, " %s c servername\n", prog);
  fprintf(stderr, " Run 1 of each in the same NFS directory on 2 different "
        "machines\n Two processes total\n");
  exit(-1);
}

int main(int ac, char **av)
{
  if(ac<2) {
    usage(av[0]);
  } if(av[1][0]=='s') {
    return server();
  }else if(ac<3) {
    usage(av[0]);
  } else if(av[1][0]=='c') {
    return client(av[2]);
  } else {
    usage(av[0]);
  }

  return -1;
}

--SUOF0GtieIMvvwua--
