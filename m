Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319855AbSINGLJ>; Sat, 14 Sep 2002 02:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319856AbSINGLJ>; Sat, 14 Sep 2002 02:11:09 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:1188 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S319855AbSINGLE>;
	Sat, 14 Sep 2002 02:11:04 -0400
Message-ID: <3D82D419.60801@candelatech.com>
Date: Fri, 13 Sep 2002 23:15:53 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: TCP connection establishment question (send to self)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm continuing work on getting a machine to send packets to itself
over external interfaces.  Arp and UDP now work with a few small hacks,
as hinted to by Alexey....

TCP/IP is not working as well as I had hoped.  After binding to the
interface, and opening a listening socket, I attempt to connect.  I
see the first packet go across the looped back wire, but I can get
no response to the initial SYN packet.  From printks in the kernel, I
see that this code is hit in tcp_v4_do_rcv:

	if (sk->state == TCP_LISTEN) {
		struct sock *nsk = tcp_v4_hnd_req(sk, skb);
                 printk("tcp_v4_do_rcv: listen, saddr: %x, nsk: %p, sk: %p\n",
                        skb->nh.iph->saddr, nsk, sk);
		if (!nsk)
			goto discard;

		if (nsk != sk) {
			if (tcp_child_process(sk, nsk, skb))
				goto reset;
			return 0;
		}
	}

nsk is null, because this code is hit in tcp_check_req (tcp_v4_search_req found something):

	/* RFC793 page 36: "If the connection is in any non-synchronized state ...
	 *                  and the incoming segment acknowledges something not yet
	 *                  sent (the segment carries an unaccaptable ACK) ...
	 *                  a reset is sent."
	 */
	if (!(flg & TCP_FLAG_ACK)) {
                 if ((skb->nh.iph->saddr == 0x7102a8c0) || (skb->nh.iph->saddr == 0x7002a8c0)) {
                         printk("not TCP_FLAG_ACK, flg: 0x%x...\n", flg);
                 }
		return NULL;
         }

 From my old networking book, it appears that the first packet does not
need the ACK flag.  A network trace of a connection between two computers
does not show the ACK flag in the first packet...

I am using SO_BINDTODEVICE on the connecting and accepting sockets, I'm
also using source-based routing.

Any suggestions would be welcome, of course!


Here is the wire capture of the attempted connection:

Frame 1 (74 on wire, 74 captured)
     Arrival Time: Sep 13, 2002 22:34:26.679702000
     Time delta from previous packet: 0.000000000 seconds
     Time relative to first packet: 0.000000000 seconds
     Frame Number: 1
     Packet Length: 74 bytes
     Capture Length: 74 bytes
Ethernet II
     Destination: 00:07:e9:09:62:ee (Intel_09:62:ee)
     Source: 00:07:e9:09:5e:3a (Intel_09:5e:3a)
     Type: IP (0x0800)
Internet Protocol, Src Addr: 192.168.2.112 (192.168.2.112), Dst Addr: 192.168.2.113 (192.168.2.113)
     Version: 4
     Header length: 20 bytes
     Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00)
         0000 00.. = Differentiated Services Codepoint: Default (0x00)
         .... ..0. = ECN-Capable Transport (ECT): 0
         .... ...0 = ECN-CE: 0
     Total Length: 60
     Identification: 0xbc8a
     Flags: 0x04
         .1.. = Don't fragment: Set
         ..0. = More fragments: Not set
     Fragment offset: 0
     Time to live: 64
     Protocol: TCP (0x06)
     Header checksum: 0xf7ff (correct)
     Source: 192.168.2.112 (192.168.2.112)
     Destination: 192.168.2.113 (192.168.2.113)
Transmission Control Protocol, Src Port: 33039 (33039), Dst Port: 33040 (33040), Seq: 931994439, Ack: 0, Len: 0
     Source port: 33039 (33039)
     Destination port: 33040 (33040)
     Sequence number: 931994439
     Header length: 40 bytes
     Flags: 0x00c2 (SYN, ECN, CWR)
         1... .... = Congestion Window Reduced (CWR): Set
         .1.. .... = ECN-Echo: Set
         ..0. .... = Urgent: Not set
         ...0 .... = Acknowledgment: Not set
         .... 0... = Push: Not set
         .... .0.. = Reset: Not set
         .... ..1. = Syn: Set
         .... ...0 = Fin: Not set
     Window size: 5840
     Checksum: 0xad83 (correct)
     Options: (20 bytes)
         Maximum segment size: 1460 bytes
         SACK permitted
         Time stamp: tsval 42957, tsecr 0
         NOP
         Window scale: 0 bytes

