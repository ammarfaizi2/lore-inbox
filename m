Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTANGUV>; Tue, 14 Jan 2003 01:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTANGUV>; Tue, 14 Jan 2003 01:20:21 -0500
Received: from [212.209.10.215] ([212.209.10.215]:36813 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S267456AbTANGUU>;
	Tue, 14 Jan 2003 01:20:20 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE61A@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>,
       "'Sam Ravnborg'" <sam@ravnborg.org>
Cc: "'Ingo Oeser'" <ingo.oeser@informatik.tu-chemnitz.de>,
       "'ebiederm@xmission.com'" <ebiederm@xmission.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Consolidate vmlinux.lds.S files
Date: Tue, 14 Jan 2003 07:27:55 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see no problem in wasting 12 more bytes on CRIS. We have an
ALIGN(8192) later in the file so the extra 12 bytes kind of 
disappears in the noise.

So, you don't have to make any special hacks for us. But
maybe it is still a good idea to keep it controllable
per arch? I don't know, it's up to you.

/Mikael (CRIS maintainer)


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Kai
Germaschewski
Sent: Tuesday, January 14, 2003 12:06 AM
To: Sam Ravnborg
Cc: Ingo Oeser; ebiederm@xmission.com; linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consolidate vmlinux.lds.S files


On Mon, 13 Jan 2003, Sam Ravnborg wrote:

> > I would suggest an approach like the following, of course showing only a 
> > first simple step.
> 
> But you do not deal with different alingment of the sections.
> I have not yet fully understood all the requirements, but wanted to
> keep the original ALIGN settings.
> In the patch you posted some architectures use ALIGN(4) {cris},
> other nothing, but most of them ALIGN(16).
> Is it OK to force them all to ALIGN(16) then?

Well, forcing them to a larger alignment surely won't break anything, 
except for wasting 12 bytes on cris. But in general, you're right, not of 
all of this is trivial to share due to these small differences. In the 
cases where it's necessary, we could do something like

(for CRIS)
#define EXTABLE_ALIGN 4

(in generic code)
#ifndef EXTABLE_ALIGN
#define EXTABLE_ALIGN 16
#endif

Of course, one could also do EXTABLE(4) and EXTABLE(16), respectively, but 
I think it's less obvious to the occasional reader that these magic 
numbers are about alignment.

> > A series of steps like this should allow for a serious 
> > reduction in size of arch/*/vmlinux.lds.S already, while being obviously 
> > correct and allowing archs to do their own special thing if necessary (in 
> > particular, IA64 seems to differ from all the other archs).
> 
> My main objective was that adding new stuff, like __gpl_ksyms could
> be done in one place only.
> Or .gnu.linkonce.vermagic, or whatever will be used for that.

Yes, and that's why I think that separating out and sharing these bits is 
a very good idea. Actually, separating out the ksymtab etc code should be 
really easy, as opposed to other stuff where there's more substantial 
differences between the archs.

It'll be a rather long and tedious process to do this work, but I think 
it's worth it.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
