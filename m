Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUJXS76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUJXS76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUJXS76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:59:58 -0400
Received: from pop-a065c32.pas.sa.earthlink.net ([207.217.121.247]:18078 "EHLO
	pop-a065c32.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261586AbUJXS7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:59:48 -0400
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: linux-kernel@vger.kernel.org
Subject: Re: Netlink Implementation.
Date: Sun, 24 Oct 2004 13:59:55 -0500
User-Agent: KMail/1.6.2
References: <200410202017.08654.eric@cisu.net> <200410221751.30798.eric@cisu.net>
In-Reply-To: <200410221751.30798.eric@cisu.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410241359.55369.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LKML,

	Here is my post from Linux-net. I am re-posting here because it's appropriate 
and I have not met with a resolution on linux-net :(

Hello again code gurus :)

	Yes another fight in my netlink saga. Thanks to all who have replied before 
and I have learned alot from the rfc's and zebra/iproute and have contructed 
a much more robust implementation. I have sent the kernel a message defined 
as below. However I have not learned what exactly I should be expecting from 
the kernel. That is, my message gets a reply from the kernel about eth0, 
however on my machine i have eth0,1,2,ppp0 and I would like information about 
them all. I have NLM_F_ROOT set on the packet as I was under the impression 
that this would dump information about all the interfaces. I have also tried 
incrementing   msg.info.ifi_index to 0,1,2,3 etc. No matter what these values 
I always recieve this output form my program.
#./nl_test_prog
Found device: eth0 - 1
Found address:             <--(Dont care about blank yet, main problem is only
					    1 if shows. This is minor)
Received end of msg.

-Am I wrong to expect the kernel to send me data about all the interfaces? 
-Am I calling this wrong?
-What can I do to query all the interfaces?

 I do loop through all the rta messages and I receive only 1 nlmsg packet from 
the kernel when calling recvmsg(). I have also tried without OR'ing 
NLM_F_MATCH. I have run it through a debugger and confirmed although there 
are multiple RTA atributes in my netlink packet but they all refer to eth0.

-Should I be expecting multiple packets (NLM_F_MULTI)?

Here is my nl_packet construction.

  msg.hdr.nlmsg_len = sizeof(msg);
  msg.hdr.nlmsg_type = RTM_GETLINK;
  msg.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT | NLM_F_MATCH; 
  msg.hdr.nlmsg_pid = getpid();
  msg.hdr.nlmsg_seq = seq++; 
  msg.info.ifi_family = AF_UNSPEC; //AF_UNSPEC for ipv4
  msg.info.ifi_type = NETLINK_ROUTE;
  msg.info.ifi_index = 0;
  msg.info.ifi_change =  (0-1); 

----------------Looping over the attributes later in code--------------
/* Loop over the attributes in this message */
    while(RTA_OK(rta, len))
    {
      switch(rta->rta_type)
      {
      case IFLA_IFNAME:
        cout << "Found device: " << (char *)RTA_DATA(rta)<< " - " <<  
info->ifi_index << endl;
        break;
      case IFLA_ADDRESS:
        cout << "Found address: " << (char *)RTA_DATA(rta) << endl;
        break;
      }
      rta = RTA_NEXT(rta, len);
      /* We hit the next packet */
    }// Packet Looping while()


More info/code available upon request.

Any help would be appreciated.

----------------------------------------
EB

> All is fine except that I can reliably "oops" it simply by trying to read
> from /proc/apm (e.g. cat /proc/apm).
> oops output and ksymoops-2.3.4 output is attached.
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

		--Alan Cox 2000-12-08 

----------------------------------------
