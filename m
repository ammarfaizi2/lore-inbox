Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVHUVM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVHUVM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVHUVM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:12:28 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751104AbVHUVM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:12:27 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: PATCH for changing of DVD speed via ioctl() call
To: cHitman <samartsev@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 21 Aug 2005 21:56:45 +0200
References: <4E0p1-3vc-23@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E6vvy-0000hI-Hj@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cHitman <samartsev@gmail.com> wrote:

> This patch implements changing of DVD speed via ioctl() call, like
> CDROM_SELECT_SPEED do. In CDROM_SELECT_SPEED its implementation isn't
> so good (diffirent values of 1x in KB/s, troubles with return value of
> cdrom_select_speed() and other). I defined CDROM_SELECT_DVDSPEED ioctl
> () call with value 0x5324. But some dvdroms (like Plexter) do not
> support this feature.. :(

Introducing another device-specific IOCTL because the other device-specific
request turned out to be wrong is likely to be wrong, too.

>  req.sense = sense;
> -     if (speed == 0)
> +     if (speed <= 0)
>  speed = 0xffff; /* set to max */
>  else
>  speed *= 177;   /* Nx to kbytes/s */

The parameter value should IMHO be a pointer to a struct {
 unsigned long long maxspeed; // (with 0 being the magic max. value?)
 int facility; /* 0=general speed, 2=general read, 4=read data,
                  6=read audio, 8=read raw ... whatever is supported
                  n+1 = s/read/write/ */
}

That will work for any device and speed you can expect in the near future.

> +static int cdrom_select_dvd_speed(ide_drive_t *drive, int speed,
> +             struct request_sense *sense)
> +{
> +     struct request req;
> +     struct request_sense cap_sense;
> +     unsigned char pd[28];
> +     unsigned long cap, spf;
> +
> +     if (!CDROM_CONFIG_FLAGS(drive)->dvd)
> +             return -ENOSYS;

EINVAL?

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
