Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUHYJk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUHYJk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHYJk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:40:29 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:55773
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S264246AbUHYJkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:40:18 -0400
Message-ID: <412C5E80.8050603@bio.ifi.lmu.de>
Date: Wed, 25 Aug 2004 11:40:16 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1: ip auto-config accepts wrong packages 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we are running a diskless client system using kernel ip autoconfiguration.
The problem is that sometimes clients accept packages that are meant
for other clients.


All clients load the kernel via pxeboot. The pxelinux.cfg contains
the following append line:

append ip=dhcp nfsroot=/,tcp,nfsvers...

Usually everything goes fine. But if two clients send the dhcp request
in the kernel at almost the same time, sometimes they accept the answer
for the other client and then two clients end up with the same IP.

E.g., we have two clients:

   host turan {
     hardware ethernet  ...:02:11:84;
     fixed-address      ....1.167;
  }

   host rado {
     hardware ethernet  ...:02:11:A5;
     fixed-address      ....1.168;
  }

And sometimes we see this output from the kernel on the boot screen:

--
Sending dhcp request. <6>tg3: eth0: Link is up at 100Mbps, full duplex.
tg3: eth0: FLow control is on for TX and on for RX
,.,., OK
IP-Config: Got DHCP answer from ...1.132, my address is ...1.167
--

But this *identical* output appears on *both* screens, i.e., also on the
screen of the host with the MAC :11:A5 that shouldget .168 as IP.
In the server log I find this:

Aug 25 10:03:26 curry dhcpd: DHCPDISCOVER from ..:11:84 via eth0
Aug 25 10:03:26 curry dhcpd: DHCPOFFER on ...1.167 to ...:11:84 via eth0
Aug 25 10:03:26 curry dhcpd: DHCPREQUEST for ...1.167 (...1.132) from ...:11:a5 via eth0: lease ....1.167 unavailable.
Aug 25 10:03:26 curry dhcpd: DHCPNAK on ...1.167 to ...:11:a5 via eth0
Aug 25 10:03:28 curry dhcpd: DHCPDISCOVER from ...:11:a5 via eth0
Aug 25 10:03:28 curry dhcpd: DHCPOFFER on ...1.168 to ...:11:a5 via eth0
Aug 25 10:03:28 curry dhcpd: DHCPREQUEST for ...1.168 (...1.132) from ...:11:84 via eth0: lease ...1.168 unavailable.
Aug 25 10:03:28 curry dhcpd: DHCPNAK on ...1.168 to ...:11:84 via eth0
Aug 25 10:03:28 curry dhcpd: DHCPREQUEST for ...1.168 (...1.132) from ...:11:a5 via eth0
Aug 25 10:03:28 curry dhcpd: DHCPACK on ...1.168 to ...:11:a5 via eth0

So it looks like the first client request is detected at 10:03:26 and the
answer is sent, but likely the second client has also sent its request in
the meantime, and now both clients accept the answer meant only for
the first client.
Then, when the second request is detected at 10:03:28 and answered,
again both clients answer to it.

 From tcpdump on the server I can indeed see that the server gets a
BOOTPREQUEST from :11:84 asking for everything, and it sends a
BOOTREPLY with the IP .1.167.

Next it gets a BOOTREQUEST from the :11:a5 address asking for the
usual parameters (Mask etc.), but it has option 50 set:
OPTION:  50 (  4) Request IP address        141.84.1.167

Then the answer from the server is of course the DHCPNAK.

Thus, it seems that the clients accept any answer without checking if
the packet is really for them during the IP autoconfig in the kernel.
Can/should they do that?

I wasn't able to reproduce the problem from the command line using
dhclient, so I'm not sure if this is a general problem with dhcp or
a problem in the ip-autoconfig code of the client.

Server and Clients both run 2.6.8.1 and the dhcp server is the ISC DHCP
server version 3.0.1rc12.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

