Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTIKNSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTIKNSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:18:30 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:22423 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261267AbTIKNSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:18:21 -0400
Message-ID: <0b2901c37867$1db399a0$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andi Kleen" <ak@colin2.muc.de>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, "Andi Kleen" <ak@muc.de>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
References: <uqD5.3BI.3@gated-at.bofh.it> <m3iso0arlx.fsf@averell.firstfloor.org> <0a5801c37821$54eb8180$890010ac@edumazet> <20030911051121.GA7751@colin2.muc.de> <0a7701c37829$c4bdef40$890010ac@edumazet> <20030911120956.GB7751@colin2.muc.de>
Subject: Re: Network buffer hang was Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Thu, 11 Sep 2003 15:17:55 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0B26_01C37877.E0329AC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0B26_01C37877.E0329AC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> > This is not a kernel crash. But total freeze as all memory is used by
> > network buffers, in no more than 10 seconds.
>
> Ok, but then you have to diagnose this freeze. I'm not sure why you
> think it must be this prefetch thingy. If the prefetch issue was
> hit then you would just get a normal segfault, not a kernel hang.

Well, the machine is a bi-athlon, and I use prefetchnta... thats all.

>
> e.g. you could write some kind of reduced test case for it and
> post it to the netdev mailing list (netdev@oss.sgi.com)

Thanks very much. I'm resending my original mail (with a small test program
attached), at the end of this one.

>
> I'm cc'ing it for you.
>
> > This application receive smalls TCP messages (about 30 bytes), but the
> > network stacks allocates 4KB buffers to store this little messages.
>
> Most drivers only allocate MTU size in their receive ring
> (normally 1.5K on ethernet). This is rounded to 2K by  the memory
allocator.
>
> But most drivers support a rx_copybreak parameter. When the received
> packet is smaller than rx_copybreak it is copied to a freshly allocated
> buffer with the right size.

I'm using e1000 driver , on linux-2.6, this driver doesnt use the
rx_copybreak trick.

>
> In addition the 2.4 stack also supports garbage collection in the TCP
> receive buffers. This means even when a driver doesn't do the rx_copybreak
> trick and the receive queue of a socket fills up it will copy the data
> to fresh, right sized packets by itself.
>
> Another limit for this scenario is that the network stack has internal
> limits that supposed to avoid this. These are: each socket has a
> fixed receive buffer size and when more data arrives (including packet
> metadata and normal wastage) than the receive buffer allows then it is
> still dropped. In addition TCP has a global memory limit that also kicks
> in. And the network stack has a global queue limit that prevents
> too much data to be queued from the driver to the higher level
> parts (/proc/sys/net/core/netdev_max_backlog). Sometimes the queueing
> can also be controlled on the driver level with driver specific
> knobs.
>

cat /proc/sys/net/core/netdev_max_backlog
300

> This all can be tuned by sysctls in /proc/sys. See
Documentation/networking/
> ip-sysctl.txt for more details.
>
> Also the latest 2.6 kernel finally has a writable
/proc/sys/vm/min_free_kbytes
> again. This controls the amount of memory kept free for interrupts.
> Increase that.

Hum I didnt knew this one...

cat  /proc/sys/vm/min_free_kbytes
16384

>
> > I posted a test application some days ago about this problem and got no
> > answers/feedback.
>
> Did you post it to netdev?  On linux-kernel such things get often
> lost in the noise.
>
> Also I would contact the driver maintainer, it could be really a driver
> Issue.
>
> -Andi

Here is the copy of the mail I sent the Sep 1st on linux-kernel & linux-net
:

Hi all

I have an annoying problem with a network server (TCP sockets)

On some stress situation,  LowMemory goes close to 0, and the whole machine
freezes.

When the sockets receive a lot of data, and the server is busy, the TCP
stack just can use too many buffers (in LowMem).

TCP stack uses "size-4096" buffers to store the datas, even if only one byte
is coming from the network.

I tried to change /proc/sys/net/ipv4/tcp_mem, without results.
# echo "1000 10000 15000" >/proc/sys/net/ipv4/tcp_mem

You can reproduce the problem with the test program attached.

# gcc -o crash crash.c
# ulimit -n 20000
# ./crash listen  8888 &
# ./crash call 127.0.0.1:8888 &

