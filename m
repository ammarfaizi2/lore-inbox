Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTFJSCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTFJSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:02:49 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:22263 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263782AbTFJSCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:02:47 -0400
Date: Tue, 10 Jun 2003 12:14:06 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large files
Message-ID: <20030610121406.D12274@schatzie.adilger.int>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0306100952560.4080@chaos> <20030610141759.GU28900@mea-ext.zmailer.org> <Pine.LNX.4.53.0306101057020.4326@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0306101057020.4326@chaos>; from root@chaos.analogic.com on Tue, Jun 10, 2003 at 11:12:55AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2003  11:12 -0400, Richard B. Johnson wrote:
> > On Tue, Jun 10, 2003 at 09:57:57AM -0400, Richard B. Johnson wrote:
> > > With 32 bit return values, ix86 Linux has a file-size limitation
> > > which is currently about 0x7fffffff. Unfortunately, instead of
> > > returning from a write() with a -1 and errno being set, so that
> > > a program can do something about it, write() executes a signal(25)
> > > which kills the task even if trapped. Is this one of those <expletive
> > > deleted> POSIX requirements or is somebody going to fix it?
> >
> >   http://www.sas.com/standards/large.file/
> >
> > #define SIGXFSZ    25    /* File size limit exceeded (4.2 BSD). */
> >
> > from  fs/buffer.c:
> >
> >         err = -EFBIG;
> >         limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
> >         if (limit != RLIM_INFINITY && size > (loff_t)limit) {
> >                 send_sig(SIGXFSZ, current, 0);
> >                 goto out;
> >         }
> >         if (size > inode->i_sb->s_maxbytes)
> >                 goto out;
> >
> >
> 
> On the system that fails, there are no ulimits and it's the root
> account, therefore I don't know how to set the above limit to
> RLIM_INFINITY (~0LU).  It's also version  2.4.20. I don't think
> it has anything to do with 'rlim' shown above. In any event
> sending a signal when the file-size exceeds some level is preposterous.
> The write should return -1 and errno should have been set to EFBIG
> (in user space). That allows the user's database to create another
> file and keep on trucking instead of blowing up and destroying the
> user's inventory or whatever else was in process.
> 
> FYI, this caused the failure of a samba server for M$ stuff. It
> gives the impression of Linux being defective. This is not good.

If your application is not compiled with O_LARGEFILE, you will also
get SIGXFSZ if you try to write past the 2GB limit.  This is to avoid
your application corrupting data by trying to store a 64-bit file
size in an (apparently) 32-bit data value (32-bit because you didn't
specify O_LARGEFILE).

I don't see anything in signal(7) which says that SIGXFSZ(25) can't be
caught and handled by the application, but at that point you may as
well just fix the app to just open the file with O_LARGEFILE and handle
64-bit file offsets properly.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

