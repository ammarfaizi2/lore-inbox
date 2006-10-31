Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965519AbWJaB5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965519AbWJaB5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965522AbWJaB5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:57:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965519AbWJaB5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:57:13 -0500
Message-ID: <4546AD6D.3080605@torque.net>
Date: Mon, 30 Oct 2006 20:57:01 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] 0/3: Fix EH problems in libsas and implement more error
 handling
References: <45468845.20400@us.ibm.com>
In-Reply-To: <45468845.20400@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Hi all,
> 
> The following three patches are early drafts of a series of patches to
> fix error handling in libsas so that the scsi_eh_* functions are called
> so that we can attempt to retry failed commands later.  There is also a
> patch to aic94xx to make escb errors are detected correctly,
> REQ_TASK_ABORT is handled, and the beginnings of a handler for
> REQ_DEVICE_RESET.
> 
> However, there are a number of issues with these patches that I wish to
> bring to the attention of this mailing list for further input:
> 
> First, the aic94xx sequencer can send back an ESCB with an error code of
> "REQ_TASK_ABORT", which means that the kernel has to send an ABORT TASK
> TMF to sequencer to unjam things.  Until this happens, the sequencer
> neither services commands nor sends back completions.  If we want to
> wait for the error handler to send the ABORT TASK, we end up waiting for
> _all_ pending commands to time out so that the EH can wake up.  This
> effectively stalls the system for 30 seconds every time we see
> REQ_TASK_ABORT.
> 
> On the assumption that we'd like to get on with things sooner than
> later, the current iteration of these patches aborts the task as soon as
> possible so that the other pending commands will flush out on their own.
>  However, this also necessitates the addition of a new sas_task flag
> (SAS_TASK_INITIATOR_ABORTED) to indicate "Task aborted, but still
> waiting for the EH to call task_done."  From what I can tell,
> SAS_TASK_STATE_ABORTED means that the task will be lldd_abort_task'd by
> the EH at some point, but does not indicate if that has been done yet,
> and SAS_TASK_STATE_DONE is set after everything is done.
> 
> The second issue is the manual decrementing of shost->host_failed in the
> error handler.  So long as we use the scsi_eh_* commands this value is
> decremented automatically--however, it appears that sas_scsi_clear_* is
> pulling scsi_cmnds off the error queue and ... dropping them so that
> they never go through the error handler.  Is this a desirable behavior,
> or am I reading the code incorrectly?  Or...?
> 
> The third pertains to REQ_DEVICE_RESET: I've not yet figured out how to
> reset a device port as has been hinted that I must do.  I don't know if
> a phy reset is sufficient or if I'm barking up the wrong tree.

Darrick,
REQ_DEVICE_RESET would seem to translate in SAS to a
hard reset (which is a specialization of link reset).
Hard reset has the effect of resetting the target device
and all logical units attached to that target.

Hard resets are sent by telling the phy attached to
the SSP target in question to do a hard reset.
There are two cases:
  a) the SSP target device (to reset) is attached to a HBA
  b) the SSP target device is attached to an expander

In case a) you need to get a phy in the HBA to do
a hard reset. Is that functionality available in the SAS
transport layer? [If not it should be.]

In case b) you need to send a SMP PHY CONTROL function
with phy_operation=hard_reset to the appropriate phy
on the expander.

For wide links the hard reset can be sent on any phy
that is part of the wide link.


As for link resets as far as I can see they perturd
the lower level SAS state machines at both ends of
a physical link without having an impact on the higher
level SAS state machines.

Doug Gilbert
