Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSJ2EH0>; Mon, 28 Oct 2002 23:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJ2EH0>; Mon, 28 Oct 2002 23:07:26 -0500
Received: from mail.cscoms.net ([202.183.255.13]:59912 "EHLO csmail.cscoms.com")
	by vger.kernel.org with ESMTP id <S261544AbSJ2EHX>;
	Mon, 28 Oct 2002 23:07:23 -0500
Date: Tue, 29 Oct 2002 11:13:30 +0700
From: Alain Fauconnet <alain@cscoms.net>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, lve@ns.aanet.ru
Subject: Re: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
Message-ID: <20021029111330.C15782@cscoms.net>
References: <20021028171956.A14460@cscoms.net> <200210290130.EAA19804@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210290130.EAA19804@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, Oct 29, 2002 at 04:30:25AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 04:30:25AM +0300, kuznet@ms2.inr.ac.ru wrote:

> > I assume that the kernel is trying to use dynamic memory that has been
> > released already, right?
> 
> Right.
> 
> > What's next in tracing this one down?
> 
> To tell what exactly driver makes this. Apparently, it continues
> to inject packets to the stack even after it has been destroyed.
>

In  this  case,  would  they  be  packets  TO  or FROM the ppp device?
(reminder:  crash  happens  in ip_route_input_slow, called with struct
net_device *dev presumably pointing at what used to be the PPP device)

> If you did not see message "Freeing alive device", this means
> that driver unregistered it. Usual ppp seems to be sane...

No such message in logs, but  "PPPIOCDETACH  file->f_count=3"  appears
quite often. If I understand it right, it'd mean that the ppp interface
is destroyed while having channels open to  it...  Does  it  give  any
hint?

Let's try to summarize anything unusual this box has:

- pptp  (PoPToP). But pptp is only userland software, how could it cause
such a problem? It merely forks pppd as a child.

- NAT, both SNAT and DNAT (for transparent redirection to a Squid),  and
a lot of rules used to do traffic accounting so iptables configuration
is kind of hairy. Could it somehow cause packets to be  "delayed"  and
thus re-injected to the stack later than  usual?  (I'm  probably  just
talking nonsense here - sorry - trying to guess).

- assymetrical routing: packets come from clients over VPN, thus over the
PPP  interface.  They are routed back though a LAN interface that goes
to the satellite uplink. To do this, the route to the peer IP  through
the PPP interface is deleted in the ip-up script.

Ah..  something  else that could be relevant (??): I see that ifconfig
-a shows "duplicate" ppp devices e.g.:

ppp96     Link encap:Point-to-Point Protocol  
          inet addr:xxx.yyy.zzz.2  P-t-P:172.16.27.104  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:44238 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3 
          RX bytes:2192741 (2.0 Mb)  TX bytes:153 (153.0 b)

ppp96     Link encap:Point-to-Point Protocol  
          inet addr:xxx.yyy.zzz.2  P-t-P:172.16.27.104  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1

Is this "normal"?

Greets,
_Alain_

