Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTIQD2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 23:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTIQD2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 23:28:34 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:51721 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262671AbTIQD2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 23:28:30 -0400
Subject: Re: Incremental update of TCP Checksum
From: "Raf D'Halleweyn" <raf@noduck.net>
To: Vishwas Raman <vishwas@eternal-systems.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <3F67734A.8060804@eternal-systems.com>
References: <3F3C07E2.3000305@eternal-systems.com>
	 <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com>
	 <200309161900.h8GJ0kYe019776@turing-police.cc.vt.edu>
	 <3F67734A.8060804@eternal-systems.com>
Content-Type: text/plain
Message-Id: <1063769305.2801.1.camel@bigboy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 16 Sep 2003 23:28:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is what I wrote some time ago. But I haven't used it recently.

/* Incrementaly update a checksum, given old and new 32bit words */
static inline __u16 incr_check_l(__u16 old_check, __u32 old, __u32 new)
{ /* see RFC's 1624, 1141 and 1071 for incremental checksum updates */
    __u32 l;
    old_check = ~ntohs(old_check);
    old = ~old;
    l = (__u32)old_check + (old>>16) + (old&0xffff)
        + (new>>16) + (new&0xffff);
    return htons(~( (__u16)(l>>16) + (l&0xffff) ));
}


I have a similar function that can be used when you only change a 16bit
word:


/* Incrementaly update a checksum, given old and new 16bit words */
static inline __u16 incr_check_s(__u16 old_check, __u16 old, __u16 new)
{    /* see RFC's 1624, 1141 and 1071 for incremental checksum updates
*/
    __u32 l;
    old_check = ~ntohs(old_check);
    old = ~old;
    l = (__u32)old_check + old + new;
    return htons(~( (__u16)(l>>16) + (l&0xffff) ));
}


On Tue, 2003-09-16 at 16:32, Vishwas Raman wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 16 Sep 2003 11:50:16 PDT, Vishwas Raman <vishwas@eternal-systems.com>  said:
> > 
> > 
> >>Can anyone out there tell me the algorithm to update the checksum 
> >>without having to recalculate it.
> > 
> > 
> > The canonical source is the RFCs:
> > 
> > 1071 Computing the Internet checksum. R.T. Braden, D.A. Borman, C.
> >      Partridge. Sep-01-1988. (Format: TXT=54941 bytes) (Updated by
> >      RFC1141) (Status: UNKNOWN)
> > 
> > 1141 Incremental updating of the Internet checksum. T. Mallory, A.
> >      Kullberg. Jan-01-1990. (Format: TXT=3587 bytes) (Updates RFC1071)
> >      (Updated by RFC1624) (Status: INFORMATIONAL)
> > 
> > 1624 Computation of the Internet Checksum via Incremental Update. A.
> >      Rijsinghani, Ed.. May 1994. (Format: TXT=9836 bytes) (Updates
> >      RFC1141) (Status: INFORMATIONAL)
> > 
> > http://www.ietf.org/rfc/rfc1071.txt
> > http://www.ietf.org/rfc/rfc1141.txt
> > http://www.ietf.org/rfc/rfc1624.txt
> 
> As mentioned in RFC1624, I did the following.
> void changePacket(struct sk_buff* skb)
> {
>      struct tcphdr *tcpHdr = skb->h.th;
> 
>      // Verifying the tcp checksum works here...
> 
>      __u16 oldDoff = tcpHeader->doff;
>      tcpHeader->doff += 1;	
> 
>      // Formula from RFC1624 is HC' = ~(C + (-m) + m')
>      // where HC  - old checksum in header
>      // C   - one's complement sum of old header
>      // HC' - new checksum in header
>      // C'  - one's complement sum of new header
>      // m   - old value of a 16-bit field
>      // m'  - new value of a 16-bit field
> 
>      long cksum = (~(tcpHdr->check))&0xffff;
>      cksum += (__u16)~oldDoff;
>      cksum += tcpHeader->doff;
>      while (cksum >> 16)
>      {
>          cksum = (cksum & 0xffff) + (cksum >> 16);
>      }
>      tcpHeader->check = ~cksum;
> 
>      // Verifying tcp checksum here fails with bad cksum
> }
> 
> Is there any glaring mistake in the above code. If so, can someone
> please let me know what it is. It will be of great help.
> 
> Thanks,
> 
> -Vishwas.
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Raf D'Halleweyn <raf@noduck.net>

