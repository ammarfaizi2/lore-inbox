Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUALNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUALNbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:31:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265315AbUALNbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:31:22 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan Van de Ven <arjanv@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <20040112092231.GG29177@suse.de>
References: <4002CC23.6000105@exavio.com.cn>
	 <1073898527.4428.1.camel@laptop.fenrus.com>
	 <20040112091903.GD24638@suse.de> <20040112091946.GA29779@suse.de>
	 <20040112092059.GC6677@devserv.devel.redhat.com>
	 <20040112092231.GG29177@suse.de>
Content-Type: text/plain
Message-Id: <1073914073.3114.263.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 12 Jan 2004 08:27:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
      Clear blocked status on the host and all devices in scsi_restart_operations
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


