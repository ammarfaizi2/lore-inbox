Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWBTNF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWBTNF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWBTNF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:05:59 -0500
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:57589 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030198AbWBTNF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:05:58 -0500
Date: Mon, 20 Feb 2006 08:05:56 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220130555.GA29405@Krystal>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <17401.21427.568297.830492@tut.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 07:46:49 up 13 days,  9:01,  2 users,  load average: 0.59, 1.15, 0.89
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Zanussi (zanussi@us.ibm.com) wrote:
> Paul Mundt writes:
>  > On Sun, Feb 19, 2006 at 09:56:23AM -0800, Greg KH wrote:
>  > 
> 
> [...]
> 
>  > > And I agree with Christoph, with this change, you don't need a separate
>  > > relayfs mount anymore.
>  > > 
>  > Yes, that's where I was going with this, but I figured I'd give the
>  > relayfs people a chance to object to it going away first.
>  > 
>  > If with this in sysfs and simple handling through debugfs people are
>  > content with the relay interface for whatever need, then getting rid of
>  > relayfs entirely is certainly the best option. We certainly don't need
>  > more pointless virtual file systems.
>  > 
>  > I'll work up a patch set for doing this as per Cristoph's kernel/relay.c
>  > suggestion. Thanks for the feedback.
> 
> Considering that I recently offered to post a patch that would do
> essentially the same thing, I can't have any objections to this. ;-)
> 
> But just to make sure I'm not missing anything in the patches, please
> let me know if any of the following is incorrect.  What they do is
> remove the fs part of relayfs and move the remaining code into a
> single file, while leaving everthing else basically intact i.e. the
> relayfs kernel API remains the same and existing clients would only
> need to make relatively minor changes:
> 
> - find a new home for their relay files i.e. sysfs, debufs or procfs.
> 
> - replace any relayfs-specific code with their counterparts in the new
>   filesystem i.e. directory creation/removal, non-relay ('control')
>   file creation/removal.
> 
> - change userspace apps to look for the relay files in the new
>   filesystem instead of relayfs e.g. change /relay/* to /sys/*
>   in the relay file pathnames.
> 
> Although I personally don't have any problems with doing this, I've
> added some of the authors of current relayfs applications to the cc:
> list in case they might have any objections to it.  The major relayfs
> applications I'm aware of are:
> 
> - LTT, not sure where LTT would want to move.
> 

Hi,

LTTng currently uses some particular features from relayfs. I would like to make
sure that they will still be available.

* LTTng uses the "void *private" private data pointer extensively. It's very
  useful to pass a kernel client specific data structure to the client
  callbacks.
* LTTng does have its own ltt_poll and ltt_ioctl that are all what is needed to
  control the interaction with the file (along with the relayfs mmap/unmap).

In this scenario, the sysfs relay attribute creation would look like :

- create an empty attr
- fill some of attr members
- sysfs_create_relay_file(kobj, attr);
  (it will overwrite some attr members : kobj, rchan, rchan_buf)
  * set specific LTTng file operations on the inode
  * set the "private" field of the rchan structure.

The two operations marked with a * would need supplementary parameters to
sysfs_create_relay_file. Or is there something I missed ?


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
