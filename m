Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUIOEso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUIOEso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 00:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUIOEso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 00:48:44 -0400
Received: from [66.35.79.110] ([66.35.79.110]:3004 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267263AbUIOEsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 00:48:39 -0400
Date: Tue, 14 Sep 2004 21:48:30 -0700
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915044830.GA4919@hockin.org>
References: <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915034229.GA30747@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:42:29PM -0700, Greg KH wrote:
> > Yeah, it's much reduced in flexibility from where it started.
> 
> That's because the original proposal was not very well defined at all.

True, I raised plenty of concerns about it in the first draft, too :)

> > Well, it will be what it will be, I think.  I know several people who
> > wanted it to be more than it is turning out to be, but that's not
> > unexpected.  Of course we can cope with what it is.
> 
> Who are those people?  What did people want it to be that it now is not?
> Will they not speak up publicly?  If not, how do they expect it to
> address things they want?

Well, I knew several groups at Sun who could have benefitted from "driver
hardening" event-logging stuff.  Things like IPMI, evlog, etc are what are
being used today.

> > What I think we'll find is that fringe users will hack around it.  It will
> > become a documentum that the "insert" event of a Foo really means
> > something else.  People will adapt to the limited "verbs" and overload
> > them to mean whatever it is that they need.
> 
> Since when did I ever state that the verbs would be "limited"?  One of
> the original issues that people were worried about was the possiblity of
> a typo in a verb that we would be forced to live with.  The patch I just
> proposed fixes that issue.

Sorry, don't get me wrong - I fully agree with amking it an enum or some
such.  In fact, I think I suggested that in the first draft, too.  But
adding a dozen enum verbs, of which each are used once in one single
driver is just not going to fly.  The barrier to creating a new "verb" is
not high, but there is a slight barrier.  Rather than deal with the
barrier, I fear (and I could be wrong) that people will just overload
existing verbs.

> > As much as we all like to malign "driver hardening", there is a *lot* that
> > can be done to make drivers more robust and to report better diagnostics
> > and failure events.
> 
> I agree.  But this interface is not designed or intended for that.  

Right.  I originally asked Robert if there was some way to make this
interface capable of handling that, too.  Maybe the answer is merely "no,
not this API".

> > I'd like to have a standardized way to spit things like ECC errors up to
> > userspace, but I don't think that's what Greg K-H wants these used for.
> 
> You are correct.  I also would like to see a way ECC and other types of
> errors and diagnostics be sent to userspace in a common and unified
> manner.  But I have yet to see a proposal to do this that is acceptable.

Well, let's open that discussion, then! :)  What requirements do you see?

Basically, they need to be exactly like this, except there needs to be
some amount of buffering of messages (somehow) and they need a data
payload.

For buffering, I could live with "all events with no listener get
printk()ed and they get buffered in dmesg".  Now all we need to solve is
the payload issue.

Really, other than payload, why NOT use this API for ECC and driver
faults?

> > I'd like to ACPI events move to a standardized event system, but they
> > *require* a data payload.
> 
> Great, that also would be wonderful.  Create such a event system for
> ACPI if you desire.  I think the ACPI developers are still working on
> bigger issues currently.

ACPI *has* it's own event system.  It's fine, but it's Yet Another Event
System.  I'd love to see it use this.  It has mostly the same behaviors,
except it has a data payload (a string and couple unsigned ints, if I
recall).  If this API can't handle that, then we have to keep ACPI's
current event system.  Wouldn't it be nicer to remove code and encourage
migrating towards standard(ish) APIs?

Again, other than payload, why NOT use this API for ACPI?

> > There are *way* too many places (IMHO) where we throw a printk() and punt,
> > or do something which is less than ideal.  If I had my druthers, we would
> > examine most places that call printk() at runtime (not startup, etc) and
> > figure out if an event makes more sense.
> 
> Please do.

I'll put it on my list.  The requirements that all kevents have a kobject
and that verbs be single words with no payload makes it hard to do,
though.

> > This model serves well for "eth0 has a link" and "hda1 was mounted" sorts
> > of events. [Though namespaces make mounting a lot of fun.  Which namespace
> > was it mounted on?  Why should my app in namespace X see an event about
> > namespace Y?]
> 
> Yeah, namespaces are interesting :)

I started a paper on why namespaces should be ripped out of Linux or else
they should be actually thought out and implemented properly.  Maybe one
day I'll finish it.

Tim
