Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSFKAHN>; Mon, 10 Jun 2002 20:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSFKAHN>; Mon, 10 Jun 2002 20:07:13 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:21770 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S316573AbSFKAHM>; Mon, 10 Jun 2002 20:07:12 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Brad Hards <bhards@bigpond.net.au>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: netlink documentation (was: of ethernet names)
In-Reply-To: Your message of "Tue, 11 Jun 2002 09:32:44 +1000."
             <200206110932.44185.bhards@bigpond.net.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jun 2002 17:06:52 -0700
Message-Id: <E17HZBU-0000Jm-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>But I can't even follow enough of iproute (or zebra, which also uses netlink, 
>AFAICT) to figure out how to do basic stuff like a list of configured 
>networking devices, or set the default route.

E.g. to get the list of devices (untested, lacking error checking, etc), 
use something like:

    struct {
	struct nlmsghdr  hdr;
	struct ifinfomsg info;
    } msg;
    struct sockaddr_nl addr;

    /* Create and bind the netlink socket */
    netlink_sk = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);

    memset(&addr, 0, sizeof(addr));
    
    addr.nl_family = AF_NETLINK;
    addr.nl_pid    = getpid();
    addr.nl_groups = RTMGRP_IPV4_IFADDR;

    bind(netlink_sk, (struct sockaddr *)&addr, sizeof(addr)));

    /* Build the netlink request */
    memset(&msg, 0, sizeof(msg));
    msg.hdr.nlmsg_len   = sizeof(msg);
    msg.hdr.nlmsg_type  = RTM_GETLINK;
    msg.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_MATCH;
    msg.hdr.nlmsg_pid   = getpid();
    msg.hdr.nlmsg_seq   = 0;

    msg.info.ifi_family = AF_UNSPEC;
    msg.info.ifi_type   = 0;
    msg.info.ifi_index  = 0;
    msg.info.ifi_change = -1;

    /* Send the message */
    send(netlink_sk, &msg, msg.hdr.nlmsg_len, 0);

    /* Loop, as we might get replies spread over several packets */
    while((bytes = recv(netlink_sk, replybuf, sizeof(replybuf), 0))) {
        struct nlmsghdr *hdr = (struct nlmsghdr *)replybuf;

        if(hdr->nlmsg_type == NLMSG_DONE) {
            break;
        }
	
	/* Loop over the messages in this packet */
        while(bytes) {
            int len = hdr->nlmsg_len;

            struct ifinfomsg *info = NLMSG_DATA(hdr);
            struct rtattr *rta = IFLA_RTA(info);    
            
            
            len -= NLMSG_LENGTH(sizeof(*info));
            
            /* Loop over the attributes in this message */
            while(RTA_OK(rta, len)) {
                switch(rta->rta_type) {
                case IFLA_IFNAME:
                    printf("Found device %s - %u\n", 
                           RTA_DATA(rta), info->ifi_index);

                    break;
                }
                
                rta = RTA_NEXT(rta, len);
            }
            
            bytes -= hdr->nlmsg_len;
            ((void *)hdr) += hdr->nlmsg_len;
        }
        
    }

Paul

