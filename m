Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVEQGSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVEQGSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVEQGSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:18:36 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40904 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261173AbVEQGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:18:17 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Elladan <elladan@eskimo.com>, Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
Date: Tue, 17 May 2005 09:17:47 +0300
User-Agent: KMail/1.5.4
Cc: Valdis.Kletnieks@vt.edu, fs@ercist.iscas.ac.cn,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu> <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp> <20050516223058.GG18792@eskimo.com>
In-Reply-To: <20050516223058.GG18792@eskimo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170917.47301.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 01:30, Elladan wrote:
> > I don't think that's good idea.
> > 
> > USB storage is gone. And it SEEMS to came back.
> > But how do you know that it's images were not changed.

Original poster seems to be a bit confused between what device driver
is responsible for, and what FS is responsible for.

IIRC, currently FS has no code to understand that device was removed.
It just gets failures on read/write ops, but does not do much with
error codes. It does not 'unmount on the fly' etc. It may do
something like this, but currently it is not coded.
Errors are simply propagated up to callers.

> > Blocks you have cached might have different image. If you remount
> > the file system, the cache image should be updated as well.
> > 
> > But very fact that *cache image should be updated* means, old cache
> > image was invalid. And when did it become invalid?
> 
> [...]
>  
> > You'll, at least, see that there is some inconsistency about cache
> > handling when we *umount->mount* and *remount*.
> 
> This is basically the problem people have had with removable storage for
> years...  You can't really solve it perfectly, since as you note one
> could always place the storage in another machine and change it.

Linux is worse than "other OSes" because it treats removable storage
either the same as ordinary disks: caches writes, starts writeback
sometime in the future (thus we do not notice removals ASAP),
or Linux can mount removables O_SYNC: writes are not cached at all
(too aggressive/slow in many circumstances) and you can be positively
sure data is on disk if I/O indicator diode is off.

A new, less aggressive sync option which means "okay to cache writes,
but start writeback at once and write out all dirty data for this device"
would bring the best of both worlds.

Users of USB sticks not dying anymore from O_SYNC mounts will be
quite happy, too :)

Further step could be a way to keep such FSes as unjournalled ext2
in 'clean' state between write bursts (if FS is mounted with abm
'lazy sync' flag) and auto-unmounting of removed media. Although
I suspect even current hotplug can be configured to do auto-unmount,
I just did not try it myself.

> But I think it's instructive to note what most other systems have done
> in this situation...  The solution seems similar in most cases, from eg.
> Mac, Amiga, DOS, Windows, etc.
> 
> The typical solution is, when a removable device is yanked when dirty
> blocks exist, is to keep the dirty blocks around, and put the device
> into some sort of pending-reinsert state.
> 
> Then most systems typically display a large message to the user of the
> form: "You idiot!  Put the disk/cd/flash/etc. back in!"

Such message may be doable with hotplug. We need 'only' a
'pending-reinsert state' bits coded.
 
> The cache and dirty blocks would then only be cleared on a user cancel.
> If the same device (according to some ID test) reappears, then it's
> reactivated and usage continues normally.
> 
> Obviously, this sort of approach requires some user interaction to get
> right.  It has the distinct advantage of not throwing away the data the
> user wrote after an inadvertant disconnect, for example if they thought
> the device was done writing when it really wasn't.  It can also keep
> from corrupting the FS metadata.
> 
> The downside is that it might not really work, if there wasn't a good
> way to know when sectors actually are in stable storage, since a few
> blocks could be lost around the time the device was pulled.

I think it is sensible to try to improve clean removals first,
then tackle dirty ones.
--
vda

