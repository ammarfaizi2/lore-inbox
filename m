Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVDGNJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVDGNJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVDGNJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:09:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262453AbVDGNI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:08:59 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mingming Cao <cmm@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050407081434.GA28008@elte.hu>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 07 Apr 2005 14:08:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-04-07 at 09:14, Ingo Molnar wrote:

> doesnt the first option also allow searches to be in parallel?

In terms of CPU usage, yes.  But either we use large windows, in which
case we *can't* search remotely near areas of the disk in parallel; or
we use small windows, in which case failure to find a free bit becomes
disproportionately expensive (we have to do an rbtree link and unlink
for each window we search.)

>  This 
> particular one took over 1 msec, so it seems there's a fair room for 
> parallellizing multiple writers and thus improving scalability. (or is 
> this codepath serialized globally anyway?)

No, the rbtree ops are serialised per-sb, and allocations within any one
inode are serialised, but the bitmap searches need not be serialised
globally.  (They are in the case of new window searches right now, which
is what we're trying to fix.)

--Stephen

