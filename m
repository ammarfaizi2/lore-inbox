Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130122AbRBAKXv>; Thu, 1 Feb 2001 05:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130233AbRBAKXl>; Thu, 1 Feb 2001 05:23:41 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6664 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130122AbRBAKXX>; Thu, 1 Feb 2001 05:23:23 -0500
Date: Thu, 1 Feb 2001 04:23:20 -0600
To: William Knop <w_knop@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
Message-ID: <20010201042320.B27725@cadcamlab.org>
In-Reply-To: <F204tAEHLB8TrBHxvZ900001de6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <F204tAEHLB8TrBHxvZ900001de6@hotmail.com>; from w_knop@hotmail.com on Thu, Feb 01, 2001 at 03:44:38AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[William Knop]
> How can DevFS know which devices to add to /dev/scsi/... without
> loading the module and scanning the bus first? Or do you manually
> insert the scsi module when you need it?

If you do 'cd /dev/scsi', the kernel looks it up and finds it missing,
which generates a "lookup" event from the kernel to your 'devfsd'
process.  (You *do* run devfsd, right?)  devfsd then calls 'modprobe
/dev/scsi' (I think that's the default action, you can change it in
/etc/devfsd.conf if you wish).  /sbin/modprobe reads /etc/modules.conf
which has an entry like 'alias /dev/scsi sym53c8xx', so when it is
asked to load /dev/scsi it actually loads sym53c8xx.  sym53c8xx in turn
triggers the creation of /dev/scsi as it initializes.

So modprobe, having loaded the module, exits.  devfsd then replies to
the kernel 'ok, try again, will you please' and the kernel does so, and
this time /dev/scsi/ exists and is accessible.

...And the chdir("/dev/scsi") system call, having waited this whole
time, finally returns successfully.  And now you know ... the rest of
the story.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
