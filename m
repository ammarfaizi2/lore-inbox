Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbTCPCnO>; Sat, 15 Mar 2003 21:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbTCPCnO>; Sat, 15 Mar 2003 21:43:14 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:23745 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262100AbTCPCnN>; Sat, 15 Mar 2003 21:43:13 -0500
Date: Sat, 15 Mar 2003 20:53:56 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <colpatch@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NUMAQ subarchification
In-Reply-To: <1047750799.1964.72.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0303152036250.27065-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Mar 2003, James Bottomley wrote:

> It is the place designed for code belonging only to one subarch.
> 
> > Last time I looked (and I don't think anyone has fixed it since) 
> > it requires copying files all over the place, making an unmaintainable
> > nightmare. Either subarch needs fixing first, or we don't use it.

I agree that duplicating files into different subarch dirs sure isn't the 
way to go.

> The problem you have (your setup.c and topology.c are identical to the
> default) was originally going to be solved using VPATH.  Unfortunately,
> that got broken along the way in the new build scheme, so the best I
> think you can do is add this to the summit Makefile

I think VPATH has never been meant to be used for anything like this, it 
could be make to work, though it would interfere with the separate src/obj 
thing. But I don't think it's a good idea, we'll have object files 
magically appear without any visible source file, that's just too obscure.

I can basically see two options at this point:

> $(obj)/setup.c: $(src)/../mach-default/setup.c
> 	cat $< $@

Something like this, but using ln -sf would be nicer, since that avoids 
someone editing the wrong file by mistake.

Or:

Make the build enter mach-default always. However, make compilation of
setup.c and topology.c conditional on CONFIG_X86_DEFAULT_SETUP and
CONFIG_X86_DEFAULT_TOPOLOGY (or combine those two into one config
variable). Then, you'll have to deal with those two variables explicitly
from Kconfig. Basically, set them to n for voyager and visws, y otherwise.

Yes, that means changing another line in Kconfig when you add a new 
subarch, but that doesn't happen all that frequently. And it's sure better 
than crashes on boot because your setup.c disappeared after a bk commit 
and the build chose to use the mach-default one instead...

--Kai


