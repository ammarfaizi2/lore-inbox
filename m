Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWGZVDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWGZVDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGZVDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:03:37 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:13759 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750777AbWGZVDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:03:37 -0400
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
	totally bizare
From: Arjan van de Ven <arjan@linux.intel.com>
To: vatsa@in.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060726204233.GA23488@in.ibm.com>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	 <20060725185449.GA8074@elte.hu>
	 <1153855844.8932.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
	 <1153921207.3381.21.camel@laptopd505.fenrus.org>
	 <20060726155114.GA28945@redhat.com>
	 <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
	 <1153942954.3381.50.camel@laptopd505.fenrus.org>
	 <20060726204233.GA23488@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 23:03:06 +0200
Message-Id: <1153947786.3381.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 13:42 -0700, Srivatsa Vaddagiri wrote:
> On Wed, Jul 26, 2006 at 09:42:34PM +0200, Arjan van de Ven wrote:
> > As a quick hack I made non-lock_cpu_hotplug()'ing versions of the 3 key
> > workqueue functions (patch below). It works, it's correct, it's just so
> > ugly that I'm almost too ashamed to post it. I haven't found a better
> > solution yet though... time to take a step back I suppose.
> 
> My worry is that such special cases might be needed in more places as we
> discover further or as code evolves. Fundamentally looks like the locked and 
> unlocked paths of the kernel cannot be separated so well because of interaction 
> between subsystems. /me thinks rwsem seems to be a sane thing to go after.

rwsems unfortunately help you zilch; an rwsem is just a mutex with a
performance tweak, but from the deadlock perspective it's really a
mutex.

I'm really starting to feel that the hotplug lock would have been better
of being a refcount (with a waitqueue for zero) than a lock. While
"refcount+waitqueue" sort of IS a lock, the semantics make more sense
imo...

Greetings,
   Arjan van de Ven
