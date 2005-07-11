Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVGKWPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVGKWPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVGKWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:13:29 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:41893 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262795AbVGKV6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:58:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=XA6CFZRoQ8XyahEQvXgNCf0FKJeOj7ibKdSJkP26c0VWp66ljsddV7RX3kEnaCfilCtMwqaRjVNgezsoGUFZ4YnxfNeqxiwbMyS3gvgjJWD9a6y5L/hxhajwHy5tLlOJjPdqdWqaWF7BwT5SHQk1pBb5A3XJp4r2T/H76JKDF6E=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>, jdike@addtoit.com
Subject: Re: [uml-devel] Re: [patch 1/1] uml: fix lvalue for gcc4
Date: Tue, 12 Jul 2005 00:05:14 +0200
User-Agent: KMail/1.8.1
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20050709110143.D59181E9EA4@zion.home.lan> <20050709120703.C2175@flint.arm.linux.org.uk>
In-Reply-To: <20050709120703.C2175@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120005.14985.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 July 2005 13:07, Russell King wrote:
> On Sat, Jul 09, 2005 at 01:01:33PM +0200, blaisorblade@yahoo.it wrote:
> > diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue
> > arch/um/sys-x86_64/signal.c ---
> > linux-2.6.git/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07
> >-09 13:01:03.000000000 +0200 +++
> > linux-2.6.git-paolo/arch/um/sys-x86_64/signal.c	2005-07-09
> > 13:01:03.000000000 +0200 @@ -168,7 +168,7 @@ int
> > setup_signal_stack_si(unsigned long
> >
> >  	frame = (struct rt_sigframe __user *)
> >  		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
> > -	((unsigned char *) frame) -= 128;
> > +	frame -= 128 / sizeof(frame);
>
> Are you sure these two are identical?
SOOOOOOOOORRY, I've become crazy, I meant sizeof(*frame)... thanks for 
noticing.

> The above code fragment looks suspicious anyway, particularly:
>
>  	frame = (struct rt_sigframe __user *)
>  		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
>
> which will put the frame at 8 * sizeof(struct rt_sigframe) below
> the point which round_down() would return (which would be 1 struct
> rt_sigframe below stack_top, rounded down).

You're completely right.

The code is copied from arch/x86_64/kernel/signal.c:setup_rt_frame(), so it 
should make some sense; but in the source, the cast is to (void*).

Surely Jeff, seeing that the result is assigned to a struct rt_sigframe 
__user, "fixed" it. The line I'm patching is new from Jeff, and I don't know 
what's about (I just remember that 

Also, the below access_ok() called on fp (which is still NULL) is surely 
completely wrong, though it won't fail (after all, NULL is under TASK_SIZE. 
right?).

On x86_64 the code is always used from arch/um/kernel/signal_kern.c, since 
CONFIG_whatever is not enabled.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
