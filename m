Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTBIWnb>; Sun, 9 Feb 2003 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBIWna>; Sun, 9 Feb 2003 17:43:30 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:1285 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267458AbTBIWn3>; Sun, 9 Feb 2003 17:43:29 -0500
Date: Sun, 9 Feb 2003 23:53:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Baudis <pasky@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kconfig] Direct use of lxdialog routines by menuconfig
 (v3)
In-Reply-To: <20030205030104.GK10207@pasky.ji.cz>
Message-ID: <Pine.LNX.4.44.0302092321270.1336-100000@serv>
References: <20021123095040.GY25628@pasky.ji.cz> <Pine.LNX.4.44.0211240159240.2113-100000@serv>
 <20030205030104.GK10207@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Feb 2003, Petr Baudis wrote:

> > It didn't apply cleanly, I had one reject from menubox.c, which I had to 
> > apply manually.
> 
> Huh.. unreproducible here :-(. It applies cleanly to my clean 2.5.49 tree.
> 
> Late note: so does it to 2.5.59.

There must be a problem with your kernel tree, I fetched a new 2.5.59 
archive and I still get a reject.

> > Could you please add this one back and just reinitialize curses? (I 
> > actually liked the new resize feature. :) )
> 
> Well I tried to do something, but it is relatively complex, since we can't do
> almost anything useful in the signal handler itself. The problem is that for a
> reason which I'm unable to hunt down now (after approx. 4 hours of mainly
> trying to accomplish that) in some percentage of cases when the window is
> resized, something terribly pollutes the stack and we're screwed. Thus I
> temporarily disabled the functional part of the winch handler for now, the rest
> of code is in place and ready to be used by anyone brave enough to s/#if 0/#if
> 1/ in the winch handler.

I played a bit with this, try this:

static sigjmp_buf jmp_env;
static int do_jmp, need_resize;
                        
static void winch_handler(int sig)
{       
	if (do_jmp)
		siglongjmp(jmp_env, 1);
	need_resize = 1;
}       

before calling into dialog add this (maybe as macro):

	if (need_resize || sigsetjmp(jmp_env, 1)) {
		init_wsize();
		resizeterm(rows + 4, cols + 5);
		/* rebuild menu */
	}
	do_jmp = 1;

After the call reset do_jmp. It seems to work mostly, but the e.g.
menu_instructions are not correctly redrawn, any ideas?

> Otherwise (with the resizing disabled) it's quite stable about my personal
> stresstesting through, and the crash always happens inside of ncurses, so I
> don't really know... thus I believe it's ready for inclusion, we can fix the
> resizing issue later as it's not anything critical, is it? *hopeful smile*

I found some other issues. :)
The Esc key doesn't seem to work correctly, in some dialogs (choice, 
string) it doesn't work at all, in menu dialogs <Esc><Esc> doesn't work 
as it did.
After selecting help in choice or string dialog, the help text stays in 
the background, what I find a bit confusing. Is it possible to 
save/restore the old background?

> > BTW just add the other patch to this one, it's not that important to keep 
> > it separate.
> 
> Well it looks as it's included already...?

You can thank Alan. :)

bye, Roman

