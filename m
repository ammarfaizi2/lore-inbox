Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbWFTJhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbWFTJhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWFTJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:37:15 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:50836 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965233AbWFTJhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:37:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jZPeKtsLmNmtTzUadrmH3kqshHyaAVK/OmdHuwGz9bKs4Pz40oLl6GjW+xTOMEVhGXPKdzZain9oMtCdkfCjyj0qUPKjvSPw4wzLfoBCLypSv9CeP2ammfcTRfIRRhEIIsAuvtWB3MSQY+Rej+xGYpxsA24sh0Sm02qmyDqk6M8=  ;
Message-ID: <4497C1BC.9090601@yahoo.com.au>
Date: Tue, 20 Jun 2006 19:37:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       ccb@acm.org, linux-kernel@vger.kernel.org,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no> <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no> <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com> <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au> <20060620083305.GB7899@elte.hu>
In-Reply-To: <20060620083305.GB7899@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> curious, do you have any (relatively-) simple to run testcase that 
> clearly shows the "scalability issues" you mention above, when going 
> from rwlocks to spinlocks? I'd like to give it a try on an 8-way box.

Arjan van de Ven wrote:
 > I'm curious what scalability advantage you see for rw spinlocks vs real
 > spinlocks ... since for any kind of moderate hold time the opposite is
 > expected ;)

It actually surprised me too, but Peter Chubb (who IIRC provided the
motivation to merge the patch) showed some fairly significant improvement
at 12-way.

https://www.gelato.unsw.edu.au/archives/scalability/2005-March/000069.html

Not sure what exactly would be going on at 8-way and above. Single
threaded lock hold times for find_lock_page should be fairly short... At
a wild guess, I'd say average lock transfer times are creeping up to the
point that spin lockers are taking multiple cacheline transfers to obtain
the lock, and the interconnect is getting saturated (read lockers should
only need one cacheline transfer in the absense of write lockers).

I thought Peter had a wider range of test cases than just reaim, but
perhaps that was for demonstrating some other problem.

Before that, Bill Irwin made some noises about Oracle improvements with
their VLM mode... that's not such a simple one to reproduce.

I'm sure SGI would be mortified too, but that's a given ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
