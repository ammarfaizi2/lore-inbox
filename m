Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTIARCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTIARCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:02:03 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:22218 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S263152AbTIARAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:00:12 -0400
Message-ID: <019d01c370aa$7b0a7520$b100a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
References: <1062389729.314.31.camel@cube> <20030901140706.GG18458@work.bitmover.com> <1062430014.314.59.camel@cube> <20030901154646.GB1327@work.bitmover.com>
Subject: Bug in linux-2.6.0-test4 ?
Date: Mon, 1 Sep 2003 18:59:59 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_019A_01C370BB.3DE06FE0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_019A_01C370BB.3DE06FE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

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

------=_NextPart_000_019A_01C370BB.3DE06FE0
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

------=_NextPart_000_019A_01C370BB.3DE06FE0--

