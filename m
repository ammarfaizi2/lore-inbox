Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWGaVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWGaVff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWGaVff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:35:35 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:16654 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030470AbWGaVfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:35:34 -0400
Date: Mon, 31 Jul 2006 23:35:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Shem Multinymous" <multinymous@gmail.com>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Henrique de Moraes Holschuh" <hmh@debian.org>,
       "Mark Underwood" <basicmark@yahoo.com>, "Greg KH" <greg@kroah.com>
Subject: Re: Generic battery interface
Message-Id: <20060731233536.92b39035.khali@linux-fr.org>
In-Reply-To: <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	<41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	<20060727232427.GA4907@suse.cz>
	<41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	<20060728074202.GA4757@suse.cz>
	<41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	<20060728202359.GB5313@suse.cz>
	<41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	<41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	<41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shem,

Disclaimer: I have no idea how the input interface works currently. And
I don't know what problem you are trying to solve. I just thought my
hwmon-oriented comments might help.

> Here's an updated rough proto-spec for the userspace side of the
> continuous-parameter polling interface, intended for hwmon, batteries
> and their ilk, and maybe even the input infrastructure.
> 
> Compared to the parent post, this version adds a second parameter to
> the ioctl (see discussion elsewhere in this thread), and corrects a
> few inaccuracies.
> 
> With an event-based data source, this interface allows polling with no
> time interrupts on tickless kernels. With a polling-based data source
> and a bit of luck, the frequency of polling = frequency of induced
> timer interrupts will be the minimum that satisfies the greediest
> client (even if there are many). In general, complicated data sources
> can be handled optimally by custom driver+infrastructure code. All of
> this is completely transparent  to userspace, which just states its
> needs and has its every desire fulfilled.
> 
> Hardware readouts are obtained from a dedicated file - a sysfs
> attribute (as in hwmon and tp_smapi) or a device file (as in the input
> infrastructure). The file has the following properties:
> 
> 1. A new ioctl DELAYED_UPDATE, with parameters min_wait and
>    min_fresh, meaning: "I want an a fresh readout. If I poll() this FD
>    with POLLIN then send an input-ready event at time is T+min_wait, or
>    when you have a readout that was received from the hardware at  time
>    T+min_fresh, whichever is *later*. Likewise if I select()".
>    Here T is the time of the ioctl call and min_wait>=min_fresh.

"A or B, whichever is later", effectively means "A and B". Or am I
missing something? I fail to see the difference between min_wait and
min_fresh.

> 2. When the file is opened in O_NONBLOCKing mode, read() always return
>    the latest cached readout rather than querying the hardware
>    (unless the latter has negligible cost).
> 3. When the file is opened in normal (blocking) mode, read() blocks
>    until a fresh readout is available and returns this readout; see
>    below.

The hwmon interface (sysfs now, procfs before) has been returning
cached values by defaut for years. Changing this at this point might be
confusing. I don't see much benefit in waiting for updated values
compared to reading them from the cache. The driver knows better how
frequently it can read from the chip. And no hardware monitoring chip I
know of can tell when the monitored value has changed - you have to read
the chip registers to know.

> To illustrate, here's an example of a proper polling loop (sans error
> checking). This app wants to refresh its display when the data has
> changed, but not more often than once per second. It wants the
> readouts to be reasonly spaced: they should be obtained at least 700ms
> apart. And it needs to update its GUI every 3 seconds regardless of
> readouts.

I don't see the point in the 700ms rule. If you don't want new data
more often than once per second, the readouts will be spaced by one
second, which implies > 700ms already.

> Application code:
> --------------------------
> /* Open attribute file with O_NONBLOCK so that all reads will
> * return cached values instead of blocking:
> */
> int fd = open("/whatever/voltage", O_NONBLOCK|O_RDONLY);
> 
> /* Read and process latest cached attribute value: */
> read(fd, ...);
> ...
> 
> while (1) {
> 	const struct delayed_update_req dureq =
> 		{ .min_wait=1000, min_fresh=700 };
> 	struct pollfd ufds = { .fd=fd, events=POLLIN };
> 
> 	/* Tell the driver we want a fresh readout, but no sooner than
> 	 * 1sec from now, and we want the readout to reflect reality no
> 	 * sooner than 700ms now:
> 	 */
> 	ioctl(fd, DELAYED_UPDATE, &dureq);
> 
> 	/* Wait for an update for at most 3 seconds. Nominally this will
> 	* block for at least 1 second, because of the above ioct. If we
> 	* were reading multiple attributes, we could poll them all
> 	* simultaneously.
> 	*/
> 	poll(&ufds, 1, 3000);
> 
> 	/* Read latest cached attribute value: */

No seek(fd, ..., 0) here? sysfs files are supposed to be simple text
files, aren't they?

> 	read(fd, ...);
> 
> 	... handle readout, update GUI ...
> }

-- 
Jean Delvare
