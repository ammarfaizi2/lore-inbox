Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbULQSJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbULQSJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbULQSJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:09:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262114AbULQSIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:08:36 -0500
Date: Fri, 17 Dec 2004 13:12:28 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: James Pearson <james-p@moving-picture.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041217151228.GA17650@logos.cnet>
References: <41C316BC.1020909@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C316BC.1020909@moving-picture.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

On Fri, Dec 17, 2004 at 05:26:20PM +0000, James Pearson wrote:
> I have an NFS server with 1Gb RAM running a 2.4.26 kernel with 2 XFS 
> file systems with about 2 million files in total.
> 
> Occasionally I get reports that the server is 'sticky' (slow 
> read/writes) and the inode cache appears to consume most of the 
> available memory and doesn't appear to reduce - a typical /proc/slabinfo 
> output is below.
> 
> If I run a simple application that grabs memory on the server, the inode 
> and other caches are reduced and the server becomes more responsive 
> (i.e. data rates to/from the server are restored to 'normal').
> 
> Is there anyway I can purge the cached inode data, or any kernel 
> parameters I can tweak to limit the inode cache or flush it more frequently?
> 
> Or am I looking in completely the wrong place i.e. the inode cache is 
> not the problem?

No, in your case the extreme inode/dcache sizes indeed seem to be a problem. 

The default kernel shrinking ratio can be tuned for enhanced reclaim efficiency.

> xfs_inode         931428 931428    408 103492 103492    1 :  124   62
> dentry_cache      499222 518850    128 17295 17295    1 :  252  126

vm_vfs_scan_ratio:
------------------
is what proportion of the VFS queues we will scan in one go.
A value of 6 for vm_vfs_scan_ratio implies that 1/6th of the
unused-inode, dentry and dquot caches will be freed during a
normal aging round.
Big fileservers (NFS, SMB etc.) probably want to set this
value to 3 or 2.

The default value is 6.
=============================================================

Tune /proc/sys/vm/vm_vfs_scan_ratio increasing the value to 10 and so on and 
examine the results.
