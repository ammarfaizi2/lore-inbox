Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVHJPnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVHJPnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVHJPnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:43:11 -0400
Received: from smtpout.mac.com ([17.250.248.70]:25288 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965165AbVHJPnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:43:09 -0400
In-Reply-To: <20050810132626.GC4954@null.msp.redhat.com>
References: <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk> <20050810070309.GA2415@infradead.org> <20050810103041.GB4634@marowsky-bree.de> <20050810103256.GA6127@infradead.org> <20050810103424.GC4634@marowsky-bree.de> <20050810105450.GA6519@infradead.org> <20050810110259.GE4634@marowsky-bree.de> <20050810110511.GA6728@infradead.org> <20050810110917.GG4634@marowsky-bree.de> <20050810111110.GA6878@infradead.org> <20050810132626.GC4954@null.msp.redhat.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F0B76E9F-6B4F-4984-A540-F431500F9B96@mac.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lars Marowsky-Bree <lmb@suse.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Linux-cluster] Re: [PATCH 00/14] GFS
Date: Wed, 10 Aug 2005 11:43:02 -0400
To: AJ Lewis <alewis@redhat.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2005, at 09:26:26, AJ Lewis wrote:
> On Wed, Aug 10, 2005 at 12:11:10PM +0100, Christoph Hellwig wrote:
>
>> On Wed, Aug 10, 2005 at 01:09:17PM +0200, Lars Marowsky-Bree wrote:
>>
>>> So for every directory hierarchy on a shared filesystem, each  
>>> user needs
>>> to have the complete list of bindmounts needed, and automatically  
>>> resync
>>> that across all nodes when a new one is added or removed? And  
>>> then have
>>> that executed by root, because a regular user can't?
>>
>> Do it in an initscripts and let users simply not do it, they  
>> shouldn't
>> even know what kind of filesystem they are on.
>
> I'm just thinking of a 100-node cluster that has different mounts  
> on different
> nodes, and trying to update the bind mounts in a sane and efficient  
> manner
> without clobbering the various mount setups.  Ouch.

How about something like the following:
     cpslink()      => Create a Context Dependent Symlink
     readcpslink()  => Return the Context Dependent path data
     readlink()     => Return the path of the Context Dependent  
Symlink as it
                       would be evaluated in the current context,  
basically as a
                       normal symlink.
     lstat()        => Return information on the Context Dependent  
Symlink in
                       the same format as a regular symlink.
     unlink()       => Delete the Context Dependent Symlink.

You would need an extra userspace tool that understands cpslink/ 
readcpslink to
create and get information on the links for now, but ls and ln could  
eventually
be updated, and until then the would provide sane behavior.  Perhaps  
this
should be extended into a new API for some of the strange things several
filesystems want to do in the VFS:
     extlink()      => Create an extended filesystem link (with type  
specified)
     readextlink()  => Return the path (and type) for the link

The filesystem could define how each type of link acts with respect  
to other
syscalls.  OpenAFS could use extlink() instead of their symlink magic  
for
adjusting the AFS volume hierarchy.  The new in-kernel AFS client  
could use it
in similar fashion (It has no method to adjust hierarchy, because  
it's still
read-only).  GFS could use it for their Context Dependent Symlinks.   
Since it
would pass the type in as well, it would be possible to use it for  
different
kinds of links on the same filesystem.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



