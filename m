Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSGSHpn>; Fri, 19 Jul 2002 03:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318461AbSGSHpn>; Fri, 19 Jul 2002 03:45:43 -0400
Received: from code.and.org ([63.113.167.33]:55760 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S318458AbSGSHph>;
	Fri, 19 Jul 2002 03:45:37 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more thoughts on a new jail() system call
References: <Pine.LNX.4.44.0207182248110.3378-200000@hawkeye.luckynet.adm>
From: James Antill <james@and.org>
Content-Type: multipart/mixed;
 boundary="Multipart_Fri_Jul_19_03:48:27_2002-1"
Content-Transfer-Encoding: 7bit
Date: 19 Jul 2002 03:48:27 -0400
In-Reply-To: <Pine.LNX.4.44.0207182248110.3378-200000@hawkeye.luckynet.adm>
Message-ID: <m3y9c8ma44.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Fri_Jul_19_03:48:27_2002-1
Content-Type: text/plain; charset=US-ASCII

Thunder from the hill <thunder@ngforever.de> writes:

> Hi,
> 
> On 19 Jul 2002, James Antill wrote:
> >  The more general spelling is FIONREAD, and I generally find that only
> > crap network applications need to use it. Good ones just try and read
> > a largish amount of data into a buffer.
> 
> That doesn't matter as long as you haven't got any idea on how much data 
> will be read. Especially relaying between two completely different hosts, 
> possibly unknown protocols, you don't have a chance to know who will send 
> next. Without TIOCINQ you'll almost be shot if you have received lots of 
> lots of stuff from the client and expect any response from the server. You 
> just won't get it.
> 
> Give me another version of the appended piece of code that won't use 
> ioctl, and I'll consider an acknowledgement.

 Hey, why not I'm bored[1] and have half an hour...

 Here it is, both libraries needed can be got from http://www.and.org/
(I know socket_poll still requires gnome-config ... I'll get around to
changing it to pkg-config soonish).

 Here's a quick list of differences[2]...

1. Your version can _lose data_ when not all of the data from recv is
sent down send.

2. Your version _loses data_ when '\0' characters are in either
stream.

3. Your version can easily get stuck doing work for just one
direction, while the other direction is ignored.

4. Your version has to use usleep() because you've done manual
polling using ioctl(FIONREAD). Welcome to latency hell.

...points 1 and 3 will heavily suggest some kind of buffering
mechanism and non-blocking read/write calls. That means you'll end up
only using ioctl() for a ready/error state indicator.
 To fix point 4 you'll need to use poll()/etc. to get a ready/error state.
 Thus your program now being not too bad ... won't need to use
ioctl(FIONREAD).


[1] But not bored enough to write everything without using some decent
libraries ... so sue me.

[2] There are a couple of differences in error reporting, Ie. mine
reports "read (*): No space left on device" when one of the
connections is closed ... yours presumably fails from ioctl(). If I
cared the code would be much different and be able to accept multiple
connections etc. but I don't.


--Multipart_Fri_Jul_19_03:48:27_2002-1
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="portforwarder.c"
Content-Transfer-Encoding: 7bit

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <sys/socket.h>

#include <fcntl.h>
#include <sys/poll.h>
#include <socket_poll.h>

#define VSTR_COMPILE_INCLUDE 1
#include <vstr.h>

#define _perror(s) perror(s); errno = 0
#define _probably_perror(s) if (errno) { perror(s); errno = 0; }

unsigned short portfrom, portto;
int sock, client, server, peer_size;
struct sockaddr_in *local, *peer, *remote;
char *buffer;
Vstr_conf *conf = NULL;
Vstr_base *s_in = NULL;
Vstr_base *c_in = NULL;

#define MV_DATA_FAIL_IN  1
#define MV_DATA_FAIL_OUT 2
#define MV_DATA_DONE     3
#define MV_DATA_EAGAIN   4

#define MY_MAX_TRANSIT 65535
// #define MY_FWD_HOST "192.168.1.1"
#define MY_FWD_HOST "127.0.0.1"

int mv_data(Vstr_base *io, int fd_in, int fd_ut, unsigned int ev)
{
  int have_read = 0;
  unsigned int err = 0;
  
  if (ev & POLLIN)
  {
    if (!vstr_sc_read_fd(io, io->len, fd_in, 2, 32, &err))
    {
      if ((err == VSTR_TYPE_SC_READ_FD_ERR_READ_ERRNO) &&
          (errno == EINTR))
        /* do nothing */;
      else
        return (MV_DATA_FAIL_IN);
    }
    else
      have_read = 1;
  }

  if (have_read || (ev & POLLOUT))
  {
    if (!vstr_sc_write_fd(io, 1, io->len, fd_ut, &err))
    {
      if ((err == VSTR_TYPE_SC_WRITE_FD_ERR_WRITE_ERRNO) &&
          (errno == EINTR))
        return (MV_DATA_EAGAIN); /* will do */
      else if ((err == VSTR_TYPE_SC_WRITE_FD_ERR_WRITE_ERRNO) &&
               (errno == EAGAIN))
        return (MV_DATA_EAGAIN);
      else
        return (MV_DATA_FAIL_OUT);
    }
  }
  
  return (MV_DATA_DONE);
}

int set_o_nonblock(int fd)
{
  int flags = 0;
  
  if ((flags = fcntl(fd, F_GETFL)) == -1)
    return (0);
  
  if (!(flags & O_NONBLOCK) &&
      (fcntl(fd, F_SETFL, flags | O_NONBLOCK) == -1))
    return (0);

  return (1);
}

int main(int argc, char **argv) {
	buffer    = malloc(65537);
	remote    = malloc(sizeof(struct sockaddr_in));
	local     = malloc(sizeof(struct sockaddr_in));
	peer      = malloc(sizeof(struct sockaddr_in));
	peer_size = sizeof(struct sockaddr_in);
	portfrom  = 26;
	portto    = 25;

        if (!vstr_init() ||
            !(conf  = vstr_make_conf()) ||
            !(vstr_cntl_conf(conf, VSTR_CNTL_CONF_SET_NUM_BUF_SZ, 4096)) ||
            !(s_in = vstr_make_base(conf)) ||
            !(c_in = vstr_make_base(conf)) ||
            0)
        {
          errno = ENOMEM; _perror("vstr_init");
          exit (1);
        }
        vstr_free_conf(conf);
        conf = NULL;
        
	if (argc >= 3) {
		portfrom = (short)(atol(argv[1]) & 0xFFFF);
		portto   = (short)(atol(argv[2]) & 0xFFFF);
	}

	local->sin_family       = AF_INET;
	local->sin_port         = htons(portfrom);
	local->sin_addr.s_addr  = htonl(INADDR_ANY);

	remote->sin_family      = AF_INET;
	remote->sin_port        = htons(portto);
	remote->sin_addr.s_addr = inet_addr(MY_FWD_HOST);

	printf("Target address: %i.%i.%i.%i:%i\n",
	       remote->sin_addr.s_addr & 0xFF,
	       (remote->sin_addr.s_addr >> 8) & 0xFF,
	       (remote->sin_addr.s_addr >> 16) & 0xFF,
	       (remote->sin_addr.s_addr >> 24) & 0xFF,
	       ntohs(remote->sin_port));

	sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (sock == -1) {
		_perror("socket (controller)");
		exit(1);
	}
	if (bind(sock, (struct sockaddr *)local,
		 sizeof(struct sockaddr_in)) < 0) {
		_perror("bind");
		exit(1);
	}
	if (listen(sock, 10) < 0) {
		_perror("listen");
		exit(1);
	}
	while ((client = accept(sock, (struct sockaddr *)peer,
				&peer_size)) >= 0) {
		unsigned long s;
		int in_recvq, overhead = 0, nr_loops = 0;

		for (s = 0; s < 65536; s++)
			buffer[s] = 0;

		printf("Connection from %s:%i\n",
		       inet_ntoa(peer->sin_addr),
		       ntohs(peer->sin_port));

		server = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
		if (server == -1) {
			_perror("socket (server)");
			exit(1);
		}
		if (connect(server, (struct sockaddr *)remote,
			    sizeof(struct sockaddr_in)) < 0) {
			_perror("connect (server)");
			goto out;
		}

		printf("Server connection is up.\n");
#if 1
                if (!set_o_nonblock(server))
                {
                  _perror("fnctl(O_NONBLOCK) (server)");
                  goto out;
                }
                
                if (!set_o_nonblock(client))
                {
                  _perror("fnctl(O_NONBLOCK) (client)");
                  goto out;
                }
                
                {
                  unsigned int s_off = socket_poll_add(server);
                  unsigned int c_off = socket_poll_add(client);
                  
                  SOCKET_POLL_INDICATOR(s_off)->events = POLLIN;
                  SOCKET_POLL_INDICATOR(c_off)->events = POLLIN;
                  while (1)
                  {
                    unsigned int ev = 0;
                    int ready = socket_poll_update_all(0);
                    if (!ready)
                      ready = socket_poll_update_all(100 * 100);

                    if ((ready == -1) && (errno == EINTR))
                      continue;
                    
                    if (ready == -1)
                    {
                      _perror("poll");
                      break;
                    }
                    
                    if (!ready)
                      break;

                    ev = SOCKET_POLL_INDICATOR(s_off)->revents;
                    if (ev & (POLLERR | POLLHUP | POLLNVAL))
                    {
                      _perror("poll (server)");
                      break;
                    }
                    ev = SOCKET_POLL_INDICATOR(c_off)->revents;
                    if (ev & (POLLERR | POLLHUP | POLLNVAL))
                    {
                      _perror("poll (client)");
                      break;
                    }

                    /* Sever -> Child data */
                    ev = ((SOCKET_POLL_INDICATOR(s_off)->revents & POLLIN) |
                          (SOCKET_POLL_INDICATOR(c_off)->revents & POLLOUT));
                    if (ev & (POLLIN | POLLOUT))
                    {
                      int fl = mv_data(s_in, server, client, ev);
                      if (fl == MV_DATA_FAIL_IN)
                      {
                        _perror("read (server)");
                        break;
                      }
                      if (fl == MV_DATA_FAIL_OUT)
                      {
                        _perror("write (client)");
                        break;
                      }
                      
                      if (fl == MV_DATA_EAGAIN)
                        SOCKET_POLL_INDICATOR(c_off)->events |=  POLLOUT;
                      else
                        SOCKET_POLL_INDICATOR(c_off)->events &= ~POLLOUT;
                      if (s_in->len > MY_MAX_TRANSIT)
                        SOCKET_POLL_INDICATOR(s_off)->events &= ~POLLIN;
                      else
                        SOCKET_POLL_INDICATOR(s_off)->events |=  POLLIN;
                    }
                    
                    /* Child -> Sever data */
                    ev = ((SOCKET_POLL_INDICATOR(c_off)->revents & POLLIN) |
                          (SOCKET_POLL_INDICATOR(s_off)->revents & POLLOUT));
                    if (ev & (POLLIN | POLLOUT))
                    {
                      int fl = mv_data(c_in, client, server, ev);
                      if (fl == MV_DATA_FAIL_IN)
                      {
                        _perror("read (client)");
                        break;
                      }
                      if (fl == MV_DATA_FAIL_OUT)
                      {
                        _perror("write (server)");
                        break;
                      }
                      
                      if (fl == MV_DATA_EAGAIN)
                        SOCKET_POLL_INDICATOR(s_off)->events |=  POLLOUT;
                      else
                        SOCKET_POLL_INDICATOR(s_off)->events &= ~POLLOUT;
                      if (s_in->len > MY_MAX_TRANSIT)
                        SOCKET_POLL_INDICATOR(c_off)->events &= ~POLLIN;
                      else
                        SOCKET_POLL_INDICATOR(c_off)->events |=  POLLIN;
                    }
                  }

                  /* cleanup ... */
                  socket_poll_del(c_off);
                  socket_poll_del(s_off);
                  vstr_del(s_in, 1, s_in->len);
                  vstr_del(c_in, 1, c_in->len);
                }
#else
		usleep(100);
                
		if (ioctl(server, TIOCINQ, &in_recvq) != 0) {
			_perror("TIOCINQ (server)");
			goto out;
		}

	data_waiting:
		if (overhead - nr_loops >= 100)
			goto out;

		while (in_recvq) {
			nr_loops++;
			overhead = nr_loops;
			for (s = 0; s < 65536; s++)
				buffer[s] = 0;

			if (recv(server,buffer, 65535, 0) < 0) {
				_perror("recv (server)");
				goto out;
			}
			printf("%s", buffer);
			if (send(client, buffer, strlen(buffer), 0) < 0) {
				_perror("send (server)");
				goto out;
			}
			if (ioctl(server, TIOCINQ, &in_recvq) != 0) {
				_perror("TIOCINQ (server)");
				goto out;
			}
		}

		if (ioctl(client, TIOCINQ, &in_recvq) != 0) {
			_perror("TIOCINQ (client)");
			goto out;
		}

		while (in_recvq) {
			nr_loops++;
			overhead = nr_loops;
			for (s = 0; s < 65536; s++)
				buffer[s] = 0;

			if (recv(client, buffer, 65535, 0) < 0) {
				_perror("recv (client)");
				goto out;
			}
			printf("%s", buffer);
			if (send(server, buffer, strlen(buffer), 0) < 0) {
				_perror("send (server)");
				goto out;
			}
			if (ioctl(client, TIOCINQ, &in_recvq) != 0) {
				_perror("TIOCINQ (client)");
				goto out;
			}
		}

		if (ioctl(server, TIOCINQ, &in_recvq) != 0) {
			_perror("TIOCINQ (server)");
			goto out;
		}

		overhead++;

		usleep(100);
		goto data_waiting;
#endif
	out:
		printf("Connection closing.\n");
                /* this is all wrong,
                   errno is only valid if the functions return -1 */
		shutdown(client, SHUT_RDWR);
		_probably_perror("shutdown (client)");
		shutdown(server, SHUT_RDWR);
		_probably_perror("shutdown (server)");
		close(client);
		_probably_perror("close (client)");
		close(server);
		_probably_perror("close (server)");
	}

	if (close(sock)) {
		_perror("close (controller)");
	}

        vstr_free_base(s_in);
        vstr_free_base(c_in);
        
        vstr_exit();
        
	exit(0);
}

/*
 * Local variables:
 *  compile-command: "gcc -W -Wall -Os `pkg-config --cflags --libs vstr` `gnome-config --cflags --libs socket_poll` -o pf portforwarder.c"
 *  c-basic-offset: 8
 * End:
 */

--Multipart_Fri_Jul_19_03:48:27_2002-1
Content-Type: text/plain; charset=US-ASCII


-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null

--Multipart_Fri_Jul_19_03:48:27_2002-1--
