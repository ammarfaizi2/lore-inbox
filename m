Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWBGAUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWBGAUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBGAUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:20:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42140 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932389AbWBGAUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:20:43 -0500
Date: Tue, 7 Feb 2006 01:19:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: ak@suse.de, clameter@engr.sgi.com, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060207001902.GA18830@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu> <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu> <20060206154537.a3e8cc25.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206154537.a3e8cc25.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> First it might be most useful to explain a detail of your proposal 
> that I don't get, which is blocking me from considering it seriously.
> 
> I understand mount options, but I don't know what mechanisms (at the 
> kernel-user API) you have in mind to manage per-directory and per-file 
> options.

well, i thought of nothing overly complex: it would have to be a 
persistent flag attached to the physical inode. Lets assume XFS added 
this - e.g. as an extended attribute. That raw inode attribute/flag gets 
inherited by dentries, and propagates down into child dentries. (There 
is a global default that the root dentry starts with, and mountpoints 
may override the flag too.) If any directory down in the hierarchy has a 
different flag, it overrides the current one. No flag means "inherit 
parent's flag". So there would be 3 possible states for every inode:

 - default: the vast majority of inodes would have no flag set

 - some would have a 'cache:local' flag

 - some would have a 'cache:global' flag

which would result in every inode getting flagged as either 'local' or 
'global'. When the pagecache (and inode/dentry cache) gets populated, 
the kernel will always know what the current allocation strategy is for 
any given object:

- if an inode ends up being flagged as 'global', then all its pagecache 
  allocations will be roundrobined across nodes.

- if an inode is flagged 'local', it will be allocated to the node/cpu 
  that makes use of it.

workloads may share the same object and may want to use it in different 
ways. E.g. there's one big central database file, and one job uses it in 
a 'local' way, another one uses it in a 'global' way. Each job would 
have to set the attribute to the right value. Setting the flag for the 
inode results in all existing pages for that inode to be flushed. The 
jobs need to serialize their access to the object, as the kernel can 
only allocate according to one policy.

	Ingo
