Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVBDBz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVBDBz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVBDBvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:51:43 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:6679 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263273AbVBDBuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:50:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aD/qd3c7zAxQKewRM2sNcAWa3J2E4+qyvfEjDl2oUXRmjessY9RQoFu3p4rXsEd08NkGrqRpushHNmQvAOQV/YQgrCBGqhRJnpHbw5d/M3hFjmKDcqFvEZI1VUQ4E/NZ3QPyLIJQcopjtXYXZ0I1ZqGmlEOVW/CWSh1AiUByDRU=
Message-ID: <58cb370e05020317506522b62f@mail.gmail.com>
Date: Fri, 4 Feb 2005 02:50:10 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 22/29] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4202C7BF.8080305@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202030727.GG1187@htj.dyndns.org>
	 <58cb370e05020309307cb8fada@mail.gmail.com>
	 <4202C7BF.8080305@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 09:54:23 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Hello again, Bartlomiej.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 12:07:27 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> >>>22_ide_taskfile_flush.patch
> >>>
> >>>      All REQ_DRIVE_TASK users except ide_task_ioctl() converted
> >>>      to use REQ_DRIVE_TASKFILE.
> >>>      1. idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
> >>>         This and the changes in ide_get_error_location() remove a
> >>>         possible race condition between ide_get_error_location()
> >>>         and other requests.
> >
> >
> > What race condition?
> 
> The old ide_get_error_location() acceses hardware registers after the
> flush request is finished, so the registers could have been crobbered by
> other on-going or finished requests.

yep, you are right

> >>@@ -80,7 +62,8 @@ static void ide_fill_flush_cmd(ide_drive
> >> static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
> >>                                           struct request *rq, int post)
> >> {
> >>-       struct request *flush_rq = &HWGROUP(drive)->wrq;
> >>+       struct request *flush_rq = &HWGROUP(drive)->flush_rq;
> >>+       ide_task_t *args = &HWGROUP(drive)->flush_args;
> >
> >
> > please don't use HWGROUP() macro,
> > just use drive->hwif->hwgroup directly
> >
> 
> I think I'll leave the code like above here and make another patch which
> removes all uses of HWGROUP() and HWGROUP() itself.  What do you think
> about that?

I prefer gradual changes because IMHO such global find'n'replace
changes have high noise ratio and are bad for maintainability
(also most of the code it would touch need some other fixes anyway).

> >>@@ -930,6 +930,39 @@ typedef ide_startstop_t (ide_pre_handler
> >> typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
> >> typedef int (ide_expiry_t)(ide_drive_t *);
> >>
> >>+typedef struct ide_task_s {
> >>+/*
> >>+ *     struct hd_drive_task_hdr        tf;
> >>+ *     task_struct_t           tf;
> >>+ *     struct hd_drive_hob_hdr         hobf;
> >>+ *     hob_struct_t            hobf;
> >>+ */
> >>+       task_ioreg_t            tfRegister[8];
> >>+       task_ioreg_t            hobRegister[8];
> >>+       ide_reg_valid_t         tf_out_flags;
> >>+       ide_reg_valid_t         tf_in_flags;
> >>+       int                     data_phase;
> >>+       int                     command_type;
> >>+       ide_pre_handler_t       *prehandler;
> >>+       ide_handler_t           *handler;
> >>+       struct request          *rq;            /* copy of request */
> >>+       void                    *special;       /* valid_t generally */
> >>+} ide_task_t;
> >
> >
> > please don't move this around,
> > adding struct ide_task_s; should do the trick
> >
> 
> No, I added ide_task_t flush_args to hwgroup_t not a pointer to
> ide_task_t, so the definition of ide_task_t has to come before the
> definition of hwgroup_t.

OK

> >
> >>+typedef struct pkt_task_s {
> >>+/*
> >>+ *     struct hd_drive_task_hdr        pktf;
> >>+ *     task_struct_t           pktf;
> >>+ *     u8                      pkcdb[12];
> >>+ */
> >>+       task_ioreg_t            tfRegister[8];
> >>+       int                     data_phase;
> >>+       int                     command_type;
> >>+       ide_handler_t           *handler;
> >>+       struct request          *rq;            /* copy of request */
> >>+       void                    *special;
> >>+} pkt_task_t;
> >
> >
> > there is no need to move pkt_task_t around
> > (moreover no code uses it currently)
> >
> 
> And it seemd kind of lonely after ide_task_t moved upward. :-)  How
> about modifying this patch such that it moves only the ide_task_t and
> adding another patch to kill pkt_task_t?

sounds good

> >
> >> typedef struct hwgroup_s {
> >>                /* irq handler, if active */
> >>        ide_startstop_t (*handler)(ide_drive_t *);
> >>@@ -955,8 +988,12 @@ typedef struct hwgroup_s {
> >>        struct request *rq;
> >>                /* failsafe timer */
> >>        struct timer_list timer;
> >>-               /* local copy of current write rq */
> >>-       struct request wrq;
> >>+               /* rq used for flushing */
> >>+       struct request flush_rq;
> >>+               /* task used for flushing */
> >>+       ide_task_t flush_args;
> >>+               /* real_rq for flushing */
> >>+       struct request *flush_real_rq;
> >>                /* timeout value during long polls */
> >>        unsigned long poll_timeout;
> >>                /* queried upon timeouts */
> >>@@ -1203,7 +1240,7 @@ extern void ide_init_drive_cmd (struct r
> >> /*
> >>  * this function returns error location sector offset in case of a write error
> >>  */
> >>-extern u64 ide_get_error_location(ide_drive_t *, char *);
> >>+extern u64 ide_get_error_location(ide_drive_t *, ide_task_t *);
> >
> >
> > extern is not needed
> >
> 
> Yeah, it isn't needed.  I was trying to be conformant with other
> declarations in the file.  I'll leave above line as it is now and write
> another patch to remove all extern's in front of function prototypes in
> ide drivers.  What do you think?

I think the same as for HWGROUP() change - better to do it gradually.
