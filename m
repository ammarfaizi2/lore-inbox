Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318948AbSIKOQE>; Wed, 11 Sep 2002 10:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318971AbSIKOQE>; Wed, 11 Sep 2002 10:16:04 -0400
Received: from host194.steeleye.com ([216.33.1.194]:20745 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318948AbSIKOQC>; Wed, 11 Sep 2002 10:16:02 -0400
Message-Id: <200209111420.g8BEKdx01979@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ? 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Tue, 10 Sep 2002 12:26:50 PDT." <20020910122650.A13738@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Sep 2002 09:20:38 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> The scsi multi-path code is not in 2.5.x, and I doubt it will be
> accepted without the support of James and others. 

I haven't said "no" yet (and Doug and Jens haven't said anything).  I did say 
when the patches first surfaced that I didn't like the idea of replacing 
Scsi_Device with Scsi_Path at the bottom and the concomitant changes to all 
the Low Level Drivers which want to support multi-pathing.  If this is to go 
in the SCSI subsystem it has to be self contained, transparent and easily 
isolated.  That means the LLDs shouldn't have to be multipath aware.

I think we all agree:

1) that multi-path in SCSI isn't the way to go in the long term because other 
devices may have a use for the infrastructure.

2) that the scsi-error handler is the big problem

3) that errors (both medium and transport) may need to be propagated 
immediately up the block layer in order for multi-path to be handled 
efficiently.

Although I outlined my ideas for a rework of the error handler, they got lost 
in the noise of the abort vs reset debate.  These are some of the salient 
features that will help in this case

- no retries from the tasklet.

- Quiesce from above, not below (commands return while eh processes, so we 
begin with the first error and don't have to wait for all commands to return 
or error out)

- It's the object of the error handler to return all commands to the block 
layer for requeue and reorder as quickly as possible.  They have to be 
returned with an indication from the error handler that it would like them 
retried.  This indication can be propagated up (although I haven't given 
thought how to do that).  Any commands that are sent down to probe the device 
are generated from within the error handler thread (no device probing with 
live commands).

What other features do you need on the eh wishlist?

James


