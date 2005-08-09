Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVHIV12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVHIV12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVHIV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:27:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964982AbVHIV11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:27:27 -0400
Date: Tue, 9 Aug 2005 14:27:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Chris Wright <chrisw@osdl.org>, gdt@linuxppc.org,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
 sa_mask
In-Reply-To: <1123621637.9553.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
References: <42F8EB66.8020002@fujitsu-siemens.com> 
 <1123612016.3167.3.camel@localhost.localdomain>  <42F8F6CC.7090709@fujitsu-siemens.com>
  <1123612789.3167.9.camel@localhost.localdomain>  <42F8F98B.3080908@fujitsu-siemens.com>
  <1123614253.3167.18.camel@localhost.localdomain> 
 <1123615983.18332.194.camel@localhost.localdomain>  <42F906EB.6060106@fujitsu-siemens.com>
  <1123617812.18332.199.camel@localhost.localdomain> 
 <1123618745.18332.204.camel@localhost.localdomain>  <20050809204928.GH7991@shell0.pdx.osdl.net>
  <1123621223.9553.4.camel@localhost.localdomain> <1123621637.9553.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Aug 2005, Steven Rostedt wrote:
>
> If this is indeed the way things should work. I'll go ahead and fix all
> the other architectures.

It does appear that this is what the standards describe in the section 
quoted by Chris.

On the other hand, the standard seems to be a bit confused according to 
google:

  "This mask is formed by taking the union of the current signal mask and
   the value of the sa_mask for the signal being delivered unless
   SA_NODEFER or SA_RESETHAND is set, and then including the signal being
   delivered. If and when the user's signal handler returns normally, the
   original signal mask is restored."

Quite frankly, the way I read it is actually the old Linux behaviour: the 
"unless SA_NODEFER or SA_RESETHAND is set" seems to be talking about the 
whole union of the sa_mask thing, _not_ just the "and the signal being 
delivered" part. Exactly the way the kernel currently does (except we 
should apparently _also_ do it for SA_RESETHAND).

So if we decide to change the kernel behaviour, I'd like this to be in -mm
for a while before merging (or merge _very_ early after 2.6.13). I could
imagine this confusing some existing binaries that had only been tested
with the old Linux behaviour, regardless of what a standard says. 
Especially since the standard itself is so confusing and badly worded.

Maybe somebody can tell what other systems do, since I assume the standard 
is trying to describe behaviour that actually exists in the wild..

		Linus
