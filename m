Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269325AbUJKXDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbUJKXDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUJKXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:03:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38616 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269325AbUJKXCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:02:06 -0400
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       LSE Tech <lse-tech@lists.sourceforge.net>, hch@infradead.org,
       steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <41672E42.9000104@yahoo.com.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com>
	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	 <20041001164118.45b75e17.akpm@osdl.org>
	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
	 <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>
	 <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>
	 <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]>
	 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>
	 <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	 <58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com>
	 <1193270000.1097025361@[10.10.2.4]> <20041005190852.7b1fd5b5.pj@sgi.com>
	 <1097103580.4907.84.camel@arrakis>  <20041007015107.53d191d4.pj@sgi.com>
	 <1097279293.6470.106.camel@arraki! s>  <41672E42.9000104@yahoo.com.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097535614.4038.82.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 11 Oct 2004 16:00:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 17:18, Nick Piggin wrote:
> Matthew Dobson wrote:
> > I think this example is easily achievable with the sched_domains
> > modifications I am proposing.  You can still create your 128 CPU
> > exclusive domain, called big_domain (due to my lack of naming
> > creativity), and further divide big_domain into smaller, non-exclusive
> > sched_domains.  We do this all the time, albeit statically at boot time,
> > with the current sched_domains code.  When we create a 4-node domain on
> > IA64, and underneath it we create 4 1-node domains.  We've now
> > partitioned the system into 4 sched_domains, each containing 4 cpus. 
> > Balancing between these 4 node-level sched_domains is allowed, but can
> > be disallowed by not setting the SD_LOAD_BALANCE flag.  Your example
> > does show that it can be more than just a convenient way to group tasks,
> > but your example can be done with what I'm proposing.
> 
> You wouldn't be able to do this just with sched domains, because
> it doesn't know anything about individual tasks. As soon as you
> have some overlap, all your tasks can escape out of your domain.
> 
> I don't think there is a really nice way to do overlapping sets.
> Those that want them need to just use cpu affinity for now.

Well, the tasks can escape out of the domain iff you have the 
SD_LOAD_BALANCE flag set on that domain.  If SD_LOAD_BALANCE isn't set,
then when the scheduler tick goes off, and the code looks at the domain,
it will see the lack of the flag and will not attempt to balance the
domain, correct?  This is what we currently do with the 'isolated'
domains, right?

You're right that you can get some of the more obscure semantics of the
various flavors of cpusets by leveraging sched_domains AND
cpus_allowed.  I don't have any desire to remove that ability, just keep
it as the exception.

-Matt

