Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVDESaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVDESaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVDESaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:30:13 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:6617 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261846AbVDESQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:16:47 -0400
Message-ID: <4252D613.4070204@zabbo.net>
Date: Tue, 05 Apr 2005 11:16:51 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] configfs, a filesystem for userspace-driven kernel object
 configuration
References: <20050403195728.GH31163@ca-server1.us.oracle.com> <20050405064153.GI25554@waste.org>
In-Reply-To: <20050405064153.GI25554@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Sun, Apr 03, 2005 at 12:57:28PM -0700, Joel Becker wrote:
> 

>>	An interface in /proc where the API is: 

>>or an ioctl(2) interface where the API is:

>>
>>becomes this in configfs:
>>
>>	# cd /config/mythingy
>>	# mkdir foo
>>	# echo 1 > foo/index
>>	# echo 3 > foo/count
>>	# echo 0x00013 > foo/address
>>
>>	Instead of a binary blob that's passed around or a cryptic
>>string that has to be formatted just so, configfs provides an interface
>>that's completely scriptable and navigable.
> 
> How does the kernel know when to actually create the object?

"actually create", huh? :)

In the trivial case Joel describes, the item is almost certainly
allocated during "# mkdir foo" when the subsystem will get a
->make_item() call for the 'mythingy' group it registerd.  The various
attribute writes then find the item by following their
configfs_attribute argument to the item that its embedded in.

But I bet you're not really asking about creation.  I bet you're
wondering how the kernel will know when enough attributes have been
filled and that it's safe to use the object.  Misguided items could
assign magical ordering to the attribute filling such that once a final
attribute is set, and others have been set, the item goes live.  That's
what ocfs2 does now, sadly, but certainly not as a long-term solution.

The missing piece is the 'commit_item' group operation that is yet to be
implemented.  The intent is to have a directory of pending items that
can have their attributes filled before being rename()ed into a
directory of items that are in active use.  The commit_item() call that
hits at rename() would give the kernel the chance to refuse the item
because attributes haven't been filled in or conflict with existing
items, or whatever.

- z
