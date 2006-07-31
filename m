Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWGaVsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWGaVsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWGaVsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:48:15 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:41155 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1030479AbWGaVsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:48:14 -0400
Message-ID: <44CE7A9B.8020508@dgreaves.com>
Date: Mon, 31 Jul 2006 22:48:11 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>	<20060730124139.45861b47.akpm@osdl.org>	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>	<17613.16090.470524.736889@cse.unsw.edu.au> <ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
In-Reply-To: <ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Oliva wrote:
> On Jul 30, 2006, Neil Brown <neilb@suse.de> wrote:
> 
>>  1/
>>     It just isn't "right".  We don't mount filesystems from partitions
>>     just because they have type 'Linux'.  We don't enable swap on
>>     partitions just because they have type 'Linux swap'.  So why do we
>>     assemble md/raid from partitions that have type 'Linux raid
>>     autodetect'? 
> 
> Similar reason to why vgscan finds and attempts to use any partitions
> that have the appropriate type/signature (difference being that raid
> auto-detect looks at the actual partition type, whereas vgscan looks
> at the actual data, just like mdadm, IIRC): when you have to bootstrap
> from an initrd, you don't want to be forced to have the correct data
> in the initrd image, since then any reconfiguration requires the info
> to be introduced in the initrd image before the machine goes down.
> Sometimes, especially in case of disk failures, you just can't do
> that.
> 
This debate is not about generic autodetection - a good thing (tm) - but
 in-kernel vs userspace autodetection.

Your example supports Neil's case - the proposal is to use initrd to run
mdadm which thne (kinda) does what vgscan does.


> 
>> So my preferred solution to the problem is to tell people not to use
(in kernel)
>> autodetect.  Quite possibly this should be documented in the code, and
>> maybe even have a KERN_INFO message if more than 64 devices are
>> autodetected. 
> 
> I wouldn't have a problem with that, since then distros would probably
> switch to a more recommended mechanism that works just as well, i.e.,
> ideally without requiring initrd-regeneration after reconfigurations
> such as adding one more raid device to the logical volume group
> containing the root filesystem.
That's supported in today's mdadm.

look at --uuid and --name

>> So:  Do you *really* need to *fix* this, or can you just use 'mdadm'
>> to assemble you arrays instead?
> 
> I'm not sure.  I'd expect not to need it, but the limited feature
> currently in place, that initrd uses to bring up the raid1 devices
> containing the physical volumes that form the volume group where the
> logical volume with my root filesystem is also brings up various raid6
> physical volumes that form an unrelated volume group, and it does so
> in such a way that the last of them, containing the 128th fd-type
> partition in the box, ends up being left out, so the raid device it's
> a member of is brought up either degraded or missing the spare member,
> none of which are good.
> 
> I don't know that I can easily get initrd to replace nash's
> raidautorun for mdadm unless mdadm has a mode to bring up any arrays
> it can find, as opposed to bringing up a specific array out of a given
> list of members or scanning for members.  Either way, this won't fix
> the problem 2) that you mentioned, but requiring initrd-regeneration
> after extending the volume group containing the root device is another
> problem that the current modes of operation of mdadm AFAIK won't
> contemplate, so switching to it will trade one problem for another,
> and the latter is IMHO more common than the former.
> 

I think you should name your raid1 (maybe "hostname-root") and use
initrd to bring it up by --name using:
 mdadm --assemble --scan --config partitions --name hostname-root


It could also, later in the boot process, bring up "hostname-raid6" by
--name too.
 mdadm --assemble --scan --config partitions --name hostname-raid6

David


-- 
