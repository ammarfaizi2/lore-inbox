Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292159AbSBBA3n>; Fri, 1 Feb 2002 19:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292160AbSBBA3e>; Fri, 1 Feb 2002 19:29:34 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18702
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292159AbSBBA3W>; Fri, 1 Feb 2002 19:29:22 -0500
Date: Fri, 1 Feb 2002 16:20:53 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Andries.Brouwer@cwi.nl
cc: p_gortmaker@yahoo.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clipped disk reports clipped lba size
In-Reply-To: <UTC200202012155.VAA123193.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.10.10202011609170.22985-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is a valid and techincally correct operation; however, it is only one
half of the solution.  Your "SETMAX" user-space IOCTL, is great if you do
not have partitions that bridge that boundary, other wise TOAST.  Now the
problem I have not addressed is the reboot issue, and neither have you.
On a warm reboot after as SET_MAX_NATIVE_ADDRESS has been issued from the
previous time, the drive is now larger than the 32GB clip limit.  Thus the
warm reboot will fail.  Since it is a volitale command and does not
survive power cycles but does survive resets and reboots, all we have
both done is to insure a dead hang in warm reboot.  So the issue is to
destroke the drive on reboot or notification by undoing the capacity
expansion.  Since I have not gotten to completing the last stage, it is a
compile option.  An option is exactly what it means.

As for the monolithic patch ... there is a much grander end game for the
driver than what most can see or even invision.  Thus the goal is to
transform the driver to handle the current various archs with conflicts of
PIO v/s MMIO calling to the transport layer built in the same system.

The other more obvious point is to standardize the data-handlers where as
the addition of a new command is simple, not adding N-different handlers
for each new command Linux attempts to support.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Fri, 1 Feb 2002 Andries.Brouwer@cwi.nl wrote:

>     From: Paul Gortmaker <p_gortmaker@yahoo.com>
> 
>     Andries.Brouwer@cwi.nl wrote:
> 
>     > Some disk types fake LBA at 33.8GB, but allow access past this point.
>     > Some disks actually give I/O errors past the 33.8GB (when jumpered),
>     > and a SETMAX command is needed to make the rest accessible.
>     > 
>     > Two years ago I wrote a tiny utility setmax that does this.
>     > If I am not mistaken this stuff is now part of the 2.5 kernel.
>     > No doubt some of it will eventually be backported to 2.4 / 2.2 / 2.0.
>     > It is in 2.4.18-pre7-ac1.
> 
>     Alan has said (quite reasonably) that he is not interested in inclusion
>     of the big IDE patch that exists for 2.2.x -- however, a minimal cut and 
>     paste backport from 2.4.x IDE to just support HDIO_DRIVE_CMD_AEB (and thus
>     support setmax) is only about a 100 line diff which I did a while ago.
> 
>     If there is any interest in this I can check it still applies cleanly to 
>     current 2.2 pre kernel and send it along for inclusion.
> 
> (1) *_AEB is intended as private namespace for me, not for inclusion
> in an official kernel. So, some official name, like HDIO_DRIVE_TASK,
> must be better.
> 
> (2) Long ago very little information was available and I wrote a small
> program that worked for me and solicited experiences from others.
> By now we have a better idea of the variations that exist.
> Moreover, this is beginning 2.5 time, so experiments are allowed.
> That means that we can delete CONFIG_IDEDISK_STROKE, and make the
> kernel do what we think is right. Once this gets to a state where
> there are no complaints anymore we can move it to some 2.4 tree,
> and if that still does not produce complaints to 2.2 and 2.0.
> 
> In the area of big disks there are two main hurdles these days:
> (a) capacity-limiting jumpers to overcome BIOS problems
> (b) disks larger than 137 GB, the old ATA limit.
> 
> Both problems can be solved with relatively small patches,
> no big monolithic IDE patch required. And I would prefer
> to solve both problems without involving ioctl's, or boot
> parameters, or config parameters. All should just work
> in the common case.
> 
> Andries
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


