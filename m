Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263493AbTCNUjr>; Fri, 14 Mar 2003 15:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263495AbTCNUjr>; Fri, 14 Mar 2003 15:39:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57094 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263493AbTCNUjk>; Fri, 14 Mar 2003 15:39:40 -0500
Message-ID: <3E723ECD.8010000@zytor.com>
Date: Fri, 14 Mar 2003 12:42:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: Kernel setup() and initrd problems
References: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de> <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu> <b4t9i6$eon$1@cesium.transmeta.com> <3E722D31.6050702@nortelnetworks.com> <3E7230D2.7010309@zytor.com> <3E7235B7.5050407@nortelnetworks.com>
In-Reply-To: <3E7235B7.5050407@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> H. Peter Anvin wrote:
> 
>> Chris Friesen wrote:
>>
>>>
>>> Below is the script that I used to pivot from a standard ramdisk (for
>>> with
>>> the infrastructure is already in place in our build environment) to a
>>> tmpfs
>>> filesystem.  This requires no changes to the boot args.
> 
> 
>> ... which means that you either have boot args or rdev so that
>> /dev/ram0 is the root filesystem (or it wouldn't work.)
> 
> 
> Yes, but after the pivot, /dev/ram0 isn't the real filesytem, its tmpfs
> mounted at /.  Isn't that what the original poster was talking about,
> where the root on the final running system is not the same as what the
> machine was booted with?
> 
> Maybe I'm just confused.
> 

I think so.

The fundamental problem is that the original initrd protocol considered
the initrd to be something different than "a real root", and its init
(linuxrc) to be something different than "a real init."

With pivot_root, all of that is historical baggage, and worse - it gets
in the way.

The way to get around the historical baggage is to tell the kernel that
the initrd is a "permanent" initrd by using the "root=/dev/ram0"
command-line option.  This has the side effect of bypassing all the
initrd historical crap and instead spawning /sbin/init using PID 1, like
any other system would do.  Now you can just pivot and "exec /sbin/init"
like you should be.

Of course, after the pivot_root, the root is something completely
different than the root= command-line option states, but that's
irrelevant.  The command-line option is there to disable the initrd
historical garbage, not for any other purpose.

	-hpa

