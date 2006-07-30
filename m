Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWG3Sh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWG3Sh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWG3Sh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:37:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:56465 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932410AbWG3ShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:37:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jElZRVM0+a6NzfTzDb1rBsz6e5uuqN+2rRM3FSB/s7JONYGQw8MW5t8a3wrFFe2vfnv/X5NWVrfYuPrCQnBSebXWm5sBkfqk2AAQZmufxWLq5H7PigwkRCnEdfmdr8DZu1QtkccBTrqKXSYv1Ml9P1JEWdtjY8ILkTNv5NwpiUo=
Message-ID: <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
Date: Sun, 30 Jul 2006 21:37:23 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Henrique de Moraes Holschuh" <hmh@debian.org>,
       "Mark Underwood" <basicmark@yahoo.com>, "Greg KH" <greg@kroah.com>,
       "Jean Delvare" <khali@linux-fr.org>
In-Reply-To: <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
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
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's an updated rough proto-spec for the userspace side of the
continuous-parameter polling interface, intended for hwmon, batteries
and their ilk, and maybe even the input infrastructure.

Compared to the parent post, this version adds a second parameter to
the ioctl (see discussion elsewhere in this thread), and corrects a
few inaccuracies.

With an event-based data source, this interface allows polling with no
time interrupts on tickless kernels. With a polling-based data source
and a bit of luck, the frequency of polling = frequency of induced
timer interrupts will be the minimum that satisfies the greediest
client (even if there are many). In general, complicated data sources
can be handled optimally by custom driver+infrastructure code. All of
this is completely transparent  to userspace, which just states its
needs and has its every desire fulfilled.

Hardware readouts are obtained from a dedicated file - a sysfs
attribute (as in hwmon and tp_smapi) or a device file (as in the input
infrastructure). The file has the following properties:

1. A new ioctl DELAYED_UPDATE, with parameters min_wait and
   min_fresh, meaning: "I want an a fresh readout. If I poll() this FD
   with POLLIN then send an input-ready event at time is T+min_wait, or
   when you have a readout that was received from the hardware at  time
   T+min_fresh, whichever is *later*. Likewise if I select()".
   Here T is the time of the ioctl call and min_wait>=min_fresh.
2. When the file is opened in O_NONBLOCKing mode, read() always return
   the latest cached readout rather than querying the hardware
   (unless the latter has negligible cost).
3. When the file is opened in normal (blocking) mode, read() blocks
   until a fresh readout is available and returns this readout; see
   below.

To illustrate, here's an example of a proper polling loop (sans error
checking). This app wants to refresh its display when the data has
changed, but not more often than once per second. It wants the
readouts to be reasonly spaced: they should be obtained at least 700ms
apart. And it needs to update its GUI every 3 seconds regardless of
readouts.

In some linux/foo.h:
--------------------------
struct delayed_update_req {
	int min_wait;
	int min_fresh;
};
--------------------------

Application code:
--------------------------
/* Open attribute file with O_NONBLOCK so that all reads will
* return cached values instead of blocking:
*/
int fd = open("/whatever/voltage", O_NONBLOCK|O_RDONLY);

/* Read and process latest cached attribute value: */
read(fd, ...);
...

while (1) {
	const struct delayed_update_req dureq =
		{ .min_wait=1000, min_fresh=700 };
	struct pollfd ufds = { .fd=fd, events=POLLIN };

	/* Tell the driver we want a fresh readout, but no sooner than
	 * 1sec from now, and we want the readout to reflect reality no
	 * sooner than 700ms now:
	 */
	ioctl(fd, DELAYED_UPDATE, &dureq);

	/* Wait for an update for at most 3 seconds. Nominally this will
	* block for at least 1 second, because of the above ioct. If we
	* were reading multiple attributes, we could poll them all
	* simultaneously.
	*/
	poll(&ufds, 1, 3000);

	/* Read latest cached attribute value: */
	read(fd, ...);

	... handle readout, update GUI ...
}
--------------------------

Legacy and lightweight applications (e.g., cat from shell) will open
the file in blocking mode. In this case, a "read(fd, ...)" has
semantics equivalent to the following O_NONBLOCK-mode code:

--------------------------
	const struct delayed_update_req dureq =
		{ .min_wait=0, min_fresh=0 };

	/* Tell driver we want an immediate update: */
	ioctl(fd, DELAYED_UPDATE, &dureq);

	/* Wait indefinitely for an update: */
	poll(&ufds, 1, -1);

	/* Read the latest cached attribute value: */
	read(fd, ...);
--------------------------

Similarly, select() and poll() on non-blocking files acts like you did
"ioctl(fd, DELAYED_UPDATE, &dureq)" with dureq={0,0} and then waited
for a refresh or timeout.

If we want to penalize code which doesn't use nonblocking mode and
delayed updates, we can increase the implicit dureq.min_wait above
from 0 to a sufficiently nasty (driver-dependent?) delay.


Comments?

(I still can't implement this myself. Just trying to elucidate my suggestion.)

  Shem
