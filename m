Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266882AbUGLQAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUGLQAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUGLQAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:00:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:53914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266882AbUGLP7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:59:53 -0400
Date: Mon, 12 Jul 2004 08:59:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@didntduck.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Grzegorz Kulewski <kangur@polcom.net>, Con Kolivas <kernel@kolivas.org>,
       Matthias Andree <matthias.andree@gmx.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: post 2.6.7 BK change breaks Java?
In-Reply-To: <40F28628.2030303@quark.didntduck.org>
Message-ID: <Pine.LNX.4.58.0407120852070.1764@ppc970.osdl.org>
References: <40EEB1B2.7000800@kolivas.org> <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.56.0407111713420.23979@jjulnx.backbone.dif.dk>
 <Pine.LNX.4.58.0407111728580.6988@alpha.polcom.net>
 <Pine.LNX.4.56.0407111735490.23998@jjulnx.backbone.dif.dk>
 <8A43C34093B3D5119F7D0004AC56F4BC082C7F9D@difpst1a.dif.dk>
 <40F20372.9000205@quark.didntduck.org> <40F20C23.9050705@quark.didntduck.org>
 <Pine.LNX.4.56.0407121256270.24702@jjulnx.backbone.dif.dk>
 <40F28628.2030303@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jul 2004, Brian Gerst wrote:
> 
> I see Linus commited a changeset that avoids a tailcall from this 
> function, which messes up the stack if CONFIG_REGPARM=n.  Specifically, 
> it clobbers %edx in the pt_regs image

Yes. 

There's more information about why this is needed in the commit message,
but it basically boils down to an optimization in the system call path
where the save-register-area is used _directly_ as the system call
argument frame on the stack. It's a very worthwhile optimization, since it 
works very well in 99% of all cases and it makes a very hot path faster, 
but gcc thinking that the callee owns the arguments has bitten us before, 
and there is no way to tell gcc that it is wrong.

Personally, I think that if you wanted the callee to own the arguments, 
you should use the "stdcall" attribute, which _literally_ is all about the 
callee owning the stack (and can often generate better code for _other_ 
reasons than tail-calls), but lacking that, I'd have preferred some other 
explicit way to tell gcc about the special "asmlinkage" rules.

No such way exists, so I just fooled gcc by hand. Ugly.

		Linus
