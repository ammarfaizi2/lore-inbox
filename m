Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271679AbRIGKbr>; Fri, 7 Sep 2001 06:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRIGKbj>; Fri, 7 Sep 2001 06:31:39 -0400
Received: from gallions-reach.inpharmatica.co.uk ([193.115.214.5]:43785 "EHLO
	gallions-reach.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S271680AbRIGKb1>; Fri, 7 Sep 2001 06:31:27 -0400
Message-ID: <3B98A1C0.6010200@purplet.demon.co.uk>
Date: Fri, 07 Sep 2001 11:30:24 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: Wietse Venema <wietse@porcupine.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906173948.502BFBC06C@spike.porcupine.org>
Content-Type: multipart/mixed;
 boundary="------------000807000303050605000203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807000303050605000203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wietse Venema wrote:
> The SMTP RFC requires that user@[ip.address] is correctly recognized
> as a final destination.  This requires that Linux provides the MTA
> with information about IP addresses that correspond with INADDR_ANY.
> 
> I am susprised that it is not possible to ask such information up
> front (same with netmasks), and that an application has to actually
> query a complex oracle, again and again, for every IP address.

If I understand correctly you want to get a full list of addresses
and netmasks that have been assigned to interfaces?

   Use netlink. I'm sure someone else has said that but I haven't
read the entire thread, just scanned for the almost certainly
required example attachment (netlink is only straight forward once
you have an example :-( ). Attached is something that simply
asks for the current addresses (and "aliases"). It should be fairly
easy to use.

   The advantage with netlink is that you can just add the socket to
your select/poll list and listen for address changes as they happen
(useful for DHCP clients, maybe fail over scenarios etc.?). This code
doesn't do that. But if you add "while (1) netlink_read(s);" at the
bottom it will merrily report address changes - probably while sucking
CPU time, I suddenly have the feeling I left the set non-blocking
line in there!

				Mike
P.S. It's IPv4. Adding IPv6 is left as an exercise for the reader :-)

--------------000807000303050605000203
Content-Type: text/plain;
 name="netlink.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netlink.c"

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/syslog.h>
#include <sys/time.h>
#include <sys/uio.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <asm/types.h>
#include <linux/rtnetlink.h>


static int netlink_seq = 0;


static void
netlink_parse_rtattr(struct rtattr **tb, int max, struct rtattr *rta, int len)
{
	while (RTA_OK(rta, len)) {
		if (rta->rta_type <= max)
			tb[rta->rta_type] = rta;
		rta = RTA_NEXT(rta,len);
	}
}


static int
netlink_ifaddr(struct sockaddr_nl *snl, struct nlmsghdr *h)
{
	int len;
	struct ifaddrmsg *ifa;
	struct rtattr *tb[IFA_MAX + 1];
	struct in_addr *addr = NULL;

	ifa = NLMSG_DATA(h);

	len = h->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
	if (len < 0)
		return -1;

	memset(tb, '\0', sizeof(tb));
	netlink_parse_rtattr(tb, IFA_MAX, IFA_RTA(ifa), len);

	if (tb[IFA_LOCAL])
		addr = RTA_DATA(tb[IFA_LOCAL]);
  	else if (tb[IFA_ADDRESS])
    		addr = RTA_DATA(tb[IFA_ADDRESS]);
	else
		return -1;

	fprintf(stderr,
		"Netlink %s: iface index %d, IPv4 address: %s/%d\n",
		h->nlmsg_type == RTM_NEWADDR ? "add" : "del",
		ifa->ifa_index, inet_ntoa(*addr), ifa->ifa_prefixlen);
	return 0;
}


int
netlink_open()
{
	int s;
	struct sockaddr_nl snl;

	s = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (s < 0) {
		fprintf(stderr, "Can't open netlink socket: %s\n", strerror(errno));
		return -1;
	}

	fcntl(s, F_SETFL, O_NONBLOCK);
  
	memset(&snl, '\0', sizeof(snl));
	snl.nl_family = AF_NETLINK;
	snl.nl_groups = RTMGRP_IPV4_IFADDR;
  
	if (bind(s, (struct sockaddr *)&snl, sizeof(snl)) < 0) {
		fprintf(stderr, "Can't bind netlink socket: %s\n", strerror(errno));
		close(s);
		return -1;
	}

	return s;
}


int
netlink_request(int s, int family, int type)
{
	struct sockaddr_nl snl;

	struct {
		struct nlmsghdr nlh;
		struct rtgenmsg g;
	} req;

	memset(&snl, '\0', sizeof(snl));
	snl.nl_family = AF_NETLINK;

	req.nlh.nlmsg_len = sizeof(req);
	req.nlh.nlmsg_type = type;
	req.nlh.nlmsg_flags = NLM_F_ROOT | NLM_F_MATCH | NLM_F_REQUEST;
	req.nlh.nlmsg_pid = 0;
	req.nlh.nlmsg_seq = ++netlink_seq;
	req.g.rtgen_family = family;
  
	if (sendto(s, (void *)&req, sizeof(req), 0, 
		(struct sockaddr *)&snl, sizeof(snl)) < 0)
	{
		fprintf(stderr, "netlink sendto failed: %s\n", strerror (errno));
		return -1;
	}

	return 0;
}


int
netlink_read(int s)
{
	int status;
	int seq = 0;

	while (1) {
		char buf[4096];
		struct iovec iov = { buf, sizeof(buf) };
		struct sockaddr_nl snl;
		struct msghdr msg = {
			(void *)&snl, sizeof(snl), &iov, 1, NULL, 0, 0
		};
		struct nlmsghdr *h;

		status = recvmsg(s, &msg, 0);
		if (status < 0) {
			if (errno == EINTR)
				continue;
			if (errno == EWOULDBLOCK)
				return 0;
			fprintf(stderr, "netlink recvmsg: %s\n", strerror(errno));
	  		continue;
		}

		if (status == 0) {
			fprintf(stderr, "netlink EOF\n");
			return -1;
		}

		if (msg.msg_namelen != sizeof(snl)) {
			fprintf(stderr, "netlink length error: %d != %d\n",
				msg.msg_namelen, sizeof(snl));
			return -1;
		}

		for (h = (struct nlmsghdr *) buf;
			NLMSG_OK(h, status); 
			h = NLMSG_NEXT(h, status))
		{
			seq = h->nlmsg_seq;
			if (h->nlmsg_type == NLMSG_DONE)
				return 0;

			if (h->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
				if (h->nlmsg_len < NLMSG_LENGTH(sizeof(struct nlmsgerr)))
					fprintf(stderr, "netlink: message truncated\n");
				else
					fprintf(stderr, "netlink: %s\n", strerror(-err->error));
				return -1;
			}

			switch (h->nlmsg_type) {
				case RTM_NEWADDR:
				case RTM_DELADDR:
					netlink_ifaddr(&snl, h);
					break;
			}
		}

		if (msg.msg_flags & MSG_TRUNC) {
			fprintf(stderr, "netlink: message truncated\n");
			continue;
		}

		if (status) {
			fprintf(stderr, "netlink: excess data, size %d\n", status);
			return -1;
		}

		/* This message is in reply to a user request. */
		if (seq == 0)
			return 0;
	}

	return 0;
}


int
main(int argc, char *argv[])
{
	int s;

	s = netlink_open();
	if (s >= 0) {
		netlink_request(s, AF_INET, RTM_GETADDR);
		netlink_read(s);
	}
}

--------------000807000303050605000203--

