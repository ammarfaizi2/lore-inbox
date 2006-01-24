Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWAXH0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWAXH0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 02:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWAXH0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 02:26:12 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:3760 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932466AbWAXH0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 02:26:11 -0500
Date: Tue, 24 Jan 2006 09:26:09 +0200
From: Ville Herva <vherva@vianova.fi>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Error message for invalid initramfs cpio format?
Message-ID: <20060124072608.GG1686@vianova.fi>
Reply-To: vherva@vianova.fi
References: <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123125420.GE1686@vianova.fi> <43D58AA8.2090903@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D58AA8.2090903@cfl.rr.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 09:02:16PM -0500, you [Phillip Susi] wrote:
> Ville Herva wrote:
> >PS: Speaking of debugging failing initrd init scripts; it would be nice if
> >the kernel gave an error message on wrong initrd format rather than 
> >silently
> >failing... Yes, I forgot to make the cpio with the "-H newc" option :-/.
> >  
> 
> LOL, yea, that one got me too when I was first getting back into linux a 
> few months ago and had to customize my initramfs to include dmraid to 
> recognize my hardware fakeraid raid0.  Then I discovered the mkinitramfs 
> utility which makes things much nicer ;)

Sure does, that's what I first used, too. But then I had to hack with the
init script and it seemed quicker to 

  gzip -d < /boot/initrd-2.6.15.1.img | cpio --extract --verbose --make-directories --no-absolute-filenames
  vi init 
  ...
  find . | cpio -H newc --create --verbose | gzip -9 > /boot/initrd-2.6.15.1.img

It seems do_header() in init/initramfs.c checks for the "070701" magic (that
is specific to the newc format [1]), and populate_rootfs() should then
panic() with "no cpio magic" error message, but I'm fairly sure I didn't see
an error about wrong initramfs format when booting with an initrd made with
cpio without the -H newc option. 

This is what I see:

 RAMDISK: Couldn't find valid RAM disk starting at 0.
 VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
 Please append correct "root=" boot option
 Kernel panic - not syncing: VFS: Unable to mount root fs on
 unknown-block(0,0)

seems the "no cpio magic" message is somehow lost. It would be useful.


-- v -- 

v@iki.fi



[1] "The new (SVR4) portable format, which supports file systems having more
     than 65536 i-nodes."
