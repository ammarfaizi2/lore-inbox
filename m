Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTH2UGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTH2UGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:06:21 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:24056 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261741AbTH2T5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:57:53 -0400
Date: Fri, 29 Aug 2003 22:57:37 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030829195737.GI150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308291325480.29088@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308291325480.29088@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 01:35:25PM -0300, you [Marcelo Tosatti] wrote:
> 
> So NMI and sysrq doesnt help. I suggest you a few things:
> 
> Try to make the bug easy to reproduce. Force the Oracle dumps again and
> again to crash the box. 

I happened to work towards that direction this morning (before I read your
mail). Taking the stance that this very probably had something to do with io
stress, I played around with several io loads. Eventually I found out that
fsx on scsi disk reliably caused the box to either lock up or the aic7xxx
driver to barf. What's more, it took under 15 minutes to trigger.

So I copied the rootfs and everything else from the scsi disk to the ide
disk (just barely had enough space), and took all the scsi disk partitions
away from fstab. After reboot, I have been unable to lock it up with fsx
(scsi disk is not accessed at all), but it will take several weeks before
I'm confident that the lock up is cured.

aic7xxx / scsi hw seems quite strong suspect for the lock ups. 2.2 possibly
worked because it has the older aic7xxx 5.x driver.

> Can you try it or its a production machine?

It is a sort-of-a production machine -- that's way I have been so wary on
trying different things. Sorry for that...
 
> BTW, can you describe this "Oracle dumps" in more detail? What do they do?
> Save lots of data to disk and thats all or ?

They dump the oracle data base to a backup file.

${ORAHOME}/bin/exp \
        ***/*** full=Y grants=Y \
        file=${DMPDIR}/fullexp.dmp 1>${LOGDIR}/fulllog.`date '+%a'` 2>&1
 
So basically just heavy IO afaict.

> Hope we can trace this down.

I'm still not 100% sure that the aic7xxx brafs (see
http://lkml.org/lkml/2003/7/29/33 for an example) and the lockups are of
the same origin. But it seems at least 99.5% certain.

If aic7xxx/scsi is to blame, then is it the
  - 2940 scsi adapter
  - the disk
  - the cabling or something (I've checked the termination)
  - the motherboard (irq routing?)
  - the aic7xxx driver?
  - some other kernel issue?

The hw is:
 Intel 815EEA2LU (i815 Chipset)
 Celeron 1.3GHz (Tualatin)
 Adaptec AHA-2940 / AIC-7871
   - Disk (rootfs) SEAGATE  Model: ST19171W Rev: 0024
   - Tape Drive    HP       Model: C1537A Rev: L708
 30GB IDE disk (scratch)


-- v --

v@iki.fi

