Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWDQPPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWDQPPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 11:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDQPPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 11:15:48 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:17123 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751094AbWDQPPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 11:15:48 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] binary firmware and modules
Date: Mon, 17 Apr 2006 17:15:44 +0200
User-Agent: KMail/1.9.1
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Oliver Neukum <oliver@neukum.org>, Jon Masters <jcm@redhat.com>,
       linux-kernel@vger.kernel.org
References: <1145088656.23134.54.camel@localhost.localdomain> <20060417142214.GI5042@tuxdriver.com> <1145284193.2847.53.camel@laptopd505.fenrus.org>
In-Reply-To: <1145284193.2847.53.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604171715.45252.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 April 2006 16:29, Arjan van de Ven wrote:
> On Mon, 2006-04-17 at 10:22 -0400, John W. Linville wrote:
> > On Sat, Apr 15, 2006 at 11:54:22AM +0200, Oliver Neukum wrote:
> > > Am Samstag, 15. April 2006 10:10 schrieb Jon Masters:
> > > > The attached patch introduces MODULE_FIRMWARE as one way of advertising
> >  
> > > Strictly speaking, what is the connection with modules? Statically
> > 
> > The same as MODULE_AUTHOR, MODULE_LICENSE, etc.  The divide is more
> > logical than physical.
> > 
> > > compiled drivers need their firmware, too. Secondly, do all drivers
> > > know at compile time which firmware they'll need?
> > 
> > They have to know what they will request, do they not?
> 
> 
> in order to not fall in the naming-policy trap: do we need a translation
> layer here? eg the module asks for firmware-<modulename>
> and userspace then somehow maps that to a full filename via a lookup
> table?

Hi Arjan, since the same module can handle different devices which need
different firmware, firmware-<modulename> is not sufficient.  An example
is the speedtouch USB modems, which need different firmware depending on
the modem revision.  In fact each modem needs two blobs uploaded, a small
one (stage 1 blob) followed by a large one (stage 2 blob).  These blobs
are fairly independant, for example a given stage 1 blob can work for a
wider range of modem revisions than a given stage 2 blob.  Also, the
manufacturer made a bunch of exotic variations on the modem (all with
the same product ids, but different revisions); I don't have a complete
list, and I don't know which ones require special firmware.  That means
that the driver does not have a complete list of different firmware names.
It could always use the same names "stage1" and "stage2", regardless of
the revision, and expect the user to place the right firmware there; but
then what about people who have multiple modems with different revisions
(like me)?  As a result of all this, the driver needs to export the following
to userspace, to let user-space find the right firmware:

(0) module name
(1) stage 1 or stage 2
(2) modem major revision number
(3) modem minor revision number (I don't know if this is really needed,
but I heard a rumour that it was: ISDN modems needing special firmware
but only varying in their minor revision from non-ISDN modems IIRC).

This is all exported in the hotplug environment.  However, current hotplug
scripts don't have any cleverness in them for handling this kind of thing
(I don't know about udev).  So the driver uses the following rather nasty
but effective scheme: first it looks for the following file:

	speedtch-<stage>.bin.<major_revision>.<minor_revision>

for example speedtch-1.bin.4.0

If that is not found, it looks for

	speedtch-<stage>.bin.<major_revision>

If that is not found, it looks for

	speedtch-<stage>.bin

If that is not found, then it gives up.

This allows people with only one modem to put their firmware in
speedtch-1.bin and speedtch-2.bin and not have to think about
revisions.  But at the same time it allows distributions to
distribute multiple firmware blobs, for example a blob for
general revision 4 modems, but with a special blob for revision 4.1
modems (this could be the ISDN kind; I made up the minor revision 1),
simply by providing files speedtouch-2.bin.4 and speedtouch-2.bin.4.1
It's got to be said that no distribution that I know of actually does
this.

All the best,

Duncan.
