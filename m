Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSICOao>; Tue, 3 Sep 2002 10:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSICOan>; Tue, 3 Sep 2002 10:30:43 -0400
Received: from host194.steeleye.com ([216.33.1.194]:32522 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318538AbSICOal>; Tue, 3 Sep 2002 10:30:41 -0400
Message-Id: <200209031435.g83EZ2F03562@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 09:35:02 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doug Ledford writes:
> 
>  > took the device off line.  So, in short, the mid layer isn't waiting
> long   > enough, or when it gets sense indicated not ready it needs to
> implement a   > waiting queue with a timeout to try rekicking things a
> few times and don't   > actually mark the device off line until a longer
> period of time has   > elasped without the device coming back.
> 
> There is a kernel config CONFIG_AIC7XXX_RESET_DELAY_MS (default 15s).
> Would increasing it help?

Justin Gibbs writes:
> This currently only effects the initial bus reset delay.  If the
> driver holds off commands after subsequent bus resets, it can cause
> undeserved timeouts on the commands it has intentionally deferred.
> The mid-layer has a 5 second delay after bus resets, but I haven't
> verified that this is honored correctly during error recovery.

I'm planning a major re-write of this area in the error handler.  The way I 
think it should go is:

1) Quiesce host (set in_recovery flag)
2) Suspend active timers on this host
3) Proceed down the error correction track (eliminate abort and go down 
device, bus and host resets and finally set the device offline).
5) On each error recovery wait out a recovery timer for the device to become 
active before talking to it again.  Send all affected commands back to the 
block layer to await reissue (note: it would now be illegal for commands to 
lie to the mid layer and say they've done the reset when they haven't).
6) issue a TUR using a command allocated to the eh for that purpose.  Process 
the return code (in particular, if the device says NOT READY, wait some more). 
 Only if the TUR definitively fails proceed up the recovery chain all the way 
to taking the device offline.

I also plan to expose the suspend and resume timers API in some form for FC 
drivers to use.

James


