Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWBVSBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWBVSBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbWBVSBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:01:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161252AbWBVSBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:01:19 -0500
Date: Wed, 22 Feb 2006 09:57:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gabor Gombas <gombasg@sztaki.hu>
cc: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
       gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
Message-ID: <Pine.LNX.4.64.0602220942040.30245@g5.osdl.org>
References: <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org>
 <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org>
 <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
 <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org>
 <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org>
 <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, Gabor Gombas wrote:
> 
> I don't think isnmod is broken. It's job is to load a chunk of code into
> the kernel, and it's doing just that.
> 
> The asynchronous device discovery is caused/required by hotplug. If you
> can recreate the problem with a kernel that has CONFIG_HOTPLUG disabled,
> then I agree that this is a kernel bug which should be fixed.

I think it currently can happen without HOTPLUG too. In fact, 
CONFIG_HOTPLUG is really a "special drivers that do hot-plugging", not 
about "devices that show up on their own".

The thing is, "insmod" really just tends to introduce the driver to the 
kernel. It leaves it pretty open what that driver will actually _do_. And 
a lot of drivers tend to do discovery independently of actually plugging 
in the driver.

For example, any USB host driver will always discover its devices 
asynchronously, and has no dependency on CONFIG_HOTPLUG. It can take 
several seconds for all the hubs to have powered up and discovered what is 
behind them.

The same is true of most SCSI buses - CONFIG_HOTPLUG may talk about 
whether the actual _controller_ is hotpluggable, but not about whether a 
disk is, or how disk discovery takes place. 

Now, arguably "insmod" (both the user binary and the kernel side) is doing 
the right thing: it's inserting the driver. The fact that all the devices 
that the driver uses may not be immediately available is not insmod's 
issue. That's a very valid way to look at it.

At the same time, it's also arguable that from an ease of use standpoint, 
"insmod" should generally try to wait until the driver has enumerated what 
it knows about. That's a totally non-technical argument, but it's an 
equally valid standpoint.

Of course, the technical argument is that discovery can take a long long 
time (minutes to wait for disks to spin up etc), so if insmod were to wait 
for it all, we'd be really screwed and our bootup times would go through 
the roof.

The usability argument is that right now we don't have any easy way at all 
to wait for bus scanning to have finished, and that's a very valid 
argument. You could wait for the hotplug event, but since you don't even 
_know_ that you'll get such an event, that's really not a very good answer 
either.

We could improve. 

I _think_ that in this particular case, the best particular choice might 
be for the "mount" binary to be taught to re-try after a few seconds: 
either with a command line argument, or with just the early bootup initrd 
code being encouraged to have a loop like

	if (mounting root failed)
		echo "Please press F1 to continue"
		do
			read-keyboard-with-5-second-timeout
		while (mounting root failed)
	endif

so that the user would have to press a key (or we'd just re-try every five 
seconds).

That way, the boot wouldn't just fail immediately over something that can 
be fixed (sometimes the root partition might just be hot-pluggable too: 
"insert disk and continue" can be a valid way to handle issues).

		Linus
