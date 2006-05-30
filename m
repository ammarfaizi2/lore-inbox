Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWE3X4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWE3X4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWE3X4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:56:24 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:24477 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932242AbWE3X4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:56:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Pi6CeqJD04cF/FWwQjaBvynONsJHUAfCUyZGT9X/kYfSwddOR227lKvLLCgokimc9orIB6b6Sdgq11QERJ9PyWbFh55GaiC+BhyPHwNhEaLzX9oQ48G+h9F1j3+ZnS48bRXGF8RK182NWBI06jMxR8HrIguIucQV906xzc1CotY=  ;
Message-ID: <447CDB99.9080805@yahoo.com.au>
Date: Wed, 31 May 2006 09:56:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com, ak@suse.de,
       linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: Re: [PATCH (try #4)] mm: avoid unnecessary OOM kills
References: <200605302235.k4UMZ4ok005150@calaveras.llnl.gov>
In-Reply-To: <200605302235.k4UMZ4ok005150@calaveras.llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:
> Below is a 2.6.17-rc4-mm3 patch that fixes a problem where the OOM killer was
> unnecessarily killing system daemons in addition to memory-hogging user
> processes.  The patch fixes things so that the following assertion is
> satisfied:
> 
>     If a failed attempt to allocate memory triggers the OOM killer, then the
>     failed attempt must have occurred _after_ any process previously shot by
>     the OOM killer has cleaned out its mm_struct.
> 
> Thus we avoid situations where concurrent invocations of the OOM killer cause
> more processes to be shot than necessary to resolve the OOM condition.
> 
> Signed-Off-By: David S. Peterson <dsp@llnl.gov>

OK this is looking nice. And I was probably premature in thinking a
single simple call out to the oom code could replace your oom_alloc...
however it _still_ does a little bit too much OOM stuff for my liking.

Can you instead use two calls? oom_kill_prepare() and oom_kill_finish(),
between which you could try the final alloc? (also, declare functions in
.h files rather than .c files).

Lastly: currently, the final alloc only tries to allocate from the high
watermark because it is all racy anyway. If you've eliminated the races,
you might want to start using the low watermark for this.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
