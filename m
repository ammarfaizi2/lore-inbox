Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262811AbTCKEQf>; Mon, 10 Mar 2003 23:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTCKEQf>; Mon, 10 Mar 2003 23:16:35 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262811AbTCKEQc>;
	Mon, 10 Mar 2003 23:16:32 -0500
Message-ID: <33000.4.64.238.61.1047356833.squirrel@www.osdl.org>
Date: Mon, 10 Mar 2003 20:27:13 -0800 (PST)
Subject: Re: reducing stack usage in v4l?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rddunlap@osdl.org>
In-Reply-To: <20030305073437.0673458e.rddunlap@osdl.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
        <87u1eigomv.fsf@bytesex.org>
        <20030305093534.A8883@flint.arm.linux.org.uk>
        <20030305073437.0673458e.rddunlap@osdl.org>
X-Priority: 3
Importance: Normal
Cc: <rmk@arm.linux.org.uk>, <kraxel@bytesex.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 5 Mar 2003 09:35:34 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
>
> | On Wed, Mar 05, 2003 at 10:15:52AM +0100, Gerd Knorr wrote:
> | > But when looking at the disasm output it is obvious that it isn't true |
>> (at least with gcc 3.2).  On the other hand it is common practice in | >
> many drivers, there must be a reason for that, no?  Any chance this | > used
> to work with older gcc versions?
> |
> | I don't believe so - I seem to remember looking at gcc 2.95 and finding |
> the same annoying behaviour.

AFAIK we have no reason to believe that this will work and we have
counter-examples of it continuing to be a problem.

> Yes, that's what I'm seeing with 2.96 as well.
>
> | > Not sure what is the best idea to fix that.  Don't like the kmalloc | >
> idea that much.  The individual structs are not huge, the real problem | >
> is that many of them are allocated and only few are needed.  Any | > chance
> to tell gcc that it should allocate block-local variables at | > the start
> block not at the start of the function?

Not that anyone has mentioned here.

> | Not a particularly clean idea, but maybe creating a union of the |
> structures and putting that on the stack? (ie, doing what GCC should | be
> doing in the first place.)

I looked into this.  The various structures are used in a variety
of combinations, so this method looks bad IMO.

> That's an idea.  Or make separate called functions for each ioctl and
> declare the structures inside them?

and this method looks like a possibility.

Gerd, Andrew says that the kmalloc() time will be small compared to
the memset()'s that the function is already doing.

Do you want to do anything about this, or want me to, or want me
to drop it?

> --
>
> Here are some v4l structure sizes from gcc 2.96 on a P4:
>
> sizeof v4l2_audio: 52
> sizeof v4l2_buffer: 68
> sizeof v4l2_capability: 104
> sizeof v4l2_fmtdesc: 64
> sizeof v4l2_format: 204
> sizeof v4l2_framebuffer: 44
> sizeof v4l2_frequency: 44
> sizeof v4l2_input: 76
> sizeof v4l2_queryctrl: 68
> sizeof v4l2_requestbuffers: 20
> sizeof v4l2_tuner: 84
> -

And here's a summary of how they are used together:

sizeof v4l2_audio: 52		+ queryctrl:68 + tuner:84 / +tuner:84
sizeof v4l2_buffer: 68		+ format:204 / alone
sizeof v4l2_capability: 104	+ framebuffer:44
sizeof v4l2_framebuffer: 44	+ capability:104 / + format:204
sizeof v4l2_frequency: 44	alone
sizeof v4l2_fmtdesc: 64		+ format:204
sizeof v4l2_format: 204		+ fmtdesc:64 / + buffer:68
sizeof v4l2_input: 76		alone / alone
sizeof v4l2_queryctrl: 68	+ audio:52 + tuner:84
sizeof v4l2_tuner: 84		alone / + audio:52 + queryctrl:68 / + audio:52

~Randy



