Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWGIKaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWGIKaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWGIKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:30:30 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:38034 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030421AbWGIKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:30:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E1cHm6EYoAzmSKukPNIS7KJLzXgD9Yhyun30iG+FlCq5ZfkZ5McOWBBS/mt3fvVmOv2SMpN18B2k4fQBI7WoKgNaut1x2mZnghP45MNtXPiE0/wWablUXOH9k923QpmrsstmCOZji/Xxkf5FglJf3cSH3efJ5SiFh8ddCKy0Nlg=
Message-ID: <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
Date: Sun, 9 Jul 2006 06:29:55 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: Automatic Kernel Bug Report
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Daniel,
>
> On 09/07/06, Daniel Bonekeeper <thehazard@gmail.com> wrote:
> > Well this probably was already discussed. Some distros have automatic
> > bug reporting tools that are triggered when something bad happens
> > (don't know if includes kernel stuff). But have anybody thought about
> > some kind of bug report tool that, under an Oops like a NULL point
> > dereference, it creates for example a packed file with the config used
> > to build the kernel, the kernel version, loaded modules, some hardware
> > info, backtraces, everything that could be useful for debugging, and
> > sends to a server to be catalogued ?
>
> How about oops reporting tool?
> http://www.stardust.webpages.pl/files/ort/
>
> [snip]
> >
> > Wouldn't that be helpful ?
> >
> > Daniel
> >
>
> Regards,
> Michal
>

Hello Michal.

Yes, something like that =)

Maybe less verbal. Another problem is that, depending on the
situation, the problem may be serious enough to not allow a program in
userspace to work (and therefore, not acknowledge the Oops nor send a
bug report). Also, important information may not be available for
userspace (imagine a machine where the kernel wasn't compiled with
debug stuff, so those details are not exposed to userspace, but
available at kernelspace). As far as I understood your script, it
requires interactivity to work (so if we have a bunch of servers in a
datacenter at 1k miles, we got a problem). My first idea was:

1) At kernelspace we have some kind of function that is called at the
end of the bug handler (BUG_ON for example) or more generically in
another place. This function just adds the current bug description
(probably the output used on printk (that is currently segmented over
the code)) and adds it to a list of structs that holds bug
descriptions inside the bug report system.

2a) The bug report system can export those bug descriptors to
userspace via sysfs, for example, where a tool there can do the rest.

2b) We could provide a device like /dev/oops which just returns the
content of the bug report lists (in ASCII so shell scripts can read
it). By having a device, we can actually know if something on the
userspace cares about bug reporting (if we have a process with
/dev/oops open (and blocked, waiting for new oops reports), we let it
handle that). Again, something serious can happen and the userspace
notifier won't run. Something simple as  easy-to-parse e-mails could
be used to KISS it.

2c) Just have the notifier on the kernel. Maybe this won't be
possible, but I thought about something very rude: at boot time,
initrd scripts tell the kernel where to send the bug report to (using
UDP, may be a machine inside their LAN where the admin can also have
information about those Oops, or point directly to servers at vger or
any place else). When the Oops occur, a notifier function inside the
kernel uses the (if available) network stuff to send a simple UDP
packet containing the info. Maybe this will be enough to overcome very
bad situations where everything on userspace locks, but the kernel
still runnable.

3) At the central bug report server, we get the bugs routed. Here we
put a hold on bugs that may not be worth to look at (for example
tainted stuff), and the useful ones (let's say, stuff that just came
out) are routed to maintainers, or just kept on the server where
everybody can have free access to it.

In any circunstance, I think that user interactivity should be
avoided. At the boot time, the initrd specifies to the kernel what to
do upon a bug (device/call a binary in userspace/send dump via UDP,
etc), and have some kind of contact information, so the system at the
other side, after receiving the bug report, can put the bug in a
catalog, assign an ID to it, and notify the admin of the server
(probably via e-mail) about the bug, asking for details that may be
helpful. The process may seem complex at a first glance, but I think
that this is worth of having (imagine how many bugs actually are
triggered every single day, but not reported...). This would also end
up as a quality meter (just imagine the current discussion about
uswsusp and suspend2... we would know which one of them have higher
rates of problems, statistics over the time, so we can see if the rate
of problems with them are getting higher or not, etc). Maybe we could
just incorporate Mozilla's bug report tool, if it's currently
available (and not hard to do at kernel side, if it's a good idea at
all).

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
