Return-Path: <linux-kernel-owner+w=401wt.eu-S932789AbWLSK6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWLSK6z (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbWLSK6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:58:55 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:31418 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932789AbWLSK6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:58:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vCBJmx/Yn7bj3RDjVOeyrlkxyfbAy35l2GIIyt/0ID4IX/vdNus2U1OOuAQHXScgOOz0YHEG0t5d+DNzmeEeVWw79HtyMDvNVmVFhjbn2Z5LuRPQNWMVTE7Ruwzu+T5Kad04tQIKzFFryxz2e+4eBQad6nXOYdFv6rz4pgSQYVA=  ;
X-YMail-OSG: H3eY9XMVM1nJv9uVrjFv6pmx8GfVXYF3InIP1mbwKcrk9x9wZnJ81CZvjMJkUiU6WSUjZVCuVM2tE40Oan5ZQIvi8sl6.S6DdOAg30..1F7kpXtVcbmsIgc0xj.HJSHsF90DcFK3IDOWrrg-
Message-ID: <4587C5C8.2060304@yahoo.com.au>
Date: Tue, 19 Dec 2006 21:58:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>	 <45876C65.7010301@yahoo.com.au>	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>	 <45878BE8.8010700@yahoo.com.au>	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>	 <4587B762.2030603@yahoo.com.au>  <20061219023255.f5241bb0.akpm@osdl.org> <1166525535.10372.138.camel@twins>
In-Reply-To: <1166525535.10372.138.camel@twins>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2006-12-19 at 02:32 -0800, Andrew Morton wrote:

>>Well it used to be.  After 2.6.19 it can do the wrong thing for mapped
>>pages.  But it turns out that we don't feed it mapped pages, apart from
>>pagevec_strip() and possibly races against pagefaults.
> 
> 
> So how about this:

Well that's still racy. Anyway several earlier patches (including
the one I posted) closed this race. Some were still reported to
trigger corruption IIRC.

> Index: linux-2.6-git/mm/page-writeback.c
> ===================================================================
> --- linux-2.6-git.orig/mm/page-writeback.c	2006-12-19 08:24:48.000000000 +0100
> +++ linux-2.6-git/mm/page-writeback.c	2006-12-19 11:43:31.000000000 +0100
> @@ -859,6 +859,9 @@ int test_clear_page_dirty(struct page *p
>  	struct address_space *mapping = page_mapping(page);
>  	unsigned long flags;
>  
> +	if (page_mapped(page))
> +		return 0;
> +
>  	if (!mapping)
>  		return TestClearPageDirty(page);
>  
> 
> 
> -

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
