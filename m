Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUGLWj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUGLWj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUGLWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:39:57 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:26302 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S264045AbUGLWjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:39:54 -0400
Message-ID: <40F313A6.909@am.sony.com>
Date: Mon, 12 Jul 2004 15:41:42 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       karim@opersys.com, linux-kernel@vger.kernel.org,
       celinux-dev@tree.celinuxforum.org, tpoynor@mvista.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com> <200407102351.05059.dtor_core@ameritech.net> <40F0C8E8.2060908@opersys.com> <200407110019.14558.dtor_core@ameritech.net> <20040710222702.3718842e.akpm@osdl.org> <Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be> <20040711005156.1d6558dd.akpm@osdl.org> <20040711094128.A27649@mail.kroptech.com> <40F2DDFC.8010501@am.sony.com> <20040712153248.A3743@mail.kroptech.com>
In-Reply-To: <20040712153248.A3743@mail.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Mon, Jul 12, 2004 at 11:52:44AM -0700, Tim Bird wrote:
> 
>>Adam Kropelin wrote:
>>
>>>Here's a patch. It places the relevant information on the same line as
>>>bogomips and does so without encouraging anyone to fiddle with
>>>loops_per_jiffy and screw up their kernel. 
>>
>>The patch is missing the Kconfig piece.  Is the wording the
>>same as from your earlier patch?
> 
> 
> Andrew requested that the config option be removed, so there are no
> longer any changes to Kconfig.

Oh - I missed the change where preset_lpj is no longer initialized
from CONFIG_PRESET_LPJ.  I see it now.  I saw the comment from
Andrew, but thought he was talking about the first version of the
patch that had ifdefs.

Here's what Andrew Morton said:
> a) I don't see much point in making it configurable.  Just add the boot
>    option and be done with it.  The few hundred bytes of extra code will be
>    dropped from core anyway.
> 
>    The main reason for this is that most people won't turn on the config
>    option, so your new code could get accidentally broken quite easily. 
>    Plus it removes some ifdefs.

I have one or two arguments in favor of keeping the config option.
First, for embedded systems it is sometimes necessary to compile-in
the value. Unfortunately, not all architectures allow the
kernel command line to be compiled in. (It would be nice if they did,
but that's something to fix separately.)

The first restructuring of the patch that you did, I think addresses
the issues that Andrew raised.  There are now no ifdefs, and since the
core code doesn't drop away (and indeed can be turned on at boot time
if needed), I think the code is not susceptible to accidental breakage
like the first version was.  I think Andrew is right that the preset
code path won't get much testing outside of embedded circles, so it is
important that it be as simple as possible.

The only *code* change from the configurable to the config-less version
of the code is:

+static unsigned long preset_lpj = CONFIG_PRESET_LPJ;
   vs.
+static unsigned long preset_lpj;

Secondly, I was hoping to get the FASTBOOT menu in the kernel, because
CELF has a few more patches to submit that have the same theme as this
one.  (I realize this is not justification for making this option
configurable, per se.  If we need to push for this on a subsequent patch,
that's OK.)

If we do put the config option back in, then there's a mistake in the
wording that needs to be fixed.  The statement "loops_per_jiffy is
roughly BogoMips * 5000."  This is only true when HZ is 100.  This
statement should just be removed - the rest of the wording works
without it.

With regard to testing - everything worked as expected.  I think the
config option issue is the last thing to be resolved before recommending
that the patch be applied.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
