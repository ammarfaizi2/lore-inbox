Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWFTIEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWFTIEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWFTIEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:04:38 -0400
Received: from iona.labri.fr ([147.210.8.143]:16608 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S965025AbWFTIEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:04:36 -0400
Date: Tue, 20 Jun 2006 10:04:35 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: David Luyer <david@luyer.net>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060620080435.GA4347@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	David Luyer <david@luyer.net>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <20060619220920.GB5788@implementation.residence.ens-lyon.fr> <C0BD782F.CF80%david@luyer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0BD782F.CF80%david@luyer.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Luyer, le Tue 20 Jun 2006 10:02:23 +1000, a écrit :
> On 20/6/06 8:09 AM, "Samuel Thibault" <samuel.thibault@ens-lyon.org> wrote:
> > linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
> >> You can't allow some terminal input to affect init. It has been the
> >> de facto standard in Unix, that the only time one should have a
> >> controlling terminal is after somebody logs in and owns something to
> >> control.
> > 
> > Ok. The following still makes sense, doesn't it? (i.e. set a session for
> > the emergency shell)
> > 
> > --- linux-2.6.17-orig/init/main.c 2006-06-18 19:22:40.000000000 +0200
> > +++ linux-2.6.17-perso/init/main.c 2006-06-20 00:07:07.000000000 +0200
> > @@ -729,6 +729,11 @@
> > run_init_process("/sbin/init");
> > run_init_process("/etc/init");
> > run_init_process("/bin/init");
> > +
> > + /* Set a session for the shell.  */
> > + sys_setsid();
> > + sys_ioctl(0, TIOCSCTTY, 1);
> > +
> > run_init_process("/bin/sh");
> >  
> > panic("No init found.  Try passing init= option to kernel.");
> 
> What if people are booting via /bin/sh and then setting up
> their custom chroot's and init(s), and don't want these init(s) to
> be part of a session?

The problem is that you can't distinguish that from usual init booting:

	if (execute_command) {
		run_init_process(execute_command);
		printk(KERN_WARNING "Failed to execute %s.  Attempting "
					"defaults...\n", execute_command);
	}
	run_init_process("/sbin/init");

If you setsid() in the if(execute_command) statement, and the
execute_command fails, you get to run init in a session.

> It is also particularly possible for an embedded system to start
> up via /bin/sh running /etc/profile rather than using an init type
> program.

Then people writing that embedded system should use /bin/login instead.

> Also, the above doesn't help people specifying "init=/bin/sh" on the
> command line (as per the original post subject).  The real solution
> is for them to specify a different init= or run/exec something to set
> up their tty and session once logged in.

Yes. And the problem is that people usually don't know about sessions
etc, and will just grumble "linux can't work".

Samuel
