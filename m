Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUJEJUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUJEJUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUJEJUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:20:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58578 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268904AbUJEJUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:20:40 -0400
Date: Tue, 5 Oct 2004 02:17:36 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041005021736.40f51b33.pj@sgi.com>
In-Reply-To: <13000000.1096928155@flay>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<20041004085327.727191bf.pj@sgi.com>
	<118120000.1096913871@flay>
	<20041004132551.551c9fd3.pj@sgi.com>
	<13000000.1096928155@flay>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Let me make one thing clear: I don't work on CKRM ;-) 

ok ...

Indeed, unless I'm not recognizing someone's expertise properly, there
seems to be a shortage of the CKRM experts on this thread.

Who am I missing ...

> However, the non-dedicated stuff seems much more debateable, and where
> the overlap with CKRM stuff seems possible to me. Do the people showing
> up at random with smaller parallel jobs REALLY, REALLY care about the
> physical layout of the machine? I suspect not, it's not the highly tuned
> syncopated rhythm stuff you describe above. The "give me 1.5 CPUs worth
> of bandwidth please" model of CKRM makes much more sense to me.

It will vary.  In shops that are doing alot of highly parallel work,
such as with OpenMP or MPI, many smaller parallel jobs will also be
placement sensitive.  The performance of such jobs is hugely sensitive
to their placement and scheduling on dedicated CPUs and Memory, one per
active thread.

These shops will often use a batch scheduler or workload manager, such
as PBS or LSF to manage their jobs.  PBS and LSF make a business of
defining various sized cpusets to fit the queued jobs, and running each
job in a dedicated cpuset.  Their value comes from obtaining high
utilization, and optimum repeatable runtimes, on a varied input job
stream, especially of placement sensitive jobs.  The feature set of
cpusets was driven as much as anything by what was required to support a
port of PBS or LSF.

> I'd argue the interface of specifying physical resources is a bit
> clunky for non-dedicated stuff.

Likeky so - the interface is expected to be wrapped with a user level
'cpuset' library, which converts it to a 'C' friendly model.  And that
in turn is expected to be wrapped with a port of LSF or PBS, which
converts placement back to something that the customer finds familiar
and useful for managing their varied job mix.

I don't expect admins at HPC shops to spend much time poking around the
/dev/cpuset file system, though it is a nice way to look around and
figure out how things work.

The /dev/cpuset pseudo file system api was chosen because it was
convenient for small scale work, learning and experimentation, because
it was a natural for the hierarchical name space with permissions that I
required, and because it was convenient to leverage existing vfs
structure in the kernel.

> So personally what I'd like is to have a unified interface
> ...
> Not sure if that's exactly what Andrew was hoping
> for, or the rest of you either ;-)

Well, not what I'm pushing for, that's for sure.

We really have two different mechanisms here:

  1) A placement mechanism, explicitly specifying what CPUs and Memory
     Nodes are allowed, and
  2) A sharing mechanism, specifying what proportion of fungible
     resources as cpu cycles, page faults, i/o requests a particular
     subset (class) of the user population is to receive.

If you look at the very lowest level hooks for cpusets and CKRM, you
will see the essential difference:

  1) cpusets hooks the scheduler to prohibit scheduling on a CPU that
     is not allowed, and the allocator to prohibit obtaining memory
     on a Node that is not allowed.
  2) CKRM hooks these and other places to throttle tasks by inserting
     small delays, so as to obtain the requested share or percentage,
     per class of user, of the rate of usage of fungible resources.

The specific details which must be passed back and forth across the
boundary between the kernel and user-space for these two mechanisms are
simply different.  One controls which of a list of enumerable finite
non-substitutable resources may or may not be used, and the other
controls what share of other anonymous, fungible resources may be used.

Looking for a unified interface is a false economy in my view, and I
am suspicious that such a search reflects a failure to recognize the
essential differences between the two mechanisms.

> The whole discussion about multiple sched-domains, etc, we had earlier
> is kind of just an implementation thing, but is a crapload easier to do
> something efficient here if the bits caring about that stuff are only
> dealing with dedicated resource partitions.

Yes - much easier.  I suspect that someday I will have to add to cpusets
the ability to provide, for select cpusets, the additional guarantees
(sole and exclusive ownership of all the CPUs, Memory Nodes, Tasks and
affinity masks therein) which a scheduler or allocator that's trying to
be smart requires to avoid going crazy.  Not all cpusets need this - but
those cpusets which define the scope of scheduler or allocator domain
would sure like it.  Whatever my exclusive flag means now, I'm sure we
all agree that it is too weak to meet this particular requirement.

> OK, now my email is getting as long as yours, so I'll stop ;-) ;-)

That would be tragic indeed.  Good thing you stopped.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
