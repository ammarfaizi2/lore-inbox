Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293716AbSCFRzo>; Wed, 6 Mar 2002 12:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293732AbSCFRzf>; Wed, 6 Mar 2002 12:55:35 -0500
Received: from angelo.kcl.ac.uk ([137.73.66.5]:28906 "EHLO angelo.kcl.ac.uk")
	by vger.kernel.org with ESMTP id <S293716AbSCFRzY>;
	Wed, 6 Mar 2002 12:55:24 -0500
Message-Id: <200203061741.g26HfEIq024218@angelo.kcl.ac.uk>
Content-Type: text/plain; charset=US-ASCII
From: costas <konstantinos.boukis@kcl.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: problem with ioctl SIOCSARP or is it?
Date: Wed, 6 Mar 2002 17:42:11 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, can anybody from the linux kernel developers tell me what is wrong with 
proxy arp in kernel 2.4. I just want to configure my machine so as to act as 
an arp proxy. When I do arp -s <ipaddr> <hwaddr> pub the kernel adds the 
following line to my arp cache:
Address                  HWtype  HWaddress           Flags Mask     Iface
ipaddr 		     * 	      *                   	MP                  eth0
and when I am trying to ping the newly configured node I receive destination 
unrichable message.
On the other hand I have the following programme which is supposed to do the 
same task, however it adds exactly the same entry in the arp cache, and I 
have also the same result as before when I try to ping the new node

int
main(argc, argv)
        int                     	argc;
        char                    	**argv;
{
        int            	    	tunfd;
        IP_addr    	   	ip_addr;
        struct ifreq            	ifreq;
        struct arpreq    	arp;
        struct ether_addr       	ea;
        struct sockaddr_in      *paddr;

        if( argc != 2){
                printf("Usage: tunnel <IP ADDRESS>\n");
                exit(1);
        }

        if( (inet_pton(AF_INET, *(argv + 1), &ip_addr)) < 0)
                err_sys("inet_pton error");

        if( (tunfd = socket(PF_INET, SOCK_DGRAM, 0)) < 0)
                err_sys("socket error");

        strcpy(ifreq.ifr_name, "eth0");
        if( ioctl(tunfd, SIOCGIFHWADDR, &ifreq))
                err_sys("ioctl error");

        memcpy(&ea, ifreq.ifr_hwaddr.sa_data, ETH_ALEN);

        memset(&arp, 0x00, sizeof(arp));

        paddr = (struct sockaddr_in*) &arp.arp_pa;
        bzero(paddr, sizeof(Sockaddr_in));
        paddr->sin_family = AF_INET;
        memcpy(&paddr->sin_addr, &ip_addr, sizeof(IP_addr));

        arp.arp_ha.sa_family = ARPHRD_ETHER;
        /*I tryied also AF_UNSPEC*/

        memcpy(arp.arp_ha.sa_data, ea.ether_addr_octet, ETH_ALEN);

        arp.arp_flags |= ATF_PUBL;

        strcpy(arp.arp_dev, "eth0");

        if( ioctl(tunfd, SIOCSARP,  &arp))
                err_sys("ioctl error");

        if(close(tunfd))
                err_sys("close error");

        return 0;
}

All I want to know is if there is a problem with ioctl SIOCSARP. Is there any 
other way to add entries to my arp cache? I heard about netlink sockets but 
except the manual page I found nothing else.
Regards
Costas

PS1. The net.ipv4.conf.all.proxy_arp flag is set.
PS2. I subscribed to the kernel mailing list a few hours ago but still 
haven't received any mail, so please if somebody answers include me in the cc:
Cheers
