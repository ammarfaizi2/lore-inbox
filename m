Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271024AbUJUWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271024AbUJUWgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271047AbUJUWdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:33:03 -0400
Received: from fmr05.intel.com ([134.134.136.6]:46285 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271024AbUJUW3Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:29:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 15:28:54 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600328792F@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS3Zm7OX+tqTtM6RvaJGLFgx7c0OQAVtRig
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Kendall Bennett" <KendallB@scitechsoft.com>,
       "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>, <linux-fbdev-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 21 Oct 2004 22:28:56.0042 (UTC) FILETIME=[5A086CA0:01C4B7BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>>         pushl   $0                                           
>   # Kill any dangerous flags
>>         popfl
>> 
>>         movl    real_magic - wakeup_code, %eax
>>         cmpl    $0x12345678, %eax
>>         jne     bogus_real_magic
>> 
>>         testl   $1, video_flags - wakeup_code
>>         jz      1f
>>         lcall   $0xc000,$3
>
>The call to 0xC000:0x0003 is the entry point to POST the card. However 
>for PCI cards you need to make sure that AX is loaded with the 
>bus, slot 
>and function for the card that is being POST'ed. It will pass 
>this value 
>to the PCI BIOS Int 0x1A functions in order to find itself, so 
>if this is 
>not set many BIOS'es will not work.
>
>The rest of the code you have above seems superfluous to me as we have 
>never needed to do that. Then again we boot the card using the BIOS 
>emulator, which is different because it runs within a 
>protected machine 
>state.
>
>Have you taken a look at the X.org code? They have code in 
>there to POST 
>the video card also (either using vm86() or the BIOS emulator).
>

I have done some experiments with this video post stuff.
I think this should be done using x86 emulator rather than doing 
in real mode. The reason being, with an userlevel emulator we can call
it at different times during resume. The current real mode videopost
does 
it before the driver has restored the PCI config space. Some systems 
(mostly the ones with Radeon card) requires this to be done after 
PCI config space is restored. With a userspace emulator, we can 
call it at various places during the driver restore.

I have seen the SciTech's x86 emulator in X.org. I could seperate it out

from X into a stand alone application that does x86 emulation. I use it
to get 
the video back on my laptop (which has radeon card), by calling this
user level 
emulator using usermodehelper call. I hope we will have x86 emulator
sitting in 
a standard place in userspace. That way we can use it in driver restore
and 
solve the S3 video restore problem in a more generic way.

Thanks,
Venki
