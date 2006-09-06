Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWIFOK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWIFOK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWIFOK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:10:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:17865 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751022AbWIFOK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:10:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jyp/ojZnVn+2pSA2Vy6zovREYdVXiBgU/S6INGgvOuMkRoNNFSzkgrWCEzi6oZ5vG0r/HXAl2TF4cbNf7zJ22cjI73DhvF3YLh8gRHfckONZcfSRfMb6ItbguJhrY/jYyORISc0UYsR5ljZNK3hcvEr7VXBwYJmZOcbGR/KCR94=
Message-ID: <bbe04eb10609060710l3be57669ufc56763e349de0da@mail.gmail.com>
Date: Wed, 6 Sep 2006 10:10:54 -0400
From: "Kimball Murray" <kimball.murray@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, ak@suse.de
In-Reply-To: <44FE6CD6.4040809@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
	 <44FE6CD6.4040809@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 9/6/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Silly question, why can't you do all this from stop_machine_run context (or
> your SMI) that doesn't have to worry about other CPUs dirtying memory?

It's not a silly question at all.  The reason we use an SMI handler is
for two reasons.  One is to perform the final mem copy in a state
where we know that the OS and interrupt handlers (even the NMI) is
quiesced.  Admittedly, there are other ways to achieve this state.
But the second reason is that after the memory is mirrored, it is
necessary to cause the CPUs on both modules to execute in lockstep.
Both CPU modules are driven by the same front-side bus clock, but
there's a lot more to getting the CPUs running in lockstep than simply
clocking them the same way.

The processors must be put in exactly the same state before leaving
the SMI.  And here I'm referring to internal processor state as well,
things than are not in the Intel developer manuals are at play here.
While in the SMI handler, we also tweak some of the processor's
internal settings so that they behave deterministically afterward.
Otherwise, they would fall out of lock in short order.

I suppose I should also have mentioned that we support 3 different
OSes on this hardware: Linux, Windows, and one of our own called VOS.
By burying some of this mirror-and-lockstep magic in the SMI handler,
we are able to run the same SMI payload for all 3 OSes.  It just makes
life easier for us from a product standpoint.  All the OS and its
modules need to do is generate a "final-copy" list of dirty pages,
store that list in a known location, and trigger an SMI.  The SMI
handler looks at the list and does the final copy.  Then in resets the
processors, applies some Intel, deterministic magic, and exits the
SMI.

I'm oversimplifying some of this, but it should provide an idea of
what has to happen.

>
> >Please consider this feature for inclusion in the kernel tree, as it is very
> >important to Stratus.
> >
>
> Given that it doesn't touch core mm/ code, I don't really care about it[*]
> except that it doesn't make sense to have the tracking hooks in generic code
> because it is pretty specific to your module.

It's generic only to x86_64.  I could try and restrict it further to
Intel versions of that platform, but as I stated before, I had hoped
the tracking interface might be useful to someone.

-kimball
