Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSJTXw5>; Sun, 20 Oct 2002 19:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbSJTXw5>; Sun, 20 Oct 2002 19:52:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38956 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264677AbSJTXw4>; Sun, 20 Oct 2002 19:52:56 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>,
       <eblade@blackmagik.dynup.net>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <Pine.LNX.4.44.0210201330380.963-100000@cherise.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Oct 2002 17:57:12 -0600
In-Reply-To: <Pine.LNX.4.44.0210201330380.963-100000@cherise.pdx.osdl.net>
Message-ID: <m18z0swtnr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> > Mostly I want a comment from Patrick Mochel why he made the change,
> > and roughly what he was thinking.  So I have a good idea about which
> > code I need to dig into and send patches to fix.  If he makes a good
> > case for an independent shutdown, method I am fine with that, just
> > every driver in the kernel needs to change, and that is a heck of a
> > lot of work before 2.6.  Otherwise we can go back to calling remove.
> 
> The main problem is locking and refcounting on the device objects. 
> ->remove() is removing objects from the device tree and freeing them. This 
> is not good when we expect the list to remain intact while we iterate over 
> it. 
>
> This is fine when a device is unplugged or a module is removed, but 
> completely unnecessary during a power transition. Nothing is going away; 
> we're just turning everything off. And, we don't we don't have to mess 
> with getting the list traversal right, since we can assume it's intact. 
 
O.k.  That is very good reason for making the change.

> In short, it's about the data structures, not the hardware. It is going to
> require modification to drivers, but the changes should be small and make
> the code cleaner. It can also happen gradually. There is going to be a lot
> of cleanup of drivers in the coming months as more things are converted to
> exploit the driver model, anyway. 
>> 
> In general, I agree with the patch that you sent later in the thread. I'll 
> apply it, at least for now. 

My big concern is with getting the shutdown path setup in a manner
that works, and gets testing.  When booting linux from linux with
sys_kexec a lot of my problems come back to some device driver not
getting shutdown.

Question, is there a method from the class shutdown code that we
can/should call, during reboot.  I just have this memory that for
network interfaces simply downing the interface tends to put it in
a quiescent state.  And I am wondering if that might be a general
thing we can take advantage of.  Though if the class remove methods
modify the data structures I guess that is out.

Eric
