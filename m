Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317518AbSGERqg>; Fri, 5 Jul 2002 13:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317519AbSGERqf>; Fri, 5 Jul 2002 13:46:35 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:52963 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317518AbSGERqe>; Fri, 5 Jul 2002 13:46:34 -0400
Date: Fri, 5 Jul 2002 15:48:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020705134816.GA112@elf.ucw.cz>
References: <20020703034809.GI474@elf.ucw.cz> <10962.1025745528@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10962.1025745528@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Okay. So we want modules and want them unload. And we want it bugfree.
> >
> >So... then its okay if module unload is *slow*, right?
> >
> >I believe you can just freeze_processes(), unload module [now its
> >safe, you *know* noone is using that module, because all processes are
> >in your refrigerator], thaw_processes().
> 
> The devil is in the details.

I don't think so.

> You must not freeze the process doing rmmod, that way lies deadlock.

That's automagic. Process doing freeze will not freeze itself.

> Modules can run their own kernel threads.  When the module shuts
> down
> it terminates the threads but we must wait until the process entries
> for the threads have been reaped.  If you are not careful, the zombie
> clean up code can refer to the module that no longer exists.  You must
> not freeze any threads that belong to the module.

Look at the code. freezer will try for 5 seconds, then give up. So, in
rare case module has some threads, rmmod will simply fail. I believe
we can fix rare remaining modules one by one.

> You must not freeze any process that has entered the module but not yet
> incremented the use count, nor any process that has decremented the use
> count but not yet left the module.  Simply looking at the EIP after

Look how freezer works. refrigerator() is blocking, by definition. So
if all processes reach refrigerator(), and the use count == 0, it is
indeed safe to unload.

> freeze is not enough.  Module code with a use count of 0 is allowed to
> call any function as long as that function does not sleep.  That
> rule

And that's okay. If it only calls non-sleeping functions, it is not
going to call refrigerator(), and it will exit module code before
calling refrigerator().

> Using freeze or any other quiesce style operation requires that the
> module clean up be split into two parts.  The logic must be :-

I still think it does not.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
