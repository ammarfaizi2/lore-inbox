Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWITRYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWITRYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWITRYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:24:04 -0400
Received: from smtp-out.google.com ([216.239.45.12]:22455 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932085AbWITRYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:24:01 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=a4kX+FNa+60mmK3eovs5pFE+N349KbVqjinPdrxKmCD72KJQmCjRzuA9TVZ3sS1Sr
	LXp2UuifrbQOYhLGGrYRg==
Message-ID: <6599ad830609201023y4efcc82fjda76df872fce907d@mail.google.com>
Date: Wed, 20 Sep 2006 10:23:54 -0700
From: "Paul Menage" <menage@google.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>, rohitseth@google.com,
       devel@openvz.org, "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <451173B5.1000805@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>
	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>
	 <451173B5.1000805@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Yeah, I'm not sure about that. I don't think really complex schemes
> are needed... but again I might need more knowledge of their workloads
> and problems.
>

The basic need for separating files into containers distinct from the
tasks that are using them arises when you have several "jobs" all
working with the same large data set. (Possibly read-only data files,
or possibly one job is updating a dataset that's being used by other
jobs).
For automated job-tracking and scheduling, it's important to be able
to distinguish shared usage from individual usage (e.g. to be able to
answer questions "if I kill job X, how much memory do I get back?" and
"how do I recover 1G of memory on this machine")

As an example, assume two jobs each with 100M of anonymous memory both
mapping the same 1G file, for a total usage of 1.2G.

Any setup that doesn't let you distinguish shared and private usage
makes it hard to answer that kind of scheduling questions. E.g.:

- first user gets charged for the page -> first job reported as 1.1G,
and the second as 0.1G.

- page charges get shared between all users of the page -> two tasks
using 0.6G each.

- all users get charged for the page -> two tasks using 1.1G each.

But in fact killing either one of these jobs individually would only
free up 100M

By explicitly letting userspace see that there are two jobs each with
a private usage of 100M, and they're sharing a dataset of 1G, it's
possible to make more informed decisions.

The issue of telling the kernel exactly which files/directories need
to be accounted separately can be handled by userspace.

It could be done by per-page accounting, or by constraining particular
files to particular memory zones, or by just tracking/limiting the
number of pages from each address_space in the pagecache, but I think
that it's important that the kernel at least provide the primitive
support for this.

Paul
