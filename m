Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUCLPlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUCLPlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:41:06 -0500
Received: from web25203.mail.ukl.yahoo.com ([217.12.10.63]:58025 "HELO
	web25203.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262100AbUCLPk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:40:58 -0500
Message-ID: <20040312154057.31369.qmail@web25203.mail.ukl.yahoo.com>
Date: Fri, 12 Mar 2004 16:40:57 +0100 (CET)
From: =?iso-8859-1?q?Fr=E9d=E9ric=20BECK?= <beck_fred@yahoo.fr>
Subject: (MLD/Mobile IPv6) Sending in a tunnel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I aim at making a MLD General Query and sending it in
the tunnels towards the mobiles. I successfuly create
the message which is correct, it works when i send on
the LAN interface (i'm working on the home agent), but
i get an error "Network is unreachable" when i send it
on a tunnel interface.

Here follows the source code. Has anyone a clue ?

Thx 
Fred

#########################################################

/** The structure of a MLDv1 report */
struct mld6_v1_hdr {
	/** The ICMPv6 structure */
	struct icmp6_hdr	mld_icmp6_hdr;
	/** The IPv6 address of the multicast group */
	struct in6_addr		mld6_addr;
};

int send_general_query(int iface)
{
	struct mld6_v1_hdr mld;
	int offset = 2;
	int length;
	int sockfd;
	
	struct sockaddr_in6 src;
	struct sockaddr_in6 dst;
	
	struct msghdr msgh;
	struct cmsghdr *cmsgh;
	struct iovec iovector;
	char control[128];
	
	/* ra is the complete HOP-by-HOP router alert option
*/
	
	char ra[8] = { IPPROTO_ICMPV6, 0, IPV6_TLV_PADN, 0,
			IPV6_TLV_ROUTERALERT, 2, 0, 0 };
	
	/* an ICMP socket for the home agent LAN interface */
	if( (sockfd = socket( AF_INET6, SOCK_RAW,
IPPROTO_ICMPV6)) <0 )
	{
		perror("Socket Creation");
		return -1;
	}
	
	memset( &src, 0, sizeof(struct sockaddr_in6) );
	memset( &dst, 0, sizeof(struct sockaddr_in6) );
	/* dest address is ff02::1 */
    if( (inet_pton(AF_INET6, "ff02::1",
&dst.sin6_addr)) == -1)
    {
        fprintf(stderr,"send_general_query : Problem
with address resolution\n");
        if(debug_lvl == VERBOSE)
			fprintf(log_file,"send_general_query : Problem with
address resolution\n");
		return FALSE;
    }   
	dst.sin6_family = AF_INET6;
	dst.sin6_port = htons(0);
	dst.sin6_scope_id = iface;
	/* Setting up SRC */
	src.sin6_family = AF_INET6;
	src.sin6_port = htons(0);
	src.sin6_addr = member_tab.oif_addr; /* my ipv6
addressz */
	src.sin6_scope_id = iface;
	length = sizeof(struct sockaddr_in6);
	if ( bind(sockfd, (struct sockaddr *)&src, length) ==
-1)
	{
		perror("Could not bind");
		return -1;
	}
	
	/* the MLD v1 query message */
	memset( &mld, 0, sizeof(struct mld6_v1_hdr) );
	mld.mld_icmp6_hdr.icmp6_type =
ICMP6_MEMBERSHIP_QUERY;
	mld.mld_icmp6_hdr.icmp6_code = 0;
	mld.mld_icmp6_hdr.icmp6_cksum = 0;
	mld.mld_icmp6_hdr.icmp6_dataun.icmp6_un_data16[0] =
htons(100);
	mld.mld_icmp6_hdr.icmp6_dataun.icmp6_un_data16[0] =
0;
	mld.mld6_addr = in6addr_any;
	
	memset( &iovector, 0, sizeof(struct iovec) );
	iovector.iov_base = &mld;
	iovector.iov_len = sizeof(struct mld6_v1_hdr);
	
	memset( &msgh, 0, sizeof(struct msghdr) );
	msgh.msg_name = &dst;
	msgh.msg_namelen = sizeof(struct sockaddr_in6);
	msgh.msg_iov = &iovector;
	msgh.msg_iovlen = 1;
	msgh.msg_control = control;
	msgh.msg_controllen = 128;
	
	/* set ancillary data options + copy hop-by-hop
option */
	cmsgh = CMSG_FIRSTHDR(&msgh);
	cmsgh->cmsg_len = CMSG_LEN(8);
	cmsgh->cmsg_level = SOL_IPV6;
	cmsgh->cmsg_type = IPV6_HOPOPTS;
	memcpy( (void *)CMSG_DATA(cmsgh), (void *)ra,
sizeof(ra) );
	msgh.msg_controllen = cmsgh->cmsg_len;
	
	/* ask kernel to compute ICMP checksum */
	if (setsockopt(sockfd,
IPPROTO_IPV6,IPV6_CHECKSUM,&offset,sizeof(offset)) <
0)
        {  
		perror ("Couldn't setsockopt IPV6_CHECKSUM");
		return(-1);
        }

	if( (sendmsg( sockfd, &msgh, MSG_DONTROUTE )) <= 0)
	{
		perror("(V1)Problem with sendmsg");
		return -1;
	}
	
	close(sockfd);
	return 0;
}



	

	
		
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout ! 
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
