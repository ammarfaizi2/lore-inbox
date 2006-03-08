Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWCHFXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWCHFXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 00:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWCHFXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 00:23:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28074
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750832AbWCHFXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 00:23:22 -0500
Date: Tue, 7 Mar 2006 21:23:02 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060308052302.GA29867@kroah.com>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com> <200603072013.29227.dtor_core@ameritech.net> <20060308012744.GA24739@kroah.com> <200603072222.11504.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603072222.11504.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 10:22:10PM -0500, Dmitry Torokhov wrote:
> On Tuesday 07 March 2006 20:27, Greg KH wrote:
> > On Tue, Mar 07, 2006 at 08:13:28PM -0500, Dmitry Torokhov wrote:
> > > On Tuesday 07 March 2006 19:57, Linus Torvalds wrote:
> > > > 
> > > > On Tue, 7 Mar 2006, Chuck Ebbert wrote:
> > > > > 
> > > > > At least one susbsystem rolls its own method of adding env vars to the
> > > > > uevent buffer, and it's so broken it triggers the WARN_ON() in
> > > > > lib/vsprintf.c::vsnprintf() by passing a negative length to that function.
> > > > 
> > > > Well, snprintf() should be safe, though. It will warn if the caller is 
> > > > lazy, but these days, the thing does
> > > > 
> > > > 	max(buf_size - len, 0)
> > > > 
> > > > which should mean that the input layer passes in 0 instead of a negative 
> > > > number. And snprintf() will then _not_ print anything. 
> > > > 
> > > > So I think input_add_uevent_bm_var() is safe, even if it's not pretty.
> > > > 
> > > > However, input_devices_read() doesn't do any sanity checking at all, and 
> > > > if that ever ends up printing more than a page, that would be bad. I 
> > > > didn't look very closely, but it looks worrisome.
> > > > 
> > > > Dmitry?
> > > 
> > > I had all this code converted to seq_file, but it depends on converting
> > > input handlers to class interfaces and it is not possible nowadays
> > > because with latest Greg's changes to class code we would try to
> > > register class devices while registering class devices/interfaces
> > > (psmouse creates input_dev which binds to mousedev interface which in
> > > turn tries to create mouseX which is also belongs to input class) and
> > > deadlocking. Greg promised current implementation is only a temporary
> > > solution.
> > > 
> > > I suppose I could separate those changes...
> > 
> > That would probably be a good idea :)
> > 
> 
> Hmm, what is the policy for attr->show()? With hotplug variables we
> return -ENOMEM if there is not enough memory to store all data, but
> what about attributes? Should we also return error (and which one,
> -ENOMEM, -ENOBUFS?) or fill as much as we can and return up to
> PAGE_SIZE?

Remember, sysfs files are supposed to be small, you are an "oddity" in
that you have a much larger buffer that you can return due to the wierd
aliases you have.

Truncating the buffer is probably good as we want userspace to get some
information, right?

> With sysfs not kernel nor application can really recover
> if attribute needs buffer larger than a page. Or just rely on BUG_ON
> in fs/sysfs/file.c::fill_read_buffer()?

How about just making this a binary attribute, then you can handle an
arbitrary size buffer and don't have to worry about the PAGE_SIZE stuff
(but it makes it more code that you have to write to handle it all,
there are tradeoffs...)

thanks,

greg k-h
