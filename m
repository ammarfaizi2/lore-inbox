Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbTIMUQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbTIMUQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:16:45 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:48646 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262178AbTIMUQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:16:44 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Sep 2003 15:16:09 -0500
Message-Id: <1063484193.1781.48.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Oh, and I'm pondering the best way to deliver out-of-bang ATA taskfiles
    and SCSI cdbs to a device.  (for the uninitiated, this is lower level
    than block devices / cdrom devices / etc.)
    
     ... AF_BLOCK is not out of the question ;-)
    
    
Well, I think the main issue to doing this is one of layering.  What
SAM-3 did for SCSI was essentially give us a 3 layer stack which the
kernel represents as the upper, the mid and the lower layers  (Note,
these layers are subdividable too).

For SCSI commands, queuecommand() is a natural handoff point from the
mid to lower layer representing a pure scsi command with no transport
dependent details.

For ATA, a task file does contain transport dependent knowledge, thus it
should enter the stack at a slightly lower level (and a level which the
current SCSI model doesn't even represent).

Thus, the two ways of approaching this would seem to be either to derive
somehow a way of removing the transport dependence from the taskfile (a
sort of Task CDB for ATA), or redo the driver model stack to subdivide
the current low level drivers correctly.  I think the latter will
probably be more productive, particularly if the subdivision is made
optional (and thus wouldn't affect most of the drivers currently in the
tree).  Even in SCSI, there are certain register based SCSI Parallel
cards that would benefit from being driven at the same level as a task
file.

James


