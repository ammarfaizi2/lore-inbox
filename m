Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSGRVCY>; Thu, 18 Jul 2002 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318364AbSGRVCY>; Thu, 18 Jul 2002 17:02:24 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:24076 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318361AbSGRVCW>;
	Thu, 18 Jul 2002 17:02:22 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Matthew Wilcox <willy@debian.org>
Date: Thu, 18 Jul 2002 23:04:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.26 broken on headless boxes
CC: jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <B4822306FB3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 02 at 21:32, Matthew Wilcox wrote:
> On Thu, Jul 18, 2002 at 01:18:57PM -0700, William Lee Irwin III wrote:
> > On Thu, Jul 18, 2002 at 02:29:46PM +0100, Matthew Wilcox wrote:
> > >>>EIP; c01b7695 <visual_init+85/e0>   <=====
> > >>>edx; f7906600 <END_OF_CODE+37502e5c/????>
> > >>>edi; c03dcc00 <vc_cons+0/fc>
> > >>>esp; c3d45e7c <END_OF_CODE+39426d8/????>
> > > Trace; c01b7773 <vc_allocate+83/140>
> > > Trace; c01baa25 <con_open+19/88>
> > > Trace; c01ac08c <tty_open+20c/394>
> > > Trace; c0145a83 <link_path_walk+683/874>
> > > Trace; c0144ed7 <permission+27/2c>
> > > Trace; c0146373 <may_open+5f/2ac>
> > > Trace; c013c33a <chrdev_open+66/98>
> > > Trace; c013b001 <dentry_open+e1/1b0>
> > > Trace; c013af16 <filp_open+52/5c>
> > > Trace; c013b307 <sys_open+37/74>
> > > Trace; c0108893 <syscall_call+7/b>
> > 
> > This is the 4th one of these I've seen in the last two days. Any chance
> > of being able to compile with -g and get an addr2line on the EIP? I've
> > tried to reproduce it myself, but haven't gotten it to happen yet.
> 
> seems fairly obvious what's happening with a couple of printks...
> 
>     printk("visual_init: sw = %p, conswitchp = %p, currcons = %d, init = %d\n",
>                     sw, conswitchp, currcons, init);
> 
> gets me the interesting fact that sw & conswitchp are both NULL.
> later on, we call:
>     sw->con_init(vc_cons[currcons].d, init);
> which seems like it would be the exact cause, no?
> 
> now whether putting a:
> 
>     if (!sw)
>         return;
> 
> call into visual_init or whether we should determine earlier never to
> call visual_init, I don't know.  The people who know about the console
> have been conspicuously silent so far...

You have enabled CONFIG_VT without CONFIG_VGA_CONSOLE and 
CONFIG_DUMMY_CONSOLE. It is illegal configuration.

To fix oopses, either enable 'Framebuffer devices' under 'Console
drivers' section (you do not have to enable any fbdev driver, just
check this option...), or disable CONFIG_VT. See arch/*/kernel/setup.c
for explanation, no code in VT subsystem kernel expects conswitchp == NULL,
but couple of architectures leaves sometime conswitchp uninitialized.

It would be possible to add error return path to visual_init, but
I think that adding

  conswitchp = &dummy_con;
+ #else
+ #error No console defined with CONFIG_VT enabled
  #endif
  #endif

at the end of setup.c will work same way, as open of /dev/tty* will
never suceed with your config with added error path anyway.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
