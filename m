Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVB1QTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVB1QTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVB1QRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:17:24 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:10655 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261672AbVB1QPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:15:35 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Date: Mon, 28 Feb 2005 17:14:55 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl> <200502271731.29448.bzolnier@elka.pw.edu.pl> <422337A1.4060806@gmail.com>
In-Reply-To: <422337A1.4060806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502281714.55960.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Monday 28 February 2005 16:24, Tejun Heo wrote:
>   Hi,
> 
> Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 27 February 2005 08:36, Tejun Heo wrote:
> > 
> >> Hello, Bartlomiej.
> >>
> >> This patch should be modified to use flagged taskfile if the
> >>task_end_request_fix patch isn't applied.  As non-flagged taskfile
> >>won't return valid result registers, TASK ioctl users won't get the
> >>correct register output.
> > 
> > 
> > Nope, it works just fine because REQ_DRIVE_TASK used only
> > no-data protocol, please check task_no_data_intr().
> > 
> 
>   Sorry, I missed that.  IDE really has a lot of ways to finish a 
> command, doesn't it?  hdio.txt is gonna look ugly. :-)

Yep but it was a lot more "fun" when there were three PIO codepaths. ;-)

hdio.txt doesn't need to know about driver internals so no problem here.

> > 
> >> IMHO, this flag-to-get-result-registers thing is way too subtle.  How
> >>about keeping old behavior by just not copying out register outputs in
> >>ide_taskfile_ioctl() in applicable cases instead of not reading
> >>registers when ending commands?  That is, unless there's some
> >>noticeable performance impacts I'm not aware of.
> > 
> > 
> > This would miss whole point of not _reading_ these registers (IO is slow).
> > IMHO new flags denoting {in,out} registers should be added (to <linux/ata.h>
> > to share them with libata) so new code can be sane and old flags would map
> > on new flags when needed.
> 
>   Please do it.
> 
>   Or, let me know what you have in mind (added fields, flag names, 
> etc...); then, I'll do it.  I think we also need to hear Jeff's opinion 
> as things need to be added to ata.h.

I was thinking about:

* adding ATA_TFLAG_{IN,OUT}_xxx flags (there is enough free
  place for all flags in ->flags field of struct ata_taskfile)
* teaching flagged_taskfile() about these flags and mapping ->tf_out_flags
  onto ATA_TFLAG_OUT_xxx (simple mapping no need to move ->tf_out_flags
  to ide_taskfile_ioctl() etc. - no risk of breaking something)
* moving flagged taskfile writing to ide_tf_load_discrete() helper
* adding ide_tf_read_discrete() helper for use by ide_end_drive_cmd()
  and mapping ->tf_in_flags onto ATA_TFLAG_IN_xxx (ditto)

If you like this plan feel free to implement it.
I'm also open for better ideas, comments etc.

Bartlomiej
