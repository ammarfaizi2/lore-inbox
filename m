Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbULEVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbULEVVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULEVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:21:48 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:14793 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261398AbULEVVp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:21:45 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041205211230.GC1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine>
	 <20041205211230.GC1012@elf.ucw.cz>
Date: Sun, 05 Dec 2004 21:21:38 +0000
Message-Id: <1102281698.9384.29.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 22:12 +0100, Pavel Machek wrote:

> > echo -n "set 03:02" >/sys/power/resume
> 
> I'd prefer not to have this one. Is it actually usefull? Then resume
> could be triggered by echo -n "03:02" > /sys/power/resume...

resume_device is set by swsusp_read, which requires name_to_dev_t to be
working. At the point where that's called, the device driver hasn't been
loaded and we don't have the information to get the dev_t. Once the
driver has been loaded, name_to_dev_t has already been discarded (it's
marked __init). So we need to set resume_device somehow.

> > will set /dev/hda2 as the resume device. 
> > 
> > echo -n "resume 03:02" >/sys/power/resume
> > 
> > will attempt a resume from /dev/hda2. Patches are against
> > 2.6.10-rc3.
> 
> Nice way to loose your data :-). [Note note note -- I'm not going to
> merge it before my bigdiff goes to mainline, so expect to rediff it
> when 2.6.10 is out. I can generate the big diff if you want to test it
> now.]

Heh. Yes, that's no problem. A new bigdiff for -rc3 would be helpful.

> You really need to make sure that userland processes are stopped
> before swsusp-resume is started. You should do freeze_process(). Then
> resume process depends on having enough memory available, so you
> probably want to free_some_memory() and warn in documentation about
> the fact.

Ok. I'll look into that. The main reason I want code like this is that
Debian use modular IDE drivers that are stored in the initrd. The disks
won't be touched until the root file system is mounted, and we'll
trigger the resume before then, so there shouldn't be any risk of data
loss. At this point, there shouldn't be any userspace running other than
a single shell script - do you think it's still a problem?

> Ugh, and you really should document "list of bad ideas with resume
> from userspace". It is extremely easy to shoot yourself into the foot
> with this one.

Will do.

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org

