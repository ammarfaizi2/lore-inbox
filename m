Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754505AbWK2Co4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbWK2Co4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 21:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbWK2Co4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 21:44:56 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:3215 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754505AbWK2Co4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 21:44:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=a9zQJ0dLQVbZ+8yb7bQQyA6YYMFfuxDcfgldo7WWi93e+VbWHgSuQtHXF6PTkLS1EAfFVmnUDGvwuA9OzHhzVMpGdK/wjq2MbB68nEX+43SqKnoBBuLosgWeuDQ26EgvFNljXWZERsCF1+JxcbEZ/4YX3gDzxJYU5A+DD/sCRP8=
Date: Wed, 29 Nov 2006 11:37:37 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Don Mullis <dwm@meer.net>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 -mm] fault-injection: lightweight code-coverage maximizer
Message-ID: <20061129023737.GA9283@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Don Mullis <dwm@meer.net>, akpm <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1164699866.2894.88.camel@localhost.localdomain> <1164700290.2894.93.camel@localhost.localdomain> <20061128091811.GA2004@APFDCB5C> <1164744877.2894.133.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164744877.2894.133.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 12:14:36PM -0800, Don Mullis wrote:
> First, waiting a few seconds for the standard FC-6 daemons to wake up.
> Then, Xemacs and Firefox.  Not tested on SMP.

Is it failslab or fail_page_alloc ?

> > This doesn't maximize code coverage. It makes fault-injector reject
> > any failures which have same stacktrace before.
> 
> Since the volume of (repeated) dumps is greatly reduced, 
> interval/probability can be set more aggressively without crippling
> interaction.  This increases the number of error recovery paths covered
> per unit of wall clock time.
> 

It seems artificial. Injecting failures into slab or page allocator causes
vastly greater range of errors and it should be. I feel what you really
want is new fault capability.

Fault injection is designed be extensible. It's not only for failslab,
fail_page_alloc, and fail_make_request.

If we want to inject errors into try_something() and have own tuning or
setting, we just need to extend fault attribute and define own judging
function,

struct fail_try_something_attr {

	struct gorgeous_tuning tuning;
	struct fail_attr attr;

} = fail_try_something = {
	.attr = FAULT_ATTR_INITIALIZER,
};

static int should_fail_try_something(void *data)
{
	if (tuning_did_clever_decision(&fail_try_something.tuning, data))
		return 0;

	return should_fail(&fail_try_something.attr);
}

Then insert it into try_something()

int try_something(void *data)
{
	if (should_fail_try_something(data))
		return 0;
...
	return 1;
}

Common debugfs entries for fault capabilities will be complicated
soon by pushing new entries for every fault case or pattern.

