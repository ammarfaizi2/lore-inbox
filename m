Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVCWF2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVCWF2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVCWF2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:28:54 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:34772 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262797AbVCWF2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:28:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SZyCFEVmgN8DB0+NHB8EIdybje5wwx9Py6SxqlGIUQ151rff9OISwQpeMBhVLYl8HKFd+RSGyeccVAzWFsRmBcSg04IkqQZZbncC7V3itdqxhyc325QHFJmxlpQTmhhKW9pEZ7sfX28XsVmsRffu1HRKnlfHhVj9RqM9Ry2bJIg=
Date: Wed, 23 Mar 2005 14:28:38 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 04/08] scsi: remove meaningless volatile qualifiers from structure definitions
Message-ID: <20050323052838.GA31878@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.2655518E@htj.dyndns.org> <1111551327.5520.99.camel@mulgrave> <4240EEFF.8030703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4240EEFF.8030703@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

On Tue, Mar 22, 2005 at 11:22:23PM -0500, Jeff Garzik wrote:
> James Bottomley wrote:
> >On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> >
> >>	scsi_device->device_busy, Scsi_Host->host_busy and
> >>	->host_failed have volatile qualifiers, but the qualifiers
> >>	don't serve any purpose.  Kill them.  While at it, protect
> >>	->host_failed update in scsi_error for consistency and clarity.
> >
> >
> >Well ... the data here is volatile so what you're advocating is a move
> >away from a volatile variable model to a protected variable one ... did
> >you audit all users of both of these to make sure we have protection on
> >all of them?  It looks like the sata strategy handlers would still rely
> >on the volatile data.

 Yes, I did (well, tried :-).  Adding locking/unlocking was just for
clarity.  We have synchronization w/ implied memory barrier before and
after eh processing, so we don't really need to acquire the lock
there.  And while adding it, I forgot about libata strategy function.
Sorry about that.  I removed the locking from scsi_error and added
comments to data structure definition that those fields can be
accessed without acquiring the host lock.  I think it's clearer this
way.

> volatile is almost always (a) buggy, or (b) hiding bugs.  At the very 
> least, barriers are usually needed.
> 
> Almost every case really wants to be inside a spinlock, or atomic_t, or 
> similarly protected.
> 
> Specifically for SATA, I am making the presumption that SCSI is smart 
> enough not to mess with host_failed until my error handler completes.

 Yes, volatile only instructs the compiler to not cache the variable
in the register and not move around accesses to the variable.  The
only valid usage would be raw synchronization with variables (busy
checking, two flag variable synchronization, etc...), but even those
usages are better off with explicit barriers and cpu relaxations to
clarify what's going on.

 Currently all accesses outside eh are properly protected with locks
except for the following two cases.

 * sg_proc_seq_show_dev(): read access, informational.  doesn't matter.
 * check looping in scsi_device_quiesce(): we have proper barrier.


 Signed-off-by: Tejun Heo <htejun@gmail.com>


Index: scsi-export/include/scsi/scsi_device.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_device.h	2005-03-23 09:40:12.000000000 +0900
+++ scsi-export/include/scsi/scsi_device.h	2005-03-23 14:04:59.000000000 +0900
@@ -43,7 +43,8 @@ struct scsi_device {
 	struct list_head    siblings;   /* list of all devices on this host */
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
-	volatile unsigned short device_busy;	/* commands actually active on low-level */
+	unsigned short device_busy;	/* commands actually active on
+					 * low-level. protected by sdev_lock. */
 	spinlock_t sdev_lock;           /* also the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
Index: scsi-export/include/scsi/scsi_host.h
===================================================================
--- scsi-export.orig/include/scsi/scsi_host.h	2005-03-23 09:40:12.000000000 +0900
+++ scsi-export/include/scsi/scsi_host.h	2005-03-23 14:04:59.000000000 +0900
@@ -448,8 +448,14 @@ struct Scsi_Host {
 	wait_queue_head_t       host_wait;
 	struct scsi_host_template *hostt;
 	struct scsi_transport_template *transportt;
-	volatile unsigned short host_busy;   /* commands actually active on low-level */
-	volatile unsigned short host_failed; /* commands that failed. */
+
+	/*
+	 * The following two fields are protected with host_lock;
+	 * however, eh routines can safely access during eh processing
+	 * without acquiring the lock.
+	 */
+	unsigned short host_busy;	   /* commands actually active on low-level */
+	unsigned short host_failed;	   /* commands that failed. */
     
 	unsigned short host_no;  /* Used for IOCTL_GET_IDLUN, /proc/scsi et al. */
 	int resetting; /* if set, it means that last_reset is a valid value */
