Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJZIhS>; Sat, 26 Oct 2002 04:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSJZIhS>; Sat, 26 Oct 2002 04:37:18 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:60868 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261972AbSJZIhR>; Sat, 26 Oct 2002 04:37:17 -0400
Date: Sat, 26 Oct 2002 18:43:23 +1000
From: Chris Edwards <chris@edwards.mine.nu>
To: linux-kernel@vger.kernel.org
Subject: Occasional TCP checksum errors with qdisc
Message-ID: <20021026084323.GA18838@ummagumma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been developing a kernel module which acts as a queuing discipline,
and modifies TCP packets to include an extra option. This obviously
involves updating the checksums. It looked like it was all working fine,
but occasionally packets get the wrong TCP checksum! I've only been able to
reproduce this when talking to a remote solaris 8 machine. Running gigs
of data against local Linux machines produces nothing! The IP checksum
is always correct, even though it too is modified.

Most of the code was taken from the ipt_TCPMSS module, which performs a
similar task. I've included the relevant bit of code below:. I can send
the full module if that helps. 

Also, I've tried performing a full checksum on the packet and that
seemed to produce the same checksums as the code below, and obviously
that didn't work!

Any help would be greatly appreciated!! I suspect something happens with
qdiscs which I don't know about. The strange thing is that it very
rarely causes problems.

Chris


        if (skb_tailroom(skb) >= TCPOLEN_QSIZE &&
                        skb->len <= (sch->dev->mtu - TCPOLEN_QSIZE)) {
                struct tcphdr *tcph;
                struct iphdr *iph;
                u_int16_t tcplen, newtotlen, oldval;
                u_int16_t pofq;

                u_int8_t *opt;

                iph = skb->nh.iph;
                tcplen = skb->len - iph->ihl * 4;

                tcph = (void *) iph + iph->ihl * 4;

                skb_put(skb, TCPOLEN_QSIZE);

                opt = (u_int8_t *) tcph + sizeof(struct tcphdr);
                memmove(opt + TCPOLEN_QSIZE, opt,
                                tcplen - sizeof(struct tcphdr));

                tcph->check = cheat_check(htons(tcplen) ^ 0xFFFF,
                                htons(tcplen + TCPOLEN_QSIZE),
                        tcph->check);

                tcplen += TCPOLEN_QSIZE;

                /* Fill the extra 4 bytes with our option. */
                opt[0] = TCPO_QSIZE;
                opt[1] = TCPOLEN_QSIZE;

                pofq = evaluatepq(sch);
                opt[2] = (pofq & 0xff00) >> 8;
                opt[3] = (pofq & 0x00ff);

                tcph->check = cheat_check(~0, *((u_int32_t *) opt),
                                tcph->check);

                oldval = ((u_int16_t *) tcph)[6];
                tcph->doff += TCPOLEN_QSIZE / 4; 

                tcph->check = cheat_check(oldval ^ 0xFFFF,
                                ((u_int16_t *) tcph)[6], tcph->check);

                newtotlen = htons(ntohs(iph->tot_len) + 4);
                iph->check = cheat_check(iph->tot_len ^ 0xFFFF,
                                newtotlen, iph->check);
                iph->tot_len = newtotlen;

                /* We need to invalidate the existing checksum, in case
                the
                 * hardware has already produced one. */
                skb->ip_summed = CHECKSUM_NONE;

                return skb;
        }

--
Chris Edwards <chris@edwards.mine.nu>

hippo 18:32:01 up 7 days, 22:47,  6 users,  load average: 0.00, 0.00, 0.00
