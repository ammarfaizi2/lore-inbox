Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUJDIMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUJDIMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUJDIMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:12:52 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:59268 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S267553AbUJDIMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:12:49 -0400
Subject: Re: [PATCH] -mm swsusp: copy_page is harmfull
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096847414.23142.42.camel@gaston>
References: <200409292014.i8TKEhov023334@hera.kernel.org>
	 <1096847414.23142.42.camel@gaston>
Content-Type: text/plain
Message-Id: <1096877559.9064.45.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 04 Oct 2004 18:12:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-10-04 at 09:50, Benjamin Herrenschmidt wrote:
> On Sat, 2004-09-25 at 10:27, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1983.1.3, 2004/09/24 17:27:41-07:00, akpm@osdl.org
> > 
> > 	[PATCH] -mm swsusp: copy_page is harmfull
> > 	
> > 	From: Pavel Machek <pavel@ucw.cz>
> > 	
> > 	This is my fault from long time ago: copy_page can't be used for copying
> > 	task struct, therefore we can't use it in swsusp.
> 
> Hi !
> 
> Just curious, but why ?
> 
> It would be useful to have this in platform code, I don't see why I couldn't
> use copy_page() on ppc and I suspect it will be more efficient than memcpy
> since it has specific optimisations due to the fact that we are known to be
> fully aligned and the size of the copy is a constant aligned power of 2.

I think I can answer that one, seeing as Pavel seems to be asleep at the
mo :>.

On x86 at least (perhaps your platform is different), copy_page can
resolve to different implementations. If you have 3D_NOW, the preempt
count will be incremented prior to copying the page via a fpu_begin
call. Sooner or later in doing the atomic copy of memory, you'll be
copying the page containing the preempt count (the task struct) for the
process doing the suspending. At that stage, you'll copy the preempt
count being one too high, and at resume time it will still be one too
high (we definitely can't use copy_page then). The simple solution would
be to use copy_page and have something like

#ifdef 3D_NOW
	dec_preempt_count();
#endif

But I'm sure you'll agree that even if it's faster, it's less clear and
uglier.

Regards,

Nigel

