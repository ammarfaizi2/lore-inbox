Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWGKOvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWGKOvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWGKOvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:51:12 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:45678 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750871AbWGKOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:51:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SAlWTu6feqzCySpCo/x47rlrMc6OMyyK6A0LRm5szOiFyxi2yeGvqMifQHym8xgx7XCDUmBvhsIe8vcLnp9OpVpAaHTEGe81+LWhygoyuN1NPC0dL7qVXzCHYj3M5CafGlRhGxNJWoXKBIx8yAu3AfbuiB0ySf0ovDtFNYsX9D4=
Message-ID: <44B3BACF.4000305@gmail.com>
Date: Tue, 11 Jul 2006 22:50:55 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, mreuther@umich.edu,
       linux-kernel@vger.kernel.org, zap@homelink.ru
Subject: Re: [PATCH] fbdev: Statically link the framebuffer notification functions
References: <200607100833.00461.mreuther@umich.edu>	 <200607102327.38426.mreuther@umich.edu>	 <20060710215253.1fcaab57.rdunlap@xenotime.net>	 <44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>	 <44B39D4D.8060209@gmail.com>	 <9e4733910607110621i720db936sebdd0bcb60fab4ad@mail.gmail.com>	 <44B3AA51.1040003@gmail.com>	 <9e4733910607110646m7f95581cl52669daddf5f2fa1@mail.gmail.com>	 <44B3B6ED.9020705@gmail.com> <9e4733910607110743w29573c02h981324a110adba11@mail.gmail.com>
In-Reply-To: <9e4733910607110743w29573c02h981324a110adba11@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> Jon Smirl wrote:
>> >> > On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> >> The backlight and lcd subsystems can be notified by the framebuffer
>> >> layer
>> >> >> of blanking events.  However, these subsystems, as a whole, can
>> >> function
>> >> >> independently from the framebuffer layer. But in order to enable to
>> >> >> the lcd and backlight subsystems, the framebuffer has to be
>> compiled
>> >> >> also,
>> >> >> effectively sucking in a huge amount of unneeded code. Besides, the
>> >> >> dependency
>> >> >> is introducing a lot of compilation problems.
>> >> >
>> >> > This code is effectively rebuilding a fb specific version of
>> >> > inter_module_get/put., something that was removed earlier.
>> >>
>> >> Huh? I don't see any semblance of inter_module_* or symbol_* in there.
>> >> Read the patch again.
>> >
>> > You are providing a fixed point to do a rendezvous between modules
>> > without refcount tracking. That's what inter_module did.
>>
>> No, you're confused on inter_module. inter_module_* allows 2 or more
>> modules to share data. The danger is that one module may disappear
>> while the other is still accessing the data.
>>
>> In this case, there is absolutely no data sharing. One module can
>> safely unload without affecting the other. The only danger is
>> that one might be in a midst of a calling the callout function while
>> the other is unregistering its notifier block. But then the notifier
>> chain already protects this from happening.
> 
> The code looks ok but this sure smells like inter_module_*.

I assure you, there is no smell of inter_module_* here. What scenario
are you afraid of?

> I guess
> inter_module had to deal with arbitrary users and this code is dealing
> with a fixed set of clients which makes it more manageable.
> 
> Have you considered making this a generic service and not fb specific?
> 

It's basically a wrapper to the notifier_call_chain, that's as generic
as it can get. And yes, it's not fb_specific (meaning, there's no need
for the client module to know fbdev internals), that's why the lcd and
backlight subsystem can take advantage of it. 

Tony

