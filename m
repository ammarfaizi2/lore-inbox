Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVDZAwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDZAwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDZAwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:52:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47580 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261224AbVDZAwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:52:34 -0400
Message-ID: <426D90CD.3090207@us.ibm.com>
Date: Mon, 25 Apr 2005 17:52:29 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: nickpiggin@yahoo.com.au, dino@in.ibm.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, dipankar@in.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
References: <1097110266.4907.187.camel@arrakis>	<20050418202644.GA5772@in.ibm.com>	<20050418225427.429accd5.pj@sgi.com>	<1113891575.5074.46.camel@npiggin-nld.site>	<20050419001926.605a6b59.pj@sgi.com>	<1113897440.5074.62.camel@npiggin-nld.site>	<20050419133431.2e389d57.pj@sgi.com> <20050423162640.69ccbabc.pj@sgi.com>
In-Reply-To: <20050423162640.69ccbabc.pj@sgi.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> A few days ago, Nick wrote:
> 
>>Well the scheduler simply can't handle it, so it is not so much a
>>matter of pushing - you simply can't use partitioned domains and
>>meaningfully have a cpuset above them.
> 
> 
> And I (pj) replied:
> 
>>Translating that into cpuset-speak, I think what you mean is ...
> 
> 
> I then went on to ask some questions.  I haven't seen a reply.
> I probably wrote too many words, and you had more pressing matters
> to deal with.  Which is fine.
> 
> Let's make this simpler.
> 
> Ignore cpusets -- let's just talk about a tasks cpus_allowed value,
> and scheduler domains.  Think of cpusets as just a strange way of
> setting a tasks cpus_allowed value.
> 
> Question:
> 
>     What happens if we have say two isolated scheduler domains
>     on a system, covering say two halves of the system, and
>     some task has its cpus_allowed set to allow _all_ CPUs?
> 
> What kind of pain does that cause?  I'm hoping you will say that
> the only pain it causes is that the task will only run on one
> half of the system, even if the other half is idle.  And that
> so long as I don't mind that, it's no problem to do this.

I'm not the sched_domains guru that Nick is, but as your question has gone
unanswered for a few days I'll chime in and see if I can't help you provoke
a more definitive response.

Your assumptions above are correct to the best of my knowledge.  The only
pain it causes is that the scheduler will not be able to "see" outside of
the span of the highest sched_domain attached to a particular CPU.


        A          B
       / \        / \
      X   Y      Z   W
     /\   /\    /\   /\
    0  1 2  3  4  5 6  7

In this setup, with your "Alpha" & "Beta" domains splitting the system in
half, a process in a cpuset spanning cpus 0..7 will get "stuck" in
whichever domain it happens to be in when the Alpha & Beta domains get
created.  Explicit sys_sched_setaffinity() calls will still move it between
domains, but it will not move between Alpha & Beta on its own.
Loadbalancing from CPU 0's perspective (in Alpha) sees only CPUs 0..3.

Right Nick? ;)

-Matt