grep "size-4096 " /proc/slabinfo
size-4096      40015  40015  4096  1  1 : tunables  24  12  0  : slabdata
40015  40015 0

(thats is 160 Mo, far more than the limit given in
/proc/sys/net/ipv4/tcp_mem)

grep TCP /proc/net/sockstat
TCP: inuse 39996 orphan 0 tw 0 alloc 39997  mem 79986

What is the unit of 'mem' field ? Unless it is 2Ko, the numbers are wrong.

 How may I ask the kernel NOT to use more than 'X Mo' to store TCP messages
?

Thanks

Eric Dumazet

/*
 * Program to freeze a linux box, by using all the LOWMEM
 * A bug on the tcp stack may be the reason
 * Use at your own risk !!
 */

/* Principles :
   A listener accepts incoming tcp sockets, write 40 bytes, and does nothing
with them (no reading)
   A writer establish TCP sockets, sends some data (40 bytes), no more
reading/writing
 */
#include <stdio.h>
# include <sys/socket.h>
# include <netinet/tcp.h>
# include <arpa/inet.h>
# include <netdb.h>
# include <unistd.h>
# include <string.h>

/*
 * Usage :
 *              crash listen port
 *              crash call IP:port
 */
void usage(int code)
{
fprintf(stderr, "Usages :\n") ;
fprintf(stderr, "    crash listen port\n") ;
fprintf(stderr, "    crash call IP:port\n") ;
exit(code) ;
}
const char some_data[40] = "some data.... just some data" ;

void do_listener(const char *string)
{
int port = atoi(string) ;
struct sockaddr_in host, from ;
int fdlisten ;
unsigned int total ;
socklen_t fromlen ;
  memset(&host,0, sizeof(host));
  host.sin_family = AF_INET;
  host.sin_port = htons(port);
  fdlisten = socket(AF_INET, SOCK_STREAM, 0) ;
  if (bind(fdlisten, (struct sockaddr *)&host, sizeof(host)) == -1) {
        perror("bind") ;
        return ;
        }
listen(fdlisten, 10) ;
for (total=0;;total++) {
        int nfd ;
        fromlen = sizeof(from) ;
        nfd = accept(fdlisten, (struct sockaddr *)&from, &fromlen) ;
        if (nfd == -1) break ;
        write(nfd, some_data, sizeof(some_data)) ;
        }
printf("total=%u\n", total) ;
pause() ;
}

void do_caller(const char *string)
{
union {
   int i ;
   char c[4] ;
        } u ;
struct sockaddr_in dest;
int a1, a2, a3, a4, port ;
unsigned int total ;
sscanf(string, "%d.%d.%d.%d:%d", &a1, &a2, &a3, &a4, &port) ;
u.c[0] = a1 ; u.c[1] = a2 ; u.c[2] = a3 ; u.c[3] = a4 ;
for (total=0;;total++) {
    int fd ;
        memset(&dest, 0, sizeof(dest)) ;
        dest.sin_family = AF_INET ;
        dest.sin_port = htons(port) ;
        dest.sin_addr.s_addr = u.i ;
    fd = socket(AF_INET, SOCK_STREAM, 0) ;
        if (fd == -1) break ;
        if (connect(fd, (struct sockaddr *)&dest, sizeof(dest)) == -1) {
                perror("connect") ;
                break ;
                }
        write(fd, some_data, sizeof(some_data)) ;
        }
printf("total=%u\n", total) ;
pause() ;
}

int main(int argc, char *argv[])
{
int listener ;
int caller ;
if (argc != 3) {
        usage(1);
        }
listener = !strcmp(argv[1], "listen") ;
caller = !strcmp(argv[1], "call") ;
if (listener) {
        do_listener(argv[2]) ;
        }
else if (caller) {
        do_caller(argv[2]) ;
        }
else usage(2) ;
return 0 ;
}
/********************************************************************/



------=_NextPart_000_0B26_01C37877.E0329AC0
Content-Type: text/plain;
	name="crash.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="crash.c"

/*=0A=
 * Program to freeze a linux box, by using all the LOWMEM=0A=
 * A bug on the tcp stack may be the reason =0A=
 * Use at your own risk !!=0A=
 */=0A=
