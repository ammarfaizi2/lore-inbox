Return-Path: <linux-kernel-owner+w=401wt.eu-S932629AbXAGSHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbXAGSHN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXAGSHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:07:12 -0500
Received: from gw.goop.org ([64.81.55.164]:52461 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932626AbXAGSHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:07:09 -0500
Message-ID: <45A136CC.60007@goop.org>
Date: Sun, 07 Jan 2007 10:07:08 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org> <459F1B82.6000808@gmail.com> <45A0B660.4060505@goop.org> <45A0B71F.1080704@gmail.com> <45A0C977.4070800@goop.org> <45A0CFC6.3030707@gmail.com>
In-Reply-To: <45A0CFC6.3030707@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Doing the set_fs() and pagefault_{disable,enable} calls for every
> single byte during the checksum seems rather silly.

Why?  It's a bit of a performance hit, but that doesn't matter here. 
probe_kernel_address() is semantically the right thing to be using;
open-coding its contents to avoid a few fairly cheap operations is a
backwards step.

> I disagree I'm afraid. Given what __get_user compiles to (nothing more
> than a .fixup entry, basically) they're largely "free" and it makes
> the code completely obvious: "If you're touching this, do so via
> __get_user and not directly" and frees it from any assumptions,
> however reasonable or unreasonable.

My point is that "__get_user" doesn't make much semantic sense here:
we're not talking about usermode pages.  We used to use it quite often
for cases where an access may or may not fault, but now we spell that
"probe_kernel_address()".

> Would you _mind_ if I submit it? If not, if you could comment on
> whether or not these pagefault calls are still useful, that would be
> great.

I don't strongly object to using probe_kernel_address() for all ROM
memory accesses if it makes you feel happier, but I think putting an
open-coded implementation in here is definitely the wrong thing to do.

    J
