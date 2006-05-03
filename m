Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWECJc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWECJc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWECJc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:32:56 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:34177 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965135AbWECJc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:32:56 -0400
In-Reply-To: <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF0EA76F71.9AA7937D-ON42257163.003067FA-42257163.00347656@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 3 May 2006 11:33:01 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 03/05/2006 11:34:03
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote on 04/29/2006 10:41:05 AM:

|snip]

> It sounds like a lot of things need some kind of shell-scriptable
> transaction interface for sysfs files.  You don't want to have more
> than one value per file, but reading or writing of some values must
> be done together for consistency reasons.  Is there any way to
> implement something like this?  This would work for the framebuffer
> people and solve the needs of a lot of the people who still want
> ioctls or some other atomic-multivalued transfer that would otherwise
> be a great sysfs candidate.
>

Martin told me that you will probably kill me for the following,
but I neverless would like to post my suggestion:

All the complicated mechanisms with filesystem trees
to obtain consistent data and transaction functionality
could be avoided, if we would use single files, which
contain all the data. When opening the file, the snapshot
is created and attached to the struct file.

As far as I know, common sense is to avoid that, because
it is ugly and error prone to parse the files in user space.

But If we would provide a standard tag language (I don't
say XML here) for all sort of kernel data, which should
be exported to user space, one standard parser could
be used to obtain the data. This is not error prone since
you can always use the standard parser to access the
data. It is still human readable, which is an advantage
compared with binary files. You can either read
the file directly or use the parser to get the tree structure
in a better readable way. E.g in our s390 hypfs example
you could call:

standardparser < /sys/hypervisor/s390/accountigdata

which prints a nice tree to stdout. Or you could use the
parser in shell scripts to obtain specific attributes.
E.g. you could call:

standardparser < .../acountingdata systems.lparxy.cpu0.time

which prints e.g. "32432515" to stdout.

This approach would solve our atomicity problem and
also the problem of parsing complicated sysfs files.

Putting the tree into one file using a tag language is from
a logical point of view exactly the same as creating a
directory tree within a filesystem.

Regarding performance in kernel space it is not more effort
to create the tree in one file than creating the tree
within a filesystem. It is even less effort, since you do not
need hundreds of system calls (open, read, close) to
obtain the data from user space.

If you think, that this topic has already been discussed
too often on this mailing list and it is not worth discussing
this further, please just ignore this posting!

Michael

