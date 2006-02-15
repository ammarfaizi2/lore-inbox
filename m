Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWBOXYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWBOXYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWBOXYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:24:40 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:20129 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751299AbWBOXYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:24:39 -0500
Message-ID: <43F3B820.8030907@vilain.net>
Date: Thu, 16 Feb 2006 12:24:16 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
In-Reply-To: <20060215145942.GA9274@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> However, if we're going to get anywhere, the first decision which we
> need to make is whether to go with a (container,pid), (pspace,pid) or
> equivalent pair like approach, or a virtualized pid approach.  Linus had
> previously said that he prefers the former.  Since there has been much
> discussion since then, I thought I'd try to recap the pros and cons of
> each approach, with the hope that the head Penguins will chime in one
> more time, after which we can hopefully focus our efforts.

I am thinking that you can have both.  Not in the sense of
overcomplicating, but in the sense of having your cake and eating it
too.

The only thing which is a unique, system wide identifier for the process
is the &task_struct.  So we are already virtualising this pointer into a
PID for userland.  The only difference is that we cache it (nay, keep
the authorative version of it) in the task_struct.

The (XID, PID) approach internally is also fine.  This says that there
is a container XID, and within it, the PID refers to a particular
task_struct.  A given task_struct will likely exist in more than one
place in the (XID, PID) space.  Perhaps the values of PID for XID = 0
and XID = task.xid can be cached in the task_struct, but that is a
detail.

Depending on the flags on the XID, we can incorporate all the approaches
being tabled.  You want virtualised pids?  Well, that'll hurt a little,
but suit yourself - set a flag on your container and inside the
container you get virtualised PIDs.  You want a flat view for all your
vservers?  Fine, just use an XID without the virtualisation flag and
with the "all seeing eye" property set.  Or you use an XID _with_ the
virtualisation flag set, and then call a tuple-endowed API to find the
information you're after.

We can enforce this by simply removing all the internal macros that deal
with single PID references only; ie, enforce the XID to be used
everywhere.  This removes the distinction between virtual PIDs and
"real" pids; it's not a type difference, but an XID value difference.

There are lots and lots of details I'm glossing over, but such finer
points are best discussed by trading patches.

IOW, we can stop arguing and start implementing :-).

Sam.
