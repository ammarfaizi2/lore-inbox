Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVARP6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVARP6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVARP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:56:16 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:20960 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261334AbVARPzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:55:41 -0500
Date: Tue, 18 Jan 2005 16:55:34 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118155534.GA12050@speedy.student.utwente.nl>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E01BC42AE@email1.mitretek.org> <20050118140203.GH2839@darkside.22.kls.lan> <20050118141707.GA11385@speedy.student.utwente.nl> <20050118152006.GJ2839@darkside.22.kls.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118152006.GJ2839@darkside.22.kls.lan>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 04:20:06PM +0100, Mario Holbe wrote:
> On Tue, Jan 18, 2005 at 03:17:07PM +0100, Sytse Wielinga wrote:
> > Why not just use dd if=/dev/xxx `blockdev --getbsz /dev/xxx` ...?
> 
> because it doesn't work, as I've demonstrated in
> Message-ID: <20050118082022.GA2839@darkside.22.kls.lan>
> 
> > root@darkside:~# dd if=/dev/hdg7 of=/dev/null bs=512
> > attempt to access beyond end of device
> > 22:07: rw=0, want=4996184, limit=4996183
> > dd: reading `/dev/hdg7': Input/output error
> > 9992360+0 records in
> > 9992360+0 records out
> > 5116088320 bytes transferred in 92,603241 seconds (55247400 bytes/sec)
> > root@darkside:~#
> > 
> > Fixing dd's blocksize to 512 doesn't help either.

That's not what I said; the block size of /dev/hdg7 there is 4096, not 512.
Besides, the blocksize of dd is 512 by default and independent of the blocksize
of the device.

Anyhow, the block size set for dd doesn't matter as even if the block size is
huge dd copies over the last partial block. The problem was that with the 2.4
kernel only whole blocks are usable, but it rounds off the device size to
multiples of the sector size (i.e., not; the device size is given in multiples
of the sector size, which, by default, is 512) instead of rounding off to
multiples of the block size. The 2.6 kernel does not have this problem; it
appears to accept partial blocks, and doesn't even appear to calculate the
device size (blockdev --getsz and --getsize return 0 on my machine.)

I think the fix could be as simple as rounding off the device size in one
location, but, as I haven't had a look at the source, I'm not sure, maybe every
driver needs a fix.

	Sytse
