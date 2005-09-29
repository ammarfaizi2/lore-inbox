Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVI2CWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVI2CWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVI2CWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:22:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751314AbVI2CWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:22:06 -0400
Date: Wed, 28 Sep 2005 19:21:31 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net
Subject: Re: RFC drivers/usb/storage/libusual
Message-Id: <20050928192131.56226005.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0509281248570.4491-100000@iolanthe.rowland.org>
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
	<Pine.LNX.4.44L0.0509281248570.4491-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 12:56:27 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 27 Sep 2005, Pete Zaitcev wrote:

> 	Can your scheme accomodate these "subdriver" modules?

Yes. We'd have to add a few types, like USB_US_TYPE_USBAT or something.

> 	Will the hotplug system work with them?  I'm not sure, but it's
> 	possible that in some cases the device descriptors will match
> 	the generic usb-storage or ub driver as well as the more
> 	specialized "subdriver".  Will the hotplug system choose the
> 	most specific match?  Even if it's not currently loaded in
> 	memory and the less specific driver is?

This problem exists already, in the shape of an Adaptec SCSI adapter
with Bulk transport. The ub attaches to it just fine, but then it cannot
drive tapes or other non-disk devices behind the adapter.

I solve it by ordering the table so that the more specific entry is
ahead of the least specific entries. This is why subdrivers have
pointers to a common table and have to test type and reject "other"
devices. This is why the table is not split.

I tried to find a way to a) make modprobe to match with v*p* first,
then dcb* and other such things, when it looks at modules.alias, and
b) have kernel to find "best fit" instead of "first fit". It can be
done. But I thought that if I engage into wholesale improvements like
that, I'll miss the window of Fedora Core 5.

Strategically, such approach sounds attractive, and, fortunately for me,
does not seem to conflict with that I came up presently. We'll add
split tables later, and that may allow to throw out request_module().
Sounds good, just maybe not this month.

-- Pete
