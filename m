Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSGQHLp>; Wed, 17 Jul 2002 03:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSGQHLo>; Wed, 17 Jul 2002 03:11:44 -0400
Received: from ftp.mips.com ([206.31.31.227]:9407 "EHLO mx2.mips.com")
	by vger.kernel.org with ESMTP id <S318170AbSGQHLm>;
	Wed, 17 Jul 2002 03:11:42 -0400
Message-ID: <3D35194D.E880DDDA@mips.com>
Date: Wed, 17 Jul 2002 09:14:21 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Ralf Baechle <ralf@oss.sgi.com>,
       GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Add sys/personality (Re: Personality)
References: <3D33DAB2.353A4399@mips.com> <20020716123632.B17038@dea.linux-mips.net> <20020716090728.A22128@lucon.org> <3D347120.B9CAFF75@mips.com> <20020716190814.A31309@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" wrote:

> On Tue, Jul 16, 2002 at 09:16:48PM +0200, Carsten Langgaard wrote:
> > Thanks.
> > Now that we are at it, what should personality return in case it's called with a
> > value, which isn't defined in the personality.h file.
> > Should it return -EINVAL ?
> > I don't think, that is the case at the moment, I believe you can set personality
> > to anything.
> >
>
> Like this?
>

No, I don't think the patch is correct.
I don't know how this actually should work, maybe someone who do know can help out
here.
But it look like the idea is, that we have a default execution domain (linux), which
have pers_low = 0 (PER_LINUX) and pers_high = 0.
If one want other execution domains, one much call the register_exec_domain to
register the execution domain and personality.
So if personality is call with a value that isn't register, it then accept the
personality and sets the execution domain to the default settings (which is linux).
So the question is should personality, return -EINVAL, if it got a personality value
which hasn't been registered or should it accept the personality, but set the
execution domain to the default setting ?
If the later is true, should it also accept values outside the values defined in the
personality.h file ?

So what should the following user calls return, if not registered in the kernel?

personality(PER_BSD):
personality(0x47):

Could someone with a better understand than I, please comment this.

>
> H.J.
> ---
> --- kernel/exec_domain.c.per    Mon Jun 10 10:05:27 2002
> +++ kernel/exec_domain.c        Tue Jul 16 19:06:13 2002
> @@ -223,7 +223,8 @@ sys_personality(u_long personality)
>
>         if (personality != 0xffffffff) {
>                 set_personality(personality);
> -               if (current->personality != personality)
> +               if (personality < current->exec_domain->pers_low
> +                   || personality > current->exec_domain->pers_high)
>                         return -EINVAL;
>         }
>

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



