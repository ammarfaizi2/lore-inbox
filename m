Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWDNUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWDNUDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWDNUCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:02:34 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:14226
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S965131AbWDNUCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:02:22 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH 1/7] fireflier LSM for labeling sockets based on its creator (owner)
Date: Fri, 14 Apr 2006 23:02:07 +0300
User-Agent: KMail/1.9.1
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604072127.30925.edwin@gurde.com> <1144869112.1083.27.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144869112.1083.27.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604142302.08122.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 April 2006 22:11, Stephen Smalley wrote:
> On Fri, 2006-04-07 at 21:27 +0300, Török Edwin wrote:
> <snip>
>
> > +u32 get_or_generate_sid(const struct file* execfile,const char unsafe)
> > +{
> > +	return
> > internal_get_or_generate_sid(execfile->f_vfsmnt->mnt_devname,execfile->f_
> >dentry->d_inode->i_ino,unsafe); +}
>
> (mnt_devname, ino) pair is not a suitable basis here.  If you truly
> cannot use inode extended attributes, then you might want to consider
> using file handles.  It would help to understand how the userspace
> component intends to use the supplied information, e.g. given some kind
> of identifier or attribute for the subjects that have access to the
> socket, what does the userspace component do with that identifier or
> attribute?
The userspace will read the attribute using getxattr, and see if the programs 
being accessing the socket are allowed by its rules, and will set the verdict 
on the packet.
The xattr of the socket inode will be a list of inodes of programs accessing 
the socket.

Lookup algorithm:
- find out socket inode from /proc/net/tcp|udp|tcp6|udp6
- search /proc/pid/fd/* for sockets with the proper inode (iterates through 
all pids)
- getxattr -> match rules

The /proc search is cached, so its only done on the 1st packet received, after 
that /proc/pidlast/fd/lastfd is stat-ed, and if the inode is still the same, 
no further searching is done. If not, the cache for that socket inode is 
invalidated.

I could have also dropped the cache, and done a full /proc lookup to find out 
which processes have access to a socket, but I think you'll agree that this 
would have had a huge impact on performance.


Alternatively an iptables module can be used that matches based on security 
context (if the userspace /proc search would be too slow on a high-load 
connection for example).

P.S.: The userspace part that reads xattr isn't implemented yet.

Cheers,
Edwin
