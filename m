Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWCKBJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWCKBJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWCKBJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:09:20 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:35816 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932359AbWCKBJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:09:20 -0500
Date: Fri, 10 Mar 2006 17:09:13 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance
Message-ID: <20060311010913.GN27280@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060310002121.GJ27280@ca-server1.us.oracle.com> <E1FHWCm-0002rT-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FHWCm-0002rT-00@calista.inka.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 02:14:08AM +0100, Bernd Eckenfels wrote:
> Mark Fasheh <mark.fasheh@oracle.com> wrote:
> > Your hash sizes are still ridiculously large.
> 
> How long are those entries in the buckets kept?
Shortly after the inode is destroyed. Basically the entries are "lock
resources" which the DLM tracks. OCFS2 only ever gets lock objects attached
to those resources. In OCFS2 the lock objects obey inode lifetimes. So the
DLM can't purge the lock resources until OCFS2 destroys the inode, etc. If
other nodes take locks on that resource and your local node is the "master"
(as in, arbitrates access to the resource) it may stay around longer.

> I mean if I untar a tree the files are only locked while extracted,
> afterwards they are owner-less... (I must admint I dont understand ocfs2
> very deeply, but maybe explaining why so many active locks need to be
> cached might help to find an optimized way.
Well, OCFS2 caches locks. That is, once you've gone to the DLM to acquire a
lock at a given level, OCFS2 will just hold onto it and manage access to it
until the locks needs to be upgraded or downgraded. This provides a very
large performance increase over always asking the DLM for a new lock.
Anyway, at the point that we've acquired the lock the first time, the file
system isn't really forcing the dlm to hit the hash much.

> > By the way, an interesting thing happened when I recently switched disk
> > arrays - the fluctuations in untar times disappeared. The new array is much
> > nicer, while the old one was basically Just A Bunch Of Disks. Also, sync
> > times dropped dramatically.
> 
> Writeback Cache?
Yep, and a whole slew of other nice features :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
