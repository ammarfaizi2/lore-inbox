Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319313AbSIKTvf>; Wed, 11 Sep 2002 15:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIKTvf>; Wed, 11 Sep 2002 15:51:35 -0400
Received: from gate.in-addr.de ([212.8.193.158]:18442 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319307AbSIKTvc>;
	Wed, 11 Sep 2002 15:51:32 -0400
Date: Wed, 11 Sep 2002 21:52:32 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020911195232.GH1212@marowsky-bree.de>
References: <20020911191701.GE1212@marowsky-bree.de> <200209111937.g8BJbfQ02442@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209111937.g8BJbfQ02442@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-11T14:37:40,
   James Bottomley <James.Bottomley@steeleye.com> said:

> I think I see driverfs as the solution here.  Topology is deduced by
> examining certain device and HBA parameters.  As long as these parameters
> can be exposed as nodes in the device directory for driverfs, a user level
> daemon map the topology and connect the paths at the top.  It should even be
> possible to weight the constructed multi-paths.

Perfect, I agree, should've thought of it. As long as this is simple enough
that it can be done in initrd (if / is on a multipath device...).

The required weighting has already been implemented in the LVM1 patch by IBM.
While it appeared overkill to me for "simple" cases, I think it is suited to
expressing proximity.

> This solution appeals because the kernel doesn't have to dictate policy, 

Right.

> I've been think about this separately.  FC in particular needs some type of
> event notification API (something like "I've just seen this disk" or "my
> loop just went down").  I'd like to leverage a mid-layer api into hot plug
> for some of this, but I don't have the details worked out.

This isn't just FC, but also dasd on S/390. Potentially also network block
devices, which can notice a link down.

> The probing issue is an interesting one.  At least SCSI has the ability to 
> probe with no IO (something like a TEST UNIT READY) and I assume other block 
> devices have something similar.  Would it make sense to tie this to a single 
> well known ioctl so that you can probe any device that supports it without 
> having to send real I/O?

Not sufficient. The test is policy, so the above applies here too ;-) 

In the case of talking to a dual headed RAID box for example, TEST UNIT READY
might return OK, but the controller might refuse actual IO, or the path may be
somehow damaged in a way which is only detected by doing some "large" IO. Now,
this might be total overkill for other scenarios.

I vote for exposing the path via driverfs (which, I think, is already
concensus so the multipath group, topology etc can be used) and allowing
user-space to reenable them after doing whatever probing deemed necessary.

What are your ideas on the potential timeframe?



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

