Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268406AbTAMW4x>; Mon, 13 Jan 2003 17:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268407AbTAMW4x>; Mon, 13 Jan 2003 17:56:53 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:1940 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268406AbTAMW4t>; Mon, 13 Jan 2003 17:56:49 -0500
Date: Mon, 13 Jan 2003 17:05:37 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, <ebiederm@xmission.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
In-Reply-To: <20030113221942.GB2423@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0301131658370.24477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


