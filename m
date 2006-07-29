Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWG2VGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWG2VGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWG2VGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:06:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:41383 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932250AbWG2VGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:06:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dboK7qIuvJYHfHqAmmsx0lXIsYB/oRz+rzJ/jMHgvAE5YQF/WhFkXQWvYwGM2w+F5KMXi0KCT31RTEWBj0UWBsqiRfCtBfKhzj0+JPcnAa2pOCrShMH1QhK1+Q8/DoQKzh0zsSRE5WZGLJ3nIII8bIDs5fxwuednQQC+M6oio/8=
Message-ID: <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
Date: Sun, 30 Jul 2006 00:06:17 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Henrique de Moraes Holschuh" <hmh@debian.org>,
       "Mark Underwood" <basicmark@yahoo.com>
In-Reply-To: <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/06, Shem Multinymous <multinymous@gmail.com> wrote:

> There's a pattern here. Maybe what we need is a generic scheme for
> publishing continuous readouts, that will work for both hdaps and
> batteries (despite a X100 difference in typical time magnitudes).
> Doubtless there are other uses for such a scheme. We want it to
> support clients with different desired rates, data sources with
> different update frequencies, use minimum CPU and avoid unnecesary
> timer interrupts on tickless kernels.
>
> Here's one approach: use a syscall (e.g., ioctl) saying "block until
> there's new data on this fd, or N milliseconds have passed, whichever
> is *later*". This way each client declares the update rate it wants
> and can change it on the fly. The driver sees all the requests and can
> perform the minimum hardware quering -- for example, it won't query
> the hardware at all if no client has submitted a request with
> parameter N more than N milliseconds go. And there's no excessive work
> or interrupts. Some (simple) kernel code infrastructure is needed to
> help drivers manage the pending requests.

Here's a rough sketch for the userspace side of a continuous function
sampling interface. It handles the blocking a bit better than the
above proposal, in that it lets you easily handle multiple readouts.
It's agnostic about /dev vs. /sys.

As always, we have a file handing out readouts obtained from the
hardware - either a device file or a sysfs attribute. The file has the
following properties:

1. A new ioctl, SYSFS_DELAYED_UPDATE, meaning: "I want an a fresh
   readout in N milliseconds, or whenver it's ready, whichever is later.
   If I poll this FD with POLLIN, wait until the new readout is ready.
   Likewise for select."
2. When the file is opened in O_NONBLOCKing mode, read() always return
   the latest cached readout rather than querying the hardware
   (unless the latter has negligible cost).
3. When the file is opened in normal (blocking) mode, read() blocks
   until a fresh readout is available and returns this readout; see
   below.

To illustrte, here's an example of a proper polling loop (sans error
checking). This app wants updates at most every second, but obviously
not more frequently than the hardware has to offer. If no readout ca
be obtained for 20 seconds, it warns the user that the data is stale.

--------------------------
/* Open attribute file with O_NONBLOCK so that all reads will
 * return cached values instead of blocking:
 */
int fd = open("/whatever/voltage", O_NONBLOCK|O_RDONLY);

/* Read and process latest cached attribute value: */
read(fd, ...);
...

while (1) {
	struct pollfd ufds = { .fd=fd, events=POLLIN };

	/* Tell driver we want a fresh readout but no sooner than 1sec
	 * from now:
	 */
	ioctl(fd, SYSFS_DELAYED_UPDATE, 1000);

	/* Wait for an update for at most 5 seconds. Nominally this will
	 * block for at least 1 second, because of the above ioct. If we
	 * were reading multiple attributes, we could poll them all
	 * simultaneously.
	 */
	poll(&ufds, 1, 20000);
	... warn user if timed out ...

	/* Read and process latest cached attribute value: */
	read(fd, ...);
	... handle readout ...
}
--------------------------

Note that the above does not ensure minimal separation between
readouts:  you're guaranteed a fresh readout at every iteration, but
it might have been taken at the beginning of the >1sec poll period. If
you need to ensure that all readouts are at least (700ms apart, add a
sleep(700) at the end of the loop and decrease 1000 to 300 in the
ioctl().I think most apps won't need this.

Legacy and lightweight applications (e.g., cat from shell) will open
the file in blocking mode. In this case, a "read(fd, ...)" has
semantics equivalent to the following O_NONBLOCK-mode code:

--------------------------
	/* Tell driver we want an immediate update: */
	ioctl(fd, ATTR_DELAY_UPDATE, 0);

	/* Wait indefinitely for an update: */
	poll(&ufds, 1, -1);

	/* Read the latest cached attribute value: */
	read(fd, ...);
--------------------------

Similarly, select() and poll() on non-blocking files acts like you did
"ioctl(fd, ATTR_DELAY_UPDATE, 0);" and then wait for a refresh or timeout.

If we want to penalize people not using nonblocking mode and delayed
updates, we can replace two "0" above with a sufficiently nasty
(driver-dependent?) constant.

How does this look?

I'm not getting into the kernel side for now; it's doable, and with
proper infrastructure (e.g., at the sysfs level) can be elegant and
efficient.

  Shem
