Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUEWPWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUEWPWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUEWPWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:22:34 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:40580 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262963AbUEWPW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:22:27 -0400
Date: Sun, 23 May 2004 16:20:57 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: consistent ioctl for getting all net interfaces?
In-Reply-To: <pan.2004.05.23.04.28.28.143054@triplehelix.org>
Message-ID: <Pine.LNX.4.44.0405231616290.3600-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2004, Joshua Kwan wrote:
> I'm interested in not having to parse /proc/net/dev to get a list of all
> available (not necessarily even up) interfaces on the system. I
> investigated the ioctl SIOCGIFCONF, but it seems to behave differently on
> 2.4 and 2.6 series kernels, e.g. sometimes it won't return all interfaces.
> 
> Is there some end-all ioctl that does what I want, or am I forever doomed
> to process /proc/net/dev (in C, no less..)?
> 
> Please CC me on replies, I don't read this list very often any more.

Of course this is possible and here is the solution I wrote some time ago
(ioctl-based).

Note that a more simple solution is also possible but is less portable
(because will depend on glibc version).

/* TCPCAP endpoint, just an opaque handle for applications */
struct tcpcap {
        int fd;                         /* socket file descriptor */
        struct timeval *ts;             /* user supplied addr of timestamp */
        struct sockaddr_ll *from;       /* user supplied addr of extra info */
        int nports;                     /* number of bits set in ->ports */
        int maxport;                    /* highest port number set in ->ports */
        unsigned char *ports;           /* ports currently set in ->lsf */
        unsigned char *setports;        /* pending ports to be added */
        unsigned char *clrports;        /* pending ports to be removed */
        int recv_buflen;                /* socket receive buffer size */
        struct sock_fprog *lsf;         /* compiled filter program */
        struct sock_filter *lsf_insns;  /* the actual LSF instructions */
        int snaplen;                    /* length of part of each packet */
        int pkt_count;                  /* number of packets seen */
        int promisc;                    /* set interface(s) to promisc. mode */
        struct tcpcap_if *iface;        /* list of network interfaces */
        int ifcount;                    /* number of elements in ->iface[] */
};


/* 
 * internal helper: get the list of all IPv4 up interfaces
 * and record their name and IP address into pcap->iface[]
 * array. Also set promiscuous mode as requested via pcap->promisc.
 */
static int walkiflist(struct tcpcap *pcap)
{
	struct ifconf ifc;
	struct ifreq *ifreqs, *ifr;
	int fd, rq_len, nifs, i, ret = 0;

	/* this is a helper datagram socket which we must create
	 * because the actual packet socket is created later on,
	 * at tcpcap_start() time.
	 */
	fd = socket(PF_INET, SOCK_DGRAM, 0);
	if (fd < 0) {
		DPRINTF("socket(), errno=%d (%s)\n",
				errno, strerror(errno));
		return TERR_SOCKET;
	}

	ifc.ifc_buf = NULL;
	rq_len = 4*sizeof(struct ifreq);
	do {
		ifc.ifc_len = rq_len;
		ifc.ifc_buf = realloc(ifc.ifc_buf, ifc.ifc_len);
		if (ifc.ifc_buf == NULL) {
			DPRINTF("ifc.buf = realloc() failed\n");
			ret = TERR_REALLOC;
			goto outclose;
		}
		if(ioctl(fd, SIOCGIFCONF, &ifc) < 0) {
			DPRINTF("ioctl(SIOCGIFCONF), errno=%d (%s)\n",
					errno, strerror(errno));
			if (ifc.ifc_buf)
				free(ifc.ifc_buf);
			ret = TERR_IOCTL;
			goto outclose;
		}
		rq_len *= 2;
	} while (rq_len < sizeof(struct ifreq) + ifc.ifc_len);

	nifs = ifc.ifc_len / sizeof(struct ifreq);
	ifreqs = realloc(ifc.ifc_buf, nifs*sizeof(struct ifreq));
	if (ifreqs == NULL) {
		DPRINTF("ifreqs = realloc()\n");
		ret = TERR_REALLOC;
		free(ifc.ifc_buf);
		goto outclose;
	}

	/* allocate enough space for the maximum number of interfaces */
	pcap->iface = zalloc(nifs*sizeof(struct tcpcap_if));
	if (pcap->iface == NULL) {
		DPRINTF("pcap->iface = zalloc() failed\n");
		ret = TERR_ZALLOC;
		goto outfree;
	}

	/* look through what we found and select only the 'interesting' ones */
	for (ifr = ifreqs, i=0; i<nifs; ifr++, i++) {
		struct sockaddr_in *addr;

		/* only interested in IPv4 */
		if (ifr->ifr_addr.sa_family != AF_INET)
			continue;

		/* not interested in loopback */
		if (!strncmp(ifr->ifr_name, "lo", 2))
			continue;

		/* request flags because SIOCGIFCONF only 
		 * initialized name, family and address
		 */
		if(ioctl(fd, SIOCGIFFLAGS, ifr) < 0) {
			DPRINTF("ioctl(SIOCGIFFLAGS), errno=%d (%s)\n",
					errno, strerror(errno));
			ret = TERR_IOCTL;
			goto outfree;
		}

		/* not interested in down interfaces */
		if (!(ifr->ifr_flags & IFF_UP))
			continue;

		/* OK, this interface passed all our criteria, so
		 * record it into pcap->iface[] array
		 */
		pcap->iface[pcap->ifcount].ifname =strdup(ifr->ifr_name);
		addr = (struct sockaddr_in *)&(ifr->ifr_addr);
		pcap->iface[pcap->ifcount].addr = htonl(addr->sin_addr.s_addr);

		/* if required set this interface into promisc. mode,
		 * unless it is already in promiscuous mode.
		 */
		if (pcap->promisc && !(ifr->ifr_flags & IFF_PROMISC)) {

			/* enable promiscuous mode */
			ifr->ifr_flags |= IFF_PROMISC;

			/* set interface flags */
			if (ioctl(fd, SIOCSIFFLAGS, ifr) == -1) {
				DPRINTF("ioctl(SIOCSIFFLAGS), errno=%d (%s)\n", 
					errno, strerror(errno));
				ret = TERR_IOCTL;
				goto outfree;
			}

			/* record the fact that we modified this interface */
			pcap->iface[pcap->ifcount].promisc = 1;
			DPRINTF("Enabled promisc. mode on %s (0x%x)\n", 
					pcap->iface[pcap->ifcount].ifname,
					pcap->iface[pcap->ifcount].addr);
		}

		pcap->ifcount++;
	}

outfree:
	free(ifreqs);

outclose:
	close(fd);

	return ret;
}

