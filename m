Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWGDLzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWGDLzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWGDLzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:55:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:11163 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932224AbWGDLzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:55:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: Battery-related regression between 2.6.17-git3 and 2.6.17-git6
Date: Tue, 4 Jul 2006 13:55:43 +0200
User-Agent: KMail/1.9.3
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200607020021.15040.rjw@sisk.pl> <200607032226.04094.rjw@sisk.pl> <20060703204519.GA11289@kroah.com>
In-Reply-To: <20060703204519.GA11289@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/clqE2QwvTY6tdd"
Message-Id: <200607041355.43361.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/clqE2QwvTY6tdd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 03 July 2006 22:45, Greg KH wrote:
> On Mon, Jul 03, 2006 at 10:26:03PM +0200, Rafael J. Wysocki wrote:
> > On Monday 03 July 2006 21:44, Greg KH wrote:
> > > On Mon, Jul 03, 2006 at 09:39:22PM +0200, Rafael J. Wysocki wrote:
> > > > On Monday 03 July 2006 20:00, Greg KH wrote:
> > > > > On Mon, Jul 03, 2006 at 01:16:45PM +0200, Rafael J. Wysocki wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Sunday 02 July 2006 11:15, Rafael J. Wysocki wrote:
> > > > > > > On Sunday 02 July 2006 00:21, Rafael J. Wysocki wrote:
> > > > > > > > With the recent -git on my box (Asus L5D, x86_64 SUSE 10) the powersave
> > > > > > > > demon is apparently unable to get the battery status, although the data in
> > > > > > > > /proc/acpi/battery/BAT0 seem to be correct.  As a result, battery status
> > > > > > > > notification via kpowersave doesn't work and it's hard to notice when the
> > > > > > > > battery is low/critical.
> > > > > > > > 
> > > > > > > > So far I have verified that this feature works fine with 2.6.17-git3 and
> > > > > > > > doesn't work with 2.6.17-git6 (-git5 doesn't compile here).
> > > > > > > > 
> > > > > > > > I'll try to get more information tomorrow (unless someone in the know has
> > > > > > > > an idea of what's up ;-) ).
> > > > > > > 
> > > > > > > I've verified that the problem first appeared in 2.6.17-git4.
> > > > > > 
> > > > > > Apparently this happens because powersaved takes the battery status
> > > > > > information from hald and the following kernel changes make hald crash on
> > > > > > my system:
> > > > > > 
> > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43104f1da88f5335e9a45695df92a735ad550dda
> > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd00949647ddcea47ce4ea8bb2cfcfc98ebf9f2a
> > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c182274ffe1277f4e7c564719a696a37cacf74ea
> > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9bde7497e0b54178c317fac47a18be7f948dd471
> > > > > > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=36679ea59846d8f34a48f71ca1a37671ca0ad3c5
> > > > > > 
> > > > > > (ie. after reverting them hald works again).
> > > > > 
> > > > > Ick, that should not cause any problems, as sysfs should look identical
> > > > > to how it was before those patches.  Except that the /sys/class/usb/
> > > > > stuff is now symlinks instead of real directories, but HAL has had to
> > > > > handle that for a long time now (and it's even documented in
> > > > > Documentation/ABI/testing/sysfs-class)
> > > > 
> > > > Well, apparently one of them happens to trigger a buffer overflow in "my"
> > > > version of hal. ;-)
> > > > 
> > > > > Can you tell me exactly which of the above patches breaks HAL?
> > > > 
> > > > That would be quite a bit of testing and now I'm sure it's a hal issue.
> > > 
> > > git bisect would help out a lot.  Or just ask the HAL developers, they
> > > might know.
> > 
> > Anyway I'd have to compile and test at least a couple of kernels.
> > [For the record: I'm quite sure that 36679ea59846d8f34a48f71ca1a37671ca0ad3c5
> > and 9bde7497e0b54178c317fac47a18be7f948dd471 together break hal on
> > my system; this seems to be related to endpoints' paths in sysfs.]
> 
> I don't understand why that would break HAL, we are just adding new
> devices to the sysfs device tree, which the kernel is free to do at any
> time.  HAL should not care about that.
> 
> Oh, and 36679ea59846d8f34a48f71ca1a37671ca0ad3c5 is just an internal api
> change, it does not affect userspace in any way.  So I don't see how
> that would have anything to do with HAL at all.

Could you please have a look at the end of the attached output of
'strace -f /usr/sbin/hald --daemon=yes --retain-privileges --verbose=yes'
(produced on vanilla 2.6.17-git4)?

I'm not sure what exactly happens there, but I think hal crashes due to
a buffer overflow.

Greetings,
Rafael

--Boundary-00=_/clqE2QwvTY6tdd
Content-Type: application/x-gzip;
  name="hal.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hal.log.gz"

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
mmt/OVorjo+ZKtu46slVU0xilceyqqyoLCsqy8rKsnKqbDm3mcpkzbbh6jIbxDOQrK43bp8qPWgO
B63G6oKapw90Xnmn3ep8iF33Metv9q+Kf3RQ/MODYthsxJIra3MtGvX24qfk3f/LUX6q+3J4thPP
Lifx68nR64Od+LX26048uPl0sDZ3bMp5IHbiSv79aSfWdN1Js2WX6cNy3Md67fy4ny1bnlnNzBS2
9+IwTmH5SWU8hU0t86cqqHfisiVW8OLsx9rJi/216Z0lq8UgvlkNTD15duSd1I5ejkeeP89HXr4F
GnnTI+eqn3Ua3cuZ2xluunn5Wd7lVyhKmlNpbLyuUqdS2dPh19O4lD5VKm7WMlvJl/P580VacdTc
vY7aoFv/0ByuvnoRl9L7cVVyfLgTL59OYp5ejtYg0407b3WKxn0eZGcX2WWr/cfW9vi5vWz4fuvv
m8PLXpHVp8W5arOUne5P/l+fvwz18DW/fZHOd1K7NRjGbopVq7lZo/rou0VH/5OcPP5xhlr05OP8
yeN5LA6buAJ7vh87YFHerve4u3a/1uU7iJP6i/wUcphfBT4gHH4+HL4IhzHxPyn/5XPMhnp1Kq39
Lj4yP8ds6DwaxZW1qJoU/f2iQaw65mee6RWIMdcri7M8KXF5oVJdrkCELgZT/FIxebiZluTB/ZI6
5+49eyzOj09nEjSZjbuHz+6PR9ejx8+PHn/r6Jma8bvDXvvq3Vm5FxmHjhLzryY/HcUC3d4wr/r4
cP8sb0XtJH989mr7+DieHWII38SLNae9stqLOLfpim4pOtY/umP9wwbmaCTEi9j65mX3qjMczIyE
UNHaUBVIPRnIhY39dtdpcwM2tnKl3+0OLwbJZjJ60P89nqfidVkx9PNto9Cnsjg0Kl6ezY/ccK+R
e+ul2l8zzF0xzLuDQa9Zz8e4Ec+SQfmKTSgWKeH/w/B/JQx+NgzxerJ3SxhuZtmD2sn+3sHP0xOt
MPOBKGbaMDvTXj89ltzKC64n7/rdq95g62L05+v4xFk1Nc7ma/mpMTxqaiz+2fL7eAG72au3NlqN
2TEhqhot0juPn7KpC+avHRpQY0sLyKuJ5XQuqDcgsDXaNj8k8/IrV51WPcuvCZJ6tzPsd9vtZv+0
czpMdZIcZ8Nme3yfSbuiLu0W7HneTm7p0ng+NhVk+KBOlZXzTfHi/nba+dvpcD8uspPuRfJqZy/Z
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
6CCVraWonZjAwX9VfgAdzDYDAA==

--Boundary-00=_/clqE2QwvTY6tdd--
