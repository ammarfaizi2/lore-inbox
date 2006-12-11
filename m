Return-Path: <linux-kernel-owner+w=401wt.eu-S936974AbWLKQMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936974AbWLKQMS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936980AbWLKQMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:12:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55137 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936974AbWLKQMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:12:16 -0500
Date: Mon, 11 Dec 2006 16:12:12 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211161212.GJ4587@ftp.linux.org.uk>
References: <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org> <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org> <20061211022746.9ec80c03.akpm@osdl.org> <20061211104556.GF4587@ftp.linux.org.uk> <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 08:01:40AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Dec 2006, Al Viro wrote:
> 
> > On Mon, Dec 11, 2006 at 02:27:46AM -0800, Andrew Morton wrote:
> > > @@ -115,6 +115,11 @@ extern void setup_arch(char **);
> > >  #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
> > >  #define late_initcall(fn)		__define_initcall("7",fn,7)
> > >  #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
> > > +#define populate_rootfs_initcall(fn)	__define_initcall("8",fn,8)
> > > +#define populate_rootfs_initcall_sync(fn) __define_initcall("8s",fn,8s)
> > > +#define rootfs_neeeded_initcall(fn)	__define_initcall("9",fn,9)
> > > +#define rootfs_neeeded_initcall_sync(fn) __define_initcall("9s",fn,9s)
> > 
> > Ewww....  After module_init()?  Please, don't.  Come on, if it can
> > be a module, it _must_ be ready to run late in the game.
> 
> Yeah, I think you should just run "populate_rootfs()" just before 
> "module_init" (which is the same as "device_initcall()").
 
> If any really core stuff needs user-land - tough titties, as they say.

FWIW, I really think that this sort of bugs ("oh, I call hotplug,
rootfs is there but kernel is not ready, woe is me") clearly show
that many, _many_ users of hotplug are BS.  The reason is simple -
if we have a call of hotplug that early, we have a driver that lives
with hotplug failures _and_ with different behaviour in built-in
and modular cases.  I would argue that any such driver is broken.
