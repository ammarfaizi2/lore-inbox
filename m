Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUALOI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUALOI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:08:57 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:29333 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S265585AbUALOIr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:08:47 -0500
Importance: Low
Sensitivity: 
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
To: Doug Ledford <dledford@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Arjan Van de Ven <arjanv@redhat.com>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
From: "Martin Peschke3" <MPESCHKE@de.ibm.com>
Date: Mon, 12 Jan 2004 15:07:55 +0100
X-MIMETrack: Serialize by Router on D12ML021/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 12/01/2004 15:07:57
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a way to merge all (or at least the common denominator) of
Redhat's and SuSE's changes into the vanilla 2.4 SCSI stack?
The SCSI part of Marcelo's kernel seems to be rather backlevel,
considering all those fixes and enhancements added by the mentioned
distributors and their SCSI experts. As this discussion underlines,
there are a lot of common problems and sometimes even common
approaches.  I am convinced that a number of patches ought to be
incorporated into the mainline kernel. Though, I must admit
that I am at a loss with how this could be achieved given the
unresolved question of 2.4 SCSI maintenance
(which has certainly played a part in building up those piles
of SCSI patches).

Mit freundlichen Grüßen / with kind regards

Martin Peschke

IBM Deutschland Entwicklung GmbH
Linux for eServer Development
Phone: +49-(0)7031-16-2349


Doug Ledford <dledford@redhat.com>@vger.kernel.org on 12/01/2004 14:27:53

Sent by:    linux-scsi-owner@vger.kernel.org


To:    Jens Axboe <axboe@suse.de>
cc:    Arjan Van de Ven <arjanv@redhat.com>, Peter Yao
       <peter@exavio.com.cn>, linux-kernel@vger.kernel.org, linux-scsi
       mailing list <linux-scsi@vger.kernel.org>
Subject:    Re: smp dead lock of io_request_lock/queue_lock patch


On Mon, 2004-01-12 at 04:22, Jens Axboe wrote:
> On Mon, Jan 12 2004, Arjan van de Ven wrote:
> > On Mon, Jan 12, 2004 at 10:19:46AM +0100, Jens Axboe wrote:
> > >
> > > ... and still exists in your 2.4.21 based kernel.
> >
> > The RHL 2.4.21 kernels don't have the locking patch at all...
>
> But RHEL3 does:
>
> http://kernelnewbies.org/kernels/rhel3/SOURCES/linux-2.4.21-iorl.patch
>
> and the bug is there.

But in RHEL3 the bug is fixed already (not in a released kernel, but the
fix went into our internal kernel some time back and will be in our next
update kernel).  From my internal bk tree for this stuff:

[dledford@compaq RHEL3-scsi]$ bk changes -r1.23
ChangeSet@1.23, 2003-11-10 17:19:54-05:00, dledford@compaq.xsintricity.com
  drivers/scsi/scsi_error.c
      Don't panic if the eh thread is dead, instead do the same thing that
      scsi_softirq_handler does and just complete the command as a failed
      command.
      Change when we wake the eh thread in scsi_times_out to accomodate
      the changes to the mlqueue operations.
      Clear blocked status on the host and all devices in
scsi_restart_operations
->    Don't grab the host_lock in scsi_restart_operations, we aren't doing
      anything that needs it.  Just goose the queues unconditionally,
      scsi_request_fn() will know to not send commands if they shouldn't
      go for some reason.
      Make sure we account SCSI_STATE_MLQUEUE commands as not being failed
      commands in scsi_unjam_host.

But, Jens is right, it's a real bug.  I just fixed it in a different
way.  And my fix is dependent on other changes in our scsi stack as
well.

--
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html




