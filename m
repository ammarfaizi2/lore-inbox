Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUDKW3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 18:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUDKW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 18:29:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262514AbUDKW3m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 18:29:42 -0400
Date: Sun, 11 Apr 2004 23:29:40 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: John Belmonte <john@neggie.net>, acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs namespace
Message-ID: <20040411222940.GJ18329@parcelfarce.linux.theplanet.co.uk>
References: <1081453741.3398.77.camel@patsy.fc.hp.com> <1081549317.2694.25.camel@patsy.fc.hp.com> <4077535D.6020403@neggie.net> <1081566768.2562.8.camel@wilson.home.net> <407786C6.7030706@neggie.net> <1081629776.2562.40.camel@wilson.home.net> <1081653618.2562.52.camel@wilson.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081653618.2562.52.camel@wilson.home.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 09:20:19PM -0600, Alex Williamson wrote:
> On Sat, 2004-04-10 at 14:42, Alex Williamson wrote:
> > 
> >    Ok, I took a look.  The open/write/read/close interface seems to be
> > the best approach.  It shouldn't be too hard, except the read/write
> > interfaces don't pass in the attribute pointer like they do for the
> > show/store interface.
> 
>    I made the assumption that this wasn't that big of a stretch to the
> bin file interface and extended it to add the arribute pointer.  Below
> is what I came up with.  There are luckly only a handful of places using
> the current sysfs bin file interface, so the additional changes are
> pretty small.  I'm guessing I can probably get rid of the spinlocks I
> added for the previous implementation, but they're not hurting anything
> for now.  Am I getting closer?  Thanks,

Yes, definitely closer to my way of thinking ...

It seems unintuitive that you have to read the file for the method to
take effect.  How about having the write function invoke the method and
(if there is a result) store it for later read-back via the read function?
It should be discarded on close, of course.  A read() on a file with
no stored result should invoke the ACPI method (on the assumption this
is a parameter-less method) and return the result directly.  Closing a
file should discard any result from the method.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
