Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWH2QdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWH2QdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWH2QdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:33:11 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:37576 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965069AbWH2QdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:33:09 -0400
Date: Tue, 29 Aug 2006 09:31:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: observations on configfs
Message-ID: <20060829163136.GW7715@ca-server1.us.oracle.com>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@gmail.com>,
	linux-kernel@vger.kernel.org
References: <1156868070.3788.38.camel@ux156>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156868070.3788.38.camel@ux156>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 06:14:30PM +0200, Johannes Berg wrote:
> I recently tried to use configfs for configuring (virtual) network
> interfaces on top of cfg80211. Here's what I noticed then and in later
> thoughts about it.

	Thanks!  I always appreciate thoughts and comments.

>  (1) it is possible to have
> 
>      | $ ls /config
>      | 02-example  02-example
> 
>      Seems like that should be prohibited when registering the new
> configfs subsystem.

	Hmm, yeah, this is a bug.  I've added
http://oss.oracle.com/bugzilla/show_bug.cgi?id=755.  Thanks for
reporting this!

>  (2) why is are there no show/store in struct configfs_attribute? That
> leads to complications like this (straight from ocfs2):
> 
> struct o2nm_node_attribute {
>         struct configfs_attribute attr;
>         ssize_t (*show)(struct o2nm_node *, char *);
>         ssize_t (*store)(struct o2nm_node *, const char *, size_t);
> };
> 
> static struct o2nm_node_attribute o2nm_node_attr_num = {
>         .attr   = { .ca_owner = THIS_MODULE,
>                     .ca_name = "num",
>                     .ca_mode = S_IRUGO | S_IWUSR },
>         .show   = o2nm_node_num_read,
>         .store  = o2nm_node_num_write,
> };
> 
> ...
> 
> I suppose I could ask the same of sysfs, but there it actually seems to
> make sense because it only needs to be implemented once per subsystem.
> The same is true of configfs, however for configfs one usually has to
> implement a new subsystem to get useful functionality...

	I did get this straight from sysfs.  You are right, there is
less sharing of such things in configfs compared to sysfs.  Here's the
thing: this scheme allows the generic code (the ->show() and ->store()
methods) to take struct configfs_attribute, but the actual worker
functions take context appropriate objects, such a struct o2nm_node in
the example you placed.  Without this indirection, every ->show() would
have to do its own conversion from configfs_attribute to the context
appropriate structures.
 
>  (3) just thought about the pending/live thing a bit more. For one I
> notice that it is not implemented, which is sad because I could really
> use it well here. Secondly, and more importantly, I think the concept is
> slightly flawed.

	Yeah, I'm sorry I haven't gotten to it yet.

> If I have virtual devices represented in configfs, they are all
> net_devices at their core, of course. Assuming they are below
> /config/cfg80211/wiphy0/, say eth0 is created as pending/eth0. Then, you
> move it to live/eth0 at which point the netdevice is allocated and
> registered (if it fails due to name collision you need to chose another
> name by renaming it in pending).

	Also note that you can fail the callback in your driver,
preventing the rename(2) -- eg, if a particular option needs to be set
but isn't, etc.

> This is all great, but say then I want to change a few parameters of the
> interface. So I move it to pending again. At this point, we run into
> problems. We can either (a) remove the net_device or (b) keep it live.

	The plan is (c).  Build a new one in pending, and rename(2) it
on top of the current one.

> Hence, I think it should be slightly redesigned to allow for another
> case, namely hardlinking the directory from live into pending (make sure
> name stays the same) at which point it isn't removed. Then, moving it
> from live to pending would be taken as an indication to actually remove
> the net_device associated with it, and linking it just as a
> reconfiguration request.

	Linux doesn't support directory hardlinks, for good reason.

Joel

-- 

Life's Little Instruction Book #313

	"Never underestimate the power of love."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
