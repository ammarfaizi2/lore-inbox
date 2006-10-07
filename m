Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932892AbWJGXg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbWJGXg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932893AbWJGXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 19:36:27 -0400
Received: from smtpout.mac.com ([17.250.248.174]:13023 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932892AbWJGXg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 19:36:26 -0400
In-Reply-To: <20061007182708.GB5937@uranus.ravnborg.org>
References: <20061007131731.GC29920@ftp.linux.org.uk> <4527C2F7.2010102@garzik.org> <20061007182708.GB5937@uranus.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8A7DAE34-9F83-44FF-A24A-F4A62C37DC36@mac.com>
Cc: Jeff Garzik <jeff@garzik.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] minimal alpha pt_regs fixes
Date: Sat, 7 Oct 2006 19:35:58 -0400
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 07, 2006, at 14:27:08, Sam Ravnborg wrote:
> It would be even more simple and future proof if we could in some  
> way do it so "#include <foo/bar.h>" would pick up bar.h from asm-$ 
> (ARCH) if it exists and otherwise pick up asm-generic/bar.h.
>
> Then we could include the generic one in asm-generic and all  
> architectures would include it except those that provide their own  
> variant. The asm-$(ARCH) specific files would need a way to include  
> the asm-generic version.
>
> I have no idea handy for how to actually implement this but wanted  
> just to share the idea. The trade-off is that if it gets too  
> implicit then suddenly users will loose overview of how it works.

Well if we changed the include dir to look like this:

   include/linux/bar.h
   include/asm/foo.h
   include/asm-powerpc/asm/foo.h
   include/asm-frv/asm/foo.h doesn't exist, defaults to generic version.

Then I suppose you could carefully order the -I directives like this:

   gcc [...] -Iinclude/asm-$(ARCH) -Iinclude [...]

The problem with that is if you only want to partially override asm/ 
foo.h, and include it from your arch-specific version.  I guess to  
solve that you could also do this:

   include/linux/bar.h
   include/asm-generic/asm/foo.h
   include/asm-powerpc/asm/foo.h
   include/asm-frv/asm/foo.h doesn't exist, defaults to generic version.

And:

   gcc [...] -Iinclude/asm-$(ARCH) -Iinclude/asm-generic -Iinclude [...]

Then you it would be possible to selectively override any headers you  
wanted too.  It also gets rid of that nasty symlink problem.  The  
only remaining trick would be teaching "headers_check" and  
"headers_install" about it.

Cheers,
Kyle Moffett

