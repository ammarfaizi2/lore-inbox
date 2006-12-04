Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759711AbWLDEVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759711AbWLDEVd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 23:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759715AbWLDEVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 23:21:32 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:24786 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1759706AbWLDEVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 23:21:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
Date: Sun, 3 Dec 2006 20:21:31 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701DBC05D@PA-EXCH03.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
Thread-Index: AccXWO3seopXw/9oSsSQCL/trcEdgwAAUz+O
References: <20061202043746.GE30531@localdomain><20061203132618.d7d58f59.akpm@osdl.org> <45738959.1000209@acm.org> <20061203185442.33faf1c0.randy.dunlap@oracle.com> <FE74AC4E0A23124DA52B99F17F44159701DBC05B@PA-EXCH03.vmware.com> <45739DB4.6000806@oracle.com>
From: "Bela Lubkin" <blubkin@vmware.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Corey Minyard" <minyard@acm.org>,
       "OpenIPMI Developers" <openipmi-developer@lists.sourceforge.net>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Joseph Barnett" <jbarnett@motorola.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> Bela Lubkin wrote:
>> Andrew Morton wrote:
>> 
>>> Sometime, please go through the IPMI code looking for all these
>>> statically-allocated things which are initialised to 0 or NULL and remove
>>> all those intialisations?  They're unneeded, they increase the vmlinux
>>> image size and there are quite a number of them.  Thanks.

>> Randy Dunlop replied:
 
<>> I was just about to send that patch.  Here it is,
>>> on top of the series-of-12.
>> ...
>>> -static int bt_debug = BT_DEBUG_OFF;
>>> +static int bt_debug;
>>
>> Is it wise to significantly degrade code readability to work around a
minor
>> compiler / linker bug?
>
> Is that the only one that is a problem?

It was the most obvious one at a quick glance.

I would argue that _every single one_ is a small problem because it makes the
code murkier.  Yes we "know" that statics are initialized to zero.  Not every
reader is perfectly versed in that.  The fact that statics and dynamics are
different is an added subtlety.  Everywhere you've removed an initializer is
a potential bug if someone needs to change that variable to a different
storage class.  Yes they "should" know better.

> I don't think it's a problem.  We *know* that static data areas
> are init to 0.  Everything depends on that.  If that didn't work
> it would all break.

Agreed; that's why it's a compiler/linker bug if _explicit_ initialization to
zero results in any difference in the final binary.  So here you're
submitting dozens of source level changes to repair a toolchain bug.

> I could say that it's a nice coincidence that BT_DEBUG_OFF == 0,
> but I think that it's more than coincidence.

I agree, it's more than coincidence.  But the new version tells you less.  It
ccertainly _could_ have been coded such that debug == 1 means no debug, 0
means debug.  Dumb, but possible.  It could also have been coded such that
debug == BT_DEBUG_OFF means debug, but that's egregiously stupid.

In other words, I believe the reader of:

  static int bt_debug = BT_DEBUG_OFF;

_knows_ debug is off.  The reader of:

  static int bt_debug = 0;

has a _strong suspicion_ that debug is off.  The reader of:

  static int bt_debug;

has at best a _strong hint_ that debug is off.

Any of those three statements could be shortly followed by:

  bt_debug = BT_DEBUG_ON;

but this would be a moderately surprising construction after the first two;
not at all surprising after the third.

>Bela<
