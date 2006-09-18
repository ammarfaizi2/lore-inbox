Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWIRPyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWIRPyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWIRPyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:54:50 -0400
Received: from mail.suse.de ([195.135.220.2]:38591 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751800AbWIRPyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:54:49 -0400
From: Andi Kleen <ak@suse.de>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Mon, 18 Sep 2006 17:54:37 +0200
User-Agent: KMail/1.9.3
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <4492D5D3.4000303@atmos.washington.edu> <p73ac4x4doi.fsf@verdi.suse.de> <20060918153822.GA805@ms2.inr.ac.ru>
In-Reply-To: <20060918153822.GA805@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609181754.37623.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 17:38, Alexey Kuznetsov wrote:
> Hello!
> 
> > For netdev: I'm more and more thinking we should just avoid the problem
> > completely and switch to "true end2end" timestamps. This means don't
> > time stamp when a packet is received, but only when it is delivered
> > to a socket.
> 
> This will work.
> 
> From viewpoint of existing uses of timestamp by packet socket
> this time is not worse. The only danger is violation of casuality
> (when forwarded packet or reply packet gets timestamp earlier than
> original packet). 

Hmm, not sure how that could happen. Also is it a real problem
even if it could?

> > handler runs. Then the problem above would completely disappear. 
> 
> Well, not completely. Too slow clock source remains too slow clock source.
> If it is so slow, that it results in "performance degradation", it just
> should not be used at all, even such pariah as tcpdump wants to be fast.
> 
> Actually, I have a question. Why the subject is
> "Network performance degradation from 2.6.11.12 to 2.6.16.20"?
> I do not see beginning of the thread and cannot guess
> why clock source degraded. :-)

It's a long and sad story.

Old kernels didn't disable the TSC on those boxes (multi core K8) and assumed
they were synchronized for timing purposes. 

This initially mostly worked  if you don't use cpufreq, 
but over a longer uptime the TSCs would drift against each other and timing
would jump more and more between CPUs.

On older versions of K8 this drift happened much slower (more
aggressive power saving in HLT in newer steppings made it worse; that is why
idle=poll helps) and could be often ignored. But technically it was still a 
bug there because it would could break timing after long uptimes.

New multi socket K8 boxes are generally 
totally unusable with TSC because they use cpufreq and the TSCs can run
at completely differently frequencies, which obviously doesn't give very 
good timing information if you assume the TSC is globally synchronized.

That is why later kernels default to TSC off.  The original plan 
was to use HPET then, which is slower than TSC, but still not that bad.
But while most modern systems have a HPET timer somewhere in the chipset 
nearly all BIOS vendors "forgot" to describe it in the BIOS because Windows
didn't use it and Linux can't find it because of that. 

Then it has to use the ACPI pmtmr which is really really slow.
The overhead of that thing is so large that you can clearly see it in
the network benchmark.

The real fix long term is to change the timer subsystem to keep all TSC
state per CPU, then it'll work on the K8s too. Unfortunately it's a moderately 
hard problem  to make the result still fully monotonic. But people are working 
on it.

-Andi
