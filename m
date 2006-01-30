Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWA3WSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWA3WSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWA3WSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:18:37 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:54544 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932389AbWA3WSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:18:36 -0500
To: thockin@hockin.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.1: UDP fragments >27208 bytes lost with ne2k-pci on
 DP83815
References: <87slr79knc.fsf@amaterasu.srvr.nix>
	<8764o23j0s.fsf@amaterasu.srvr.nix>
	<1138566075.8711.39.camel@lade.trondhjem.org>
	<871wyq3dl3.fsf@amaterasu.srvr.nix>
	<1138572140.8711.82.camel@lade.trondhjem.org>
	<874q3lwt7w.fsf@amaterasu.srvr.nix>
	<1138640968.30641.3.camel@lade.trondhjem.org>
	<87vew1vd03.fsf_-_@amaterasu.srvr.nix>
	<20060130190306.GA19227@hockin.org>
	<87vew1ttz7.fsf@amaterasu.srvr.nix>
	<20060130193224.GA21500@hockin.org>
	<87ek2pts25.fsf@amaterasu.srvr.nix>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Mon, 30 Jan 2006 22:18:10 +0000
In-Reply-To: <87ek2pts25.fsf@amaterasu.srvr.nix> (nix@esperi.org.uk's
 message of "Mon, 30 Jan 2006 19:49:06 +0000")
Message-ID: <87irs1qs0t.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, nix@esperi.org.uk uttered the following:
> On Mon, 30 Jan 2006, thockin@hockin.org said:
>> I can't imagine what kind of hidden bug would lay dormant for 4 years and
>> then pop up for just one person.  I don't know what I can offer except
>> extra eyes  to vet any potential solutions.  Happt Hunting.
> 
> I'll verify that the cause really is the network card shortly (by
> swapping the network cards I use for ADSL and internal networking:
> the ADSL link has very little large UDP traffic). This'll let us
> localize the problem to the NIC, or not, as the case may be.
> 
> More once this is done.

We pretty much have proof now that the problem is that the card and/or
driver can't consume UDP packets at the rate at which 100Mb/s Ethernet
can throw them at it. (This is peculiar, as it seems to have no
difficulty consuming TCP packets at that rate: there are no
reported retransmissions.)

- catting a huge file over NFS *from* the hanging machine works fine.
  Confirmation that it's UDP *reception* at fault.

- catting a huge file over UDP netcat from the hanging machine works fine:

loki $ nc -v -p 20202 -u amaterasu 20202 < ~/Graphics/octo-snake.mov
   on one end, and
amaterasu $ nc -v -l -p 20202 -u > /tmp/octo-snake.mov
   on the other, yields

-rw-r--r-- 1 nix users 3255013 Nov 30  2004 /home/nix/Graphics/octo-snake.mov
   on one end, and
-rw-r--r-- 1 nix users 3255013 Jan 30 21:55 /tmp/octo-snake.mov
   on the other.

- catting a huge file over UDP netcat to the hanging machine doesn't work so
  well: we stall after 40 packets; above the 32K rsize for NFS UDP on this
  connection, but not by far, and you can see how a small change in the
  rate at which the CPU sucks packets from the card could cause the limit
  to fall below 32K:

-rw-r--r-- 1 nix users 57280 Jan 30 21:53 /tmp/octo-snake.mov

  There is a bridge in the way, so I captured both the raw interface and
  the bridge. Both saw only 40 packets.

- this machine also has an RTL-8029 in it, used for chattering
  over ADSL. With this in place, I see rather better results.
  Results from three consecutive runs:

-rw-r--r-- 1 nix users 2214629 Jan 30 22:03 /tmp/octo-snake.mov
-rw-r--r-- 1 nix users 3107557 Jan 30 22:11 /tmp/octo-snake.mov
-rw-r--r-- 1 nix users 3140325 Jan 30 22:11 /tmp/octo-snake.mov

  It's not perfect, but it's *way* more than the other card is capable
  of, and it's way above the 32K limit for NFS UDP. And indeed with this
  card NFS UDP works fine, no matter how vast the files I request.

  (It *is* strange that it's still losing packets even though the
  machine is faster than amaterasu up there, which was receiving packets
  without difficulty and dropping none. Ah well, one can't really
  compare IA32 and UltraSPARC speeds like that, and the failing machine
  has the extra CPU load of a bridge in the way.)


I find myself wondering if receiving consecutive line-saturating UDP
traffic is just more than this cheap little card is capable of :/

It's either the NIC or the driver for it; that much is clear.  Plus it's
really easy to reproduce the problem now: spray stuff from `netcat -u'
at such a card and see how much arrives.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
