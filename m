Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbTDQUMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDQUMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:12:41 -0400
Received: from [144.51.25.10] ([144.51.25.10]:54226 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261978AbTDQUMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:12:39 -0400
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: richard offer <offer@sgi.com>
Cc: Andreas Gruenbacher <ag@bestbits.at>,
       Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <743940000.1050530541@changeling.engr.sgi.com>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
	 <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
	 <385390000.1050425884@changeling.engr.sgi.com>
	 <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil>
	 <743940000.1050530541@changeling.engr.sgi.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1050553474.1076.88.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 00:24:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 18:02, richard offer wrote:
> If you attach a capability attribibute to a file under the capability
> module, what happens when you use SELinux ? Under your scheme, you'd remove
> the capability and write a combined attribute that included SELinux and and
> if needed the capability. 

Yes.  You have to initially label the filesystem in order to use
SELinux, as you would with any MAC scheme, and incorporating additional
state into that labeling procedure wouldn't be difficult.  It isn't
clear that you actually need the additional state; you can assign
privileges via TE rather than using capabilities if you want
fine-grained decomposition of root.

However, point taken - if the existing Linux capability model (in the
mainline kernel) was already using xattr and had an attribute name
reserved, I don't think we would have suggested re-using that attribute
name (or its handler) for all security modules.  I view this as a
special case, as the capability model was already in mainline and is
expected to exist by certain applications, so colliding with it could
pose a problem for many security modules.  For other security modules,
or at the very least, the class of security modules implementing a MAC
scheme, I would still suggest a single attribute name and handler.  

> Under my scheme, the capability attribute would be left alone, SELinux
> would add its own, and then as its the primary module would decide whether
> to use the existing capability attribute or its own "combined" attribute.
> The important thing is that if you ever decide to reboot a pure capability
> system that you don't have to refigure all your attributes (although you
> could/should).

True.  As above, I view this as a special case for the capability model
because it has been part of the mainline.  If I am switching between
different MAC schemes, I need to do a thorough relabeling of the
filesystem, and that relabeling is a delicate operation as one MAC
scheme may permit data mixing that is prohibited by another, leading to
a violation of confidentiality or integrity requirements of the other
MAC scheme.  Also, note that if you switch from a MAC scheme to a
capability-only scheme, switching back is a very delicate operation if
you want to verify a secure state.

> Extended attributes are still relatively rare that people forget to record
> them when replacing a file (I do that all the time under Trusted Irix),
> under your scheme they would have to record every attribute on the system
> before loading a module if they every wanted to return to its prior state.
> If you forgot to do it just once the consequences could be nasty.

Since you have to initially relabel the filesystem to switch to a
different MAC scheme, it isn't unreasonable to have that labeling step
also make a backup of any existing attribute values prior to changing
them.

> I can see your reasons for the single attribute (known quantity for
> production systems), but think its better at this stage to experiment with
> multiple attributes and see how people use them before forcing everyone to
> a single standard. It allows small steps rather than force everyone to make
> a single large one.

Per-module attribute names create no incentive for the security module
writers to provide a consistent API and guarantees a forked userland. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

