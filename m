Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbSKSFtf>; Tue, 19 Nov 2002 00:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbSKSFtf>; Tue, 19 Nov 2002 00:49:35 -0500
Received: from dp.samba.org ([66.70.73.150]:19630 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267094AbSKSFtd>;
	Tue, 19 Nov 2002 00:49:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Tue, 19 Nov 2002 10:49:21 +1100."
Date: Tue, 19 Nov 2002 16:52:25 +1100
Message-Id: <20021119055636.94C182C088@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> right).  Or you can run a notifier on "enlivening" a module: I'd hoped
> to avoid that.

Actually, after some thought, this seems to clearly be the Right
Thing, because it solves another existing race.  Consider a module
which does:

	if (!register_foo(&my_foo))
		goto cleanup;
	if (!create_proc_entry(&my_entry))
		goto cleanup_foo;

If register_foo() calls /sbin/hotplug, the module can still fail to
load and /sbin/hotplug is called for something that doesn't exist.
With the new module loader, you can also have /sbin/hotplug try to
access the module before it's gone live, which will fail to prevent
the "using before we know module won't fail init" race.

Now, if you run /sbin/hotplug out of a notifier which is fired when
the module actually goes live, this problem vanishes.  It also means
we can block module unload until /sbin/hotplug is run.

The part that makes this feel like the Right Thing is that adding to
init/main.c:

	/* THIS_MODULE == NULL */
	notifier_call_chain(&module_notifiers, MODULE_LIVE, NULL);

means that /sbin/hotplug is called for everything which was registered
at boot.  (We may not want to do this, but in general the symmetry
seems really nice).

[ Note: the logic for /sbin/hotplug applies to any similar "publicity"
  function which promises that something now exists. ]

Al, thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
