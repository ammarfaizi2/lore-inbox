Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289380AbSBENRD>; Tue, 5 Feb 2002 08:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289496AbSBENQy>; Tue, 5 Feb 2002 08:16:54 -0500
Received: from mailhost.cs.tamu.edu ([128.194.130.106]:60140 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S289380AbSBENQq>;
	Tue, 5 Feb 2002 08:16:46 -0500
Date: Tue, 5 Feb 2002 07:16:44 -0600 (CST)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: IP fragment
Message-ID: <Pine.SOL.4.10.10202050628350.24459-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,
	One night!!!

	I use linux-2.4.17 and iptables is os integrated. But no rules
are set. So iptables should not influence the following
experiments (don't know ??).
	
	This whole night I tried to use 
socket(AF_INET,SOCK_RAW,IPPROTO_RAW) socket to generate artificial
fragment packets: 

1. In my first experiment, I generated a UDP packet whose data length was
61 bytes, not including
ip header and udp header and this packet can be sent out. I used Ethereal
and saw it.

2. In the second experiment, the construted UDP packet will not
be sent out. When the UDP
packet is ready, I fragmented it into two packets. The data length (not
including ip header) of the first packet was 24. And the second packet was
45 bytes long (not including ip header). Of course I tried to set "more
fragment" bit in the first packet and the second packet had no such
setting. But I never sent these two packets out and ethereal could not see
either of them.

3. In the third experiment, I reset the "more fragment" bit of the first
packet of these two fragments to 0. This time, I can see this packet, but
still never saw the second packet. Of couse the first packet had a wrong
udp checksum.

So what's the problem?

1. Does (SOCK_RAW,IPPROTO_RAW) socket allow me to do fragments in suer
sapce?
2. Or does my program have some problem?

Thanks! 
 
I attached my fragmentation code below and hope someone can help me.

Xinwen Fu

/*

  Fragment the ip packet "srcip" into "num_frag" fragments, the size of
each fragment (ip payload not including ip header) is
  specified in table "each_frag", the fragments are returned by "frags"

**************************************************************************
Function: make_fragment
Description: fragment IP packets.
Status: 
***************************************************************************
 */

int make_fragment(struct ip *srcip, u16 num_frag, u16 *each_frag, struct ip *frags[]) {

  u16 i,total_size=0;
  u16 frag_offset=0;

  /*************************************
  check if the fragment size is correct
  **************************************/
  for (i=0; i<num_frag; i++) {
    total_size+=each_frag[i];
  }

  if ( ntohs(srcip->ip_len) - sizeof(struct ip)  != total_size) {
    return -1;
  }

  /**************************************
    fragment the packet
  **************************************/
  for (i=0; i<num_frag; i++) {

    frags[i]=(struct ip *)calloc(sizeof(struct ip) + each_frag[i], sizeof(char)); /* allocate enough memory */
    
    /****************************************
      create a fragment
     ****************************************/
    memcpy((char *) frags[i]+ sizeof(struct ip), (char *)srcip + sizeof(struct ip) + frag_offset, each_frag[i]); /* first copy data -payload to payload */
    
    /****************************************
      form the header
    ********************************************/
    frags[i]->ip_hl         = srcip->ip_hl;   /* Headerlength with no options ???????????????????  */
    frags[i]->ip_v          = srcip->ip_v;
    frags[i]->ip_tos        = srcip->ip_tos;
    frags[i]->ip_len        = htons(each_frag[i] + sizeof(struct ip));
    frags[i]->ip_id         = srcip->ip_id;
    frags[i]->ip_off        = frag_offset >> 3;
 
    if (i < num_frag-1) {
      frags[i]->ip_off = frags[i]->ip_off | IP_MF;
    }

    frags[i]->ip_ttl        = srcip->ip_ttl ;
    frags[i]->ip_p          = srcip->ip_p;
    frags[i]->ip_sum        = 0;   /* Fill in later */
    frags[i]->ip_src.s_addr = srcip->ip_src.s_addr;
    frags[i]->ip_dst.s_addr = srcip->ip_dst.s_addr;
    frags[i]->ip_sum        = ip_sum_calc(sizeof(struct ip), (u16 *)frags[i]);

    frag_offset+=each_frag[i];
  }

  return 0;

}


