Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVDZGuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVDZGuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDZGuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:50:25 -0400
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:45414 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261355AbVDZGuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:50:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Date: Tue, 26 Apr 2005 01:50:00 -0500
User-Agent: KMail/1.8
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
References: <200504210207.02421.dtor_core@ameritech.net> <d120d500050425132250916bcb@mail.gmail.com> <1114497816.8527.66.camel@uganda>
In-Reply-To: <1114497816.8527.66.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260150.00948.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 01:43, Evgeniy Polyakov wrote:
> On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> > On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > While thinking about locking schema
> > > with respect to sysfs files I recalled,
> > > why I implemented such a logic -
> > > now one can _always_ remove _any_ module
> > > [corresponding object is removed from accessible
> > > pathes and waits untill all exsting users are gone],
> > > which is very good - I really like it in networking model,
> > > while with whole device driver model
> > > if we will read device's file very quickly
> > > in several threads we may end up not unloading it at all.
> > 
> > I am sorrry, that is complete bull*. sysfs also allows removing
> > modules at an arbitrary time (and usually without annoying "waiting
> > for refcount" at that)... You just seem to not understand how driver
> > code works, thus the need of inventing your own schema.
> 
> Ok, let's try again - now with explanation, 
> since it looks like you did not even try to understand what I said.
> If you will remove objects from ->remove() callback
> you may end up with rmmod being stuck.
> Explanation: each read still gets reference counter, 
> while in rmmod path there is a wait until it is zero.
> If there are too many simultaneous reads - even
> if each will put reference counter at the end, we still can have
> non zero refcnt each time we check it in rmmod path.
> That is why object must be removed from accessible pathes
> first, and only freed in ->remove() callback.

Please try to read the code. device_unregister and kobject_unregister
do not require caller to wait for the last reference to drop, they rely
on availability of release method to clean up the object when last user
is gone. driver_unregister is blocking (like your family code) but
teardown takes no time. If driver is in use (attributes are open) then
module refcount is non-zero and instead of (possibly endless) "waiting for
refcount to drop" message you will get nice -EBUSY.

If you program so that you wait in module_exit for object release - you
get what you deserve. 

> > BTW, I am looking at the connector code ATM and I am just amazed at
> > all wied refounting stuff that is going on there. what a single
> > actomic_dec_and_test() call without checkng reurn vaue is supposed to
> > do again?
> 
> It has explicit barrieres, which guarantees that
> there will not be atomic operation vs. non atomic
> reordering. 

And you can't use explicit barriers - why exactly?

-- 
Dmitry
