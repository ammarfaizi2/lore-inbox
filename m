Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266915AbUHOVmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266915AbUHOVmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUHOVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:42:52 -0400
Received: from unthought.net ([212.97.129.88]:58769 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S266915AbUHOVmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:42:49 -0400
Date: Sun, 15 Aug 2004 23:42:48 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux SATA RAID FAQ
Message-ID: <20040815214247.GU27443@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
	Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net> <1092315392.21994.52.camel@localhost.localdomain> <411BA7A1.403@pobox.com> <411BA940.5000300@pobox.com> <1092520163.27405.11.camel@localhost.localdomain> <1092603242.7421.6.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092603242.7421.6.camel@nomade>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:54:02PM +0200, Xavier Bestel wrote:
> Le sam 14/08/2004 à 23:49, Alan Cox a écrit :
> > > > * Caching
> > 
> > Is it battery backed ? If it is battery backed then its useful, if not
> > then it becomes less useful although not always. The i2o drivers have
> > some ioctls so you can turn on writeback caching even without battery
> > backup. While this is suicidal for filesytems its just great for swap..
> 
> Isn't sufficient to have it do ordered writes ? If you power your
> machine off, you'll have things half-written anyway, the only thing
> important with journaled filesystems (and raid5 arrays) is to have
> writes staying between barriers.

On a RAID controller with battery backed write-back cache, it can
complete a "sync" operation as soon as the data is in the controller
cache.   This gives a significant performance speedup.

If the cache is not battery backed and power is lost after such a "sync"
operation, then data that the kernel/userspace thought was sync'ed to
disk is actually lost.

This *will* break journalling filesystems and databases.  They work from
the assumption that 'sync' means 'sync' - and if it doesn't, then all
hell breaks lose.

It is common to enforce ordering of writes by issuing a 'sync' of some
data and after the sync completes then starting the writeout of the
'next' data.  On a controller with write-back cache without battery
backup, you could actually risk that your 'next' data were written
before the data you just issued a 'sync' for.

In other words;  write-back cache without battery backup is absolutely
insane, except for some few isolated cases, such as swap-space that Alan
pointed out.

-- 

 / jakob

