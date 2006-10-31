Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161617AbWJaHt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161617AbWJaHt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161615AbWJaHt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:49:29 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:43140 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161613AbWJaHt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:49:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=cFfYpdWC44XoTEBcErf/gwVhbgBqAGPtCSV0WVG3UJGgSIt6ck4RTKGnT3CE4vc620FRrHM8RZKUfsfuGfEW8NVxeMKqtBao5JRrwg8sp+wxJitK5uQmbE92ZNW4LZReHxWJ+ewwGPRQy7TdsU25KT6Js6WDH3UvrOfkEW/QbUQ=  ;
X-YMail-OSG: AfWmu4QVM1maB3BuigvecKGmsx1Q_q._xDo5ow8uTWkRawjEQZBmF4SsykMSOifXF3rTMrjDGf7pBfHu2fiYre5p647JbSeo6KspM19D77mpqwFghnWMKP8GVKjVnfBgk4hfK.NFh3g-
Date: Mon, 30 Oct 2006 23:49:26 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] 0/3: Fix EH problems in libsas and implement more error handling
To: "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alexis Bruemmer <alexisb@us.ibm.com>
In-Reply-To: <45468845.20400@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <937570.82987.qm@web31801.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Darrick J. Wong" <djwong@us.ibm.com> wrote:
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

The original code (as posted to this list) and as is currently maintained
by me, does _not_ wait 30 seconds to start error recovery of the timed
out command when the task is requested to be aborted by REQ_TASK_ABORT.

I don't know how or why someone changed the code as there is a "black out
perdiod" when the code was being "worked on" by bottomley and gang outside
of git control.

SCSI core already allows you to do what you're trying to do here going
around your elbow... in a more straightforward way, and more elegantly.

Study the following threads:
http://marc.theaimsgroup.com/?l=linux-scsi&m=113833937421677&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=114399387517874&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=114771297626171&w=2

I've listed them in chronological order so that you can see
the "evolution" of opinion-changing.

> On the assumption that we'd like to get on with things sooner than
> later, the current iteration of these patches aborts the task as soon as
> possible so that the other pending commands will flush out on their own.
>  However, this also necessitates the addition of a new sas_task flag
> (SAS_TASK_INITIATOR_ABORTED) to indicate "Task aborted, but still
> waiting for the EH to call task_done."  From what I can tell,
> SAS_TASK_STATE_ABORTED means that the task will be lldd_abort_task'd by
> the EH at some point, but does not indicate if that has been done yet,
> and SAS_TASK_STATE_DONE is set after everything is done.

This new task flag is neither necessary nor needed.

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
> 
> In any case, these patches have been tested on a x206m, x260 and a x366.
>  They seemed pretty stable, though YMMV.  The patches should apply
> against linux-2.6.19-rc3 + scsi-misc + scsi-rc-fixes + aic94xx git trees
> in the order that they are posted.  They may also eat your disks.
> 
> Questions/comments?  This is still very much a work in progress and at
> this stage I'm merely seeking constructive feedback to mould this code
> into better shape.

It is good that it keeps you busy.  Sadly it has already been implemented.

Good luck!
   Luben


> 
> --D
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

