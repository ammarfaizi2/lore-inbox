Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTIPUdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbTIPUdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:33:11 -0400
Received: from [207.175.35.50] ([207.175.35.50]:8818 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262482AbTIPUdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:33:01 -0400
Message-ID: <3F67734A.8060804@eternal-systems.com>
Date: Tue, 16 Sep 2003 13:32:10 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo>            <3F675B68.8000109@eternal-systems.com> <200309161900.h8GJ0kYe019776@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 16 Sep 2003 11:50:16 PDT, Vishwas Raman <vishwas@eternal-systems.com>  said:
> 
> 
>>Can anyone out there tell me the algorithm to update the checksum 
>>without having to recalculate it.
> 
> 
> The canonical source is the RFCs:
> 
> 1071 Computing the Internet checksum. R.T. Braden, D.A. Borman, C.
>      Partridge. Sep-01-1988. (Format: TXT=54941 bytes) (Updated by
>      RFC1141) (Status: UNKNOWN)
> 
> 1141 Incremental updating of the Internet checksum. T. Mallory, A.
>      Kullberg. Jan-01-1990. (Format: TXT=3587 bytes) (Updates RFC1071)
>      (Updated by RFC1624) (Status: INFORMATIONAL)
> 
> 1624 Computation of the Internet Checksum via Incremental Update. A.
>      Rijsinghani, Ed.. May 1994. (Format: TXT=9836 bytes) (Updates
>      RFC1141) (Status: INFORMATIONAL)
> 
> http://www.ietf.org/rfc/rfc1071.txt
> http://www.ietf.org/rfc/rfc1141.txt
> http://www.ietf.org/rfc/rfc1624.txt

As mentioned in RFC1624, I did the following.
void changePacket(struct sk_buff* skb)
{
     struct tcphdr *tcpHdr = skb->h.th;

     // Verifying the tcp checksum works here...

     __u16 oldDoff = tcpHeader->doff;
     tcpHeader->doff += 1;	

     // Formula from RFC1624 is HC' = ~(C + (-m) + m')
     // where HC  - old checksum in header
     // C   - one's complement sum of old header
     // HC' - new checksum in header
     // C'  - one's complement sum of new header
     // m   - old value of a 16-bit field
     // m'  - new value of a 16-bit field

     long cksum = (~(tcpHdr->check))&0xffff;
     cksum += (__u16)~oldDoff;
     cksum += tcpHeader->doff;
     while (cksum >> 16)
     {
         cksum = (cksum & 0xffff) + (cksum >> 16);
     }
     tcpHeader->check = ~cksum;

     // Verifying tcp checksum here fails with bad cksum
}

Is there any glaring mistake in the above code. If so, can someone
please let me know what it is. It will be of great help.

Thanks,

-Vishwas.






