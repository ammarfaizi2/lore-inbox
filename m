Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSGVJAv>; Mon, 22 Jul 2002 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSGVJAu>; Mon, 22 Jul 2002 05:00:50 -0400
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:60176 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S316594AbSGVJAt>; Mon, 22 Jul 2002 05:00:49 -0400
Date: Mon, 22 Jul 2002 11:03:56 +0200
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: When does PF_PACKET, SOCK_DGRAM lose packets, and how do I notice that?
Message-ID: <20020722110356.A16287@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have modified the net-accounting daemon net-acct
(http://exorsus.net/projects/net-acct/) to use PF_PACKET, SOCK_DGRAM
to be able to access the packet type (I am only interested in outgoing
packets).

This is the relevant part of my code (prepare for userspace code ahead
;) ), debugging code and some comments removed:

void init_capture()
{
    struct ifreq ifr;
    struct promisc_device *p;
    struct protoent *pr;

    if ((capture_sd = socket (PF_PACKET, SOCK_DGRAM, htons (ETH_P_ALL))) < 0)
	{
	    syslog(LOG_ERR, "can't get socket: %m\n");
	    daemon_stop(0);
	}
}


void packet_loop()
{
  struct sockaddr_ll saddr_ll;
  int sizeaddr_ll;
  unsigned char buff[1600];
  unsigned char *buf;
  int length;
  static struct iphdr *tmp_iphdr;
  int dynamicstyle;
  int do_user;
  __u32 dynamicaddr, otheraddr;
  char *user;
  struct promisc_device *p;
  int found = 0;
  struct mon_host_struct *ptr;    

  /* For getting the ifname from ifindex --hillu */
  struct ifreq ifr;

  dynamicstyle = (dev2line != NULL) ? 1 : ((cfg->dynamicip != NULL) ? 2 : 0);

  buf = &buff[20];

  while (running)
    {
      sizeaddr_ll = sizeof(struct sockaddr_ll);
      length = recvfrom (capture_sd, buf, 127, 0, 
			 (struct sockaddr *) &saddr_ll, &sizeaddr_ll);

      if (length == -1)
	{
	  continue;
	}
      /*We capture ETH_P_ALL, only process IP packages. --hillu */
      if (ntohs(saddr_ll.sll_protocol) != ETH_P_IP)
	continue;
      
      /* Get devicename from interface index --hillu */
      ifr.ifr_ifindex = saddr_ll.sll_ifindex;

      do_user = 0;

      /* determine various reasons to ignore the packet, continue if ignore */
      /* code removed. debug information is written for each ignored packet */
      /* so I know that nothing is ignored here in the test cases

      if((tmp_iphdr->saddr & cfg->ignoremask) == (tmp_iphdr->daddr & cfg->ignoremask))
	{
	  packets->local++;
	  continue;
	}
      else
	{
	  /* snip code for ignoring entire networks. Again, packets ignored */
	  /* here produce debug output, so no chance of packets */
	  /* slipping here                                      */
	  packets->ip++;
	  user = NULL;

	  /* snip code handling dynamic IPs, no possibility to exit here */

 	  handle_ip(buf, ifr.ifr_name, user, saddr_ll.sll_pkttype);
	}
    }
}

The buffer handling (buf and buff, and the 20 index) is broken, but
seems to be correct nevertheless. Didn't dare to change it yet.

Until I goofed badly, I can be pretty sure that every packet given to
me by recvfrom either gets dropped (and logged!), or handed down to
the handle_ip function, which looks like that everything handed down
there eventually ends up in the log file.

While testing in a lab setup, this works fine, and the data accounted
for is accurate. However, when I put the program on a loaded system,
it seems to lose data. Here is a description of my tests:

Diesen Code haben wir in eine Veränderung des netacctd eingebracht,
und das hat im Labor und im Feldtest auch problemlos funktioniert.
Seit einigen Tagen läuft der modifizierte netacct auf einem Router,
der unsere gesamte Netzlast abbekommt, und in diesem Kontext verliert
diese Konstruktion leider Daten:

-------------------
| Test machine Q  |
-------------------
       |
       |
------------------
| Linux router L |
------------------
       |
       |
------------------
| Cisco router C |
------------------
       |
       |
-------------------
| Testr machine S |
-------------------


(1)
For testing, I send exactly 1 MB of data over a tcp connection from Q
to S.

(2)
L runs the modified netacctd, logging packets on both interfaces, and
a tcpdump "src host A and tcp port 10000". The tcpdump loggs exactly
728 packets.

(3)
C is in the setup for reference and has "ip accounting output-packets"
set on both interfaces.

(4)
net-acct running on L logs significantly less data volume between Q
and S as the tcpdump and the IP accounting on C does. The amount of
data loss seems to be random, starting from just a few packets of the
728, but sometimes amounting to 400 Packets being lost. Even data
accounted on both interfaces of L differs.

I suspect that data is not polled quickly enough so that a buffer
overflows, causing packets not to be seen by my userspace code. Since
I am pretty confident that my code either correctly dumps the packet
into the accounting log or drops it (generating debugging output in
the process), I suspect that the data is being lost on the socket.

The system does not seem to be overloaded, it is moving about 5000
packets a second on 4 interfaces; CPU statistics show 10 % user, 20 %
system and 70 % idle. Under these circumstances, I think that it
should be possible to poll the socket often enough to prevent data
from being lost.

When I remove the "base load" from the system, leaving only my test
traffic (1 MB from Q to S) on the network, all packets are accounted
for, making the chance for a programming error in the netacct
smaller. This must be some weird kind of buffering problem, I think.

Is there a possibility to ask the kernel if data has been lost on the
DGRAM socket so that I am able to raise a flag to the operators that
they'd better look after the system? Or is my diagnosis wrong and I am
losing data somewhere else?

Thanks for your comments, I really appreciate it.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
