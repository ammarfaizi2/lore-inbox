Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWAUDpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWAUDpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWAUDpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:45:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932267AbWAUDpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:45:01 -0500
Date: Fri, 20 Jan 2006 19:44:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Titov <a.titov@host.bg>
Cc: James.Bottomley@SteelEye.com, chase.venters@clientec.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: OOM Killer killing whole system
Message-Id: <20060120194438.53a15d85.akpm@osdl.org>
In-Reply-To: <1137814181.11771.70.camel@localhost>
References: <1137337516.11767.50.camel@localhost>
	<1137793685.11771.58.camel@localhost>
	<20060120145006.0a773262.akpm@osdl.org>
	<200601201819.58366.chase.venters@clientec.com>
	<20060120165031.7773d9c4.akpm@osdl.org>
	<1137806248.4122.11.camel@mulgrave>
	<1137814181.11771.70.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Titov <a.titov@host.bg> wrote:
>
> On Fri, 2006-01-20 at 19:17 -0600, James Bottomley wrote:
> > On Fri, 2006-01-20 at 16:50 -0800, Andrew Morton wrote:
> > > For linux-scsi reference, Chase's /proc/slabinfo says:
> > > 
> > > scsi_cmd_cache    1547440 1547440    384   10    1 : tunables   54   27    8 : 
> > > slabdata 154744 154744      0
> > 
> > There's another curiosity about this: the linux command stack is pretty
> > well counted per scsi device (it's how we control queue depth), so if a
> > driver leaks commands we see it not by this type of behaviour, but by
> > the system hanging (waiting for all the commands the mid-layer thinks
> > are outstanding to return).  So, the only way we could leak commands
> > like this is in the mid-layer command return logic ... and I can't find
> > anywhere this might happen.
> > 
> 
> Just to mention, that 2.6.14.2 does not have this problem:
> 
> vip ~ # cat /proc/slabinfo | grep scsi
> scsi_cmd_cache        60     60    384   10    1 : tunables   54   27
> 8 : slabdata      6      6     27
> 
> but my guess is that the problem may be not in SCSI, as not /and
> previosly actually/ I have this:
> 
> vip ~ # cat /proc/slabinfo | grep reiser
> reiser_inode_cache 556594 556614    408    9    1 : tunables   54   27
> 8 : slabdata  61846  61846      0
> 
> which seems too high too

Having large numbers of cached inodes is fairly common.  Try running
something which uses lots of memory: memset(malloc(gigabytes)), or usemem
from http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz or
read a multi-gigabyte file from disk and you shuld see the inode count wind
down.


