Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVHJJpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVHJJpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 05:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVHJJpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 05:45:05 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:16667 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932536AbVHJJpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 05:45:01 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,95,1122847200"; 
   d="scan'208"; a="13868719:sNHT2715597864"
Message-ID: <42F9CC95.4090402@fujitsu-siemens.com>
Date: Wed, 10 Aug 2005 11:44:53 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@osdl.org>,
       gdt@linuxppc.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
 sa_mask
References: <42F8EB66.8020002@fujitsu-siemens.com>  <1123612016.3167.3.camel@localhost.localdomain>  <42F8F6CC.7090709@fujitsu-siemens.com>  <1123612789.3167.9.camel@localhost.localdomain>  <42F8F98B.3080908@fujitsu-siemens.com>  <1123614253.3167.18.camel@localhost.localdomain>  <1123615983.18332.194.camel@localhost.localdomain>  <42F906EB.6060106@fujitsu-siemens.com>  <1123617812.18332.199.camel@localhost.localdomain>  <1123618745.18332.204.camel@localhost.localdomain>  <20050809204928.GH7991@shell0.pdx.osdl.net>  <1123621223.9553.4.camel@localhost.localdomain> <1123621637.9553.7.camel@localhost.localdomain> <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 9 Aug 2005, Steven Rostedt wrote:
> 
>>If this is indeed the way things should work. I'll go ahead and fix all
>>the other architectures.
> 
> 
> It does appear that this is what the standards describe in the section 
> quoted by Chris.
> 
> On the other hand, the standard seems to be a bit confused according to 
> google:
> 
>   "This mask is formed by taking the union of the current signal mask and
>    the value of the sa_mask for the signal being delivered unless
>    SA_NODEFER or SA_RESETHAND is set, and then including the signal being
>    delivered. If and when the user's signal handler returns normally, the
>    original signal mask is restored."

I've googled a bit, too. Unfortunately, I don't have much knowledge about
standards and who defines or changes them. Nevertheless it might help
what I've found in "http://www.opengroup.org/austin/docs/austin_251.txt":

   XSH ERN 84 sigaction Accept as marked below

   Change from:
    This mask is formed by taking the union of the current signal mask and
    the value of the sa_mask for the signal being delivered [XSI] [Option
    Start]  unless SA_NODEFER or SA_RESETHAND is set, [Option End] and
    then including the signal being delivered.
   to:
    This mask is formed by taking the union of the current signal mask and
    the value of the sa_mask for the signal being delivered, and [XSI] [Option
    Start]  unless SA_NODEFER or SA_RESETHAND is set, [Option End]
    then including the signal being delivered.

Maybe, the standard already is fixed?

	Bodo

> 
> Quite frankly, the way I read it is actually the old Linux behaviour: the 
> "unless SA_NODEFER or SA_RESETHAND is set" seems to be talking about the 
> whole union of the sa_mask thing, _not_ just the "and the signal being 
> delivered" part. Exactly the way the kernel currently does (except we 
> should apparently _also_ do it for SA_RESETHAND).
> 
> So if we decide to change the kernel behaviour, I'd like this to be in -mm
> for a while before merging (or merge _very_ early after 2.6.13). I could
> imagine this confusing some existing binaries that had only been tested
> with the old Linux behaviour, regardless of what a standard says. 
> Especially since the standard itself is so confusing and badly worded.
> 
> Maybe somebody can tell what other systems do, since I assume the standard 
> is trying to describe behaviour that actually exists in the wild..
> 
> 		Linus
