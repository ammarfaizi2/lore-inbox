Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWH3Hb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWH3Hb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 03:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWH3Hb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 03:31:58 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:45970 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751087AbWH3Hb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 03:31:57 -0400
Subject: Re: observations on configfs
From: Johannes Berg <johannes@sipsolutions.net>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060829163136.GW7715@ca-server1.us.oracle.com>
References: <1156868070.3788.38.camel@ux156>
	 <20060829163136.GW7715@ca-server1.us.oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Aug 2006 09:32:28 +0200
Message-Id: <1156923148.4013.23.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 09:31 -0700, Joel Becker wrote:

> 	I did get this straight from sysfs.  You are right, there is
> less sharing of such things in configfs compared to sysfs.  Here's the
> thing: this scheme allows the generic code (the ->show() and ->store()
> methods) to take struct configfs_attribute, but the actual worker
> functions take context appropriate objects, such a struct o2nm_node in
> the example you placed.  Without this indirection, every ->show() would
> have to do its own conversion from configfs_attribute to the context
> appropriate structures.

Yes, I know this, and I appreciate that sysfs does this generically in
order to get better type checking etc. Maybe it'd be possible to also
give each node a void* data pointer that get's passed around to the
store/show callbacks and hence it doesn't need to do any container_of
conversion but rather cast that data pointer. I'm not really sure, but I
think that the setup required for configfs is a bit too much since one
is essentially implementing what would in sysfs be a subsystem for every
node time.
 
> > If I have virtual devices represented in configfs, they are all
> > net_devices at their core, of course. Assuming they are below
> > /config/cfg80211/wiphy0/, say eth0 is created as pending/eth0. Then, you
> > move it to live/eth0 at which point the netdevice is allocated and
> > registered (if it fails due to name collision you need to chose another
> > name by renaming it in pending).
> 
> 	Also note that you can fail the callback in your driver,
> preventing the rename(2) -- eg, if a particular option needs to be set
> but isn't, etc.

Yes, I know that.

> > This is all great, but say then I want to change a few parameters of the
> > interface. So I move it to pending again. At this point, we run into
> > problems. We can either (a) remove the net_device or (b) keep it live.
> 
> 	The plan is (c).  Build a new one in pending, and rename(2) it
> on top of the current one.

Ah, will that new one in pending start out with the same set of
parameters as the one in live? I guess there could be a callback when
something is added to pending so that it can be filled in to look the
same.

Another question. For this application we'll probably need something
like
/config/cfg80211/wiphy0/eth0/type <- type of interface: sta, monitor,...
/config/cfg80211/wiphy0/eth0/sta/ <- sta attributes, e.g. 'ssid'

but if the type changes, those sta attributes ought to disappear. It
seems that I should be able to do that, but I'm not sure how it would be
done in pending. That is, when in pending I have an object and someone
sets the 'sta' type then the 'sta' attributes directory must show up.

Thanks,
johannes
