Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263266AbUJ2CZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbUJ2CZB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbUJ2CXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:23:51 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:54213 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263183AbUJ2CRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 22:17:15 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Date: Fri, 29 Oct 2004 12:16:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16769.43027.267366.474937@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch to add RAID autostart to IBM partitions
In-Reply-To: message from Pete Zaitcev on Tuesday October 19
References: <20041015224822.7d980a9e@lembas.zaitcev.lan>
	<20041016110939.GB30336@infradead.org>
	<20041016082937.62c15e6c@lembas.zaitcev.lan>
	<16756.29638.846336.56357@cse.unsw.edu.au>
	<20041019093237.291b7ab8@lembas.zaitcev.lan>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 19, zaitcev@redhat.com wrote:
> On Tue, 19 Oct 2004 11:54:14 +1000, Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> Dear Neil,
> 
> thank you for your patient reply. It makes things a lot clearer.
> 
> > Yes, you haven't told it what defines "/dev/md0", so it assumes the
> > first device listed will define it, but /dev/dasda doesn't so....
> 
> > You have to tell mdadm how to recognise /dev/md0.  Possibly by UUID.
> > Possibly by "minor number".
> > e.g.
> > 
> >  DEVICE partitions
> >  ARRAY /dev/md0 super-minor=0
> > 
> > which means "if you find any devices listed in /proc/partitions which
> > contains an MD superblock which has a "md_minor" field of "0", then
> > use those to assemble /dev/md0.
> 
> I see now. I'm sorry that I was unable to deduce it from the manual.
> One last question, if the -As worked, would it do the same?

No.  -As needs a config file.  Currently without the config file, it
crashes.  In the next release, without a config file it will fail more
gracefully. 

> 
> > This will often be what you want, but might not always.  e.g. if you
> > have plugged in a drive that was part of /dev/md0 in another machine,
> > then mdadm will have no way of knowing which drive is the "right" one.
> 
> I guess there's nothing we can do about possible conflicts, except warn
> the operator at installation time. What is the recommended way to ask
> mdadm to list all conflicts, or simply all found array devices, for the
> benefit of an installation program reading a pipe?

These isn't really one.
  mdadm -Es -c partitions

will list all possibly arrays - you could then pick the one you want.

But choosing the drives to assemble to make an md array is a lot like
choosing the partition to mount to find the root filesystem.  It might
be possible to guess, but if you rely in the guess, it will sometimes
be wrong.  At install time, it is safe to guess if there is only one
candidate.  If there are more, you really have to ask.

After that, the boot process (or whatever process assembles the
arrays) really needs to have been told how to recognise components,
just like lilo tells linux which device has root (root=).

The output of mdadm -E could possibly be made more friendly (currently
it will happily list arrays that cannot possibly be completely
assembled right along side arrays that are likely to work).

NeilBrown