=0A=
/* Principles :=0A=
   A listener accepts incoming tcp sockets, write 40 bytes, and does =
nothing with them (no reading)=0A=
   A writer establish TCP sockets, sends some data (40 bytes), no more =
reading/writing=0A=
 */=0A=
#include <stdio.h>=0A=
# include <sys/socket.h>=0A=
# include <netinet/tcp.h>=0A=
# include <arpa/inet.h>=0A=
# include <netdb.h>=0A=
# include <unistd.h>=0A=
# include <string.h>=0A=
=0A=
/*=0A=
 * Usage :=0A=
 *              crash listen port=0A=
 *              crash call IP:port=0A=
 */=0A=
void usage(int code)=0A=
{=0A=
fprintf(stderr, "Usages :\n") ;=0A=
fprintf(stderr, "    crash listen port\n") ;=0A=
fprintf(stderr, "    crash call IP:port\n") ;=0A=
exit(code) ;=0A=
}=0A=
const char some_data[40] =3D "some data.... just some data" ;=0A=
=0A=
void do_listener(const char *string)=0A=
{=0A=
int port =3D atoi(string) ;=0A=
struct sockaddr_in host, from ;=0A=
int fdlisten ;=0A=
unsigned int total ;=0A=
socklen_t fromlen ;=0A=
  memset(&host,0, sizeof(host));=0A=
  host.sin_family =3D AF_INET;=0A=
  host.sin_port =3D htons(port);=0A=
  fdlisten =3D socket(AF_INET, SOCK_STREAM, 0) ;=0A=
  if (bind(fdlisten, (struct sockaddr *)&host, sizeof(host)) =3D=3D -1) {=0A=
	perror("bind") ;=0A=
	return ;=0A=
	}=0A=
listen(fdlisten, 10) ;=0A=
for (total=3D0;;total++) {=0A=
	int nfd ;=0A=
	fromlen =3D sizeof(from) ;=0A=
	nfd =3D accept(fdlisten, (struct sockaddr *)&from, &fromlen) ;=0A=
	if (nfd =3D=3D -1) break ;=0A=
	write(nfd, some_data, sizeof(some_data)) ;=0A=
	}=0A=
printf("total=3D%u\n", total) ;=0A=
pause() ;=0A=
}=0A=
=0A=
void do_caller(const char *string)=0A=
{=0A=
union {=0A=
   int i ;=0A=
   char c[4] ;=0A=
	} u ;=0A=
struct sockaddr_in dest;=0A=
int a1, a2, a3, a4, port ;=0A=
unsigned int total ;=0A=
sscanf(string, "%d.%d.%d.%d:%d", &a1, &a2, &a3, &a4, &port) ;=0A=
u.c[0] =3D a1 ; u.c[1] =3D a2 ; u.c[2] =3D a3 ; u.c[3] =3D a4 ;=0A=
for (total=3D0;;total++) {=0A=
    int fd ;=0A=
	memset(&dest, 0, sizeof(dest)) ;=0A=
	dest.sin_family =3D AF_INET ;=0A=
   	dest.sin_port =3D htons(port) ;=0A=
   	dest.sin_addr.s_addr =3D u.i ;=0A=
    fd =3D socket(AF_INET, SOCK_STREAM, 0) ;=0A=
	if (fd =3D=3D -1) break ;=0A=
	if (connect(fd, (struct sockaddr *)&dest, sizeof(dest)) =3D=3D -1) {=0A=
		perror("connect") ;=0A=
		break ;=0A=
		}=0A=
	write(fd, some_data, sizeof(some_data)) ;=0A=
	}=0A=
printf("total=3D%u\n", total) ;=0A=
pause() ;=0A=
}=0A=
=0A=
int main(int argc, char *argv[])=0A=
{=0A=
int listener ;=0A=
int caller ;=0A=
if (argc !=3D 3) {=0A=
	usage(1);=0A=
	}=0A=
listener =3D !strcmp(argv[1], "listen") ;=0A=
caller =3D !strcmp(argv[1], "call") ;=0A=
if (listener) {=0A=
	do_listener(argv[2]) ;=0A=
	}=0A=
else if (caller) {=0A=
	do_caller(argv[2]) ;=0A=
	}=0A=
else usage(2) ;=0A=
return 0 ;=0A=
}=0A=
/********************************************************************/=0A=

------=_NextPart_000_0B26_01C37877.E0329AC0--

