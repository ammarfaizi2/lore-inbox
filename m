Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDJU2E>; Tue, 10 Apr 2001 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDJU1z>; Tue, 10 Apr 2001 16:27:55 -0400
Received: from code.and.org ([63.113.167.33]:6544 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S132140AbRDJU1o>;
	Tue, 10 Apr 2001 16:27:44 -0400
To: "Stephen D. Williams" <sdw@lig.net>
Cc: Michael Lindner <mikel@att.net>, Chris Wedgwood <cw@f00f.org>,
        Dan Maas <dmaas@dcine.com>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data    available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no>
	<015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net>
	<20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net>
	<3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph>
	<20010121133433.A1112@metastasis.f00f.org> <3A6A558D.5E0CF29E@att.net>
	<3AD1CD13.F1A917FA@lig.net> <nnbsq5opdz.fsf@code.and.org>
	<3AD35119.D1C5E90D@lig.net>
From: James Antill <james@and.org>
Content-Type: multipart/mixed;
 boundary="Multipart_Tue_Apr_10_16:25:43_2001-1"
Content-Transfer-Encoding: 7bit
Date: 10 Apr 2001 16:25:43 -0400
In-Reply-To: "Stephen D. Williams"'s message of "Tue, 10 Apr 2001 14:29:45 -0400"
Message-ID: <nng0fgmri0.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Tue_Apr_10_16:25:43_2001-1
Content-Type: text/plain; charset=US-ASCII

"Stephen D. Williams" <sdw@lig.net> writes:

> James Antill wrote:
> > 
> >  I seemed to miss the original post, so I can't really comment on the
> > tests. However...
> 
> It was a thread in January, but just ran accross it looking for
> something else.  See below for results.

 Ahh, ok.

> > > Michael Lindner wrote:
> ...
> > > > <0.000021>
> > > >      0.000173 select(8, [3 4 6 7], NULL, NULL, NULL) = 1 (in [6])
> > > > <0.000047>
> > 
> >  The strace here shows select() with an infinite timeout, you're
> > numbers will be much better if you do (pseudo code)...

[snip ... ]

> > ...basically you completely miss the function call for __pollwait()
> > inside poll_wait (include/linux/poll.h in the linux sources, with
> > __pollwait being in fs/select.c).
> 
> Apparently the extra system call overhead outweighs any benefit.

 There shouldn't be any "extra" system calls in the fast path. If data
is waiting then you do one call to poll() either way, if not then you
are wasting time blocking so it doesn't matter what you do.

>                                                                   In any
> case, what you suggest would be better done in the kernel anyway.

 Possibly, however when this has come up before the kernel people have
said it's hard to do in kernel space.

>                                                                    The
> time went from 3.7 to 4.4 seconds per 100000.

 Ok here's a quick test that I've done. This passes data between 2
processes. Obviously you can't compare this to your code or Michael's,
however...

 The results with USE_DOUBLE_POLL on are...

% time ./pingpong
./pingpong  0.15s user 0.89s system 48% cpu 2.147 total
% time ./pingpong
./pingpong  0.19s user 0.91s system 45% cpu 2.422 total
% time ./pingpong
./pingpong  0.10s user 1.02s system 49% cpu 2.282 total

 The results with USE_DOUBLE_POLL off are...

% time ./pingpong
./pingpong  0.24s user 1.07s system 50% cpu 2.614 total
% time ./pingpong
./pingpong  0.21s user 1.00s system 44% cpu 2.695 total
% time ./pingpong
./pingpong  0.21s user 1.13s system 50% cpu 2.667 total

 Don't forget that the poll here is done with _1_ fd. Most real
programs have more, and so benifit more.

 I also did the TRY_NO_POLL, as I was pretty sure what the results
would be, that gives...

% time ./pingpong
./pingpong  0.03s user 0.41s system 50% cpu 0.874 total
% time ./pingpong
./pingpong  0.06s user 0.44s system 58% cpu 0.855 total
% time ./pingpong
./pingpong  0.07s user 0.35s system 51% cpu 0.820 total


--Multipart_Tue_Apr_10_16:25:43_2001-1
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="pingpong.c"
Content-Transfer-Encoding: 7bit

#define _GNU_SOURCE 1
#include <stdlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <errno.h>
#include <netinet/ip.h>

#define USE_DOUBLE_POLL 1
#define USE_TRY_NO_POLL 0


#define DIE() die(__LINE__)

static void die(int line)
{
 char *buf = NULL;

 asprintf(&buf, "%d:", line);
 if (buf)
   perror(buf);
 exit (EXIT_FAILURE);
}

#define EV_WRITE 1
#define EV_READ 2
#define EV_POLL_WRITE 3
#define EV_POLL_READ 4

#if USE_TRY_NO_POLL
# define EV_AFTER_READ EV_WRITE
# define EV_AFTER_WRITE EV_READ
#else
# define EV_AFTER_READ EV_POLL_WRITE
# define EV_AFTER_WRITE EV_POLL_READ
#endif

#define EV_IS_WRITE(x) ((x) & 1)

static int do_event(int fd, int event)
{
 char buf[1];
 int ret = 0;
 
 switch (event)
 {
  case EV_WRITE:
    if ((ret = write(fd, "a", 1)) == -1)
    {
     if (errno != EAGAIN)
       DIE();
     event = EV_POLL_WRITE;
    }
    else
      event = EV_AFTER_WRITE;
    break;
    
  case EV_READ:
    if ((ret = read(fd, buf, 1)) == -1)
    {
     if (errno == EPIPE)
       exit (EXIT_SUCCESS);
     if (errno != EAGAIN)
       DIE();
     event = EV_POLL_READ;
    }
    else
      event = EV_AFTER_READ;
    break;
    
  case EV_POLL_WRITE:
  {
   struct pollfd p;
   p.fd = fd;
   p.events = POLLOUT;
   p.revents = 0;
   
   if (!USE_DOUBLE_POLL || !(ret = poll(&p, 1, 0)))
     ret = poll(&p, 1, -1);
   if (ret != 1)
     DIE();
   event = EV_WRITE;
  }
  break;
  
  case EV_POLL_READ:
  {
   struct pollfd p;

   p.fd = fd;
   p.events = POLLIN;
   p.revents = 0;
   
   if (!USE_DOUBLE_POLL || !(ret = poll(&p, 1, 0)))
     ret = poll(&p, 1, -1);
   if (ret != 1)
     DIE();
   event = EV_READ;
  }
  break;
 }

 return (event);
}

static void go_parent(int fd)
{
 int event = EV_WRITE;
 unsigned int count = 100000;

 while (count)
 {
  int write_event = EV_IS_WRITE(event);
  
  event = do_event(fd, event);

  if (!!write_event != !!EV_IS_WRITE(event))
    --count;
 } 
}

static int go_chld(int fd)
{
 int event = EV_WRITE;

 while (1)  
   event = do_event(fd, event);
}

int main(void)
{
 int fds[2];
 pid_t chld = 0;
 
 if (socketpair(PF_LOCAL, SOCK_STREAM, IPPROTO_IP, fds) == -1)
   DIE();
 
 if ((chld = fork()) == -1)
   DIE();
 
 if (chld)
   go_parent(fds[0]);
 else
   go_chld(fds[1]);

 exit (EXIT_SUCCESS);
}

--Multipart_Tue_Apr_10_16:25:43_2001-1
Content-Type: text/plain; charset=US-ASCII



-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null

--Multipart_Tue_Apr_10_16:25:43_2001-1--
