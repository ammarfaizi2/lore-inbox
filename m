Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUJSBy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUJSBy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUJSBy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:54:57 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:24759 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268270AbUJSByu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:54:50 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Date: Tue, 19 Oct 2004 11:54:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16756.29638.846336.56357@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@infradead.org>, schwidefsky@de.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Patch to add RAID autostart to IBM partitions
In-Reply-To: message from Pete Zaitcev on Saturday October 16
References: <20041015224822.7d980a9e@lembas.zaitcev.lan>
	<20041016110939.GB30336@infradead.org>
	<20041016082937.62c15e6c@lembas.zaitcev.lan>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday October 16, zaitcev@redhat.com wrote:
> On Sat, 16 Oct 2004 12:09:39 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > We had this for a few partition types (and full block devices) already
> > and it's been vetoed.  Use mdadm from initrd/initramfs instead.
> 
> It is doable in theory, but in practice mdadm is too retarded (I'm taliking
You sweet-talker you....

> about mdadm 1.6.0 here). Its man page says:
> 
>     mdadm can perform (almost) all of its functions  without  having  a
>     configuration  file  and  does  not use one by default.
> 
> I guess "almost" is the key. Firstly, it collapses with any attempt to run
> "mdadm -A -s" or any variation of such, because it's full of places like
> this.
> 
> 	mddev_ident_t array_ident = conf_get_ident(configfile, dv->devname);
> 	mdfd = open_mddev(dv->devname, array_ident->autof);

Hmm, thanks for the bug report.  I'll fix that rather silly bit of
code..... there.  The next release won't have that bug.
> 
> Obviously, array_ident is NULL if a config file is not present. It is
> possible to fool the stupid thing by giving it a dummy config file,

There's that silver tongue again.  It makes one feel all warm
inside....

> like this one:
> 
> DEVICE partitions
> ARRAY /dev/md0
> 
> It still won't scan, aborting with this:
> mdadm: /dev/dasda has no superblock - assembly aborted

Yes, you haven't told it what defines "/dev/md0", so it assumes the
first device listed will define it, but /dev/dasda doesn't so....

You have to tell mdadm how to recognise /dev/md0.  Possibly by UUID.
Possibly by "minor number".
e.g.

 DEVICE partitions
 ARRAY /dev/md0 super-minor=0

which means "if you find any devices listed in /proc/partitions which
contains an MD superblock which has a "md_minor" field of "0", then
use those to assemble /dev/md0.

This will often be what you want, but might not always.  e.g. if you
have plugged in a drive that was part of /dev/md0 in another machine,
then mdadm will have no way of knowing which drive is the "right" one.

NeilBrown
