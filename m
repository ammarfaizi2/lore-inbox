Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWBIVIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWBIVIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWBIVIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:08:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31659 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750793AbWBIVIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:08:14 -0500
Date: Thu, 9 Feb 2006 13:07:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: akpm@osdl.org, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH v2 02/07] cpuset use combined atomic_inc_return calls
Message-Id: <20060209130753.685ce15e.pj@sgi.com>
In-Reply-To: <200602092023.51547.mbuesch@freenet.de>
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
	<20060209185424.8596.89333.sendpatchset@jackhammer.engr.sgi.com>
	<200602092023.51547.mbuesch@freenet.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael wrote:
> Is this hunk really correct? I did not look into the code, but from
> the patch context it seems like it adds an inc here.

You have sharp eyes.

It doesn't matter much either way whether we increment or not here.

That's because this is in cpuset_init_early(), which is the -very- first
use of the global cpuset_mems_generation counter.  All other uses must
increment, so that they don't reuse a generation value someone else
used.  But we're first, so no possibility of reuse.

We can start with the first value, zero (0), or we can increment and
use one (1).

I changed it to atomic_inc_return() just to be consistent with all the
other locations that read this.  That way, if anyone else ever has to
get a value of cpuset_mems_generation and looks around to see how to do
it, they will see that it is always done using atomic_inc_return(), and
probably do it the same way, with minimum risk of confusion.

Just avoiding gratuitous differences in code that don't have a good
reason.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
