Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWBTRPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWBTRPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWBTRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:15:36 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:404 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1161060AbWBTRPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:15:35 -0500
Date: Mon, 20 Feb 2006 19:15:31 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220171531.GA9381@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Tom Zanussi <zanussi@us.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220130555.GA29405@Krystal>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:05:56AM -0500, Mathieu Desnoyers wrote:
> LTTng currently uses some particular features from relayfs. I would like to make
> sure that they will still be available.
> 
> * LTTng uses the "void *private" private data pointer extensively. It's very
>   useful to pass a kernel client specific data structure to the client
>   callbacks.
> * LTTng does have its own ltt_poll and ltt_ioctl that are all what is needed to
>   control the interaction with the file (along with the relayfs mmap/unmap).
> 
> In this scenario, the sysfs relay attribute creation would look like :
> 
> - create an empty attr
> - fill some of attr members
> - sysfs_create_relay_file(kobj, attr);
>   (it will overwrite some attr members : kobj, rchan, rchan_buf)
>   * set specific LTTng file operations on the inode
>   * set the "private" field of the rchan structure.
> 
->rchan is set after sysfs_create_relay_file(), you can set
->rchan->private after it's created. All that happens in
sysfs_create_relay_file() as far as the relay interface is concerned is
wrapping relay_open(), where ->rchan is first allocated.

As far as setting specific file operations for the inode, that's
definitely not in line with the sysfs way of doing things. If you need
to do this, go with debugfs, or stick with the relayfs patch on top of
CONFIG_RELAY as this stuff is clearly not going to be merged into
mainline as Cristoph also pointed out.

debugfs gives you roughly all of the same functionality, and the kernel
side implementation for what LTTng will need should be quite trivial. LTT
is arguably a debugging thing anyways, so debugfs seems like a more
appropriate match than trying to beat sysfs into submission with this
workload.
