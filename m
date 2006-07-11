Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWGKOee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWGKOee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWGKOee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:34:34 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:28465 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750878AbWGKOed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:34:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SAUAaIaTz8nCe5GqNkoXnlByRJ6qnIe2Qes/asKbJ+z+1OWo0U48YCWphHlqVNa9KA+Ny0Csqc2/+6eSh4Wn4jLjxVqeRyLjSkKIS8suZDkOW1s1z9kUMlAohPjU0V3lICsDdjy2/xf5ps7LbZWCvy6CVuOGgMxHd3q9BQj0O6w=
Message-ID: <44B3B6ED.9020705@gmail.com>
Date: Tue, 11 Jul 2006 22:34:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, mreuther@umich.edu,
       linux-kernel@vger.kernel.org, zap@homelink.ru
Subject: Re: [PATCH] fbdev: Statically link the framebuffer notification functions
References: <200607100833.00461.mreuther@umich.edu>	 <20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>	 <44B27931.30609@gmail.com> <200607102327.38426.mreuther@umich.edu>	 <20060710215253.1fcaab57.rdunlap@xenotime.net>	 <44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>	 <44B39D4D.8060209@gmail.com>	 <9e4733910607110621i720db936sebdd0bcb60fab4ad@mail.gmail.com>	 <44B3AA51.1040003@gmail.com> <9e4733910607110646m7f95581cl52669daddf5f2fa1@mail.gmail.com>
In-Reply-To: <9e4733910607110646m7f95581cl52669daddf5f2fa1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> The backlight and lcd subsystems can be notified by the framebuffer
>> layer
>> >> of blanking events.  However, these subsystems, as a whole, can
>> function
>> >> independently from the framebuffer layer. But in order to enable to
>> >> the lcd and backlight subsystems, the framebuffer has to be compiled
>> >> also,
>> >> effectively sucking in a huge amount of unneeded code. Besides, the
>> >> dependency
>> >> is introducing a lot of compilation problems.
>> >
>> > This code is effectively rebuilding a fb specific version of
>> > inter_module_get/put., something that was removed earlier.
>>
>> Huh? I don't see any semblance of inter_module_* or symbol_* in there.
>> Read the patch again.
> 
> You are providing a fixed point to do a rendezvous between modules
> without refcount tracking. That's what inter_module did.

No, you're confused on inter_module. inter_module_* allows 2 or more
modules to share data. The danger is that one module may disappear
while the other is still accessing the data.

In this case, there is absolutely no data sharing. One module can
safely unload without affecting the other. The only danger is
that one might be in a midst of a calling the callout function while
the other is unregistering its notifier block. But then the notifier
chain already protects this from happening.

> The symbol is
> being passed implicitly via the entry point names.
> 
> Just wrap fb_notifier in a module and it will get tracked.

No, there's no need to do this. It just adds more complexity to
the already complicated dependency.

Tony
