Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUJGSTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUJGSTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUJGSRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:17:54 -0400
Received: from jade.aracnet.com ([216.99.193.136]:15337 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267683AbUJGSPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:15:54 -0400
Date: Thu, 07 Oct 2004 11:13:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <1344740000.1097172805@[10.10.2.4]>
In-Reply-To: <20041007105425.02e26dd8.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com><834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]><20041003175309.6b02b5c6.pj@sgi.com><838090000.1096862199@[10.10.2.4]><20041003212452.1a15a49a.pj@sgi.com><843670000.1096902220@[10.10.2.4]><Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr><58780000.1097004886@flay><20041005172808.64d3cc2b.pj@sgi.com><1193270000.1097025361@[10.10.2.4]>
 <20041005190852.7b1fd5b5.pj@sgi.com><1097103580.4907.84.camel@arrakis><20041007015107.53d191d4.pj@sgi.com><Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr><1250810000.1097160595@[10.10.2.4]> <20041007105425.02e26dd8.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So we have the purely exclusive stuff, which needs kernel support in the form
>> of sched_domains alterations. The rest of cpusets is just poking and prodding
>> at cpus_allowed, the membind API, and the irq binding stuff. All of which
>> you could do from userspace, without any further kernel support, right?
>> Or am I missing something?
> 
> Well ... we're gaining.  A couple of days ago you were suggesting
> that cpusets could be replaced with some exclusive domains plus
> CKRM.
> 
> Now it's some exclusive domains plus poking the affinity masks.
> 
> Yes - you're still missing something.
> 
> But I must keep in mind that I had concluded, perhaps three years ago,
> just what you conclude now: that cpusets is just poking some affinity
> masks, and that I could do most of it from user land.  The result ended
> up missing some important capabilities.  User level code could not
> manage collections of hardware nodes (sets of CPUs and Memory Nodes) in
> a co-ordinated and controlled manner.
> 
> The users of cpusets need to have system wide names for them, with
> permissions for viewing, modifying and attaching to them, and with the
> ability to list both what hardware (CPUs and Memory) in a cpuset, and
> what tasks are attached to a cpuset.  As is usual in such operating
> systems, the kernel manages such system wide synchronized controlled
> access views.
> 
> As I quote below, I've been saying this repeatedly.  Could you
> tell me, Martin, whether the disconnect is:
>  1) that you didn't yet realize that cpusets provided this model (names,
>     permissions, ...) or
>  2) you don't think such a model is useful, or
>  3) you think that such a model can be provided sensibly from user space?
> 
> If I knew this, I could focus my response better.
> 
> The rest of this message is just quotes from this last week - many
> can stop reading here.

My main problem is that I don't think we want lots of overlapping complex 
interfaces in the kernel. Plus I think some of the stuff proposed is fairly 
klunky as an interface (physical binding where it's mostly not needed, and
yes I sort of see your point about keeping jobs on separate CPUs, though I
still think it's tenuous), and makes heavy use of stuff that doesn't work 
well (e.g. cpus_allowed). So I'm searching for various ways to address that.

The purely exclusive parts of cpusets can be implemented in a much nicer
manner inside the kernel, by messing with sched_domains, instead of just
using cpus_allowed as a mechanism ... so that seems like much less of a
problem.

The non-exclusive bits seem to overlap heavily with both CKRM and what
could be done in userspace. I still think the physical stuff is rather
obscure, and binding stuff to specific CPUs is an ugly way to say "I want
these two threads to not run on the same CPU". But if we can find some
other way (eg userspace) to allow you to do that should you utterly insist
on doing so, that'd be a convenient way out.

As for the names and permissions issue, both would be *doable* from 
userspace, though maybe not as easily as in-kernel. Names would probably 
be less hassle than permissions, but neither would be impossible, it seems.

It all just seems like a lot of complexity for a fairly obscure set of
requirements for a very limited group of users, to be honest. Some bits
(eg partitioning system resources hard in exclusive sets) would seem likely
to be used by a much broader audience, and thus are rather more attractive.
But they could probably be done with a much simpler interface than the whole
cpusets (BTW, did that still sit on top of PAGG as well, or is that long
gone?)

M.

