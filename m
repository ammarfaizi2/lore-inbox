Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVFPGTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFPGTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVFPGTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:19:53 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:567 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261498AbVFPGTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:19:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E2FNU6hjZWEiVsgDNaiLXOBtGZp/kh4VP9OJBfOGpG4SWA7KnogyY+2sxvIniF8YKc8Idl/uc/259yZvw6moOciLT/Ybdr2jgN3FVz55ntHVAXe/7egvwWZi3rZlMPVjgb2pDWUWn6mwO0g7dkUJ2OWAZkyP08M4mgwR3tLcevE=
Message-ID: <42B119F7.6000709@gmail.com>
Date: Thu, 16 Jun 2005 15:19:35 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 00/06] blk: generic dispatch queue
 (for review)
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jens.
> 
>  This patchset implements generic dispatch queue I've talked about in
> the last ordered reimplementation patchset.  The patches are against
> 2.6.12-rc6-mm1 + ordered patchset + 3 last blk fix patches.  As I
> haven't posted ordered patchset against 2.6.12-rc6-mm1 (still waiting
> for your comments), to apply this patchset, you'll have to apply the
> ordered patchset against 2.6.12-rc5-mm2 to 2.6.12-rc6-mm1, and then
> apply these patches.  libata changes will fail but it wouldn't matter
> for review purpose.  (if you want ordered patchset against
> 2.6.12-rc6-mm1, I can send it to you, just tell me.)
> 
>  This patchset updates only noop and cfq io schedulers.  as and
> deadline wouldn't compile w/ this patchset applied.  I'll update as
> and deadline once some consensus regarding the general direction of
> this patchset is gained.
> 
>  This patchset is composed of two large parts.
> 
>  * Implementation of generic dispatch queue & updating individual
>    elevators.
>  * Move last_merge handling into generic elevator.
> 
>  Currently, each specific iosched maintains its own dispatch queue to
> handle ordering, requeueing, cluster dispatching, etc...  This causes
> the following problems.
> 
>  * duplicated codes
>  * difficult to enforce semantics over dispatch queue (request
>    ordering, requeueing, ...)
>  * specific ioscheds have to deal with non-fs or ordered requests
>    directly.
> 
>  With generic dispatch queue, specific ioscheds are guaranteed to be
> handed only non-barrier fs requests, such that ioscheds only have to
> implement ordering logic of normal fs requests.  Also, callback
> invocation is stricter now.  Each fs request follows one of the
> following paths.
> 
>  * add_req_fn -> dispatch_fn -> activate_fn (-> deactivate_fn ->
>    activate_fn)* -> completed_req_fn
>  * add_req_fn -> merged_req_fn


  Oops, sorry.  I was being delusional.  The following special case path 
doesn't exist.  It never reaches specific ioscheds, so it's just above 
two paths.

>  * add_req_fn -> dispatch_fn (This path is special case for barrier
>    request.  This can be easily removed by activating at the start of
>    ordered sequence, and completing at the end.  Would removing this
>    path be better?)

-- 
tejun
