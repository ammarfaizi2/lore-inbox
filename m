Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbSLSDCT>; Wed, 18 Dec 2002 22:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbSLSDCT>; Wed, 18 Dec 2002 22:02:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:61652 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267490AbSLSDCR>; Wed, 18 Dec 2002 22:02:17 -0500
Date: Wed, 18 Dec 2002 19:10:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with
 more than 8 CPUs 
Message-ID: <724320000.1040267406@titus>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E192@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E192@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if I'm somewhat jumpy - bear in mind that I've burnt a lot of 
hours
and torn out hair recently breaking up all the Summit patches (which I sent
you, but aren't generally published in their entirety yet). I've also got a
hell of a lot of time invested in making this area of code work as it is 
now ;-)
(as have others). Going through another iteration isn't top on my list of
favourite things to do right now ... what you're trying to do does actually 
seem
sane in general, I'm just not sure I like the method - probably fairly easy 
to
fix.

As a general approach thing, it would be much smoother if you took the path
of trying to make it totally obvious that whatever you're trying to change
doesn't hurt anyone else. Part of that is small easily readable patches,
part of that is choosing your constructs carefully, explaining what you're
doing and why it's safe, and not turning changes on by default ;-)

> 					numaq		summit/			all other
> 							other >8 CPU system	systems
> -------------------------------------------------------------------------
> ----- clustered_apic_mode		CLUSTERED	CLUSTERED			NONE
> configured_platform_type	NUMAQ		NONE				NONE
> -------------------------------------------------------------------------

OK, so you still seem to have a tristate here. What does this gain us over
the existing scheme?

clustered_apic_mode == CLUSTERED_APIC_NUMAQ   (equiv CLUSTERED / NUMAQ)
clustered_apic_mode == CLUSTERED_APIC_XAPIC   (equiv CLUSTERED / NONE)
clustered_apic_mode == CLUSTERED_APIC_NONE    (equiv NONE / NONE)

Or are their other situations you haven't outlined above?

> ----- Note that in the patch, wherever I said NUMA, I actually meant
> NUMAQ. I think I lost that Q, while I was trying to reduce the length of
> this variable  (CONFIGURED_PLATFORM_NUMAQ) :). Sorry about all the
> resulting confusion. Doing a  search and replace of NUMA by NUMAQ on my
> patch right now.

Cool, that starts to make a little more sense to me now then ...

> Noticeable changes here are
> - summit using CLUSTERED in place of XAPIC(Physical destination).
> - use "configured_platform_type" it basically separate out numaq specific
> stuff   (like, waking up the CPUs through NMI), from the generic cluster
> apic support.

Right ... that's all my fault. I started off with clustered_apic_mode as
a simple boolean switch to represent the P3's clustered apic mode ... then
abused it for anything NUMA-Q specific. Stuff that's numaq specific should
be changed to something like "if (x86_numaq)" instead of "if 
(clustered_apic_mode == ...)".
If we only have one platform type, it's going to make much more readable 
code
to just use a boolean here. Somewhere in a header file (where 
clustered_apic_mode
is defined):

#ifdef CONFIG_X86_NUMAQ
#define x86_numaq (1)
#else
#define x86_numaq (0)
#endif

Just makes the resultant c-code easier to read, and shoves all the ifdefs 
in a
header file. I used to think that people complaining about ifdefs in code 
was
annoying, but having tried to read the results of ifdef hell ... I rapidly 
came
to the conclusion they're right ... the whole apic handling code area is 
enough to
make your head hurt even if it's as readable as possible ;-)

I can't deny that the current code has a few problems re style and 
cleanliness ...
I've been off doing 2.5 for ages, and that will be pretty clean after it's
broken into subarch.

> We are trying to use a common APIC destination mode for all systems with
> more than 8 CPUs. This is by having the logical clusters of the CPUs. I
> am hoping that this mode works fine on summit. Another option is to allow
> summit to continue using  physical mode, if there is any binding reason
> to do so. But anyway NUMAQ specific stuff has to be separated from
> cluster APIC stuff.

Look at the 2.5 summit stuff I sent you - I think 2.5 uses logical on 
Summit.
Historical split ... don't ask.

>> You seem to have lost turning on CONFIG_X86_NUMA.
>
> I dont see CONFIG_X86_NUMA getting used anywhere in 2.4.21-pre1. Am I
> missing something here??

I think it's used in some patches floating around ... as a general rule,
please don't delete stuff as cleanups at the same time as adding new 
features,
the resultant tangle is very hard to verify correct (I have the scars from
trying to untangle such things, and they're fresh and they hurt ;-))

>> Errrm ... on by default?
>
> I was just trying to be little ambitious :). Will remove that now..

Cool ;-)

>> And that was off before for NUMA-Q ... you seem to have turned it on.
>> Unless you've inverted the meaning of clustered_apic_mode, which is
>> going to confuse the hell out of everyone?
>
> NO. This check is happening inside calculate_ldr() routine, and NUMAQ
> never comes to calculate_ldr(), as (according to the comments), it is the
> BIOS that programs  LDR in NUMAQ. So only thing we have to worry about in
> calculate_ldr() is  non-NUMAQ systems.

I don't have a view in front of me, but the fact there's a
"if (clustered_apic_mode != CLUSTERED_APIC_NUMAQ)" in there right now
makes me suspect it's needed. It's *possible* it's unneeded, but I'm
suspicious.

> I am trying to get the stuff which are _only_ specific to NUMAQ, under
> "platform type" check. And the stuff specific to cluster APIC setup under
> "apic mode" check.

See above ... I'm not sure you need anything this invasive to do what you
want. However, I do have a better idea what you're trying to do now ;-)

> Can you please review the complete patch now. I am not sure whether my
> explaination  was clear enough. Let me know if have any questions.

I'll try to go through the updated one when you send it. Hint: smaller
patches with explanations of why they're safe are much easier to read.
Andrew Morton has managed to beat this lesson into me after a while ;-)

M.

