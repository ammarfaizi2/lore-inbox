Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVGTRzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVGTRzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 13:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVGTRzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 13:55:39 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:53813 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261442AbVGTRzc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 13:55:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Im/dPiPxRix72hjLblHiJRZLNt91mQ8QqTlg0Kohp1c7FGOUmq3gR4l/lX3ut2NQd3e/P0/wSB+bqmXQBe47cNZHWfTst/luZtRJBIIYeYtuSnigIpZVTBfo/rHLUOFNhAeULuehktMci2/URjob9EK5i8/dq89+bzkIQEj9QQ8=
Message-ID: <29495f1d05072010551c875a4a@mail.gmail.com>
Date: Wed, 20 Jul 2005 10:55:02 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus ion
Cc: Matt Domsch <Matt_Domsch@dell.com>, Olaf Hering <olh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org
In-Reply-To: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Moore, Eric Dean <Eric.Moore@lsil.com> wrote:
> On Tuesday, July 12, 2005 8:17 PM, Matt Domsch wrote:
> > In general, this construct:
> >
> > > > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > > > -static int inline scsi_device_online(struct scsi_device *sdev)
> > > > -{
> > > > - return sdev->online;
> > > > -}
> > > > -#endif
> >
> > is better tested as:
> >
> > #ifndef scsi_device_inline
> > static int inline scsi_device_online(struct scsi_device *sdev)
> > {
> >     return sdev->online;
> > }
> > #endif
> >
> > when you can.  It cleanly eliminates the version test, and tests for
> > exactly what you're looking for - is this function defined.
> >
> 
> What you illustrated above is not going to work.
> If your doing #ifndef around a function, such as scsi_device_online, it's
> not going to compile
> when scsi_device_online is already implemented in the kernel tree.
> The routine scsi_device_online is a function, not a define.  For a define
> this would work.
> 
> I'm trying your example around msleep, msleep_interruptible, and
> msecs_to_jiffies, and
> my code simply won't compile in SLES9 SP2(-191).  In SLES9 SP1(-139), these
> three routines were not implemented and
> your suggestion works.  I won't be able to to a linux version check as this
> change occurred between service packs
> of the 2.6.5 kernel suse tree.   Anybody on the linux forums have any ideas?
> 
> Example:
> 
> #ifdef msleep
> static void inline msleep(unsigned long msecs)
> {
>         set_current_state(TASK_UNINTERRUPTIBLE);
>         schedule_timeout(msecs_to_jiffies(msecs) + 1);
> }
> #endif

Just an FYI, if you are trying to emulate the actual behavior of
msleep() in the current kernel via this function, then you need to
place the sleep in a while-loop. Please see kernel/timer.c::msleep().
Your version will wake up on wait-queue events, while msleep() in the
current kernel does not.

Thanks,
Nish