Frame 2 (74 on wire, 74 captured)
     Arrival Time: Sep 13, 2002 22:34:29.669918000
     Time delta from previous packet: 2.990216000 seconds
     Time relative to first packet: 2.990216000 seconds
     Frame Number: 2
     Packet Length: 74 bytes
     Capture Length: 74 bytes
Ethernet II
     Destination: 00:07:e9:09:62:ee (Intel_09:62:ee)
     Source: 00:07:e9:09:5e:3a (Intel_09:5e:3a)
     Type: IP (0x0800)
Internet Protocol, Src Addr: 192.168.2.112 (192.168.2.112), Dst Addr: 192.168.2.113 (192.168.2.113)
     Version: 4
     Header length: 20 bytes
     Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00)
         0000 00.. = Differentiated Services Codepoint: Default (0x00)
         .... ..0. = ECN-Capable Transport (ECT): 0
         .... ...0 = ECN-CE: 0
     Total Length: 60
     Identification: 0xbc8b
     Flags: 0x04
         .1.. = Don't fragment: Set
         ..0. = More fragments: Not set
     Fragment offset: 0
     Time to live: 64
     Protocol: TCP (0x06)
     Header checksum: 0xf7fe (correct)
     Source: 192.168.2.112 (192.168.2.112)
     Destination: 192.168.2.113 (192.168.2.113)
Transmission Control Protocol, Src Port: 33039 (33039), Dst Port: 33040 (33040), Seq: 931994439, Ack: 0, Len: 0
     Source port: 33039 (33039)
     Destination port: 33040 (33040)
     Sequence number: 931994439
     Header length: 40 bytes
     Flags: 0x00c2 (SYN, ECN, CWR)
         1... .... = Congestion Window Reduced (CWR): Set
         .1.. .... = ECN-Echo: Set
         ..0. .... = Urgent: Not set
         ...0 .... = Acknowledgment: Not set
         .... 0... = Push: Not set
         .... .0.. = Reset: Not set
         .... ..1. = Syn: Set
         .... ...0 = Fin: Not set
     Window size: 5840
     Checksum: 0xac57 (correct)
     Options: (20 bytes)
         Maximum segment size: 1460 bytes
         SACK permitted
         Time stamp: tsval 43257, tsecr 0
         NOP
         Window scale: 0 bytes

Frame 3 (42 on wire, 42 captured)
     Arrival Time: Sep 13, 2002 22:34:31.669777000
     Time delta from previous packet: 1.999859000 seconds
     Time relative to first packet: 4.990075000 seconds
     Frame Number: 3
     Packet Length: 42 bytes
     Capture Length: 42 bytes
Ethernet II
     Destination: 00:07:e9:09:62:ee (Intel_09:62:ee)
     Source: 00:07:e9:09:5e:3a (Intel_09:5e:3a)
     Type: ARP (0x0806)
Address Resolution Protocol (request)
     Hardware type: Ethernet (0x0001)
     Protocol type: IP (0x0800)
     Hardware size: 6
     Protocol size: 4
     Opcode: request (0x0001)
     Sender MAC address: 00:07:e9:09:5e:3a (Intel_09:5e:3a)
     Sender IP address: 192.168.2.112 (192.168.2.112)
     Target MAC address: 00:00:00:00:00:00 (XEROX_00:00:00)
     Target IP address: 192.168.2.113 (192.168.2.113)

Frame 4 (60 on wire, 60 captured)
     Arrival Time: Sep 13, 2002 22:34:31.670014000
     Time delta from previous packet: 0.000237000 seconds
     Time relative to first packet: 4.990312000 seconds
     Frame Number: 4
     Packet Length: 60 bytes
     Capture Length: 60 bytes
Ethernet II
     Destination: 00:07:e9:09:5e:3a (Intel_09:5e:3a)
     Source: 00:07:e9:09:62:ee (Intel_09:62:ee)
     Type: ARP (0x0806)
     Trailer: 00000000000000000000000000000000...
Address Resolution Protocol (reply)
     Hardware type: Ethernet (0x0001)
     Protocol type: IP (0x0800)
     Hardware size: 6
     Protocol size: 4
     Opcode: reply (0x0002)
     Sender MAC address: 00:07:e9:09:62:ee (Intel_09:62:ee)
     Sender IP address: 192.168.2.113 (192.168.2.113)
     Target MAC address: 00:07:e9:09:5e:3a (Intel_09:5e:3a)
     Target IP address: 192.168.2.112 (192.168.2.112)


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


