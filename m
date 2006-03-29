Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWC2W1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWC2W1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWC2W1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:27:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:31209 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750997AbWC2W1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:27:06 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: dcache leak in 2.6.16-git8 II
Date: Thu, 30 Mar 2006 00:26:58 +0200
User-Agent: KMail/1.9.1
Cc: bharata@in.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <200603270750.28174.ak@suse.de> <200603271822.28043.ak@suse.de> <20060327190027.24498e3a.akpm@osdl.org>
In-Reply-To: <20060327190027.24498e3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603300026.59131.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 05:00, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > On Monday 27 March 2006 13:48, Bharata B Rao wrote:
> > > On Mon, Mar 27, 2006 at 07:50:20AM +0200, Andi Kleen wrote:
> > > > 
> > > > A 2GB x86-64 desktop system here is currently swapping itself to death after
> > > > a few days uptime.
> > > > 
> > > > Some investigation shows this:
> > > > 
> > > > inode_cache         1287   1337    568    7    1 : tunables   54   27    8 : slabdata    191    191      0
> > > > dentry_cache      1867436 1867643    208   19    1 : tunables  120   60    8 : slabdata  98297  98297      0
> > > > 
> > > 
> > > Would it be possible to try out this experimental patch which
> > > gets some stats from the dentry cache ?
> > 
> > It should be trivial to reproduce by other people. Biggest workload
> > is kernel compiles and quilt.
> > 
> > After a few hours with -git12 it's already at
> > 
> > dentry_cache      947013 952014    208   19    1 : tunables  120   60    8 : slabdata  50100  50106    480
> > 
> > and starting to go into swap.
> > 
> > I can't imagine I'm the only one seeing this?
> > 
> > I have a few x86-64 patches applied too, but they don't change anything
> > in this area.
> 
> I don't think I can reproduce this on x86 uniproc.  (avtab_node_cache
> is a different story - maintainers separately pinged).


I got another OOM from this with -git13. Unfortunately it seems to take a few days at least
to trigger.

dentry_cache      999168 1024594    208   19    1 : tunables  120   60    8 : slabdata  53926  53926      0 : shrinker stat 18522624 8871000

Hrm interesting is this one:

sock_inode_cache  996784 996805    704    5    1 : tunables   54   27    8 : slabdata 199361 199361      0

Most of the leaked dentries seem to be sockets. I didn't notice this earlier.

This was with the debugging patches applied btw. 

So maybe we have a socket leak?

I still got a copy of the /proc in case anybody wants more information.

-Andi
 
meminfo debugging was

r_dentries/page        nr_pages        nr_inuse
         0              0               0
         1              139             139
         2              115             230
         3              99              297
         4              103             412
         5              84              419
         6              80              480
         7              75              519
         8              65              520
         9              52              466
        10              58              580
        11              55              605
        12              73              868
        13              124             1610
        14              184             2576
        15              313             4685
        16              518             8288
        17              1338            22744
        18              4591            82633
        19              45843           870758
        20              0               0
        21              0               0
        22              0               0
        23              0               0
        24              0               0
        25              0               0
        26              0               0
        27              0               0
        28              0               0
        29              0               0
Total:                  53909           998829
dcache lru: total 232 inuse 1


