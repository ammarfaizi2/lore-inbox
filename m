Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWBTRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWBTRhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWBTRhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:37:35 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:18643 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1161075AbWBTRhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:37:34 -0500
Date: Mon, 20 Feb 2006 12:37:32 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Paul Mundt <lethal@linux-sh.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, axboe@suse.de,
       karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220173732.GA7238@Krystal>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060220171531.GA9381@linux-sh.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 12:17:40 up 13 days, 13:32,  3 users,  load average: 0.63, 0.41, 0.29
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Mundt (lethal@linux-sh.org) wrote:
> On Mon, Feb 20, 2006 at 08:05:56AM -0500, Mathieu Desnoyers wrote:
> > LTTng currently uses some particular features from relayfs. I would like to make
> > sure that they will still be available.
> > 
> > * LTTng uses the "void *private" private data pointer extensively. It's very
> >   useful to pass a kernel client specific data structure to the client
> >   callbacks.
> > * LTTng does have its own ltt_poll and ltt_ioctl that are all what is needed to
> >   control the interaction with the file (along with the relayfs mmap/unmap).
> > 
> > In this scenario, the sysfs relay attribute creation would look like :
> > 
> > - create an empty attr
> > - fill some of attr members
> > - sysfs_create_relay_file(kobj, attr);
> >   (it will overwrite some attr members : kobj, rchan, rchan_buf)
> >   * set specific LTTng file operations on the inode
> >   * set the "private" field of the rchan structure.
> > 
> ->rchan is set after sysfs_create_relay_file(), you can set
> ->rchan->private after it's created. All that happens in
> sysfs_create_relay_file() as far as the relay interface is concerned is
> wrapping relay_open(), where ->rchan is first allocated.
> 

I though about it, but it would create a race where the channel could be
accessed from user space before the private data pointer is set or the specific
inode operations are set.

> As far as setting specific file operations for the inode, that's
> definitely not in line with the sysfs way of doing things. If you need
> to do this, go with debugfs, or stick with the relayfs patch on top of
> CONFIG_RELAY as this stuff is clearly not going to be merged into
> mainline as Cristoph also pointed out.
> 

Those inode operations are generic enough to eventually be integrated to
relayfs. The poll is enhanced to support multiple readers. For the ioctl, it's
just a matter of getting/pulling buffer segments, reading the number of
subbuffers and their size, which I think really fits the i/o control purpose for
such a file.


> debugfs gives you roughly all of the same functionality, and the kernel
> side implementation for what LTTng will need should be quite trivial. LTT
> is arguably a debugging thing anyways, so debugfs seems like a more
> appropriate match than trying to beat sysfs into submission with this
> workload.
> 

debugfs seems to offer really too much flexibility for what LTTng needs. It
doesn't really have to redefine "new" operations : the poll/ioctl used by LTTng
could in fact be integrated into RelayFS and simplify the file reading
operation.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
