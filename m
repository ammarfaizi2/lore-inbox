Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVC2Ttq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVC2Ttq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVC2Ttq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:49:46 -0500
Received: from mx1.mail.ru ([194.67.23.121]:41340 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261326AbVC2Ttn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:49:43 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: dtor_core@ameritech.net
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Date: Tue, 29 Mar 2005 23:49:55 +0400
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200503282126.55366.adobriyan@mail.ru> <200503292128.20140.adobriyan@mail.ru> <d120d50005032911027c13436e@mail.gmail.com>
In-Reply-To: <d120d50005032911027c13436e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503292349.55319.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 23:02, Dmitry Torokhov wrote:
> On Tue, 29 Mar 2005 21:28:20 +0400, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> > On Tuesday 29 March 2005 10:27, Dmitry Torokhov wrote:
> > > On Monday 28 March 2005 12:26, Alexey Dobriyan wrote:
> > > > Steps to reproduce for me:
> > > >     * Boot CONFIG_PREEMPT_BKL=y kernel (.config, dmesg are attached)
> > > >     * Start rebooting
> > > >     * Start moving serial mouse (I have Genius NetMouse Pro)
> > > >     * Right after gpm is shut down I see the oops
> > > >     * The system continues to reboot
> > >
> > > Could you try the patch below, please? Thanks!
> > 
> > > Input: serport - fix an Oops when closing port - should not call
> > >        serio_interrupt when serio port is being unregistered.
> > 
> > Doesn't work, sorry. Even worse: rebooting now also produces many pages of
> > oopsen, then hang the system. I'm willing to test any new patches.
> 
> Does it oops at the same place with this patch or at some other place?

I manage to find this in the logs (nothing more :-( ):
============================================================================
Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
c0202947
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables binfmt_misc uhci_hcd snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc floppy
CPU:    0
EIP:    0060:[<c0202947>]    Not tainted VLI
EFLAGS: 00010282   (2.6.12-rc1-bk2-serio) 
============================================================================
According to vmlinux, c0202947 is at:

c020293e <serport_ldisc_write_wakeup>:
c020293e:       8b 80 78 09 00 00       mov    0x978(%eax),%eax
c0202944:       8b 40 0c                mov    0xc(%eax),%eax
c0202947:       8b 50 68                mov    0x68(%eax),%edx		<<<<====
c020294a:       85 d2                   test   %edx,%edx
c020294c:       74 07                   je     c0202955 <serport_ldisc_write_wakeup+0x17>
c020294e:       8b 52 10                mov    0x10(%edx),%edx
c0202951:       85 d2                   test   %edx,%edx
c0202953:       75 01                   jne    c0202956 <serport_ldisc_write_wakeup+0x18>
c0202955:       c3                      ret
c0202956:       ff d2                   call   *%edx
