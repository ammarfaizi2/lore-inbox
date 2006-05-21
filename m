Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWEUQ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWEUQ2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEUQ2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 12:28:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8159 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751546AbWEUQ2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 12:28:02 -0400
Date: Sun, 21 May 2006 11:27:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060521162759.GA19707@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > This patchset introduces a per-process utsname namespace.  These can
> > be used by openvz, vserver, and application migration to virtualize and
> > isolate utsname info (i.e. hostname).  More resources will follow, until
> > hopefully most or all vserver and openvz functionality can be implemented
> > by controlling resource namespaces from userspace.
> >
> > Previous utsname submissions placed a pointer to the utsname namespace
> > straight in the task_struct.  This patchset (and the last one) moves
> > it and the filesystem namespace pointer into struct nsproxy, which is
> > shared by processes sharing all namespaces.  The intent is to keep
> > the taskstruct smaller as the number of namespaces grows.
> 
> 
> Previously you mentioned:
> > BTW - a first set of comparison results showed nsproxy to have better
> > dbench and tbench throughput, and worse kernbench performance.  Which
> > may make sense given that nsproxy results in lower memory usage but
> > likely increased cache misses due to extra pointer dereference.
> 
> Is this still true?  Or did our final reference counting tweak fix
> the kernbench numbers?
> 
> I just want to be certain that we don't add an optimization,
> that reduces performance.

Here are the numbers with the basic patchsets.  But I guess I should
do another round with adding 7 more void*'s to represent additional
namespaces.

(intervals are for 95% CI, tests were each run 15 times)

           |  with nsproxy  |   without nsproxy |
kernbench  | 68.90 +/- 0.21 |   69.06 +/- 0.22  |
dbench     | 386.0 +/- 26.6 |   388.4 +/- 21.0  |
tbench     | 391.6 +/- 8.00 |   389.4 +/- 10.95 |

reaim with nsproxy
1 115600.000000 5512.441557
3 246985.712000 9375.780582
5 272309.092000 8029.833742
7 290020.000000 7288.367116
9 298591.580000 5557.531915
11 nan nan
13 nan nan
15 nan nan

reaim without nsproxy
1 110160.000000 5728.697311
3 246985.712000 9375.780582
5 262204.197333 11138.510652
7 288660.000000 6880.898412
9 300631.580000 4351.926692
11 nan nan
13 nan nan
15 nan nan
