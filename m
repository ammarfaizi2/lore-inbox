Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVJSPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVJSPXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVJSPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:23:48 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:39941 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751090AbVJSPXr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:23:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sz8ovci9SwrWmXDpnPgvmi4dSo/iyuVtkk1W2HzbfXRHNeHIWQOrt2i21DlRM2Q6CZZ5ofX8+uBk1P1epbV07vZDgy4CZXDtfT1ipsPG9RdivGbIHr7NZ1Ypp8XeY0juOLq1CjBIpObzXfnd9I9AEq8DbGITYmhnilybBx9NvU0=
Message-ID: <5bdc1c8b0510190823t70218437xab301031897aecf1@mail.gmail.com>
Date: Wed, 19 Oct 2005 08:23:46 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: scsi_eh / 1394 bug - -rt7
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
	 <1129693423.8910.54.camel@mindpipe>
	 <1129695564.8910.64.camel@mindpipe>
	 <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> On Wed, 19 Oct 2005, Lee Revell wrote:
>
> > On Tue, 2005-10-18 at 23:43 -0400, Lee Revell wrote:
> > > On Tue, 2005-10-18 at 14:02 -0700, Mark Knecht wrote:
> > > > Hi,
> > > >    I'm seeing this each time I plug in a 1394 hard drive:
> > > >
> > > > Attached scsi disk sdc at scsi6, channel 0, id 0, lun 0
> > > > ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> > > > ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> > > > ieee1394: Reconnected to SBP-2 device
> > > > ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
> > > > ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00b31ec]
> > > > prev->state: 2 != TASK_RUNNING??
> > > > scsi_eh_6/20286[CPU#0]: BUG in __schedule at kernel/sched.c:3328
> > >
> > > I hit this exact same bug while at a client site today, with an external
> > > USB drive.
> >
> > And again on my home machine running -rt1 with my digital camera!
> >
> > Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> > usb 2-1: USB disconnect, address 2
> > prev->state: 2 != TASK_RUNNING??
> > scsi_eh_0/12648[CPU#0]: BUG in __schedule at kernel/sched.c:3326
> >  [<c01048b9>] dump_stack+0x19/0x20 (20)
> >  [<c011e766>] __WARN_ON+0x46/0x80 (12)
> >  [<c02c0bf7>] __schedule+0x547/0x790 (84)
> >  [<c012057a>] do_exit+0x26a/0x430 (28)
> >  [<c010147b>] kernel_thread_helper+0xb/0x10 (1020129312)
> >
>
> This is also a problem in the upstream kernel.  It's just that RT catches
> it!  Here's the patch. I'll also write one for the upstream kernel,
> although this patch would probably work there as well. But I'll make it
> official.
>
> Ingo,
>
> Here's the patch.  The problem is similar to the pcmcia bug.  It seems
> that the loop usually exits in the TASK_INTERRUPTIBLE state.
>
>
> Lee and Mark,
>
> Can you two try it as well and confirm that you cant get the
> bug anymore.
>
> Thanks,
>
>
> -- Steve
>
>
> Index: linux-2.6.14-rc4-rt9/drivers/scsi/scsi_error.c
> ===================================================================
> --- linux-2.6.14-rc4-rt9.orig/drivers/scsi/scsi_error.c 2005-10-19 02:54:49.000000000 -0400
> +++ linux-2.6.14-rc4-rt9/drivers/scsi/scsi_error.c      2005-10-19 02:57:06.000000000 -0400
> @@ -1645,6 +1645,12 @@
>                 set_current_state(TASK_INTERRUPTIBLE);
>         }
>
> +       /*
> +        * There's a good chance that the loop will exit in the
> +        * TASK_INTERRUPTIBLE state.
> +        */
> +       __set_current_state(TASK_RUNNING);
> +
>         SCSI_LOG_ERROR_RECOVERY(1, printk("Error handler scsi_eh_%d"
>                                           " exiting\n",shost->host_no));
>
>

Steve,
   Initial indications are that this fixes it. I've attached and
removed a 1394 drive a few times. I'll watch it through the day,
either in -rt7-patched or -rt10 when I get it built correctly.

   Thanks very much!

Cheers,
Mark
