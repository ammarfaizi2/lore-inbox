Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSGHApl>; Sun, 7 Jul 2002 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSGHApk>; Sun, 7 Jul 2002 20:45:40 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:24806 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316684AbSGHApj>; Sun, 7 Jul 2002 20:45:39 -0400
Date: Mon, 8 Jul 2002 01:46:26 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Werner Almesberger <wa@almesberger.net>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020708014626.B13387@kushida.apsleyroad.org>
References: <20020707220933.B11999@kushida.apsleyroad.org> <Pine.LNX.3.96.1020707201054.19682A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020707201054.19682A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Sun, Jul 07, 2002 at 08:18:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I think you have to do it with the use count, and there may well be
> modules you can't remove safely.

I agree, this is the correct and clean thing to do.

It rather implies that any function in a module which calls
MOD_{INC,DEC}_USE_COUNT should always be called from a non-module
function which _itself_ protects the module from removal by temporarily
bumping the use count.

> But to add re-init code to modules,
> define new ioctls to call it, etc, etc, doesn't seem satisfactory. I think
> we really need to bump the use counter more carefully, to really know when
> a module is in use, and when we can clear it out.
>
> The smp case looks doable, the preempt case may be harder. I really like
> the idea of simply queueing a remove and then doing it when the use count
> drops to zero. But we have have to provide a "don't use" to keep new
> things out. That's hard.

That's already done in `try_inc_mod_count', it's just a bit slow.  But
arguably it's only impact is when you're getting a handle or creating an
object, which is usually relatively slow anyway, such as opening a
device or socket, or adding a firewall rule.

The more I think about it, the more I think the `owner' thing in
file_operations et al. is the right thing in all cases, and that Al Viro
is right about the overhead being reasonable.  Perhaps the interface
could be made a little more generic (`{get,put}_module_reference'?), and
double check the corner cases such as when a module is in "don't use"
mode, blocking and scheduling a reload.

-- Jamie
