Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWJDEkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWJDEkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWJDEkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:40:00 -0400
Received: from gw.goop.org ([64.81.55.164]:30173 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030259AbWJDEj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:39:59 -0400
Message-ID: <45233B1E.3010100@goop.org>
Date: Tue, 03 Oct 2006 21:39:58 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: tim.c.chen@linux.intel.com
CC: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <1159916644.8035.35.camel@localhost.localdomain>	 <4522FB04.1080001@goop.org> <1159919263.8035.65.camel@localhost.localdomain>
In-Reply-To: <1159919263.8035.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen wrote:
> I think if the condition changes between two evaluations, we do have a
> problem with my fix.

That's not the problem; one hopes that the WARN_ON predicate has no 
side-effects (though I know there are places which have side effects in 
BUG_ON).  The point is that the vast majority of WARN_ONs *don't* have 
their values used, so in the current code the variable reference is dead 
code and will be removed.  But if gcc can't prove the predicate is 
side-effect free (call to an external function, for example), then gcc 
will have to generate two calls to it, regardless of whether the second 
value is used.

And since the condition variable will - at worst - be stored on the 
stack on a hot cache line, I don't see how there could be any extra 
cache misses.

>   I don't have a better idea to avoid using a local
> variable to store the condition.  I think we should at least reverse the
> WARN_ON/WARN_ON_ONCE patch if a better way cannot be found.

I don't think you've proved your case here.  Do you *know* there are 
extra cache misses (ie, measuring them), or is it just your theory to 
explain a performance regression?

The other question is whether WARN_ON should return a value.  Where does 
it get used?  It doesn't seem very valuable.

    J
