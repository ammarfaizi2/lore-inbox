Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUIJWPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUIJWPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUIJWPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:15:37 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:46265 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S267974AbUIJWPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:15:30 -0400
Message-ID: <41422746.602@sun.com>
Date: Fri, 10 Sep 2004 23:14:30 +0100
From: Brian Somers <brian.somers@sun.com>
Organization: Sun Microsystems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Michael.Waychison@sun.com, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>	<200408162049.FFF09413.8592816B@anet.ne.jp>	<20040816143824.15238e42.davem@redhat.com>	<412CD101.4050406@sun.com>	<20040825120831.55a20c57.davem@redhat.com>	<412CF0E9.2010903@sun.com>	<20040825175805.6807014c.davem@redhat.com>	<412DC055.4070401@sun.com>	<20040826123730.375ce5d2.davem@redhat.com>	<41419F82.10109@sun.com> <20040910135357.393f7737.davem@redhat.com>
In-Reply-To: <20040910135357.393f7737.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 10 Sep 2004 13:35:14 +0100
> Brian Somers <brian.somers@sun.com> wrote:
> 
> 
>>The problem seems to be that autoneg is disabled on the IBM switches.
>>After disabling autoneg on the Sun shelf switches, I see the problem.
>>This patch fixes things by reverting to sw autoneg which defaults to
>>a 1000Mbps/full-duplex link but with no flow control when it fails
>>(IBM should really have autoneg enabled!) - I'd appreciate it if
>>someone could test this against an IBM blade.
> 
> 
> Did you see the fix I posted the other day and have
> already merged upstream?
> 
> The real problem was the MAC_STATUS register checking in
> tg3_timer() that we use to determine if we should call
> the PHY code.  Specifically, we were failing to test
> MAC_STATUS_SIGNAL_DET being set, which when trying to
> bring the link up means we should call tg3_setup_phy().

To be honest, when I saw your mail about that change, I was happy
to down tools as the problem was clearly fixed.  At that point I
already had suspicions that the optimisations in this area may
have issues.

But after a few more days, all the IBM blade folks were still
saying they were having problems - and then Mike W gave me a
kick ;*P

I think the issue with the code up 'till now is that when HW
autoneg fails, the driver just hangs about waiting for the
hardware to do something - in my previous testing here, the
switch would eventually recover (my only way of breaking the
switch was to drop it to the monitor prompt or reload it),
and at that point tg3 picks up the link status change and
everything's rosy.

> There are still some nagging problems with certain blades even
> with my current code.  Brian, if you want to help I'd really
> appreciate it if you worked with current tg3 sources as I rewrote
> the 5704 hw autoneg support from scratch since it was missing
> a hw bug workaround and had other issues as well.
> 
> Thanks.

Yes, I really ought to be running a current box, but for various
reasons I've been quite short of hardware for the past couple of
months.  I now have a lab again, but it's not yet turned on, so
I'm still scrounging hardware from people...

Feeble excuses... but they're the only ones I have :-/

-- 
Brian Somers                                            Sun Microsystems
                                             Sparc House, Guillemont Park
Software Engineer - LSE                          Minley Road, Blackwater
Tel: +44 1252 421 263   Ext: 21263                    Camberley GU17 9QG
