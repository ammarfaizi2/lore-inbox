Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTB1O3o>; Fri, 28 Feb 2003 09:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267934AbTB1O3o>; Fri, 28 Feb 2003 09:29:44 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:58065 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267932AbTB1O3i>; Fri, 28 Feb 2003 09:29:38 -0500
Message-ID: <3E5F748E.2080605@nortelnetworks.com>
Date: Fri, 28 Feb 2003 09:39:10 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
References: <3E5E7081.6020704@nortelnetworks.com> <20030228083009.Y53276@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Thu, 27 Feb 2003, Chris Friesen wrote:

>>It is fairly common to want to distribute information between a single
>>sender and multiple receivers on a single box.

>>Multicast IP sockets are one possibility, but then you have additional
>>overhead in the IP stack.

> I think this is a _very weak_  reason.
> Without addressing any of your other arguements, can you describe what
> such painful overhead you are talking about? Did you do any measurements
> and under what circumstances are unix sockets vs say localhost bound
> udp sockets are different? I am not looking for hand waving reason of
> "but theres an IP stack".

 From lmbench local communication tests:

This is a multiproc 1GHz G4
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                         ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
pcary0z0. Linux 2.4.18- 0.600 3.756 6.58  10.2  26.4  13.8  36.9 599K
pcary0z0. Linux 2.4.18- 0.590 3.766 6.43  10.1  26.7  13.9  37.2 59.1


This is a 400MHz uniproc G4
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                         ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
zcarm0pd. Linux 2.2.17- 1.710 9.888 21.3  26.4  59.4  43.0 105.4 146.
zcarm0pd. Linux 2.2.17- 1.740 9.866 22.2  26.3  60.4  43.1 106.7 147.

This is a 1.8GHz P4
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                         ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
pcard0ks. Linux 2.4.18- 1.740  10.4 15.9  20.1  33.1  23.5  44.3 72.7
pcard0ks. Linux 2.4.18-        10.3 16.1  19.8  36.3  22.8  43.6 74.1
pcard0ks. Linux 2.4.18- 1.560  10.6 16.0  23.4  38.1  36.1  44.6 77.4


 From these numbers, UDP has 18%-44% higher latency than AF_UNIX, with 
the difference going up as the machine speed goes up.

Aside from that, IP multicast doesn't seem to work properly.  I enabled 
multicast on lo and disabled it on eth0, and a ping to 224.0.0.1 still 
got responses from all the multicast-capable hosts on the network.  From 
userspace, multicast unix would be *simple* to use, as in totally 
transparent.

The other reason why I would like to see this happen is that it just 
makes *sense*, at least to me.  We've got multicast IP, so multicast 
unix for local machine access is a logical extension in my books.

Do we agree at least that some form of multicast is the logical solution 
to the case of one sender/many listeners?

Thanks for your thoughts,

Chris





-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

