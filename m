Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVIUUMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVIUUMs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVIUUMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:12:48 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:6337
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S964804AbVIUUMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:12:47 -0400
Date: Wed, 21 Sep 2005 16:07:58 -0400
From: Sonny Rao <sonny@burdell.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050921200758.GA25362@kevlar.burdell.org>
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4331B89B.3080107@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 01:46:35PM -0600, Christopher Friesen wrote:
> 
> Just for kicks I tried with 2.6.14-rc2, and got the same behaviour. 
> /proc/slabinfo gives the following two high-runners within a second of 
> the oom-killer running:
> 
> dentry_cache      3894397 3894961    136   29    1 : tunables  120   60 
>    0 : slabdata 134307 134309      0
> filp              1216820 1216980    192   20    1 : tunables  120   60 
>    0 : slabdata  60844  60849      0
> 
> 

If I'm reading this correctly, you seem to have about 1.2 million
files open and about 3.9 million dentrys objects in lowmem with almost
no fragmentation..  for those files which are open there certainly
will be a dentry attached to the inode (how big is inode cache?), but
the shrinker should be trying to reclaim memory from the other 2.7
million objects I would think.

Based on the lack of fragmentation I would guess that either the shrinker isn't
running or those dentrys are otherwise pinned somehow (parent
directorys of the open files?)  What does the directory structure look
like? 
 
Just for kicks (again), have you tried ratcheting up the
/proc/sys/vm/vfs_cache_pressure tunable by a few orders of magnitude ?

Probably go from the default of 100 to say 10000 to start.

Over one million files open at once is just asking for trouble on a
lowmem-crippled x86 machine, IMHO.

Sonny
