Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVAXBqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVAXBqx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 20:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVAXBqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 20:46:53 -0500
Received: from ns1.giga-sj-001.net ([216.218.210.201]:28377 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S261413AbVAXBqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 20:46:48 -0500
From: Tim Fairchild <tim@bcs4me.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: DVD burning still have problems
Date: Mon, 24 Jan 2005 11:46:32 +1000
User-Agent: KMail/1.6.1
Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       linux-kernel@vger.kernel.org
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de> <5a4c581d050123125967a65cd7@mail.gmail.com>
In-Reply-To: <5a4c581d050123125967a65cd7@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501241146.32427.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 Jan 2005 06:59, Alessandro Suardi wrote:
> On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
>
> <volker.armin.hemmann@tu-clausthal.de> wrote:
> > Hi,
> >
> > have you checked, that cdrecord is not suid root, and
> > growisofs/dvd+rw-tools is?
> >
> > I had some probs, solved with a simple chmod +s growisofs :)
>
> Lucky you. Burning as root here, cdrecord not suid. Tried also
>  burning with a +s growisofs, but...

You can test if it's the kernel/growisofs clashing by hacking the
drivers/block/scsi_ioctl.c  code

It's around line 193 in 2.6.9, and line 196 in 2.6.10
not sure about 2.6.11

find the code:

        /* Write-safe commands just require a writable open.. */
        if (type & CMD_WRITE_SAFE) {
                if (file->f_mode & FMODE_WRITE)
                        return 0;
        }

edit it to something like:

        /* Write-safe commands just require a writable open.. */
        if (type & CMD_WRITE_SAFE) {
                printk ("Write safe command in ");
                if (file->f_mode & FMODE_WRITE)
                        printk ("write mode.\n");
                else
                        printk ("read mode.\n");
                return 0;
        }

Compile the kernel with that and that may make it work and burn dvd and let 
you know if it's growisofs sending incorrect commands. You'll get messages in 
dmesg like

Write safe command in read mode.

which means growisofs is still not right. Maybe later version fixed this?

tim


-- 
---------------------------------------------------------
  Tim & Therese Fairchild
  Atchafalaya Border Collies.
  Kuttabul, Queensland, Australia.
---------------------------------------------------------
 Email       mailto:tim@bcs4me.com
 Homepage    http://www.bcs4me.com
 Photos      http://www.pbase.com/amosf
---------------------------------------------------------
