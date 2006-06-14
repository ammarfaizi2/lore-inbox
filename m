Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWFNNqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWFNNqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWFNNqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:46:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:24889 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964823AbWFNNqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:46:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YwGdU5twO0pHbzFy1I0bpduaTzJ6qoZ62W1R1DjnH292LtvojOsPtQDv2grDyO0MgBe8KF9Bmmm54KvFOQ0l38oa/Mf+0g1v4GjObcWiY3XY1VSEMpBRCr2LBd8+qLruYrxBxVp8/wE6OPMxGJeNtVb5ZeFkE0Phk3Pqow6XuZM=
Message-ID: <b0943d9e0606140646u2e1c90ebic575ebdba67e8349@mail.gmail.com>
Date: Wed, 14 Jun 2006 14:46:04 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>,
       "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20060614120326.GA23337@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <20060612105345.GA8418@elte.hu>
	 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	 <20060612192227.GA5497@elte.hu>
	 <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
	 <20060613072646.GA17978@elte.hu>
	 <b0943d9e0606130349s24614bbcia6a650342437d3d1@mail.gmail.com>
	 <20060614040707.GA7503@elte.hu> <448FA476.8000705@goop.org>
	 <20060614120326.GA23337@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> > This seems pretty over-engineered.  I wouldn't go this far unless
> > you're actually seeing performance/correctness problems, and a simple
> > with/without pointers flag isn't enough.  It also doesn't address the
> > most troublesome source of false pointers: stacks.  There is all sorts
> > of junk lying around on stacks, and you can have an old dead pointer
> > sitting there pinning old dead memory for a long time.
>
> in an earlier thread i suggested to not scan kernel stacks at all, but
> to delay the registration of new blocks to return-from-syscall time (via
> having a per-task list of newly allocated but not yet registered
> blocks). That way we dont get false positives for stuff that is on the
> kernel stack temporarily and then freed, and we correctly register newly
> allocated blocks as well.

I didn't have time to try this idea. However, the number of false
positives doesn't seem to be increased (or they are only reported
temporarily) if you don't scan the stacks at all (especially if you
scan the memory at a relatively quiet time). That's why I added a
config option for this.

The problem looks a bit more complicated for kernel threads as they
always use the kernel stack.

Another idea would be to only scan the stacks of the sleeping tasks
(and you could also get the frame pointer from the call to the
schedule function).

-- 
Catalin
