Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUIUR0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUIUR0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUIUR0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:26:47 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:49796 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267792AbUIUR0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:26:44 -0400
Date: Tue, 21 Sep 2004 19:26:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921172625.GA30425@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095785315.6307.6.camel@tdi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +   Evaluating the first 4 bytes of the return buffer shows this is an
> +ACPI_TYPE_STRING structure.  Using the string entry from the union, the
> +next 4 bytes provides the length of the string (0x14 = 20 bytes).  Finally,
> +this data type uses a pointer to a buffer to provide the actual data.  As
> +seen in the output, the 8 byte pointer value (ia64 system) has been replaced
> +by a buffer offset.  Therefore, the 20 byte char array starts at offset
> +0x18 in the buffer.
> +
> +   The return value for commands is dependent on the command issued.
> +The version command returns an acpi_object to facilitate synchronizing
> +the size of a union acpi_object between kernel and user space.  The type
> +commands simple return an acpi_object_type value.  Current available
> +commands include:
> +
> +/* Get version, returned in union acpi_object (integer) struct */
> +#define VERSION                 0x0
> +/* Get the type of the object (Integer, String, Method, etc...) */
> +#define GET_TYPE                0x1
> +/* Get the type of the parent to the object (Device, Processor, etc...) */
> +#define GET_PTYPE               0x2
> +
> +   Commands are issued by writing the following data structure to the ACPI
> +object file:
> +
> +struct special_cmd {
> +        u32                     magic;
> +        unsigned int            cmd;
> +        char                    *args;
> +};

Talk to Andi Kleen; passing such structures using read/write is evil,
because (unlike ioctl) there's no place to put 32/64bit
translation. Imagine i386 application running on x86-64 system.

> +   NOTE: ACPI methods have a purpose.  Randomly calling methods without
> +knowing their side-effects will undoubtedly cause problems.  ACPI objects
> +like _HID, _CID, _ADR, _SUN, _UID, _STA, _BBN should always be safe to
> +evaluate.  These simply return data about the object.  Methods like
> +_ON_, _OFF_, _S5_, etc... are meant to cause a change in the system and
> +can cause problems.  The ACPI sysfs module makes an attempt to hide some
> +of the more dangerous interfaces, but it not fool-proof.  DO NOT randomly
> +read files in the ACPI namespace unless you know what they do.

Hmm, reading file causing side-effects is not nice, either. I can see
some backup tools doing that by mistake. Heh, even I might want to
backup my system with tar, and it should not screw my system too badly
if I forgot --exclude /sys...

Perhaps ioctl is really right thing to use here? read() should not
have side effects and it solves 32/64 bit problems.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
