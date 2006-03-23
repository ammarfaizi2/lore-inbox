Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWCWSDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWCWSDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWCWSDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:03:04 -0500
Received: from mail.aknet.ru ([82.179.72.26]:64778 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S964922AbWCWSDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:03:01 -0500
Message-ID: <4422E2DA.7050305@aknet.ru>
Date: Thu, 23 Mar 2006 21:03:06 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>	 <4422318C.407@aknet.ru> <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>
In-Reply-To: <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

[ adding LKML to CC and removing akpm as this went into a
discussion phase apparently ]

Dmitry Torokhov wrote:
> Yes, I remember. And after re-reading all of it now I still see that
> he wasn't really happy with the solution.
Yes, neither did I, but there always should be some
compromiss if the better solution is not found. :)

>> Well, the main reason behind that change, is that there is a PC-Speaker
>> PCM driver/emulator, snd-pcsp, pending in an ALSA CVS. I can't get it
>> included in kernel before there is a way to disable the pcspkr driver.
> Why can't you? We have ALSA and OSS together in the kernel just fine.
But the pcspkr driver is not an OSS, it is an "input" driver.

> If you are concerned about both modules baing active at the same time
> do not let user compile pcspkr if snd_pcsp is selected for now.
The problem is that the snd-pcsp doesn't replace pcspkr. And if I do
what you say, whoever opted to use snd-pcsp, will no longer be able
to hear the console beeps, and that I find a disadvantage.
I myself do not like the console beeps, but some people will really
complain. So I'd like to find another solution if possible, and the
input solution looked quite what I needed.

>> only to disable it. OTOH, if someone loads pcspkr while snd-pcsp is
>> running, the input subsystem notifies snd-pcsp so that it can immediately
>> disable pcspkr, to not let it to harm even in that case.
> Does it? How does it do it? There is no "new driver" event in the
> input subsystem...
But I register an input handler, and whenever the pcspkr driver is
loaded, my "connect" handler is invoked, and from there I send an
SND_SILENT.

> No, I don't want SND_SPKR_STARTED either.
OK, how about something under a SYN_CONFIG then?

> What you need is a way to
> disable a certain driver somehow and I think it is a task that belongs
> to driver core, not input or any other individual subsystem.
But what if I just want to grab SND_BELL so that it is delivered
exclusively to my driver? Intuitively, I'd use the input subsystem
for that, but unfortunately it simply doesn't have that grabbing
capability (I asked Vojtech to be sure - he confirmed that there
is none). Be there such a capability, that would be excellent, no
hacks will be needed. But if I modify the pcspkr driver to disable
it directly via some function call, then snd-pcsp will always load
pcspkr, which is highly undesireable. I am not sure what did you
mean about the driver core though.

> Because
> next time you want to disable for example a framebuffer driver because
> you have written better one and you are back to square 1.
The difference is that the snd-pcsp and pcspkr drivers are doing the
completely different tasks. snd-pcsp doesn't absolete pcspkr - being
an ALSA driver it only plays sound, but doesn't do the console beeps,
thats the problem. Somehow I have to make sure they both can peacefully
co-exist. Making them mutually exclusive is bad, and making them
dependant (by calling into each other directly) is also rather bad.

