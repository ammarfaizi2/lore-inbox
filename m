Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUJPPaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUJPPaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUJPPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:30:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27042 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268756AbUJPPaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:30:17 -0400
Date: Sat, 16 Oct 2004 08:29:37 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: schwidefsky@de.ibm.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       <neilb@cse.unsw.edu.au>
Subject: Re: Patch to add RAID autostart to IBM partitions
Message-ID: <20041016082937.62c15e6c@lembas.zaitcev.lan>
In-Reply-To: <20041016110939.GB30336@infradead.org>
References: <20041015224822.7d980a9e@lembas.zaitcev.lan>
	<20041016110939.GB30336@infradead.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2004 12:09:39 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> We had this for a few partition types (and full block devices) already
> and it's been vetoed.  Use mdadm from initrd/initramfs instead.

It is doable in theory, but in practice mdadm is too retarded (I'm taliking
about mdadm 1.6.0 here). Its man page says:

    mdadm can perform (almost) all of its functions  without  having  a
    configuration  file  and  does  not use one by default.

I guess "almost" is the key. Firstly, it collapses with any attempt to run
"mdadm -A -s" or any variation of such, because it's full of places like
this.

	mddev_ident_t array_ident = conf_get_ident(configfile, dv->devname);
	mdfd = open_mddev(dv->devname, array_ident->autof);

Obviously, array_ident is NULL if a config file is not present. It is
possible to fool the stupid thing by giving it a dummy config file,
like this one:

DEVICE partitions
ARRAY /dev/md0

It still won't scan, aborting with this:
mdadm: /dev/dasda has no superblock - assembly aborted

The ChangeLog looks as if someone tried to make it work, but I observe
it didn't go very far.

-- Pete
