Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbTGVSnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271006AbTGVSnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:43:19 -0400
Received: from rrcs-sw-24-73-247-26.biz.rr.com ([24.73.247.26]:9870 "HELO
	engine.infodancer.org") by vger.kernel.org with SMTP
	id S271003AbTGVSnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:43:06 -0400
Date: Tue, 22 Jul 2003 13:58:10 -0500
From: Matthew Hunter <matthew@infodancer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21, NFS v3, and 3com 920
Message-ID: <20030722185810.GE18532@infodancer.org>
References: <20030722054245.GA768@infodancer.org> <200307221319.h6MDJVgf007961@turing-police.cc.vt.edu> <3F1D7D43.5070401@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1D7D43.5070401@rackable.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:06:59AM -0700, Samuel Flory <sflory@rackable.com> wrote:
> >Try nailing the devices on both ends of the cat-5 to the same thing (full 
> >or half).  This can of course be interesting if you have an 
> >unmanaged hub that doesn't give you a choice...
>  You should be able to use mii-tool, or ethtool (one or both should 
> work) to check the state your ethernet controller thinks it is set to, 
> and change the settings.

So far I've seen several people point to this, and I just now had 
the chance to test the advice.  Here are the results:

image:~# mii-tool -v eth0
eth0: negotiated 100baseTx-FD, link ok
  product info: vendor 00:10:5a, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

That's the default.  OK, the hub thinks it's FD, the adapter 
thinks its FD.  Should be a match.  

Test with a large file transfer: 80 KB/s, about as expected (ie, 
the problem still exists.

Let's assume the hub is smoking something interesting and 
force HD.  (The hub is unmanaged, so I can't force it to do 
anything).

image:~# mii-tool --force=100baseTx-HD eth0         
image:~# mii-tool -v eth0
eth0: 100 Mbit, half duplex, link ok
  product info: vendor 00:10:5a, model 0 rev 0
  basic mode:   100 Mbit, half duplex
  basic status: link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

OK, adapter forced to half duplex.

Test with a large file transfer -- no change, still about 80 
KB/s.

Let's try to autonegotiate for the same result...

image:~# mii-tool --reset eth0
resetting the transceiver...
image:~# mii-tool --advertise=100baseTx-HD eth0 
restarting autonegotiation...
image:~# mii-tool -v eth0
eth0: negotiated 100baseTx-HD, link ok
  product info: vendor 00:10:5a, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

OK, looks fine.  Test... no change.

I predict hardware swaps in my future when I get home.

Just for giggles, I'll try 10baseT.

image:~# mii-tool --reset eth0
resetting the transceiver...
image:~# mii-tool --advertise=10baseT-FD eth0 
restarting autonegotiation...
image:~# mii-tool -v eth0
eth0: negotiated 10baseT-FD, link ok
  product info: vendor 00:10:5a, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  10baseT-FD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

Low-and-behold, 1.1 MB/s!  

Note that this is supposedly a fast ethernet hub and a fast 
ethernet adapter.  The other hosts on the hub all think so.

I wonder if I'm plugged into a special port or something.  
I'll play with that when I'm near the hardware later on tonight.

Thanks for your help, all of you.  I think I have the answers 
that I wanted -- namely, it's probably not a kernel problem.  

I am unsure if this explains the NFS problem (ie, NFS breaks with 
v3 enabled), but since it works via tcp, I'm not of any mind to 
complain.  If anyone is interested, I can try without tcp but 
with the ethernet controller in better shape and see if I can 
still cause the same symptoms.

-- 
Matthew Hunter (matthew@infodancer.org)
Public Key: http://matthew.infodancer.org/public_key.txt
Homepage: http://matthew.infodancer.org/index.jsp
Politics: http://www.triggerfinger.org/index.jsp
