Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSDZHjB>; Fri, 26 Apr 2002 03:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313327AbSDZHjA>; Fri, 26 Apr 2002 03:39:00 -0400
Received: from elin.scali.no ([62.70.89.10]:59918 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313242AbSDZHi6>;
	Fri, 26 Apr 2002 03:38:58 -0400
Subject: Re: Possible bug with UDP and SO_REUSEADDR. Was Re: [PATCH]
	zerocopy NFS updated
From: Terje Eggestad <terje.eggestad@scali.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020425.194301.90782367.davem@redhat.com>
Content-Type: multipart/mixed; boundary="=-shj0n7GOXtMOD2GenMyW"
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 09:38:52 +0200
Message-Id: <1019806735.7410.1102.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-shj0n7GOXtMOD2GenMyW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

'course



On Fri, 2002-04-26 at 04:43, David S. Miller wrote:
>    From: Terje Eggestad <terje.eggestad@scali.com>
>    Date: 25 Apr 2002 14:37:44 +0200
> 
>    However writing a test server that stand in blocking wait on a UDP
>    socket, and start two instances of the server it's ALWAYS the server
>    last started that get the udp message, even if it's not in blocking
>    wait, and the first started server is. 
>    
>    Smells like a bug to me, this behavior don't make much sence. 
>    
>    Using stock 2.4.17.
> 
> Can you post your test server/client application so that I
> don't have to write it myself and guess how you did things?
> 
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

--=-shj0n7GOXtMOD2GenMyW
Content-Disposition: attachment; filename=client.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=client.c; charset=ISO-8859-1

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include <unistd.h>
#include <fcntl.h>

#define BS 4096*3
main(int argc, char ** argv)
{
  int s, n, ns, cond, len, rc, val;
  short port =3D 6767;
  struct sockaddr_in mysock;
  char buffer[BS];
  char addr[16], * host;
  time_t t;=20
  struct hostent * he;
  s =3D socket(PF_INET, SOCK_DGRAM, 0);

  if (argc >=3D 2) {
    host =3D argv[1];
  } else {
    printf ("error\n");
  };

  if (argc >=3D 3) {
    port =3D atoi(argv[2]);
  };

  mysock.sin_family =3D AF_INET;
  mysock.sin_port =3D htons(port);
  he =3D gethostbyname(host);
  if (he =3D=3D NULL) exit(9);

  printf ("host  %s : %s, %d %#x \n", host, he->h_name, he->h_addrtype, he-=
>h_addr_list[0]);
  memcpy(&mysock.sin_addr.s_addr, he->h_addr_list[0], he->h_length);
 =20
  printf("\n");
  time(&t);
  rc =3D sprintf(buffer, "%d : %s : hei hei", getpid(), ctime(&t));
  len =3D sizeof(struct sockaddr_in);
  inet_ntop(AF_INET, &mysock.sin_addr.s_addr, addr, 16);
  printf("sento: %s:%d =3D\"%s\"\n", addr, ntohs(mysock.sin_port), buffer);
  rc =3D sendto(s, buffer, rc, 0, (struct sockaddr*) &mysock, len);=20

};

/*=20
 * Local variables:
 *  compile-command: "gcc -g  -o client client.c"
 * End:
 */

--=-shj0n7GOXtMOD2GenMyW
Content-Disposition: attachment; filename=server.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=server.c; charset=ISO-8859-1

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#include <unistd.h>
#include <fcntl.h>

#define BS 4096*3
main(int argc, char ** argv)
{
  int s, n, ns, cond, len, rc, val;
  short port =3D 6767;
  struct sockaddr_in mysock, peeraddr;
  char buffer[BS];
  char addr[16];
=20
  s =3D socket(PF_INET, SOCK_DGRAM, 0);

  if (argc >=3D 2) {
    port =3D atoi(argv[1]);
  };

  mysock.sin_family =3D AF_INET;
  mysock.sin_port =3D htons(port);
  mysock.sin_addr.s_addr =3D INADDR_ANY;
 =20
  val =3D 1;
  rc =3D setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(int));
  printf ("setsockopt =3D> %d (%d)\n", rc, errno);
 =20
  rc =3D bind(s, (struct sockaddr*) &mysock, sizeof(struct sockaddr_in));
  printf ("bind =3D> %d (%d)\n", rc, errno);
 =20

  while(1) {

    printf("\n");
    len =3D sizeof(struct sockaddr_in);
    rc =3D recvfrom(s, buffer, BS, 0, (struct sockaddr*) &peeraddr, &len);=20

    if (rc =3D=3D -1) printf("recvfrom returned %d (%d)\n", rc, errno);
    else {
      inet_ntop(AF_INET, &peeraddr.sin_addr.s_addr, addr, 16);
      printf("recvfrom got from %s:%d =3D\"%s\"\n", addr, ntohs(peeraddr.si=
n_port), buffer);
    };
    sleep(1);
  };
};

/*=20
 * Local variables:
 *  compile-command: "gcc -g  -o server server.c"
 * End:
 */

--=-shj0n7GOXtMOD2GenMyW--

