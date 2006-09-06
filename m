Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWIFPKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWIFPKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWIFPKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:10:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:63711 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751329AbWIFPKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:10:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GMpHNDQsWBxcZz/IRbWVokZg3d3Nwm9kwWLzYjjm9p8hExjQJ4PWerc2eWO3Mh0Qtxppk3dDMnxp30bnKbAJBU/w1K3/5/3Sle8GjtKjcrdcRXcgDi8RRzvcg8Db+CVCM+p574gHBzwXVLo+0V4M0Qb71IfUoc5DzoNFQvxBkC8=
Message-ID: <bbe04eb10609060810j70562e3dt6a87067d95bc883e@mail.gmail.com>
Date: Wed, 6 Sep 2006 11:10:04 -0400
From: "Kimball Murray" <kimball.murray@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
In-Reply-To: <200609060936.19268.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
	 <44FE6CD6.4040809@yahoo.com.au> <200609060936.19268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/06, Andi Kleen <ak@suse.de> wrote:
>
> > Silly question, why can't you do all this from stop_machine_run context (or
> > your SMI) that doesn't have to worry about other CPUs dirtying memory?
>
> Because that would be too slow for continuous mirroring.
>
> You can't go through 10+GB of virtual memory (or more with shared
> memory because the scan has to be virtual) in an interrupt.
>
> The only sane way is to do it continuously.

That's exactly right on all counts.  We can "harvest" dirty pages in a
continuous fashion, as a background task.  But when we finally decide
to dive in to machine blackout for the final copy, we need to ensure
that the blackout is as short as possible.  Toward that goal, we have
built a sort of DMA engine that can move pages over the backplane to
the spare cpu/memory module without interfering (much) with the active
module's activities.  We continue doing this until the number of pages
for final copy is small enough that we can be sure the final blackout
copy will take a sufficiently short time.

And you're right about the virtual scan as well.  Trouble is, it's a
potentially unbounded scan.  With the right machine load, we can find
ourselves in a state where it takes so long to scan all the page
tables that the pages are all dirty again before we start the next
pass. For this situation we have two choices.  We can either give up
and dive into the blackout passing a dirty list that basically
includes all of memory (long blackout time!), or we can continue
scanning for a long time, waiting and hoping the machine load will
decrease to a point where are target number of dirty pages is reached.
 This sort of thing will always be a problem with a software solution.

-kimball
