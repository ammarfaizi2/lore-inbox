Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWAUAuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAUAuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAUAuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:50:06 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:60044 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932221AbWAUAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:50:05 -0500
Subject: Re: [PATCH] driver core: remove unneeded klist methods
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0601201043540.4788-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0601201043540.4788-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 13:19:47 -0600
Message-Id: <1137784787.3442.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 11:39 -0500, Alan Stern wrote:
> This patch (as641) removes unneeded klist methods from the driver core and
> changes a klist_del call to klist_remove in device_del.
> 
> The _get and _put methods have no effect, because the klist nodes are
> deleted by calling klist_remove, which waits until they are unreferenced
> by any klist iterators.  Furthermore, the _puts cause problems because
> they occur while the iterator is holding a spinlock.

Could you just elaborate on the actual problem that you're trying to
solve here?

Iterators of volatile lists are ipso facto just "best guess", so moving
the location of the iterator piece is OK.  However, your assumption that
only the routine called by the iterator is always going to do the final
put on the object is fundamentally flawed.  The list is volatile because
references to the object are being acquired and released all the time.
Additionally, the list nodes are embedded in the object, so by removing
the object get and put calls, you remove the ability for the object
refcounting to see the fact that the list is using the object.  This
will lead to the situation where the object could be freed while the
iterator is acting on it.  You cannot remove the object get/put calls
from the klist references otherwise the list refcounting will be totally
divorced from the object refcounting.

James


