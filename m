Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWFUXqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWFUXqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWFUXqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:46:07 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:4159 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932725AbWFUXqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:46:06 -0400
Message-ID: <4499DA12.10909@watson.ibm.com>
Date: Wed, 21 Jun 2006 19:45:22 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com> <44999A98.8030406@engr.sgi.com> <44999F5A.2080809@watson.ibm.com> <4499D7CD.1020303@engr.sgi.com>
In-Reply-To: <4499D7CD.1020303@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

> 
> Shailabh and me now eye on the lock patch that fixed an exit race
> crash i reported. The global lock was held too long in scanning threads.
> Shailabh is working on a new patch.

To clarify further,

when I ran the same benchmark as Jay (same set of patches, on a 2.6.17 kernel)
on a uniprocessor, I see the same kind of low differential between
tgid stat sending on and off as I was seeing before.

Using /usr/bin/time ./mkthread 1000 10
		yes	no	%Ovhd
system		1.63	1.55	+5%
elapsed		1.96	1.88	+4%

(similar differences whether data is written to file or not, only
total times change)

Since his system is an SMP, one suspect is the
lock hold time of taskstats_exit_mutex. Since the fill_tgid() is done
within this mutex which serializes all task exits, and there'll be contention on the
SMP, its possible the fill_tgid's overhead is exacerbating the locking.

So I'm trying to see if a patch that uses only per-task locking will help.
Will work it out and post when patch is stable or if it helps.

--Shailabh

> 
> - jay
> 

