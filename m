Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVDAKgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVDAKgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVDAKgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:36:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21690 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262694AbVDAKf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:35:26 -0500
Date: Fri, 1 Apr 2005 12:34:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-ID: <20050401103452.GA31082@elte.hu>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com> <424C8956.7070108@yahoo.com.au> <20050331220526.3719ed7f.pj@engr.sgi.com> <20050401065955.GB26203@elte.hu> <20050401012902.2fb1a992.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401012902.2fb1a992.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> > It has to be made sure that H1+H2+H3 != H4+H5+H6,
> 
> Yeah - if you start trying to think about the general case here, the 
> combinations tend to explode on one.

well, while i dont think we need that much complexity, the most generic 
case is a representation of the actual hardware (cache/bus) layout, 
where separate hardware component types have different IDs.

e.g. a simple hiearchy would be:

         ____H1____
      _H2_        _H2_
    H3    H3    H3    H3
   [P1]  [P2]  [P3]  [P4]

Then all that has to happen is to build a 'path' of ids (e.g. "H3,H2,H3" 
is a path), which is a vector of IDs, and an array of already measured 
vectors. These IDs never get added so they just have to be unique per 
type of component.

there are two different vectors possible: H3,H2,H3 and H3,H2,H1,H2,H3, 
so two measurements are needed, between P1 and P2 and P1 and P3. (the 
first natural occurence of each path)

this is tree walking and vector building/matching. There is no 
restriction on the layout of the hierarchy, other than it has to be a 
tree. (no circularity) It's easy to specify such a tree, and there are 
no 'mixup' dangers.

> I'm thinking we get off easy, because:
> 
>  1) Specific arch's can apply specific short cuts.
> 
> 	My intuition was that any specific architecture, when it
> 	got down to specifics, could find enough ways to cheat
> 	so that it could get results quickly, that easily fit
> 	in a single 'distance' word, which results were 'close
> 	enough.'

yes - but the fundamental problem is already that we do have per-arch 
shortcuts: the cache_hot value. If an arch wanted to set it up, it could 
do it. But it's not easy to set it up and the value is not intuitive. So 
the key is to make it convenient and fool-proof to set up the data - 
otherwise it just wont be used, or will be used incorrectly.

but i'd too go for the simpler 'pseudo-distance' function, because it's 
so much easier to iterate through it. But it's not intuitive. Maybe it 
should be called 'connection ID': a unique ID for each uniqe type of 
path between CPUs. An architecture can take shortcuts if it has a simple 
layout (most have). I.e.:

	sched_cpu_connection_type(int cpu1, int cpu2)

would return a unique type ID for different. Note that 'distance' (or 
'memory access latency', or 'NUMA factor') as a unit is not sufficient, 
as it does not take cache-size nor CPU speed into account, which does 
play a role in the migration characteristics.

	Ingo
