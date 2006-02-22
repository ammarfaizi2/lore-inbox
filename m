Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWBVRvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWBVRvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWBVRvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:51:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3523 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161143AbWBVRvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:51:40 -0500
Date: Wed, 22 Feb 2006 17:51:31 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Zeuthen <david@fubar.dk>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222175131.GC27946@ftp.linux.org.uk>
References: <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com> <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:08:47AM -0800, Linus Torvalds wrote:
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175998
> 
> So the kernel obviously shouldn't be just randomly changing the type 
> numbers around. 

> The _real_ bug seems to be that some people think it is OK to do this kind 
> of user-visible changes, without even considering the downstream, or 
> indeed, without even telling anybody else (like Andrew or me) about it.

That's not quite true...

Some background: sbp2 took SCSI devices of type 14 (very reduced and slightly
incompatible version of "SCSI disk", fairly common for external disks) and
forcibly marked them as type 0.  Since sd.c had no way to tell whether it's
dealing with normal SCSI disk or with RBC one, it was unable to tell how
to find out whether the cache on that disk is write-through or write-behind
(that being one of the incompatibilities).

That leads to actual data corruption on reboot, BTW - some of these guys
simply lose the contents of cache at that.

Obvious fix?  Make sd.c deal with RBC (note that it's a valid SCSI type -
you bloody well can have it for a device attached to any SCSI bus, not
just firewire) and leave the sdev->type intact, so that sd.c could know
what's going on.  Right?

As it turns out, sdev->type is not just exposed to userland via sysfs
(that has legitimate uses), it's exposed to userland that happens to be
braindead.  There are two questions:
	* what commands does that device accept?
	* is there an sd<...> block device for it?
Both are valid for userland.  E.g. stuff like scsiinfo, etc., is issuing
SCSI commands via SG_IO.  And yes, knowing the device type is very, very
useful there.  For that we actually would want accurate type, for the same
reasons why we want it in sd.c.  The second question ("is there an sd.c
block device for this guy?") also is valid and has a sane answer in sysfs.

What got broken?  Code that used to assume that sd.c will never, ever handle
openly RBC disks.  As long as that remained true, userland could assume that
"sd fodder" and "has type 0" were the same.  Which was never guaranteed.
