Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWCHBNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWCHBNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWCHBNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:13:31 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:53665 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751166AbWCHBNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:13:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fw: Re: oops in choose_configuration()
Date: Tue, 7 Mar 2006 20:13:28 -0500
User-Agent: KMail/1.9.1
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com> <Pine.LNX.4.64.0603071648430.32577@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603071648430.32577@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072013.29227.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 19:57, Linus Torvalds wrote:
> 
> On Tue, 7 Mar 2006, Chuck Ebbert wrote:
> > 
> > At least one susbsystem rolls its own method of adding env vars to the
> > uevent buffer, and it's so broken it triggers the WARN_ON() in
> > lib/vsprintf.c::vsnprintf() by passing a negative length to that function.
> 
> Well, snprintf() should be safe, though. It will warn if the caller is 
> lazy, but these days, the thing does
> 
> 	max(buf_size - len, 0)
> 
> which should mean that the input layer passes in 0 instead of a negative 
> number. And snprintf() will then _not_ print anything. 
> 
> So I think input_add_uevent_bm_var() is safe, even if it's not pretty.
> 
> However, input_devices_read() doesn't do any sanity checking at all, and 
> if that ever ends up printing more than a page, that would be bad. I 
> didn't look very closely, but it looks worrisome.
> 
> Dmitry?

I had all this code converted to seq_file, but it depends on converting
input handlers to class interfaces and it is not possible nowadays
because with latest Greg's changes to class code we would try to
register class devices while registering class devices/interfaces
(psmouse creates input_dev which binds to mousedev interface which in
turn tries to create mouseX which is also belongs to input class) and
deadlocking. Greg promised current implementation is only a temporary
solution.

I suppose I could separate those changes...

BTW, what is ETA for 2.6.16 - I could not affort enought time getting
psmouse resync logic working in all cases so I'd like to have it disabled
for 2.6.16 final.

-- 
Dmitry
