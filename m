Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315215AbSDWO0G>; Tue, 23 Apr 2002 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSDWO0F>; Tue, 23 Apr 2002 10:26:05 -0400
Received: from ns1.auto.ucl.ac.be ([130.104.239.129]:10167 "EHLO
	ns1.auto.ucl.ac.be") by vger.kernel.org with ESMTP
	id <S315215AbSDWOZ5>; Tue, 23 Apr 2002 10:25:57 -0400
Date: Tue, 23 Apr 2002 17:20:51 +0200
From: Vincent Guffens <guffens@auto.ucl.ac.be>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Frank Louwers <frank@openminds.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423172051.A22111@auto.ucl.ac.be>
In-Reply-To: <20020423113935.A30329@openminds.be> <3CC55D62.1501C94A@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-face: $!yrw0$NB\Y%oy$vuiO5|@s&!qPXX?$FdAr!v/Jx1C8mGr,?D_,\-z|P^),fiP.EvS`t@/@f6zSb,<tSt2liuZz}@-tK6K1mTd@H+XHh/TaCQC^.8#?)wlRP3WE2L@8G[K.IK8"ckxDDz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 09:10:58AM -0400, Chris Friesen wrote:
> Frank Louwers wrote:
> > 
> > Hi,
> > 
> > We recently stummed across a rather annoying bug when 2 nics are on
> > the same network.
> > 
> > Our situation is this: we have a server with 2 nics, each with a
> > different IP on the same network, connected to the same switch. Let's
> > assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> > netmask of 255.255.255.0.
> > 
> > Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> > matter what!
> 
> 
> This is actually standards compliant behaviour, as silly as it sounds.  However,
> if you want stricter arp behaviour I *think* that the following will fix it.  At
> least it used to...
> 
> 
> echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
> 
> 
> If this is no longer correct I'd love to hear it.


Hi,

I'm looking at that as well and it doesn't look as it solves the problem, in fact I think that the arp_filter is meant to
insure that the reply will be sent out to the interface where linux would route it, that is to say, the other way around. It
should be something like that instead :

ip_route_output(&rt,tip, sip, 0, 0) 

But this function will route tip to eth0 ( the wrong one in that context). But in fact, it comes back to the fact that the
two interfaces are put on the same subnet. I know that on some routers, this not even possible to configure  two interfaces on
the same subnet, it is supposed to be possible on linux ? ok, from what I see in the reply, this is possible but linux will
take the first one into account and install a local route to that subnet pointing to the first interface , making the other one
useless as we see in this example.  

   

static int arp_filter(__u32 sip, __u32 tip, struct net_device *dev)
{
        struct rtable *rt;
        int flag = 0;
        /*unsigned long now; */

        
        if (ip_route_output(&rt, sip, tip, 0, 0) < 0)
                return 1;             
        if (rt->u.dst.dev != dev) {
                NET_INC_STATS_BH(ArpFilter);
                flag = 1;
        } 

        ip_rt_put(rt);



> 
> Chris
> 
> 
> Chris Friesen                    | MailStop: 043/33/F10  
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
		Vincent Guffens
		Unite d'automatique, de dynamique et d'analyse des systemes, UCL
