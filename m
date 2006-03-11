Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWCKBEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWCKBEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWCKBEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:04:30 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:43208 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932359AbWCKBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:04:29 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [PATCH] -mm: Small schedule() optimization
Date: Sat, 11 Mar 2006 12:00:26 +1100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20060308175450.GA28763@rhlx01.fht-esslingen.de>
In-Reply-To: <20060308175450.GA28763@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111200.27557.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ed Ingo since he's maintainer.

On Thursday 09 March 2006 04:54, Andreas Mohr wrote:
> Hello all,
>
> I found that there's a possible small optimization right at the very
> beginning of schedule():
>
>         if (likely(!current->exit_state)) {
>                 if (unlikely(in_atomic())) {
>
> can be reversed into
>
>         if (unlikely(in_atomic())) {
>                 if (likely(!current->exit_state)) {
>
> This is a Good Thing since it avoids having to evaluate both checks,
> and both use current_thread_info() which has an inherent AGI stall risk on
> x86 CPUs if it cannot be inter-mingled with other unrelated opcodes.
>
> I'm a bit puzzled that this has not been done like that before.
> Probably since the exit_state check got added as an after-thought...
> Or did I miss some important reason here? (branch prediction??)

This looks good. See below.

> Patch against 2.6.16-rc5-mm3.
>
> Thanks!
>
> Signed-off-by: Andreas Mohr <andi@lisas.de>
>
>
> --- linux-2.6.16-rc5-mm3/kernel/sched.c.orig	2006-03-08 18:36:58.000000000
> +0100 +++ linux-2.6.16-rc5-mm3/kernel/sched.c	2006-03-08 18:39:55.000000000
> +0100 @@ -3022,8 +3022,8 @@
>  	 * schedule() atomically, we ignore that path for now.
>  	 * Otherwise, whine if we are scheduling when we should not be.
>  	 */
> -	if (likely(!current->exit_state)) {
> -		if (unlikely(in_atomic())) {
> +	if (unlikely(in_atomic())) {
> +		if (likely(!current->exit_state)) {

I suspect that once we're in_atomic() then we're no longer likely to 
be !current->exit_state

Probably better to just
	if (unlikely(in_atomic())) {
		if (!current->exit_state) {

Ingo?

Cheers,
Con
