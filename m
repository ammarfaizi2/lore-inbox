Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWEJN2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWEJN2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEJN2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:28:14 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:55955 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S964949AbWEJN2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:28:12 -0400
Subject: Re: [dm-devel] [RFC] dm-userspace
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: Dan Smith <danms@us.ibm.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org,
       Xen Developers <xen-devel@lists.xensource.com>
In-Reply-To: <m33bfig5u6.fsf@guaranine.beaverton.ibm.com>
References: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
	 <1146092129.14129.333.camel@localhost.localdomain>
	 <m33bfig5u6.fsf@guaranine.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 09:27:37 -0400
Message-Id: <1147267657.905.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 16:02 -0700, Dan Smith wrote:
> (I'm including the xen-devel list on this, as things are starting to
> get interesting).
> 
> MZ> do u have any benchmark results about overhead?
> 
> So, I've spent some time over the last week working to improve
> performance and collect some benchmark data.
> 
> I moved to using slab caches for the request and remap objects, which
> helped a little.  I also added a poll() method to the control device,
> which improved performance significantly.  Finally, I changed the
> internal remap storage data structure to a hash table, which had a
> very large performance impact (about 8x).


why need a poll here? ask a dumb question.

this is interesting. have u ever check the average loop up path length
with single queue and has table? this can improve by 8X, quite
impressive.



> 
> Copying data to a device backed by dm-userspace presents a worst-case
> scenario, especially with a small block-size like what qcow uses.  In
> one of my tests, I copy about 20MB of data to a dm-userspace device,
> backed by files hooked up to the loopback driver.  I compare this with
> a "control" of a single loop-mounted image file (i.e., without
> dm-userspace or CoW).  I measured the time to mount, copy, and unmount
> the device, which (with the recent performance improvements) are
> approximately:
> 
>   Normal Loop:        1 seconds
>   dm-userspace/qcow: 10 seconds
> 
> For comparison, before adding poll() and the hash table, the
> dm-userspace number was over 70 seconds.

nice improvement!

> 
> One of the most interesting cases for us, however, is providing a
> CoW-based VM disk image, which is mostly used for reading, with a
> small amount of writing for configuration data.  To test this, I used
> Xen to compare a fresh FC4 boot (firstboot, where things like SSH keys
> are generated and written to disk) that used an LVM volume as root to
> using dm-userspace (and loopback-files) as the root.  The numbers are
> approximately:
> 
>   LVM root:          26 seconds
>   dm-userspace/qcow: 27 seconds

this is quite impressive, i think application take most of the time and
some time are overlapped with io. and with little io here, this little
difference is what u can get. i think this will be very helpful for
diskless san boot.



> 
> Note that this does not yet include any read-ahead type behavior, nor
> does it include priming the kernel module with remaps at create-time
> (which results in a few initial compulsory "misses").  Also, I removed
> the remap expiration functionality while adding the hash table and
> have not yet added it back, so that may further improve performance
> for large amounts of remaps (and bucket collisions).
> 
> Here is a link to a patch against 2.6.16.14:
> 
>   http://static.danplanet.com/dm-userspace/dmu-2.6.16.14-patch
> 
> Here are links to the userspace library, as well as the cow daemon,
> which provides qcow support:
> 
>   http://static.danplanet.com/dm-userspace/libdmu-0.2.tar.gz
>   http://static.danplanet.com/dm-userspace/cowd-0.1.tar.gz
> 
> (Note that the daemon is still rather rough, and the qcow
> implementation has some bugs.  However, it works for light testing and
> the occasional luck-assisted heavy testing)
> 
> As always, comments welcome and appreciated :)
> 

