Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVA1TeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVA1TeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVA1TaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:30:25 -0500
Received: from marc2.theaimsgroup.com ([63.238.77.172]:32155 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S262769AbVA1TZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:25:04 -0500
Date: Fri, 28 Jan 2005 14:24:47 -0500 (EST)
From: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
cc: Lorenzo <lorenzo@gnu.org>
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <010501281348590.32700@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2005-01-28, Stephen Hemminger said on linux-kernel:

> > "Randomized IP IDs hinders OS fingerprinting and will keep your
> > machine from being a bounce for an untraceable portscan."
> > 
> > References: [1]:
> > http://www.gentoo.org/proj/en/hardened/grsecurity.xml

> This is a very transitory effect, it works only because your machine
> is then different from the typical Linux machine; therefore the
> scanner will go on to the next obvious ones. But if this gets
> incorporated widely then the rarity factor goes away and this defense
> becomes useless.

This is true and not true.  Its utility for hindering OS fingerprints
will indeed diminish towards zero as it gets more popular.  But the bit
about keeping you from being used for untraceable port scans is real.

The way those scans work is basically:

  - I send something boring to you, an innocent bystander, and get your
    current IPID from your response
  - I send SYN packets to my target spoofed with your source address
    - If the target filters that port, it drops the SYN on the floor
    - If the target is not listening, it sends you an RST; you drop it on
      the floor
    - If the target is listening, it sends you a SYNACK; you reply with
      an RST which increments your IPID
  - I send another something boring to you, get your IPID from your
    response
  - I draw the conclusion that you did, or did not send an RST inbetween,
    thus I know if you received a SYNACK and the port is listening

It's rather nice, because the target saw only packets / a portscan
coming from you, and if anything you saw some unsolicited SYNACKs, and
whatever the "something boring" I've chosen to send to you for the IPID
heartbeats.

Of course this is only effective if:
  - the bystander (you) is quiescent
  - the bystander uses predictable (incrementing) IPIDs
  - the bystander will answer to "something boring" (ICMP, SYNs from
    source port 20, SYNACKs from source port 80, UDP from source port 53,
    whatever)

Only the user can do something about the first; distributions can do
something about the last, but the kernel can do something about the
middle.

And in a more general sense: why do I need to know how busy your network
stack is?  How popular (IPID, pkts/sec) your corporate webserver is?
How busy (TCP source ports, conns/sec) your outbound proxy is?  I don't.
If I want to know that stuff I should go pound sand.  That's why
network-stack randomness is a Good Thing[TM] if you can get it.

Thanks,

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQFB+pF/IvjvEYYapvERArpGAJ9fe8zWMEKbHdobvRS3Xa9V02LxLACfUx4i
VQnx7UmriLwF5niX4FCIr7A=
=HX4V
-----END PGP SIGNATURE-----
