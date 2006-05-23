Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWEWXil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWEWXil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 19:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWEWXil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 19:38:41 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:26212 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932128AbWEWXil convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 19:38:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GmVQDW92Q5SdFmzHJX4nIA3SqcLAkkay1rr1j7vB8K1lgmyg+2oSYlFE2BDA+m6PYpK9v6X6FVZNEZZzZdgWFFVYKIxWdyG94tlBHq01OZTgXj4EHkI1SlSjg/igIqteBNPPxoDWRsFfAMANQeZHieOGnoFwYgf/TCBw6xv+a0s=
Message-ID: <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
Date: Tue, 23 May 2006 19:38:40 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>
In-Reply-To: <E1Fifom-0003qk-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <E1Fifom-0003qk-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
>
> > 1) Running the video ROM at boot to reset cards, emu86
>
> Jon, how many times am I going to have to tell you that this won't work?
> The video ROM is not always present on laptop hardware, and even when it
> is it may jump into sections of ROM that have vanished since boot.
> In the long run, graphics drivers need to know how to program cards from
> scratch rather than depending on 80x25 text mod being there for them.

1) I didn't put a lot of detail into the line item but you only need
to use the ROM to reset secondary cards on x86 architectures. Primary
cards are always initialized by the system BIOS so you don't need to
run their ROM on boot. I think the only way to get a secondary card
into a laptop is through a PCMCIA slot and I've only seen one PCMCIA
video card.

2) The ROM support in the kernel knows about the shadow RAM copy at
C000::0. When you request the ROM from a laptop video system it
returns a map to the shadow RAM copy, not to a physical ROM. You need
access to the shadow RAM copy to get to things the BIOS left there
when it ran.

So to add more detail,
Run the ROM on primary adapters if the arch is non-x86 and the ROM
contains x86 code.
Run the ROM on primary adapters on embedded systems if the system BIOS
doesn't do it.
Otherwise don't run a primary ROM. The kernel ROM API tracks primary
versus secondary for you.
Always run the ROM on secondary adapters. Secondary adapters don't
have the compressed laptop ROM problem.

When running the ROMs you will need to add code to manage the active
VGA device since both adapters will try and turn it on when their ROMs
are run.

You will also need to provide a mechanism to call out to userspace.
The userspace program will use vm86 or emu86 to run the ROM image.

The contents of the ROM image should be put back into the kernel using
the ROM copy APIs but no one has gotten that far yet. Video ROMs
assume they are running out of shadow RAM so they alter things and
leave pointers to what they found.

I can provide more detail on how to set all of this up if needed.

-- 
Jon Smirl
jonsmirl@gmail.com
