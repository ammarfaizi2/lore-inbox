Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262521AbTCZVvZ>; Wed, 26 Mar 2003 16:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbTCZVvY>; Wed, 26 Mar 2003 16:51:24 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:46090 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S262521AbTCZVvX>;
	Wed, 26 Mar 2003 16:51:23 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303262202.h2QM2Pg29846@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <5.1.0.14.2.20030327083757.037c0760@mira-sjcm-3.cisco.com> from
 Lincoln Dale at "Mar 27, 2003 08:48:08 am"
To: Lincoln Dale <ltd@cisco.com>
Date: Wed, 26 Mar 2003 23:02:25 +0100 (MET)
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       ptb@it.uc3m.es, Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lincoln Dale wrote:"
> >what multipathing and failover accomplish.  iSCSI can be shoving bits 
> >through multiple TCP connections, or fail over from one TCP connection to 
> >another.
> 
> while the iSCSI spec has the concept of a "network portal" that can have 
> multiple TCP streams for i/o, in the real world, i'm yet to see anything 
> actually use those multiple streams.

I'll content myself with mentioning that ENBD has /always/ throughout
its five years of life had automatic failover between channels.  Mind
you, I don't think anybody makes use of the multichannel architecture in
practice for the purposes of redundancy (i.e.  people using multiple
channels don't pass them through different interfaces or routes, which
is the idea!), they may do it for speed/bandwidth.

But then surely they might as well use channel bonding in the network layer?
I've never tried it, or possibly never figured out how ..

> the reason why goes back to how SCSI works.  take a ethereal trace of iSCSI 
> and you'll see the way that 2 round-trips are used before any typical i/o 
> operation (read or write op) occurs.

Hmm.

I have some people telling me that I should pile up network packets
in order to avoid too many interrupts firing on Ge cards, and other
people telling me to send partial packets as soon as possible in order
to avoid buffer buildup.  My head spins.

> multiple TCP streams for a given iSCSI session could potentially be used to 
> achieve greater performance when the maximum-window-size of a single TCP 
> stream is being hit.
> but its quite rare for this to happen.

My considered opinion is that there are way too many variables here for
anyone to make sense of them.


> in reality, if you had multiple TCP streams, its more likely you're doing 
> it for high-availability reasons (i.e. multipathing).

Except that in real life most people don't know what they're doing and
they certainly don't know why they're doing it! In particular they
don't seem to get the idea that more redundancy is what they want.

I can almost see why.

But they can be persuaded to run multichannel by being promised more
speed.


> if you're multipathing, the chances are you want to multipath down two 
> separate paths to two different iSCSI gateways.  (assuming you're talking 
> to traditional SAN storage and you're gatewaying into Fibre Channel).

Yes. This is all that really makes sense for redundancy. And make sure
the routing is distinct too.

Then you start having problems maintaining request order across
multiple paths. At least I do.  But ENBD does it.

> determining the policy (read-preferred / write-preferred / round-robin / 
> ratio-of-i/o / sync-preferred+async-fallback / ...) on how those paths are 
> used is most definitely something that should NEVER be in the kernel.

ENBD doesn't have any problem - it uses all the channels, by demand.
Each userspace daemon runs a different channel and each daemon picks
up requests to treat as soon as it can, as soon as there are any. The
kernel does not dictate. It's async.

(iscsi stream over tcp)
>              5 minutes output rate 929091696 bits/sec, 116136462 bytes/sec, 
> 80679 frames/sec
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Very impressive. I think the most that's been seen over ENBD is 60MB/s
sustained, across Ge.

> not bad for a single TCP stream and a software iSCSI stack. :-)
> (kernel is 2.4.20)

Ditto.


Peter
