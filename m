Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967790AbWLDX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967790AbWLDX0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967759AbWLDX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:26:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:26344 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967810AbWLDX0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:26:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kLT3iaTaPNOFfRcFVzmyasdh/8Cp4beGpv7r7YWmzsVivfIpmSCQRcMUrV0SbaOJ2DND99EYqaoBDcjxm/vEqYsQd5SPFg6ZNufY/Yee44F+OsILYcu0kfU5rC76Nc4awjRjG1MsL8zS3nS1U6znYnU2vLSpsSDw7NPi59S4tlw=
Message-ID: <4807377b0612041526k1bace33ag5d4f75826716a87@mail.gmail.com>
Date: Mon, 4 Dec 2006 15:26:11 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: Re: Intel 82559 NIC corrupted EEPROM
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com, bunk@stusta.de, jgarzik@pobox.com,
       saw@saw.sw.com.sg
In-Reply-To: <45704001.9040108@privacy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com>
	 <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net>
	 <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com>
	 <45533801.7000809@privacy.net>
	 <4807377b0611291055o6e28c66ft9edeb3c8363dd49b@mail.gmail.com>
	 <45704001.9040108@privacy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, John <me@privacy.net> wrote:
> > can you try adding mdelay(100); in e100_eeprom_load before the for loop,
> > and then change the multiple udelay(4) to mdelay(1) in e100_eeprom_read
>
> I applied the attached patch.
>
> Loading the driver now takes around one minute :-)

ouch, but yep, thats what happens when you use "super extra delay"

> I ran 'source load_unload' 25 times in a loop.
>
> The first 12 times were successful. The last 13 times failed.
> (cf. attached archive)
>
> I noticed something very strange.
>
> The number of words obviously in error (0xFFFF) returned by the EEPROM
> on 00:09.0 is not constant.

That is very strange, I would think that maybe you have something else
on the bus with the e100 that may be hogging bus cycles you have
failing hardware (maybe a bad eeprom, or possibly a bad mac chip)

> $ grep -c 0xFFFF insmod*
> insmod_300.txt:0
> insmod_301.txt:0
> insmod_302.txt:0
> insmod_303.txt:0
> insmod_304.txt:0
> insmod_305.txt:0
> insmod_306.txt:0
> insmod_307.txt:0
> insmod_308.txt:0
> insmod_309.txt:0
> insmod_310.txt:0
> insmod_311.txt:0
> insmod_312.txt:1
> insmod_313.txt:5
> insmod_314.txt:24
> insmod_315.txt:45
> insmod_316.txt:243
> insmod_317.txt:256
> insmod_318.txt:256
> insmod_319.txt:256
> insmod_320.txt:256
> insmod_321.txt:256
> insmod_322.txt:256
> insmod_323.txt:253
> insmod_324.txt:240

this is even stranger, does it cycle back down (sine wave) to zero
again?  The delays did seem to work, at least sometimes.  This
indicates that something needs that extra delay to successfully read
the eeprom.  I might try changing all the udelay(4) to udelay(40) (x10
increase) and see if that gives you a happy medium of "most times
driver loads without error"

John, this problem seems to be very specific to your hardware.  I know
that you have put in a lot of time debugging this, but I'm not sure
what we can do from here.  If this were a generic code problem more
people would be reporting the issue.

What would you like to do?  At this stage I would like e100 to work
better than it is, but I'm not sure what to do next.

Thanks for your patience on this issue,
  Jesse
