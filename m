Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSIBSAj>; Mon, 2 Sep 2002 14:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSIBSAj>; Mon, 2 Sep 2002 14:00:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58831 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318332AbSIBSAi>; Mon, 2 Sep 2002 14:00:38 -0400
Date: Mon, 2 Sep 2002 14:05:09 -0400
From: Doug Ledford <dledford@redhat.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: CAMTP guest <camtp.guest@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020902140509.A10976@redhat.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	CAMTP guest <camtp.guest@uni-mb.si>, linux-kernel@vger.kernel.org
References: <15731.22574.493121.798425@proizd.camtp.uni-mb.si> <1231170000.1030981811@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1231170000.1030981811@aslan.scsiguy.com>; from gibbs@scsiguy.com on Mon, Sep 02, 2002 at 09:50:11AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 09:50:11AM -0600, Justin T. Gibbs wrote:
> > I'm running 2.4.19, using AIC7XXX 6.2.8.
> > SCSI devices are 0:0:0 hard disk and 0:6:0 CDR.
> > During CD burning, errors sometimes occur and aic7xxx driver
> > sets the CDR offline. Is there a way to reset the device and
> > set it online again _without_rebooting_ ?
> 
> I don't know that any mechanism currently exists.  It shouldn't be
> too hard to create on though.  Just modify the proc handler in 
> drivers/scsi/scsi.c.
> 
> While your looking at that, I would like to better understand why the
> device is being set offline.  The message listing you've provided is
> not complete.  If you send me all of the messages output by the driver
> from boot through failure I will try to diagnose your problem.

Actually, it looked to me like there was a bus hang, a device reset, the 
driver returned a complete reset to the error handler thread, then the 
error handler thread kicked the queue before the CD was ready to accept 
commands again and as a result of sense info saying as much the mid layer 
took the device off line.  So, in short, the mid layer isn't waiting long 
enough, or when it gets sense indicated not ready it needs to implement a 
waiting queue with a timeout to try rekicking things a few times and don't 
actually mark the device off line until a longer period of time has 
elasped without the device coming back.

As for getting it to be not off line without rebooting, just do a this:

echo "scsi-remove-single-device 0 0 6 0" > /proc/scsi/scsi
echo "scsi-add-single-device 0 0 6 0" > /proc/scsi/scsi

That'll remove the device and then rescan it.  Assuming it's had enough 
time to complete the reset by the time you do this and it's once again 
ready to accept commands, this should get your CD back working.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
